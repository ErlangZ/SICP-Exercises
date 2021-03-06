#lang racket
; 计算如下表达式的值

10                ;10

(+ 5 3 4)         ;12

(- 9 1)           ;8

(/ 6 2)           ;3

(+ (* 2 4) (- 4 6));6

(define a 3)      ;X            => define只完成绑定，没有返回值（实际上，这个结果是依赖于具体的实现的，有的方言是有返回值的）

(define b (+ a 1));X

(+ a b (* a b))   ;19

(= a b)           ;#f

(if (and (> b a) (< b (* a b)))
    b
    a)            ;4

(cond ((= a 4) 6)
      ((= b 4) (+ 7 6 a))
      (else 25))  ;16

(+ 2 (if (> b a) b a)) ;6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))        ;16

