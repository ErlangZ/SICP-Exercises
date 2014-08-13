#lang racket
; 使用foldr和foldl进行reverse的定义
(define (reverse-r sequence)
  (foldr (lambda (x y) (append y (list x))) '() sequence))
(reverse-r (list 1 2 3 4))


(define (reverse-l sequence)
  (foldl (lambda (x y) (cons x y)) '() sequence))
(reverse-l (list 1 2 3 4))