#lang racket
; 修改fixed-point打印出来它生成的近似数序列，然后找x^x=1000的解，x*log(x)=log(1000),
; x->log(1000)/log(x)。观察一下使用和不使用avarage-dump方法，中间经历的结果。
(define tolerance 0.00000001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (display guess)
      (newline)
      (if (close-enough? next guess)
          guess
          (try next))))
  (try first-guess))

(fixed-point (lambda (x) (/ (log 1000.0) (log x)))
             1.1)

; 在使用一下average-dump, x->(x+(log(1000)/log(x))/2
(fixed-point (lambda (x) (/ (+ (/ (log 1000.0)
                                  (log x))
                               (* 1 x))
                            2.0))
             1.1)
; 为啥average-dump收敛的更快？？？？快了一倍