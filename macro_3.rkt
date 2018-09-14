#lang racket

; calling a function and logging the function parameter
(define (with-logging f x)
  (begin
    (printf "called with x = ~a \n" x)
    (f x)))

(define (f x) (+ x 1))

(with-logging f 3) ; that works ok
(with-logging f (+ 1 2)) ; but here we see that a function gets its argument evaluated

; the same via macro
(define-syntax-rule (mysr f x)
  (begin
    (printf "called with x = ~a \n" 'x) ; print out the argument (quoted to avoid evaluation)
    (f x))) ; execute the function (with the argument) and return the result

(mysr f 3) ; as above
(mysr f (+ 1 2)) ; a macro does not evaluate its arguments; it gets the x as provided in the function call


; a simple test case runner
(define-syntax-rule (my-test-case tc)
  (begin
    (printf "executing ~a \n" 'tc) ; here the macro is essential; otherwise this would print true / false (and not the TC itself)
    tc))

(my-test-case (= 3 (+ 1 2)))
(my-test-case (= 4 (+ 1 2)))
