#lang racket

(define (member? x lst)
  (cond
    ((null? lst) #f)
    (else (or (eq? (car lst) x)
              (member? x (cdr lst))))))

(define (set? lst)
  (cond
    ((null? lst) #t) ; we are done, no duplicates found -> set
    ((member? (car lst) (cdr lst)) #f) ; car lst is contained in the cdr of lst -> no set
    (else (set? (cdr lst))))) ; keep on searching for duplicates

; (set? '()) -> #t
; (set? '(1 2 3)) -> #t
; (set? '(1 1 3)) -> #f

(define (make-set lst)
  (cond
    ((null? lst) '()) ; we are done
    ((member? (car lst) (cdr lst)) (cdr lst)) ; car is a duplicate -> continue with cdr of lst
    (else (cons (car lst)
                (make-set (cdr lst))))))

; (make-set '()) -> '()
; (make-set '(1 2)) -> '(1 2)
; (make-set '(1 2 1)) -> '(2 1)

; is set1 a subset of set2
(define (subset? set1 set2)
  (cond
    ((null? set1) #t) ; we are done
    (else
     (and (member? (car set1) set2)
          (subset? (cdr set1) set2)))))

; (subset? '(1) '(1 2)) -> #t
; (subset? '(2) '(1 2)) -> #t
; (subset? '(3) '(1 2)) -> #f
; (subset? '(1 2) '(1 2)) -> #t
; (subset? '(1 2 3) '(1 2)) -> #f
; (subset? '(1 3) '(1 2)) -> #f