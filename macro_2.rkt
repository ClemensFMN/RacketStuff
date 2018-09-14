#lang racket

; does NOT work as define-macro is legacy and not recommended...
(define-macro (report expr)
  #'(begin
      (displayln (format "input was ~a" 'expr))
      expr))
                 
