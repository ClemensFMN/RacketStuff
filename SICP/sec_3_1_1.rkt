#lang sicp

; create some kind of accumulator "function object"
(define (make-acc init-val)
  (define (add-to val) ; several functions
      (set! init-val (+ init-val val)))
  (define (sub-from val) ; several functions
      (set! init-val (- init-val val)))
  (define (print-val) ; several functions
    (display init-val)
    (newline))  
  (define (dispatch op) ; and a dispatch function which takes ops / messages and returns functions
    (cond ((eq? op 'inc) add-to)
          ((eq? op 'dec) sub-from)
          ((eq? op 'prnt) print-val)))
  dispatch) ; the dispatch function is the actual return value


(define acc-1 (make-acc 0))
((acc-1 'inc) ; (acc-1 'inc) returns the object's method
 3) ; and we provide the parameter 3 to this method
((acc-1 'prnt)) ; we need the double parens here: (acc-1 'prnt) returns the method and the outer parens call it - no params here
((acc-1 'inc) 5)
((acc-1 'dec) 1)
((acc-1 'prnt))

