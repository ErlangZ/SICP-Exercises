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
  (if (= r 0) 
      d 
      (gcd r (modulo d r))))

(define (reduce-left op init ls) 
  (if (null? ls)
      init
      (op (car ls) 
          (reduce-left 
           op init 
           (cdr ls)))))

(define (make-rat numerator denominator)
  (let ((divisor (abs 
                  (gcd numerator 
                       denominator)))
        (signal (reduce-left
                 * 
                 1 
                 (map 
                    (lambda (x) (cond ((> x 0) 1)
                                      ((= x 0) 0)
                                      ((< x 0) -1)))
                    (list numerator denominator)))))
    (cons (* signal (/ (abs numerator) 
                       (if (= 0 divisor) 1 divisor)))
          (/ (abs denominator) 
             (if (= 0 divisor) 1 divisor)))))

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


