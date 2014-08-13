#lang racket
; 使用accumulate 来定义基础的列表操作

; @brief 将序列seq通过op二元操作压缩为一个最终答案
(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

(accumulate + 0 (list 1 2 3 4 5))

; @brief map也可以由accumulate定义
(define (map proc seq)
  (accumulate (lambda (x y) (cons (proc x) y))
              '()
              seq))

(define (inc x) (+ x 1))
(map inc (list 1 2 3 4 5))

; @brief append函数可以由accumulate定义,append实际上也可以由map实现
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(append (list 1 2 3 4 5) (list 6 7 8 9 10))

; @brief length函数是有accumulate函数定义
(define (length seq)
  (accumulate (lambda (x y) (+ 1 y)) 0 seq))
(length (list 1 2 3 4 5))
(length (list 1))
(length '())
