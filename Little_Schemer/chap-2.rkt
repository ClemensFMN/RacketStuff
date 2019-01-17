#lang racket

(define (atom? a)
  (and (not (pair? a)) (not (null? a))))



(define (lat? l)
  (cond ((null? l) #t)
        ((atom? (car l)) (lat? (cdr l)))
        (else #f)))

; (lat? '(1 2)) -> #t
; (lat? '(1 '(2 3))) -> #f

(define (member? x lst)
  (cond
    ((null? lst) #f)
    (else (or (eq? (car lst) x)
              (member? x (cdr lst))))))

; (member? 1 '(1 2)) -> #t
; (member? 3 '(1 2)) -> #f

; slightly simplified version...
(define (member-v2? x lst)
  (cond
    ((null? lst) #f)
    ((eq? (car lst) x) #t)
    (else (member-v2? x (cdr lst)))))

; (member-v2? 1 '(1 2)) -> #t
; (member-v2? 3 '(1 2)) -> #f

(define (rember x lst)
  (cond
    ((null? lst) '())
    ((eq? (car lst) x) (cdr lst))
    (else (cons (car lst)
                (rember x (cdr lst))))))
  
; (rember 1 '(1 2)) -> '(2)
; (rember 2 '(1 2)) -> '(1)
; (rember 3 '(1 2)) -> '(1 2)

(define (insertR new old lst)
  (cond
    ((null? lst) '())
    ((eq? (car lst) old) (cons old
                               (cons new
                                     (cdr lst))))
    (else (cons (car lst)
                (insertR new old (cdr lst))))))

; (insertR 10 1 '(1 2 3)) -> '(1 10 2 3)
; (insertR 10 2 '(1 2 3)) -> '(1 2 10 3)
; (insertR 10 0 '(1 2 3)) -> '(1 2 3)

(define (insertL new old lst)
  (cond
    ((null? lst) '())
    ((eq? (car lst) old) (cons new
                               (cons old
                                     (cdr lst))))
    (else (cons (car lst)
                (insertL new old (cdr lst))))))

; (insertL 10 1 '(1 2 3)) -> '(10 1 2 3)
; (insertL 10 2 '(1 2 3)) -> '(1 10 2 3)
; (insertL 10 0 '(1 2 3)) -> '(1 2 3)

(define (subst new old lst)
  (cond
    ((null? lst) '())
    ((eq? (car lst) old) (cons new (cdr lst)))
    (else (cons (car lst)
                (subst new old (cdr lst))))))

; (subst 10 1 '(1 2 3)) -> '(10 2 3)
; (subst 10 2 '(1 2 3)) -> '(1 10 3)
; (subst 10 0 '(1 2 3)) -> '(1 2 3)


(define (multi-rember x lst)
  (cond
    ((null? lst) '())
    ((eq? (car lst) x) (multi-rember x (cdr lst)))
    (else (cons (car lst)
                (multi-rember x (cdr lst))))))

; (multi-rember 1 '(1 2)) -> '(2)
; (multi-rember 2 '(1 2 2)) -> '(1)
; (multi-rember 2 '(1 2 2 3 4 2)) -> '(1 3 4)


(define (multi-subst new old lst)
  (cond
    ((null? lst) '())
    ((eq? (car lst) old) (cons new (multi-subst new old (cdr lst))))
    (else (cons (car lst)
                (multi-subst new old (cdr lst))))))

; (multi-subst 10 1 '(1 2 3)) -> '(10 2 3)
; (multi-subst 10 2 '(1 2 3 2)) -> '(1 10 3 10)
; (multi-subst 10 0 '(1 2 3)) -> '(1 2 3)