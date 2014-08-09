#lang racket

; 定义两个数据x和y，写出解释器对下列数据的结果
(define x (list 1 2 3 4))
(define y (list 4 5 6))

; '(1 2 3 4 4 5 6)
(append x y)

; '((1 2 3 4) 4 5 6)
(cons x y)

; '((1 2 3 4) (4 5 6))
(list x y)
