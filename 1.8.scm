#lang racket

; 牛顿法计算立方根，我们假设y是x立方根的近似，那么一个更好的近似会是(x/y^2+2y)/3
; 使用这种方法实现一个立方根求解公式
(define (cube-root-ori x)
  (cube-root-iter 1 x improve))
(define (cube-root-mine x)
  (cube-root-iter 1 x improve-2))

(define (cube-root-iter guess x improve)
  (if (good-enough? guess (improve guess x))
      guess
      (cube-root-iter (improve guess x) x improve)))

(define (good-enough? oldguess guess)
  (< (abs (- (/ oldguess guess) 1)) 1e-8))


(define (improve guess x)
  (/ (+
      (/ x (* guess guess))
      (* 2 guess))
     3))

;近似公式为什么不能是 (x/y^2+2y)/2
(define (improve-2 guess x)
  (/ (+ guess
        (/ x (* guess guess)))
     2))

(cube-root-ori 64e-21)
(cube-root-ori 64e21)

(cube-root-mine 64e-21)
(cube-root-mine 64e21)