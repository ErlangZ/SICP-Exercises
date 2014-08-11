#lang racket
; 我们使用list来表示集合S，需要计算S的所有子集
(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (n)
                             (cons (car s) n))
                           rest)))))

(subsets '(1 2 3))
