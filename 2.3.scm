#lang racket
; 在平面上实现一种矩形的表示方法。提示：你可以使用2.2中的代码。使用你的构造器和选择器，计算给定矩形的周长和面积。然后再设计一种矩形的不同表示，你可以设计一种合适的抽象边界，让周长和面积在这种模
; 式下也可以工作。

(define (perimeter-rect rect)
  (let ((height (height-rect rect))
        (width (width-rect rect)))
    (* 2 (+ height width))))

(define (area-rect rect)
  (let ((height (height-rect rect))
        (width (width-rect rect)))
    (* height width)))

;两层抽象之间的边界
(define (height-rect rect height)
  '(height rect))
(define (width-rect rect width)
  '(width rect))

;使用左下角和右上角的点表示矩形
(define (make-rect1 point-lb point-ru)
  (cons point-lb point-ru))

(define (left-bottom-point rect1)
  (car rect1))

(define (right-up-point rect1)
  (cdr rect1))
;使用左上角和右下角的点表示矩形