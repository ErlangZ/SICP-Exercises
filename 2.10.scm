#lang racket
; Ben Bitdiddle是一个编程专家，站在Alyssa的背后，幽幽的说，原来的除法运算是可以计算除以跨度为0的区间的。
; 但是这种计算实际上是没有意义的。
; 修改Alyssa的代码检查这种情况，如果出现的话，抛出一个异常

(define (make-interval x y)
  (cons x y))
(define (upper-bound interval)
  (cdr interval))
(define (lower-bound interval)
  (car interval))
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (span-interval interval)
  (- (upper-bound interval)
     (lower-bound interval)))

(define (div-interval x y)
  (if (and (> (upper-bound y) 0) 
           (< (lower-bound y) 0))
      (error "divided interval spans 0")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound x))
                                   (/ 1.0 (lower-bound y))))))
                
(div-interval (make-interval 1 2)
              (make-interval 1 2))
(div-interval (make-interval 1 2)
              (make-interval -1 1))