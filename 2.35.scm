#lang racket
; 使用accumulate和map函数，重新定义count-leaves函数，计算所有tree的叶子
(define accumulate foldr)

(define (count-leaves t)
  (accumulate + 
              0
              (map (lambda (sub-t)
                     (if (not (pair? sub-t)) 
                         1
                         (count-leaves sub-t)))
                   t)))

(count-leaves (cons (list 1 2) (list 3 4)))
                         
              
  