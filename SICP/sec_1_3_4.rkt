#lang sicp

; define a function which returns a function; namely f two times applied
(define (apply-two-times f)
  (lambda (x) (f (f x))))

; a simple test function
(define (f1 x) (+ x 1))

(define f1-double (apply-two-times f1))

(f1 3)

(f1-double 3)

; compose two functions f and g
(define (combine f g)
  (lambda (x) (f (g x))))

; another test function
(define (f2 x) (* 2 x))

; f2(f1(x)) = f2(x+1) = 2(x+1)
((combine f2 f1) 10)

; define a composed function
(define f21 (combine f2 f1))
(f21 10) ; and use it

; f1(f2(x)) = f1(2x) = 2x+1
((combine f1 f2) 2)


(define (small-enough? a)
  (< (abs a) 0.001))

; Newton method for function f, first derivative fp, and starting point x
(define (newton f fp x)
  (let ((fx (f x))
        (fpx (fp x)))
    (if (small-enough? fx)
        x
        (newton f fp (- x (/ fx fpx))))))

(newton (lambda (x) (- (* x x) 1)) (lambda (x) (* 2 x)) 0.2)
