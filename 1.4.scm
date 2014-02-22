#lang racket
; 通过观察可以得知，我们的计算模型允许运算符也是表达时候的计算结果
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(a-plus-abs-b 1 -2)
(a-plus-abs-b 1 2)
(a-plus-abs-b 1 0)