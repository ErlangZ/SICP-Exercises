#lang racket
; 计算一个关于x的多项式， Anx^n+A(n-1)x^(n-1)+...+A1x^1+A0，可以使用Horner法则计算
(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ (* x higher-terms) this-coeff))
              0
              coefficient-sequence))

; 计算 1 + 3x + 5x^3 + x^5, 其中x=2，结果应该是1+6+40+32=79 
(horner-eval 2 (list 1 3 0 5 0 1))