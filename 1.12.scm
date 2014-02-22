#lang racket
; 下边的模式描述了帕斯卡三角
;         1
;       1   1
;     1   2   1
;   1   3   3   1
; 所有在三角边缘的数都是1，每个三角形内部的数都是上方两个数的和。使用递归过程，写一个获取帕斯卡三角元素的函数

(define (fold-in-half m n)
  (define (mid-point m)
    (/ (if (odd? m) (+ 1 m) m)
       2))
  (if (<= n (mid-point m))
      n
      (- n (mid-point m))))


         
(define (pascal-triangle m n)
  (cond ((< m n) (error "pascal-triangle's row number has to be larger than col number r:~a c:~a" m n))
        ((or (<= m 0) (<= n 0)) (error "pascal-triangle's row&col number has to be larger than 0 r:~a c:~a" m n))
        ((or (= n 1) (= n m)) 1)
        (else (+ (pascal-triangle (- m 1) (- n 1))
                 (pascal-triangle (- m 1) n)))))
      

(pascal-triangle 1 1)
(pascal-triangle 2 1)
(pascal-triangle 2 2)
(pascal-triangle 3 1)
(pascal-triangle 3 2)
(pascal-triangle 3 3)
(pascal-triangle 4 1)
(pascal-triangle 4 2)
(pascal-triangle 4 3)
(pascal-triangle 4 4)

(fold-in-half 1 1)
(fold-in-half 2 1)
(fold-in-half 2 2)
(fold-in-half 3 1)
(fold-in-half 3 2)
(fold-in-half 3 3)