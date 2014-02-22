#lang racket
; 上边提到的过程，很像一半的数学函数。他们指定一个或者多个参数。但是在数学函数和计算过程之间还是有很大的区别的--计算过程必须很高效。
; 我们举一个例子。可以定义出来一个过程 sqrt(x) = y， 当y>0时有x=y^2。这描述了一个完全合法的数学函数。我们可以用这个方法来检测一个数是否是另一个数的平方根，
; 但是我们无法用这个方法来求解平方根。另一方面，这个定义并没有描述出来一个过程。实际上，它几乎没有给我们提供任何信息。
; 下边我们使用了一个函数， x = (y/x+x)，当这个等式成立的时候，求出来的就是x的开方

(provide improve)
(provide average)
(provide square)
(provide good-enough?)

; 定义开方迭代过程
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
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

(sqrt 9)
(sqrt (+ 100 37))
(sqrt (+ (sqrt 2) (sqrt 3)))
(square (sqrt 1000))