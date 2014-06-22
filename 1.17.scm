#lang racket
; 本节提到的指数算法是基于重复乘法的。近似的，我们也可以通过重复加法来进行乘法运算。接下来的
; 过程同expt算法是同质的。

(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

; 如上的算法的时间复杂度是随着b的大小线性增长的。现在假设我们定义一个叫做double的运算，将一
; 个整数乘2；还有一种运算叫做halve就是将一个数字除以2。通过使用这些方法，我们可以设计一种方
; 法同expt-fast算法是同质的，以指数复杂度来计算乘法

(define (mul-fast a b)
  (if (= b 0)
      0
      (if (even? b)
          (mul-fast (double a) (halve b))
          (+ a (mul-fast (double a) (halve (- b 1)))))))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))