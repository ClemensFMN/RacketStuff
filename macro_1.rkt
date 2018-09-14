
; following http://www.greghendershott.com/fear-of-macros/all.html

(define-syntax (say-hi stx)
    #'(displayln "hi"))

(say-hi)

(define-syntax (show-me stx)
    (print stx)
    #'(void))

(show-me '(+ 1 2))

; this takes an expression and returns a list of expressions
(syntax->datum #'(reverse-me "backwards" "am" "i" values))
(syntax->datum #'(1 + 2))

; define a simple syntax transformer
(define-syntax (reverse-me stx)
    (datum->syntax stx ; the stx is required to give the context
      (reverse (cdr (syntax->datum stx))))) ; and this builds up an S-expression

(reverse-me "backwards" "am" "i" values)



(define-syntax (my-add-v1 stx)
    (syntax-case stx ()
      [(_ e1 e2)
       #'(+ e1 e2)]))

(my-add-v1 3 4)


(define-syntax (my-eval-v1 stx)
    (syntax-case stx ()
      [(_ e1 op e2)
       #'(op e1 e2)]))

(my-eval-v1 1 - 2)



(define-syntax-rule (my-add-v2 e1 e2)
  (+ e1 e2))

(my-add-v2 3 4)


