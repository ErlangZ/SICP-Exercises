#lang racket
; 原文中定义了fix-pointed方法求牛顿法，我们先来回顾一下

;定义fixed-point
(define (fixed-point G guess)
  (define (good-enough? next guess)
    (< (abs (- next guess)) 0.00001))
  (let ((next (G guess)))
    (if (good-enough? next guess)
        next
        (fixed-point G next))))

;定义一个抽象的fixed-point方法
(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

; 使用抽象的fixed-point方法定义newton-method。牛顿法实际上就是x-y/斜率, 这个函数不变了
; 就是零点
(define (newton-method G guess)
  (define (newton-transform g)
    (lambda (x) (- x (/ (g x) ((deriv g) x)))))
  (fixed-point-of-transform G newton-transform guess))

; 当然，这里缺一个求导函数
(define (deriv g)
  (let ((dx 0.00001))
    (lambda (x)
      (/ (- (g (+ x dx)) (g x))
         dx))))

(define (cube x) (* x x x)); 定义一个立方函数 x^3
((deriv cube) 2) ; 3*x^2 = 12
(newton-method (lambda (y) (- (* y y) 4)) 1.0); 算sqrt(4)的，y-x^2的零点，x=2

; 按照题目的原意，(newtons-method (cubic a b c) 1)
(define (cubic a b c) 
  (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))

; ok，我们可以试试-1 是x^3+1的一个零点
(newton-method (cubic 0 0 1) 1.0)
