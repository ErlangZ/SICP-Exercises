#lang racket
;定义一个make-rat的改进版，可以同时处理正参数和负参数。make-rat应该可以对符号进行归一化。这样，如果
;有理数是正的，那么分子分母都是正的。如果有理数是负的，那么只有分子是负的，分母是正数。

(provide make-rat)
(provide add-rat)
(provide sub-rat)
(provide mul-rat)
(provide div-rat)
(provide equal-rat)
(provide numer)
(provide denom)

(define (gcd d r)
  (if (= r 0) d
      (gcd r (remainder d r))))

(gcd -2 3) ; = 1
(gcd 2 -3) ; = -1
(gcd -2 -6) ; = -2
(gcd -2 -3) ; = -1
(gcd 2 3) ; = 1

;@brief： 返回一个数的相反数
;@param x -一个自然数
(define (negative x) (- x))

; 从题目中的意思可以看出，分子可以是负数，分母就一定得是正数
; @brief: 给出一对分子和分母，返回一个分母是正数的有理数,并且化简成最简形式
(define (make-rat numerator denominator)
  (let ((GCD (gcd numerator denominator)))
    (if (< (/ denominator GCD) 0)
        (cons (negative (/ numerator GCD))
              (negative (/ denominator GCD)))
        (cons (/ numerator GCD) 
              (/ denominator GCD)))))

(make-rat 2 -4) ; -1/2
(make-rat -2 -4) ; 1/2
(make-rat 2 4) ; 1/2
(make-rat -2 4) ; -1/2

(define (numer rat)
  (car rat))

(define (denom rat)
  (cdr rat))

(define (add-rat x y)
  (make-rat (+ (*(numer x) (denom y))
               (*(numer y) (denom y)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (*(numer x) (denom y))
               (*(numer y) (denom y)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))


