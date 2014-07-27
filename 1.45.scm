#lang racket
; 在1.3.3小节，我们试图计算一个数的平方根的时候，发现原生的y<-X/y的函数在求fixed-point的时
; 候不收敛。我们引入了一个方法叫average-damp
(define (average x1 x2)
  (/ (+ x1 x2) 2))
(define (average-damp f)
  (lambda (x) (average x (f x))))

; 当我们要计算y^3=x的时候，对y<-(average-damp X/y^2)，使用一次average-dump函数，
; 求fixed-point的时候,发现这个函数也是不收敛的。但是调用average-damp 两次之后，函数就收敛
; 了
; 我们先来回顾一下基础函数--fixed-point
(define (good-enough? next guess)
  (< (abs (- next guess)) 0.00001))
(define (fixed-point f guess)
  (let ((next (f guess)))
        (if (good-enough? next guess)
            next
            (fixed-point f next))))

; 然后是compose和repeated函数
(define (compose f g)
  (lambda (x) (f (g x))))
(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

; 定义一个n次方根的解--我们就来猜测一下吧，要repeated，n-1次
; hooooo,结论不对，老老实实的(repeated average-damp M)中的M固定为2，发现n到1-7结果正常
; M固定位3，发现n1-15工作正常，推论M=(floor(/(log n) (log 2)))
(define (n-root X n)
  (fixed-point ((repeated average-damp 
                          (floor(/ (log n) (log 2))))
                (lambda (x) (/ X (expt x (- n 1)))))
               1.0))

(n-root 125 3)
(n-root 1 5)
(n-root 0.125 3)
(n-root 1000000 10)