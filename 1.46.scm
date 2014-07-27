#lang racket
; 很多数值方法实际上都是一种叫iterative improvement方法的特例。使用这种方法，就是如果你要
; 计算某个值的话，都是先从一点开始，测试一下当前点是否够好，如果不够好的话，再改进一下测试的点
; 测试新点怎么样，这个过程循环往复。 写一个iterative-improvment过程，把两个过程数作为参数
; ,一是判定当前点是否足够好的函数，而是改进guess值的函数；它返回一个过程，会接收一个guess值
; 作为参数，然后反复的改进直到结果足够好。
; 使用iterative-improvment重写1.1.7节的sqrt函数和1.3.3节的fixed-point函数

; @param: good-enough? 判定guess是否足够好
; @param: improve 将guess进行改进，称为better-guess
; @return: 接收init-guess，返回最终结果的函数
(define (iterative-improvement good-enough? improve)
  (lambda (guess)
    (let ((better-guess (improve guess)))
      (if (good-enough? guess better-guess)
          better-guess
          ((iterative-improvement good-enough? improve) better-guess)))))

;题目中要求计算sqrt函数，就是求得y<-(y+X/y)/2的good-guess
; @param: X 被开方数
; @return y 且 y^2 = x
(define (sqrt X)
  ((iterative-improvement (lambda (guess better-guess)
                            (< (/ (abs (- guess better-guess)) guess)
                               0.00001))
                          (lambda (y)
                            (/ (+ (/ X y) y) 2)))
   1.0))

(sqrt 100) ; 10
(sqrt 4) ; 2

; 然后是计算fixed-point
; @param：F是要被计算的函数
; @return: F的fixed-point
(define (fixed-point F)
  ((iterative-improvement (lambda (x1 x2)
                            (< (/ (abs (- x1 x2)) 
                                  x1)
                               0.00001))
                          F)
   1.0))

;我们试验一下，计算sqrt 2
(define (average x1 x2) (/ (+ x1 x2) 2))
(define (average-damp f)
  (lambda (x) (average x (f x))))
(fixed-point (average-damp (lambda (y) (/ 4 y))));=2.0
                                  
                        
        