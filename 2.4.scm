#lang racket
; 这是一种对于pairs的另一种表示。使用这种表示方法，证明(car (cons x y))对任何的x y参数都会返回x。

;@brief 将两个元素关联成一个“配对”
;@param x-元素1 y-元素2
;@return 返回一个函数，函数接受两个参数
(define (cons x y)          
  (lambda (m) (m x y)))

;@brief 接受一个“配对”，返回第一个元素
(define (car l)             
  (l (lambda (x y) x)))

;@brief 接受一个“配对”，返回第二个元素
(define (cdr l)
  (l (lambda (x y) y)))


(car (cons 1 2))
(cdr (cons 1 2))