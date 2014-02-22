#lang racket

; Alyssa.P.Hacker不明白为什么if必须是一种特殊形式。"为什么我不能用cond来定义if呢？--cond也是一种特殊形式~~"。她的朋友Eva Lu Ator说这实际上是可以的，所以他定义了一个新版本的if
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (new-if-if predicate then-clause else-clause)
  (if predicate then-clause else-clause))

(new-if (= 2 3) 0 5)
(new-if (= 1 1) 0 5)


; Alyssa很高兴，接着就用new-if写了下边的代码
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
(define (sqrt-iter2 guess x)
  (new-if-if (good-enough? guess x)
          guess
          (sqrt-iter2 (improve guess x)
                     x)))
; 定义改进过程
(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

;当然，这个定义是有问题的，我们比较了绝对差值
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))
(define (sqrt-2 x)
  (sqrt-iter2 1.0 x))

;sqrt-2使用了if也被卡主了，说明不是cond、if的问题
(sqrt-2 9)

; 这里肯定会卡住，因为new-if是一个普通的过程，每个subexpression都被计算了
(sqrt 9)