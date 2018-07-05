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

; helper function for remove duplications
(define (add-if-not-in-list e xs)
  (if (member e xs)
    xs
    (cons e xs)))

; remove duplicates from list: build up an accumulator using add-if-not-in-list; 
; i.e. the accumulator is only updated with an item it the item is not already 
; in the accumulator 
(define (remove-dup xs)
  (reverse 
    (foldl add-if-not-in-list '() xs)))

(remove-dup '(1 2 1 3 5 1 3))


