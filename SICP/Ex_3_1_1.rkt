#lang sicp

; exercise 3.1
(define (make-accumulator x)
  (define (call val)
    (begin
      (set! x (+ x val))
      x))
  call)

(define acc1 (make-accumulator 30))
(acc1 3)
(acc1 2)


; exercise 3.2
(define (make-monitored f)
  (let ((cnt 0)) ; the counter
    (define (cll x) ; the function to actually call our test function
      (begin
        (set! cnt (+ cnt 1)) ; update the counter
        (f x))) ; and call the function - the order of these two is important as we are interested in the result of f x!!
    (define (num-calls) ; return the counter
      cnt)
    (define (reset-calls) ; reset the counter
      (set! cnt 0))
    (define (dispatch op) ; dispatch function: Note the difference between how-many & reset on the one side and the call on the other side
      (cond ((eq? op 'how-many-calls?) num-calls); this returns a function
            ((eq? op 'reset-count) reset-calls) ; this as well
            (else (cll op)))) ; this actually calls the function
    dispatch))

(define (f x) (+ x 1))
(define mf (make-monitored f))
((mf 'how-many-calls?)) ; the dispatch function returns a function which we need to call afterwards -> (( .. ))
(mf 4) ; the dispatcher actually calls the function -> one set of (...) needed
((mf 'how-many-calls?))
(mf 5)
((mf 'how-many-calls?))
((mf 'reset-count))
((mf 'how-many-calls?))
(mf 5)
((mf 'how-many-calls?))

(newline)

; a somewhat easier to use function as we put commands right into the dispatch function...
(define (make-monitored-v2 f)
  (let ((cnt 0)) ; the counter
    (define (dispatch op) 
      (cond ((eq? op 'how-many-calls?)
             cnt)
            ((eq? op 'reset-count)
             (set! cnt 0))
            (else
               (set! cnt (+ 1 cnt))
               (f op))))
    dispatch))

(define mf2 (make-monitored-v2 f))
(mf2 'how-many-calls?)
(mf2 4)
(mf2 'how-many-calls?)
(mf2 4)
(mf2 'how-many-calls?)
(mf2 'reset-count)
(mf2 'how-many-calls?)

