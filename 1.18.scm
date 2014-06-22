#lang racket
; 使用1.16和1.17的习题结果，设计一个迭代过程来计算两个整数的乘法。只使用add,double,halve
; 并且时间复杂度是对数级别的。
(define (mul-fast a b)
  (mul-fast-iter 0 a b))

(define (mul-fast-iter result a b)
  (if (= b 0)
      result
      (if (even? b)
          (mul-fast-iter result (double a) (halve b))
          (mul-fast-iter (add result a) (double a) (halve (- b 1))))))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define add +)