#lang racket
; 定义一个过程reverse接收一个列表，然后按逆序返回列表
(define (reverse ls)
  (if (null? ls)
      ls
      (append (reverse (cdr ls))
              (cons (car ls) '()))))

;使用迭代过程
(define (reverse-iter ls)
  (define (reverse-iter-fun ls result)
    (if (null? ls)
        result
        (reverse-iter-fun (cdr ls)
                          (cons (car ls) result))))
  (if (null? ls)
      ls
      (reverse-iter-fun ls '())))

(reverse '())
(length (reverse '(1 2 3 4 5)))

(list? (reverse-iter '(1 2 3 4 5)))  
(reverse-iter '(1 2 3 4 5))

(reverse-iter '())