#lang racket
(define tree-sum
	(lambda (exp)
		(match exp
			[(? number? x) x]
			[`(,e1, e2)
				(let ([v1 (tree-sum e1)]
					  [v2 (tree-sum e2)])
					(+ v1 v2))])))

#lang racket
(define calc
	(lambda (exp)
		(match exp
			[(? number? x) x]
			[`(,op, e1, e2)
				((let ([v1 (calc e1)]
					   [v2 (calc e2)])
					(match op
						['+ (+ v1 v2)]
						['- (+ )])
					()))

			]
		)
	)
	
#lang racket

(define env0 '())

(define ext-env
	(lambda (x v env)
		cons `(,x . ,v)env)))

(define lookup 
	lambda (x env)
		(let ([p (assq x env)])
			(cond
				[(not p) #f]
				[else (cdr p)]))))

(struct Closure (f env))

(define interp
	(lambda (exp env)
		(match exp
