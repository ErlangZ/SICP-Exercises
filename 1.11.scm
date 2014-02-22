#lang racket
; 有一个函数f遵从这个规则，当n<3时f(n)=n， 否则, f(n) = f(n-1) + 2f(n-2) + 3f(n-3)
; 分别使用递归和迭代过程对他们进行定义
(define (f n)
  (if (< n 3)
      n
      (+ (* 1 (f(- n 1))) 
         (* 2 (f(- n 2)))
         (* 3 (f(- n 3))))))


(define (f-iter fn-minus-1 fn-minus-2 fn-minus-3 i n)
    (let ((fn (+(* 1 fn-minus-1)(* 2 fn-minus-2)(* 3 fn-minus-3))))
      (if (= i n)
          fn
          (f-iter fn fn-minus-1 fn-minus-2 (+ 1 i) n))))

(define (f-linear n)
  (if (< n 3) 
      n
      (f-iter 2 1 0 3 n)))

(map f (build-list 10 values))
(map f-linear (build-list 10 values))