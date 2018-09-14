; a blank cell contains values 1..9
(define blank-board-cell (for/list ([x 9]) (+ 1 x)))

; shortcut for blank cells
(define bc blank-board-cell)

(define problem-board
  (vector (vector '(5) '(3)   bc   bc   '(7)   bc   bc   bc   bc)
          (vector '(6)   bc   bc   '(1) '(9)   '(5) bc   bc   bc)
          (vector   bc '(9)   '(8) bc   bc     bc   bc   '(6) bc)
          (vector '(8) bc     bc   bc   '(6)   bc   bc   bc   '(3))
          (vector '(4) bc     bc   '(8) bc     '(3) bc   bc   '(1))
          (vector '(7) bc     bc   bc   '(2)   bc   bc   bc   '(6))
          (vector bc   '(6)   bc   bc   bc     bc   '(2) '(8) bc)
          (vector bc   bc     bc   '(4) '(1)   '(9) bc   bc   '(5))
          (vector bc   bc     bc   bc   '(8)   bc   bc   '(7) '(9))))

; all positions in the board 
(define all-pos
  (for*/list ((x 9)
              (y 9))
    (list x y)))

; retrieve board value
(define (board-ref b row col)
  (vector-ref (vector-ref b row) col))


(define (ineq? x y)
  (not (= x y)))

; given a row/col position, provide the coords of all row neighbours WITHOUT row/col
(define (coords-row-neighbours row col)
  (for/list ([c 9]
             #:when (ineq? c col))
  (list row c)))

; provide all column neighbours
(define (coords-col-neighbours row col)
  (for/list ([r 9]
             #:when (ineq? r row))
  (list r col)))


(define (get-range x)
  (range (* 3 (floor (/ x 3))) (* 3 (+ 1 (floor (/ x 3))))))

(get-range 6) ; -> '(6 7 8)

; provide all block neighbours
(define (coords-block-neighbours row col)
  (for*/list ([x (get-range row)]
              [y (get-range col)]
              #:when (or (ineq? y col) (ineq? x row)))
      (list x y)))

(coords-block-neighbours 0 2)

; get values from board b at positions coord
(define (get-vals b coords)
  (for/list ((c coords))
    (board-ref b (first c) (last c))))

(get-vals problem-board (coords-row-neighbours 0 0))

; get the relevant neighbour values for a row/col position
(define (get-neighbour-values b row col)
  (let* ((coords (append
                  (coords-row-neighbours row col)
                  (coords-col-neighbours row col)
                  (coords-block-neighbours row col)))
          (vals (get-vals b coords))
          (relevant-vals (filter (lambda (x) (= 1 (length x)))
                                  vals)))
  (remove-duplicates (flatten relevant-vals))))


(get-neighbour-values problem-board 0 2)

; update a board at row/col with new-cell
(define (board-update b target-row target-col new-cell)
  (for/vector ([row 9])
    (for/vector ([col 9])
      (cond [(and (= row target-row)
                  (= col target-col))
             new-cell]
            [else (board-ref b row col)]))))

(require racket/set)

; constraint propagation: set diff of two sets
(define (const-prop-val own other)
  (set->list (set-subtract (list->set own) (list->set other))))

(const-prop-val '(1 2 3) '(1 2))

; constraint propagation for one position
(define (const-prop-position b coord)
  (let* ((row (first coord))
         (col (last coord))
         (nvals (get-neighbour-values b row col))
         (newval (const-prop-val (board-ref b row col) nvals)))
    (board-update b row col newval)))

(define res (const-prop-position problem-board (list 0 2)))
(board-ref res 0 2)

; constraint prop over all positions ONCE
(define (const-prop-round b)
  (foldl (lambda (coord b) (const-prop-position b coord))
    b
    all-pos))

(const-prop-round (const-prop-round (const-prop-round(const-prop-round (const-prop-round problem-board)))))
(const-prop-round (const-prop-round (const-prop-round (const-prop-round(const-prop-round (const-prop-round problem-board))))))

; constraint prop until nothing changes anymore
(define (const-prop b)
  (if (equal? b (const-prop-round b))
    b
    (const-prop (const-prop-round b))))

(const-prop problem-board)



