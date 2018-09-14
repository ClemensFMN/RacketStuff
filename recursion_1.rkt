(define (anyoddp xs)
  (cond ((empty? xs) #f)
        ((odd? (first xs)) #t)
        (else (anyoddp (rest xs)))))


(anyoddp '(1))
(anyoddp '(2))
(anyoddp '(1 2))
(anyoddp '(2 1))


(define (my-length-1 xs)
  (cond ((empty? xs) 0)
        (else (+ 1 (my-length-1 (rest xs))))))

(my-length-1 '(1 2 3))


(define (my-length-2 xs)
  (define (pfunc xsp acc)
    (cond ((empty? xsp) acc)
          (else (pfunc (rest xsp) (+ 1 acc)))))
  (pfunc xs 0))

(my-length-2 '(1 2 3))


