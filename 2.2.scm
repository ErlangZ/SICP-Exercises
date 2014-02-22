#lang scheme
; 考虑一下这个问题：在一个平面中表示一个线段。每个线段都用一对儿点来表示，一个起点，一个终点。定义一个构造器make-segment和访问器start-segment和end-segment用来访问
; 线段的起点和终点。此外，点是可以使用一对儿数字来表示：x坐标和y坐标。于是，我们可以指定一个构造器make-point和访问器x-point和y-point定义了这种表示。最后，使用构造器
; 和访问器，定义一个过程midpoint-segment，可以接收一个线段参数，返回这个线段的终点。为了检验这个过程，用下边这种方式来打印出一个点。 
(require "2.1.scm")

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-point x y) 
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

(define (make-segment p1 p2)
  (cons p1 p2))
(define (start-segment p)
  (car p))
(define (end-segment p)
  (cdr p))

(define (mid-segment seg)
  (make-point (avg (x-point(start-segment seg)) (x-point(end-segment seg)))
              (avg (y-point(start-segment seg)) (y-point(end-segment seg)))))

(define (avg rat1 rat2)
  (make-rat 
   (+ (*
       (denom rat2) 
       (numer rat1))
      (*
       (denom rat1)
       (numer rat2)))
   (* 2 
      (denom rat1) 
      (denom rat2))))