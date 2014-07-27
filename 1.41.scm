#lang racket
; 定义一个double过程，传入一个函数，然后返回一个重复计算这个函数两次的函数。比如inc函数将一
; 个数加1，(double inc)就是加2
; 求(double (double double)) inc) 5)的值 = 5 + 1 * 2 * 2 * 2
(define (double g)
  (lambda (x) (g (g x))))
(define (inc x) (+ x 1))

(((double (double double)) inc) 5)