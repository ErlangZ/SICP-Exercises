#lang slideshow
; 这里的vect(x,y)表示向量(0,0)->(x,y)
(define (make-vect x y) (cons x y))
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))
(define (display-vect v)
  (display (format "[~a,~a]" (car v) (cdr v))))

(define (add-vect v1 v2) (make-vect (+ (xcor-vect v1) (xcor-vect v2))
                                    (+ (ycor-vect v1) (ycor-vect v2))))
(define (sub-vect v1 v2) (make-vect (- (xcor-vect v1) (xcor-vect v2))
                                    (- (ycor-vect v1) (ycor-vect v2))))
(define (scale-vect s v) (make-vect (* s (xcor-vect v))
                                    (* s (ycor-vect v))))

(define (make-frame origin-frame edge1-frame edge2-frame)
  (list origin-frame edge1-frame edge2-frame))
(define (origin-frame frame) (car frame))
(define (edge1-frame frame) (cadr frame))
(define (edge2-frame frame) (caddr frame))


(define (frame-coord-map frame)
  (λ (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))


; 一个平面上的有向线段可以用一对向量来表示，向量1-从原点到有向线段起点的向量，向量2-从原点
; 到有向向量终点的向量
(define (make-segment v1 v2) (cons v1 v2))
(define (start-segment v) (car v))
(define (end-segment v) (cdr v))
(define (display-segment segment)
  (display-vect (start-segment segment))
  (display "-->")
  (display-vect (end-segment segment))
  (newline))

(define (make-point x y) (cons x y))
(define (xcor-point p) (car p))
(define (ycor-point p) (cdr p))
(define (display-point point)
  (display (format "[~a, ~a]" (xcor-point point) (ycor-point point))))
                   

(require racket/draw)
(require racket/gui/base)
; @brief 在dc上从P1->P2点画出一条直线
(define (draw-line dc P1 P2)
  (send dc draw-line 
        (xcor-point P1) (ycor-point P1)
        (xcor-point P2) (ycor-point P2)))
; 
(define (segement->painter segment-list)
  (let* ((target (make-bitmap 500 500))
         (dc (new bitmap-dc% [bitmap target])))
    (lambda (frame)
      (for-each
       (lambda (segment)
         (draw-line dc
          ((frame-coord-map frame) (start-segment segment))
          ((frame-coord-map frame) (end-segment segment))))
       segment-list)
      target)))
; ----------------------------2.49.scm------------------------------------
; 使用segements->painter定义如下几种frame
; a. 画出frame轮廓的painter
(define (frame-outline-painter frame)
  (let* ((E1 (make-segment (origin-frame frame) (add-vect (origin-frame frame) (edge1-frame frame))))
         (E2 (make-segment (origin-frame frame) (add-vect (origin-frame frame) (edge2-frame frame))))
         (E3 (make-segment (end-segment E1) (add-vect (end-segment E1) (edge2-frame frame))))
         (E4 (make-segment (end-segment E2) (add-vect (end-segment E1) (edge2-frame frame)))))
    ((segement->painter (list E1 E2 E3 E4)) frame)))
(frame-outline-painter (make-frame (make-vect 0 0)
                                   (make-vect 20 0)
                                   (make-vect 0 10)))
  