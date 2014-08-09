#lang racket
; 修改2.18题目中的reverse函数的定义方式，给出一个deep-reverse过程， 接受一个list作为参数
; 返回一个list每个列表子元素都被revserse。
(define x (list (list 1 2) (list 3 4)))

(define (reverse ls)
  (define (reverse-iter ls ans)
    (if (null? ls)
        ans
        (reverse-iter (cdr ls)
                      (cons (car ls) ans))))
  (reverse-iter ls '()))


(define (deep-reverse ls)
  (define (reverse-iter ls ans)
    (if (null? ls)
        ans
        (reverse-iter (cdr ls)
                      (cons (reverse (car ls)) ans))))
  (reverse-iter ls '()))

; '(4 3 2 1)
(reverse '(1 2 3 4))
; '((4 3) (2 1))
(deep-reverse x)            