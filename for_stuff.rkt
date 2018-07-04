#lang racket

(for ([i (range 10)])
  (display i))

(define f1
  (for/list ([i (range 10)]
             #:when (even? i))
  i))

(define f2
  (for/list ([i (range 10)])
  (list i (* i i))))

; if there are several clauses, it steps in parallel over the values
(define f3
  (for/list ((i (range 0 5))
             (j (range 5 10)))
    (list i j)))

(define f4
  (for*/list ((i (range 0 5))
             (j (range 5 10)))
    (list i j)))


; we need the for* variant here in order to run over all values in parallel
(define f5
  (for*/list ((i (range 10))
             (j (range 10))
             #:when (= (+ i j) 10))
    (list i j)))

(define f6
  (for*/list ((i (range 1 10))
             (j (range 1 10))
             (k (range 1 10))
             #:when (= (sqr i) (+ (sqr j) (sqr k))))
    (list i j k)))