#lang racket
; 假设f和g是两个单参数函数，f在s之后的composition，被定义成f(g(x))。定义一个composite函
; 数来实现这个过程.inc是累加函数
(provide compose)

(define (inc x) (+ x 1))
(define (square x) (* x x))

(define (compose f g) 
  (lambda (x) (f (g x))))


((compose square inc) 6) ; (6+1)^2=49