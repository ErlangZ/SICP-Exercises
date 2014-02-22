#lang racket
(provide make-interval)
(provide lower-bound)
(provide upper-bound)
(provide add-interval)
(provide sub-interval)
(provide mul-interval)
(provide div-interval)

; 创建一个区间
(define (make-interval x y)
  (if (> x y)
      (printf "something is wrong with make-interval(~a,~a)" x y)
      (cons x y)))

; 区间上界
(define (lower-bound i) (car i))

; 区间下界
(define (upper-bound i) (cdr i))

; 计算宽度
(define (width i)
  (/ (- (upper-bound i)
        (lower-bound i)) 
     2))

; 区间加法
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

; 区间减法
(define (sub-interval x y)
  (if (< (width x) (width y))
      (error "sub-interval fail. result width is negtive")
      (make-interval (- (lower-bound x) (lower-bound y))
                 (- (upper-bound x) (upper-bound y)))))

; 区间乘法
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

; 区间除法
(define (div-interval x y)
  (if (and (< (lower-bound y) 0) (> (upper-bound y) 0))
      (error "divided interval should not contain 0")
      (let ((p1 (/ (lower-bound x) (lower-bound y)))
            (p2 (/ (lower-bound x) (upper-bound y)))
            (p3 (/ (upper-bound x) (lower-bound y)))
            (p4 (/ (upper-bound x) (upper-bound y))))
        (make-interval (min p1 p2 p3 p4)
                       (max p1 p2 p3 p4)))))