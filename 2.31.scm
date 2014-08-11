#lang racket
;定义一个 (define (square-tree tree) (tree-map square tree))

(define (square x) (* x x))
;注意map实际上操作的是每个列表的子元素
(define (tree-map proc tree) 
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map proc sub-tree)
             (proc sub-tree)))
       tree))

(define (square-tree tree) (tree-map square tree))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))