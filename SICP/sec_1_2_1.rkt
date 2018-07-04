#lang sicp

(define (factorial n)
  (fact-iter 1 1 n))

; a linear iterative proces
(define (fact-iter product counter max-count) ; product is the running product, counter the number of iterations done so far
  (if (> counter max-count) ; finished?
      product ; -> yes, return product
      (fact-iter (* counter product) ; otherwise, call again with updated counter
                 (+ 1 counter) ; increased counter
                 max-count))) ; and unchanged max-count

