#lang sicp

(define (average a b)
  (/ (+ a b) 2))

(define (close-enough? a b)
  (< (abs (- a b)) .001))

; searching for zeros of a funtion using the midpoint method
(define (search f neg-p pos-p)
  (let ((mid-p (average neg-p pos-p))) ; the interval midpoint
  (if (close-enough? pos-p neg-p)
      mid-p ; the interval is close enough -> return the interval midpoint as solution
      (let ((test-value (f mid-p))) ; otherwise continue searching...
        (cond ((positive? test-value) ; depending ont he sign of the test value in the left half
               (search f neg-p mid-p))
              ((negative? test-value)
               (search f mid-p pos-p)) ; the right half
              (else mid-p)))))) ; or return the midpoint as exact result
      
; when using, be careful to correctly use neg-p (that's where f yields a negative value) and pos-p
(search (lambda (x) (sin x)) 4.0 2.0)

(define (search-v2 f p1 p2)
  (let ((f1 (f p1))
        (f2 (f p2)))
    (cond ((and (negative? f1) (positive? f2))
             (search f p1 p2))
          ((and (negative? f2) (positive? f1))
             (search f p2 p1))
          (else (error "wrong initial points")))))

; now this works as well
(search-v2 (lambda (x) (sin x)) 2.0 4.0)

