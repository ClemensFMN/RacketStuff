#lang racket


(define ht (hash "apple" 'red "banana" 'yellow))
(hash-ref ht "apple")

(define ht2 (hash-set ht "coconut" 'brown))
; nope: (hash-ref ht "coconut")
(hash-ref ht "coconut" 0)
(hash-ref ht2 "coconut")

(define ht3 #hash((1 . "one") (2 . "two")))


(hash-ref ht3 1)
(hash-ref ht3 3 0) ; provide a default value to return if key is not found


(define ht4 (hash "one" 1 "two" 2))

(define (inc x) (+ x 1))

(hash-update ht4 "three" inc 0)


(define (word-cnt lst)
  (foldl (lambda (x acc)
           (hash-update acc x inc 0))
    (hash)
    lst))

(word-cnt
 (string-split "hallo clemens hallo hallo"))



