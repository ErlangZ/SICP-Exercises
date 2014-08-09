#lang racket
; 有一个叫Reasoner的人重写了square-list过程，他的定义过程如下
(define (square x) (* x x))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))

(square-list (list 1 2 3 4))

; 很显然，出来的结果是倒的。有个叫Louis的人对代码进行了修改
(define (square-list-2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items '()))

; 当然，这是一列 nil. 1 . 4 . 9 . 16
(square-list-2 (list 1 2 3 4))
