(require net/url)
(require json)

(define u (string->url "http://now.httpbin.org/"))

(define prt (get-pure-port u))

(define response-string (port->string prt))
(close-input-port prt)

(string->jsexpr response-string)


