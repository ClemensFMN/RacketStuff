#lang sicp

; Exercise 1.37
; calculate a contnued fraction with k terms
; n and d are functions taking an index i and returning the value N_I and D_i, respectivley
(define (cont-frac n d k)
  (define (frac i) ; an innner function
     (if (< i k)
         (/ (n i) (+ (d i) (frac (+ i 1)))) ; all but the last term: N_i / (D_i + frac(i+1)
         (/ (n i) (d i)))) ; the last term is then N_k / D_k
  (frac 1))

; continued fraction for 1/\phi 
(cont-frac (lambda (i) 1.0) ; with d_i = 1
            (lambda (i) 1.0) ; and k_i = 1
            10) ; calculating 10 terms