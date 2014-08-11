#lang racket
; 定义一个对树元素进行平方的函数
(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (* sub-tree sub-tree)))
       tree))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

; -- map本质上是for，所以，本质上就是如下的函数
(define (square-tree-2 tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree-2 (car tree))
                    (square-tree-2 (cdr tree))))))

(square-tree-2
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
      