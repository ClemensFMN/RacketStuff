#lang sicp

; message passing
; a procedure creates a "function object" with two params
(define (create-obj x y)
  (define (dispatch msg) ; part of the "function object" is a dispatch function which takes a msg as parameter
    (cond ((eq? msg 'msg-1) x) ; depending on the message, it performs different actions on the object
          ((eq? msg 'msg-2) y)
          ((eq? msg 'msg-3) (+ x y))))
  dispatch) ; the whole function object returns the dispatch function

; create an object & assign it to a name
(define obj1 (create-obj 1 2))
(obj1 'msg-1) ; now we can "send" messages to the object
(obj1 'msg-2)
(obj1 'msg-3)

(newline)

(define (create-obj-v2 x)
  (define (f1 y)
    (* x y))
  (define (f2 a b)
    (* a b))
  (define (dispatch msg)  ; dispatch function
    (cond ((eq? msg 'msg-1) f1) ; if it returns a function, we must use it as ((obj2 'msg-1) 3) (see further below)
          ((eq? msg 'x-val) x)
          ((eq? msg 'msg-2) f2) ; the advantage is, that we can supply an unlimited number of arguments
          (else (* x msg)))) ; if we specify the function right away, we can use it but have to reuse msg as function argument (which allows for one argument only)
  
  dispatch)

(define obj2 (create-obj-v2 2))
(obj2 'x-val)
((obj2 'msg-1) 3)
((obj2 'msg-2) 3 5)
(obj2 4)
