#lang racket 
; f(x)=x的位置就可以称作函数f(x)的fix-point。有些函数，我们可以定义由一个初始值，不断迭代
; f(x),f(f(x)),f(f(f(x)))...来找到fix-point。
; 请注意，这里f作为了fixed-point的参数
(define tolerance 0.0000001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; 可以找到cos 函数的fixed-point
(fixed-point cos 1.0)
; 同理，也可以找到y=siny+cosy的fixed-point
(fixed-point (lambda (y) (+ (cos y) (sin y))) 
             1.0)

;实际上，黄金分割率是函数x->1+1/x的fixed-point
(fixed-point (lambda (x) (+ 1 (/ 1.0 x)))
             1.0)