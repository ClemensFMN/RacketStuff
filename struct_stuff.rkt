(struct style (color size weight) #:transparent #:mutable)
(define s (style "red" 42 'bold))

; by defining a struct, we get a bunch of additional methods:

(style? s)
(style-color s)
(style-size s)
(style-weight s)


