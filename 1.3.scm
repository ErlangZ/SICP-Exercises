#lang racket
; 定义一个过程接收三个参数，返回两个大数的平方和

(define (larger-two-square-sum a b c)
  (square-sum (max a b c) (mid a b c)))

(define (square-sum x y)
  (+ (square x) (square y)))

(define (square x)
  (* x x))

(define (mid a b c)
  (cond ((or (and (>= a b) (>= b c)) (and (>= c b) (>= b a))) 
             b)
        ((or (and (>= b a) (>= a c)) (and (>= c a) (>= a b)))
             a)
        (else c)))

; test-code
(display "test-mid\n")
(mid 1 2 3)
(mid 2 1 3)
(mid 3 1 2)
(mid 3 2 1)
(mid 1 3 2)
(mid 2 3 1)
(mid 1 2 2)
(mid 1 1 1)

(display "test-larger-two-square-sum\n")
(larger-two-square-sum 1 2 3)
(larger-two-square-sum 2 1 3)
(larger-two-square-sum 3 1 2)
(larger-two-square-sum 3 2 1)
(larger-two-square-sum 1 3 2)
(larger-two-square-sum 2 3 1)
(larger-two-square-sum 1 2 2)
(larger-two-square-sum 1 1 1)