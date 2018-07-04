#lang racket


(define ht (hash "apple" 'red "banana" 'yellow))
(hash-ref ht "apple")

(define ht2 (hash-set ht "coconut" 'brown))
; nope: (hash-ref ht "coconut")
(hash-ref ht "coconut" 0)
(hash-ref ht2 "coconut")

(define ht3 #hash((1 . "one") (2 . "two")))


(hash-ref ht3 1)