#lang racket
; Ben Bitdiddle是一个编程专家，站在Alyssa的背后，幽幽的说，原来的除法定义无法解释被除的区间跨度为0的情况。修改Alyssa的代码检查这种情况，如果出现的话，抛出一个异常

(define (span-interval interval)
  (- (upper-bound interval)
     (lower-bound interval)))

(define (div-interval x y)
  (if (= 0 (span-interval y))
      (error "the span of divided interval is 0")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound x))
                                   (/ 1.0 (lower-bound y))))))
                