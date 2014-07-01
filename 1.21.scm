#lang racket
(provide smallest-divisor)
;人类从很早就开始解决素数相关的问题。判定一个数是不是素数，有一种方法是找到这个数的因子。
;如下的方法就是找到数N大于1的最小因子
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) 
  (* x x))

; 使用如上方法找到199,1999,19999数的最小因子
(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)