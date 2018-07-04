(struct style (color size weight) #:transparent #:mutable)
(define s (style "red" 42 'bold))

; by defining a struct, we get a bunch of additional methods:

(style? s)

; getters
(style-color s)
(style-size s)
(style-weight s)


; and if the whole thing is set as mutable, we get setters as well

(set-style-color! s "green")
(set-style-size! s 10)
(set-style-weight! s 'italic)
