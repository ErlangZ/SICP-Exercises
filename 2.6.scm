#lang racket
; 如果说使用过程来表示pair不够考验智商，想想在一门可以操作过程的语言中，我们可以使用过程来表示数字(至少到现在为止，我们还没有考虑过负数)。我们可以先实现数字0，然后实现加1的操作。

(define (zero f)
  (lambda (f)
    (lambda (x) x)))

(define (add-1 n)
  (lambda (f)
    (lambda (x) (f ((n f) x)))))

; 这种表示被称为Church数，以它的发明人的名字命名，Alonzo Church，他提出了λ运算。
; 按照这种方式，定义数字one 和数字two

; 使用递推关系定义
;(define one
;  (add-1 zero))

;(define two
;  (add-1 two))

; 使用替换模型，看一下one的计算过程
; (define one
;  (lambda (f)
;    (lambda (x) (f ((zero f) x)))))
; 继续替换
; (define one
;  (lambda (f)
;    (lambda (x) (f ((lambda (x) x) x))))
; 继续
; (define one
;  (lambda (f)
;    (lambda (x) (f x)))

; 使用替换模型，看一下two的计算模型
; (define two
;   (lambda (f)
;     (lambda (x) (f ((one f) x)))))
; 继续替换
; (define two
;   (lambda (f)
;     (lambda (x) (f ((lambda (x) (f x)) x)))
; 继续
; (define two
;   (lambda (f)
;     (lambda (x) (f (f x))))

; 那么规范化这个定义

(define one
  (lambda (f)
    (lambda (x) (f x))))
(define two
  (lambda (f)
    (lambda (x) (f (f x)))))
