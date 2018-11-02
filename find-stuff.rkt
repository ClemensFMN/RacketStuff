#lang racket/base
(require racket/list)


(define (my-zip lst)
  (map list (range (length lst))
       lst))

(my-zip '(a b c))


; returns index of lst, where list element = vl
(define (find-iv lst vl)
  (for/list ([itm (my-zip lst)]
             #:when (= (second itm) vl))
    (first itm)))

(find-iv '(1 2 3 4 3 2 1) 2)

(define (find-ivp lst pred)
  (for/list ([itm (my-zip lst)]
             #:when (pred (second itm)))
    (first itm)))

(find-ivp '(1 2 3 4 3 2 1) (lambda (x) (< x 3)))
