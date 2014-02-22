#lang racket
; 定义一个函数，可以返回list的最后一个元素
(define (last-pair ls)
  (if (null? ls)
      '()
      (if (null? (cdr ls))
          ls
          (last-pair (cdr ls)))))

(last-pair (list 1 4 9 16 25))