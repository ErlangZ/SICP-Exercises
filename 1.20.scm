#lang racket 
; + * 和 list方法是可以接受任意个数的参数的。有一种定义这种过程的方法称为使用dotted-tail记
; 号的定义。在一个过程定义中，最后一个参数前带点好标记，表示点号前的元素是有固定值的，而点号后
; 的元素表示这是一个列表，包含了之后所有的参数。
; 比如(define (f x y . z) <body>)
; (f 1 2 3 4 5 6) ; x=1,y=2,z=(3,4,5,6)
; 使用这种方法写一个same-parity函数，接受一个或者多个参数，返回同第一个参数相同奇偶性的参数

;@brief 至少接受一个参数,返回同第一个整数奇偶性相同的参数
;@param init 第一个参数
;@param ls 剩余的参数--不定个数的参数。
; 直接递归调用是有问题的, lisp 中似乎没有python里*运算符

(define (same-parity first . rest)
  (define (same-parity-inner init ls)
    (cond ((null? ls) '())
          ((even? init) (if (even? (car ls))
                            (cons (car ls) (same-parity-inner init (cdr ls)))
                            (same-parity-inner init (cdr ls))))
          ((odd? init) (if (odd? (car ls))
                           (cons (car ls) (same-parity-inner init (cdr ls)))
                           (same-parity-inner init (cdr ls))))))
  (same-parity-inner first rest))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)
       