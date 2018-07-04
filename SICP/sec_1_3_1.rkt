#lang sicp

; a generic sum function, summing term starting with a, going up to b and claculating the immediate values according to next
(define (sum term a next b)
  (if (> a b) ; finished if the lower interval boundary has reached the upper one
      0
      (+ (term a) ; otherwise add term a to the remainder
         (sum term (next a) next b))))

; we can easily specialise this to summing up integers
(define (sum-integers a b)
  (sum identity a inc b))

(sum-integers 1 10)

; changing the term function allows adding something different
(define (sum-squares a b)
  (define (square x) (* x x))
  (sum square a inc b))

(sum-squares 1 4) ; 1 + 2^2 + 3^2 + 4^2 = 1 + 4 + 9 + 16 = 30

(define (sum-even-integers a b)
  (define (this-next x) (+ x 2))
  (sum identity a this-next b))

(sum-even-integers 2 6)

; we can also use this to approx imtegrals according to
; \int_a^b f dx \approx dx * ( f(a+dx/2) + f(a+dx+dx/2) + f(a+2dx+ dx/2) + ... )
(define (integral f a b dx)
  (define (this-next x) (+ x dx)) ; the this-next function takes dx as closure from outside
  (* dx
     (sum f (+ a (/ dx 2.0)) this-next b)))

; use the thing with an anonymuous function (lambda)
(integral (lambda (x) (* x x)) 0 1 0.001)
    