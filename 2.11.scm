#lang racket
; 在过去，Ben也幽幽的说了句“通过测试端点的符号，可以将mul-interval分解为九种情况，其中只有一个要求超过两次乘法运算”。根据这个提示，重写这个过程;

; 思路：每个区间以0为分界点，可以分为3种情况；两个区间的组合就一共有9种情况
; (1,2).(-1,2).(-2,-1)同(3,4).(-3,4).(-4,-3)的组合
(require "interval-arthmetic.scm")

(define (mul-interval x y)
  (cond  ((and (positive? (lower-bound x)) (positive? (lower-bound y))) 
         (make-interval (* (lower-bound x) (lower-bound y))
                        (* (upper-bound x) (upper-bound y))))
         
         ((and (positive? (lower-bound x)) (positive? (upper-bound y)) (negative? (lower-bound y)))
         (make-interval (* (upper-bound x) (lower-bound y))
                        (* (upper-bound x) (upper-bound y))))
         
         ((and (positive? (lower-bound x)) (negative? (upper-bound y)))
         (make-interval (* (upper-bound x) (lower-bound y))
                        (* (lower-bound x) (upper-bound y))))
         
         ((and (negative? (upper-bound x)) (positive? (lower-bound y)))
         (make-interval (* (lower-bound x) (upper-bound y))
                        (* (upper-bound x) (lower-bound y))))
         
         ((and (negative? (upper-bound x)) (positive? (upper-bound y)) (negative? (lower-bound y)))
         (make-interval (* (lower-bound x) (upper-bound y))
                        (* (lower-bound x) (lower-bound y))))
         
         ((and (negative? (upper-bound x)) (negative? (upper-bound y)))
         (make-interval (* (upper-bound x) (upper-bound y))
                        (* (lower-bound x) (lower-bound y))))
         
         ((and (positive? (upper-bound x)) (negative? (lower-bound x)) (negative? (upper-bound y)))
         (make-interval (* (upper-bound x) (lower-bound y))
                        (* (lower-bound x) (lower-bound y))))
         
         ((and (positive? (upper-bound x)) (negative? (lower-bound x)) (positive? (lower-bound y)))
         (make-interval (* (lower-bound x) (upper-bound y))
                        (* (upper-bound x) (upper-bound y))))
         
         ((and (positive? (upper-bound x)) (negative? (lower-bound x)) (positive? (upper-bound y)) (negative? (lower-bound y)))
          (let ((p1 (* (lower-bound x) (upper-bound y)))
                (p2 (* (lower-bound x) (lower-bound y)))
                (p3 (* (upper-bound x) (upper-bound y)))
                (p4 (* (upper-bound x) (lower-bound y))))
         (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))))

(define (test-mul-interval interval1 interval2 except-result)
  (if (not (equal-interval (mul-interval interval1 interval2) except-result))      
      (begin
        (display "bad case:")
        (print-interval interval1)
        (print-interval interval2)
        (display " real-result:")
        (print-interval (mul-interval interval1 interval2))
        (display" except-result:")
        (print-interval except-result)
        (display"\n"))      
      #t))
(map test-mul-interval (list (list (make-interval 0 2) (make-interval 3 4) (make-interval 0 8))
                             (list (make-interval 1 2) (make-interval 3 4) (make-interval 3 8))))
(test-mul-interval (make-interval 0 2) (make-interval 3 4) (make-interval 0 8))
(test-mul-interval (make-interval 1 2) (make-interval 3 4) (make-interval 3 8))
(test-mul-interval (make-interval 1 2) (make-interval 3 4) (make-interval 3 8))
(test-mul-interval (make-interval 1 2) (make-interval -3 4) (make-interval -6 8))
(test-mul-interval (make-interval 1 2) (make-interval -4 -3) (make-interval -8 -3))
(test-mul-interval (make-interval -1 2) (make-interval 3 4) (make-interval -4 8))
(test-mul-interval (make-interval -1 2) (make-interval -3 4) (make-interval -6 8))
(test-mul-interval (make-interval -2 1) (make-interval -3 4) (make-interval -8 6))
(test-mul-interval (make-interval -1 2) (make-interval -4 -3) (make-interval -8 4))
(test-mul-interval (make-interval -2 -1) (make-interval 3 4) (make-interval -8 -3))
(test-mul-interval (make-interval -2 -1) (make-interval -3 4) (make-interval -8 6))
(test-mul-interval (make-interval -2 -1) (make-interval -4 -3) (make-interval 3 8))