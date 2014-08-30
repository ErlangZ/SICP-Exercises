#lang racket
; 定义两种方式给frame
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame frame) (car frame))
(define (edge1-frame frame) (cadr frame))
(define (edge2-frame frame) (caddr frame))

(origin-frame (make-frame 1 2 3))
(edge1-frame (make-frame 1 2 3))
(edge2-frame (make-frame 1 2 3))


; 给出cons cons的定义方式
(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame-2 frame-2) (car frame-2))
(define (edge1-frame-2 frame-2) (cadr frame-2))
(define (edge2-frame-2 frame-2) (cddr frame-2))

(origin-frame-2 (make-frame-2 1 2 3))
(edge1-frame-2 (make-frame-2 1 2 3))
(edge2-frame-2 (make-frame-2 1 2 3))
