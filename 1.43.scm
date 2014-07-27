#lang racket
; 假设f是一个数值函数，n是一个正整数；那么我们可以计算f连续计算的函数,
; 比如f(f(f..(f(x)...)。例如，f是一个x->x+1的函数，那么f的第n次重复
; 是x->x+n；如果f是一个x->x^2函数，那么f的第n次重复是x->x^2^n函数。
; 写一个过程，f和n是参数，将f重复n次。
(require "1.42.scm")
(provide repeated)

(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1))))); 注意，这里必须用compose，
                                        ; (f(repeated f (- n 1)))到最后是(f f)
                                        ; 而不是(compose f f)

(define (square x) (* x x))

((repeated square 2) 5) ; 5^2^2=5^4=5 * 5 * 5 * 5 = 125*5=625