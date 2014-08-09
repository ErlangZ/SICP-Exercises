#lang racket
; 写一个fringe过程接受一棵树（使用list表示），返回一个列表列出这棵树的所有叶子元素。
(define x (list (list 1 2) (list 3 4)))

(define (fringe tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (cons tree '()))
        (else
         (append (fringe (car tree))
                 (fringe (cdr tree))))))

(fringe x)
(fringe 1)
(fringe '())
(fringe '(1 2 3))
(fringe '(1 (2 3)))
         