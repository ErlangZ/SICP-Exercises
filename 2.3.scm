#lang racket
; 在平面上实现一种矩形的表示方法。提示：你可以使用2.2中的代码。使用你的构造器和选择器，计算给定矩形的周长和面积。
; 然后再设计一种矩形的不同表示，你可以设计一种合适的抽象边界，让周长和面积在这种模式下也可以工作。
;-----------------------------------Point-------------------------------------------------
; @brief: 定义一个点
(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

;-----------------------------------Rect---------------------------------------------------
;@brief: 传入左上角和右下角的点表示一个矩形
(define (make-rect left-upper right-bottom)
  (cons left-upper right-bottom))
;@brief: 返回矩形左上角的点
(define (left-upper rect)
  (car rect))
;@brief: 返回矩形右下角的点
(define (right-bottom rect)
  (cdr rect))
;@brief: 返回矩形的高
(define (height rect)
  (- (y-point (left-upper rect))
     (y-point (right-bottom rect))))
;@brief: 返回矩形的宽度
(define (width rect)
  (- (x-point (right-bottom rect))
     (x-point (left-upper rect))))

;-------------------------------------public Method----------------------------------------
;@brief : 求矩形周长
;@param : rect -- 矩形
;@return : 矩形的周长
(define (perimeter-rect rect)
  (* 2 (+ (height rect) (width rect))))
;@brief : 求矩形的面积
;@param : rect -- 矩形
;@return : 矩形的面积
(define (area-rect rect)
    (* (height rect) (width rect)))

;--------------------------------------测试一下----------------------------------------------
(perimeter-rect (make-rect (make-point 0 1)
                           (make-point 1 0)))
(area-rect (make-rect (make-point 0 1)
                           (make-point 1 0)))