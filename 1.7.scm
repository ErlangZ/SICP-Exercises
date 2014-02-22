#lang racket
; 原文中使用的good-enough?函数在计算很小的数时候，并不高效。此外在实际的计算中，算术操作的几乎总是在一定的精度内进行的。这使得我们的代码对于大数的计算精度也是不够的。解释一下这种状况，
; 为什么对于极小的数和极大的数都不能奏效。重新设计一种方法可以实现good-enough?，每次判断变化的比率是否足够小，实现一下这个版本的代码，看看是否比原来的，工作的更好
(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (> 0.0001
     (abs (/ (- (square guess) x)
             x))))

; 将sqrt中的good-enough?改为(good-enough? guess (improve guess x))
;(define (good-enough? oldguess guess)
;  (< (abs (- 1 (/ oldguess guess))) 0.01))

(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))
  
 
(sqrt 9)
(sqrt 16e8)
(sqrt 16e-8)


