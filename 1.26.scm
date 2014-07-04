#lang racket
; Louis Reasoner在做1.24题时碰到了很大的困难。他设计了一种fast-prime?测试好像比原文中的
; prime?测试要慢的多。Louis叫他的朋友Eva Lu Ator来帮忙。检查代码的时候，他们发现Louis用
; 的expmod方法是这样的，他显示的调用了乘法，而不是调用square函数

(define(expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))))
        (else
         (remainder (* base (expmod (base (- exp 1) m)))
                    m))))

; Louis说他没看出来这有什么差别，但是Eva说他确实看出来了差别。 这么写代码，对数时间复杂度的
; 程序被拉成了线性时间复杂度。

; 很明显，Eva是对的。 
; 像原文中的写法, n为偶数时，F(n)=F(n/2)+c， n为奇数时， F(n)=F(n-1)+c; 
; 而像louis的写法，n为偶数时，F(n) = 2F(n/2) + c， n为奇数时，F(n)=F(n-1)+c ;