#lang racket/base
(require racket/list)

; poor man's zip
(define (my-enum lst)
  (map list (range (length lst))
       lst))

(my-enum '(a b c))

; some helpers to abstract the structure of our enumerated list
(define (get-ind itm) (first itm))
(define (get-elem itm) (second itm))

; returns index of lst, where list element = vl
(define (find-iv lst vl)
  (for/list ([itm (my-enum lst)]
             #:when (= (get-elem itm) vl))
    (get-ind itm)))

(find-iv '(1 2 3 4 3 2 1) 2) ; -> (1 5)

; doing the same with reduce / foldl
(define (find-iv-v2 lst vl)
  (foldl (lambda (elem acc)
           (if (= (get-elem elem) vl)
               (cons (get-ind elem) acc)
               acc))
         '()
         (my-enum lst)))

(find-iv-v2 '(1 2 3 4 3 2 1) 2) ; ->(5 1)

; returns index of lst, where pred list element = true
(define (find-ivp lst pred)
  (for/list ([itm (my-enum lst)]
             #:when (pred (get-elem itm)))
    (get-ind itm)))

(find-ivp '(1 2 3 4 3 2 1) (lambda (x) (< x 3))) ; -> (0 1 5 6)

; like previous, but include index in predicate function
(define (find-ivpi lst pred)
  (for/list ([itm (my-enum lst)]
             #:when (pred itm))
    (get-ind itm)))

(find-ivpi '(1 2 3 4 3 2 1)
           (lambda (x) ; completely stupid predicate
             (and
              (< (get-elem x) 3) ; value < 3
              (> (get-ind x) 2)))) ; and index > 2

; -> (5 6)
