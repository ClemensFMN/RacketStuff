#lang sicp


(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "untagged data")))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "untagged data")))


(define t1 (attach-tag 'rect '(4 5)))

(type-tag t1)
(contents t1)

(define (rect? z)
  (eq? (type-tag z) 'rect))

(define (polar? z)
  (eq? (type-tag z) 'polar))


(rect? t1)
(polar? t1)