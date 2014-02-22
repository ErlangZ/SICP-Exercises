#lang racket
; 使用Alyssa类似的方法，描述如何计算两个区间的差值。定义一个相应的减法过程，被叫做sub-interval
(require "2.7.scm")
(require "interval-arthmetic.scm")

(define (sub-interval a b)
  (add-interval a
                (make-interval (- 0 (lower-bound b))
                               (- 0 (upper-bound b)))))



(let ((A (make-interval 1 2)))
  (sub-interval A A))

;sub-interval 也是同样
(sub-interval (make-interval 1 2) (make-interval 1 2))