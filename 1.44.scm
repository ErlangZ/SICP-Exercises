#lang racket
; 对一个函数进行smoothing，在信号处理领域里是一个重要的概念。如果f是一个函数，dx是一个很小
; 的数,那么f在x上的平滑版本是f(x-dx),f(x),f(x+dx)的平均值。写一个函数smooth，将f作为一
; 个参数，返回平滑之后的f版本。有时候，连续n次平滑的意义重大，就是说要连续的平滑，平滑之后的
; 函数。请用repeated和smooth实现之
(require "1.43.scm")

(define (mean-3 x1 x2 x3) (/ (+ x1 x2 x3) 3))

(define (smooth f dx)
  (lambda (x)
    (mean-3 (f (- x dx))
            (f x)
            (f (+ x dx)))))

(define (smooth-n f dx n)
  (repeated (smooth f dx) n))

; 我们用sin函数试验一下,可以用excel画一个sin函数，然后平滑-可以看到sin函数变扁了
; 也可以用阶梯函数试一下
(sin (/ pi 2))

((smooth sin 0.7) (/ pi 2))

(sin pi)
((smooth sin 0.7) pi)

((smooth-n sin 0.7 2) (/ pi 2))