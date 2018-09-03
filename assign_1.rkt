; using assignment to sum up numbers...
(define (my-sum n)
	(let ((sum 0))
		(for ([i (range (+ n 1))])
			(set! sum (+ sum i)))
		sum))

(my-sum 5)

; probably better
(define (my-sum-v2 n)
  (let loop ([nint n] [s 0])
    (if (= 0 nint)
        s
        (loop (- nint 1) (+ s nint)))))

(my-sum-v2 5)