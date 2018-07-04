#lang racket

(define (f1 x)
  (+ x 1))

(define (myfact n)
  (cond ((= n 1) 1)
        (else (* n (myfact (- n 1))))))

(define (myfact-v2 n acc)
  (cond ((= n 1) acc)
        (else (myfact-v2 (- n 1) (* n acc)))))

(define (mylen xs)
  (cond ((empty? xs) 0)
        (else (+ 1 (mylen (cdr xs))))))

(define (mymap f xs)
  (cond
    [(empty? xs) empty]
    [else (cons (f (car xs))
                (mymap f (rest xs)))]))

(define (myfilter f xs)
  (cond ((empty? xs) '())
        ((f (car xs)) (cons (car xs) (myfilter f (cdr xs))))
         (else (myfilter f (cdr xs)))))