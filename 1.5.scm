#lang racket
; Ben Bitdiddle发明了一种测试方法来检测解释器使用的事应用序还是标准序。他定义了下边两个过程
(define (p) (p))

(define (test x y)
  (if (= x 0) 0 y))

;然后计算，立即返回0，说明是正则序；程序不断进行尾递归，也不返还，说明是应用序
(test 0 (p))
