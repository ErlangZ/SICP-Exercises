#lang racket
; 这个表达式是#t
(equal? '() '())

; 这个表达式是#t
(equal? '(this is a list) '(this is a list))

; 这个表达式是#f
(equal? '(this is a list) '(this (is a) list))

; eq? 可以用来判断符号是否相同
(eq? 'a 'a)
(eq? 'a 'b)

; 我们重新定义一下equal? -- null 是相等的，两个symbol相等才是#t
; 然后是两个list的递归定义
(define (my-equal? a b)
  (cond 
    ((and (null? a) (null? b) #t))
    ((and (symbol? a) (symbol? b) (eq? a b)) #t)
    ((and (list? a) (list? b))
     (and (my-equal? (car a) (car b))
          (my-equal? (cdr a) (cdr b))))
    (else #f)))
(my-equal? '() '())
(my-equal? '(this is a list) '(this is a list))
(my-equal? '(this is a list) '(this (is a) list))
              
        