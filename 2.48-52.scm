#lang slideshow
; 这里的vect(x,y)表示向量(0,0)->(x,y)
(define (make-vect x y) (cons x y))
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))
(define (display-vect v)
  (display (format "[~a,~a]" (car v) (cdr v))))
; @brief 将两个向量相加
(define (add-vect v1 v2) (make-vect (+ (xcor-vect v1) (xcor-vect v2))
                                    (+ (ycor-vect v1) (ycor-vect v2))))
; @brief 将两个向量相减
(define (sub-vect v1 v2) (make-vect (- (xcor-vect v1) (xcor-vect v2))
                                    (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect s v) (make-vect (* s (xcor-vect v))
                                    (* s (ycor-vect v))))

; @brief 定义canvas，表示一幅的作画空间
(define (make-canvas)
  (let* ((target (make-bitmap 500 200))
         (dc (new bitmap-dc% [bitmap target])))
    (list dc target)))
(define (show-canvas canvas) (cadr canvas))
(define (get-canvas canvas) (car canvas))

; @brief 定义frame
(define (make-frame origin-frame edge1-frame edge2-frame)
  (list origin-frame edge1-frame edge2-frame (make-canvas)))
(define (origin-frame frame) (car frame))
(define (edge1-frame frame) (cadr frame))
(define (edge2-frame frame) (caddr frame))
(define (canvas-frame frame) (cadddr frame))

; 根据frame来映射坐标系
(define (frame-coord-map frame)
  (lambda (vect)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect vect)
                           (edge1-frame frame))
               (scale-vect (ycor-vect vect)
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
               
(require racket/draw)
(require racket/gui/base)
; @brief 在dc上从P1->P2点画出一条直线
(define (draw-line frame v1 v2)
  (let ((canvas (get-canvas (canvas-frame frame))))
    (send canvas draw-line 
          (xcor-vect v1) (ycor-vect v1)
          (xcor-vect v2) (ycor-vect v2))))

; @brief 将线段转换成painter
(define (segement->painter segment-list)
  (lambda (frame)
    (for-each (lambda (segment)
                (draw-line frame
                           ((frame-coord-map frame) (start-segment segment))
                           ((frame-coord-map frame) (end-segment segment))))
              segment-list)
    frame))
; ----------------------------2.49.scm------------------------------------
; 使用segements->painter定义如下几种frame
; a. 画出frame轮廓的painter
(define (frame-outline-painter frame)
  (let* ((E1 (make-segment (origin-frame frame) 
                           (add-vect (origin-frame frame) 
                                     (edge1-frame frame))))
         (E2 (make-segment (origin-frame frame) 
                           (add-vect (origin-frame frame) 
                                     (edge2-frame frame))))
         (E3 (make-segment (end-segment E1) 
                           (add-vect (end-segment E1) (edge2-frame frame))))
         (E4 (make-segment (end-segment E2) 
                           (add-vect (end-segment E1) (edge2-frame frame)))))
    ((segement->painter (list E1 E2 E3 E4)) frame)))
(define outline-paint (frame-outline-painter (make-frame (make-vect 0 0)
                                                         (make-vect 20 0)
                                                         (make-vect 0 10))))
(show-canvas (canvas-frame outline-paint))

; b. 画出frame边界的X型
(define (frame-X-painter frame)
  (let* ((P1 (origin-frame frame))
         (P2 (add-vect (origin-frame frame) (edge1-frame frame)))
         (P3 (add-vect (origin-frame frame) (edge2-frame frame)))
         (P4 (add-vect P2 (edge2-frame frame)))
         (S1 (make-segment P1 P4))
         (S2 (make-segment P2 P3)))
    ((segement->painter (list S1 S2)) frame)))

(define X-paint (frame-X-painter (make-frame (make-vect 0 0)
                                             (make-vect 20 0)
                                             (make-vect 0 10))))
(show-canvas (canvas-frame X-paint))

; c. 连接各个边的中点，画出一个钻石形
(define (frame-diamond-painter frame)
  (define (mid-vect v1 v2)
    (make-vect (/ (+ (xcor-vect v1) (xcor-vect v2)) 2)
               (/ (+ (ycor-vect v1) (ycor-vect v2)) 2)))
  (let* ((P1 (origin-frame frame))
         (P2 (add-vect (origin-frame frame) (edge1-frame frame)))
         (P3 (add-vect (origin-frame frame) (edge2-frame frame)))
         (P4 (add-vect P2 (edge2-frame frame)))
         (M1 (mid-vect P1 P2))
         (M2 (mid-vect P2 P4))
         (M3 (mid-vect P4 P3))
         (M4 (mid-vect P3 P1))
         (S1 (make-segment M1 M2))
         (S2 (make-segment M2 M3))
         (S3 (make-segment M3 M4))
         (S4 (make-segment M4 M1)))
    ((segement->painter (list S1 S2 S3 S4)) frame)))

(define diamond-paint
(frame-diamond-painter (make-frame (make-vect 0 0)
                                   (make-vect 20 0)
                                   (make-vect 0 10))))
(show-canvas (canvas-frame diamond-paint))

; d. 画wave
(define (wave-painter frame)
  (define (vects->segements vectors)
    (if (<= (length vectors) 1)
        '()
        (cons (make-segment (car vectors) (cadr vectors))
              (vects->segements (cdr vectors)))))
  ((segement->painter (vects->segements (list (make-vect 0.4  0.0)
                                              (make-vect 0.5  0.33)
                                              (make-vect 0.6  0.0))))
   frame) ;inside legs
  ((segement->painter (vects->segements (list (make-vect 0.25 0.0)
                                              (make-vect 0.33 0.5)
                                              (make-vect 0.3  0.6)
                                              (make-vect 0.1  0.4)
                                              (make-vect 0.0  0.6))))
   frame) ;lower left
  ((segement->painter (vects->segements (list (make-vect 0.0  0.8)
                                              (make-vect 0.1  0.6)
                                              (make-vect 0.33 0.65)
                                              (make-vect 0.4  0.65)
                                              (make-vect 0.35 0.8)
                                              (make-vect 0.4  1.0))))
   frame) ;upper left
  ((segement->painter (vects->segements (list (make-vect 0.75 0.0)
                                              (make-vect 0.6  0.45)
                                              (make-vect 1.0  0.15))))
   frame) ;lower right
  ((segement->painter (vects->segements (list (make-vect 1.0  0.35)
                                              (make-vect 0.8  0.65)
                                              (make-vect 0.6  0.65)
                                              (make-vect 0.65 0.8)
                                              (make-vect 0.6  1.0))))
   frame)) ;upper right
(define wave-paint 
  (wave-painter (make-frame (make-vect 0 0)
                            (make-vect 200 0)
                            (make-vect 0 100))))
(show-canvas (canvas-frame wave-paint))

; ------------------------2.50.scm-------------------------------
; @brief 绘制painter中的左下角origin、左上角corner1、右下角的corner2位置
(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let* ((m (frame-coord-map frame))
           (new-origin (m origin)))
      (painter (make-frame new-origin
                           (sub-vect (m corner1) new-origin)
                           (sub-vect (m corner2) new-origin))))))
(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))
(define (shrink-to-upper-right painter)
  (transform-painter painter
                     (make-vect 0.5 0.5)
                     (make-vect 1.0 0.5)
                     (make-vect 0.5 1.0)))
; 试一下，将wave反转
(define flip-vert-wave 
  ((flip-vert wave-painter)
   (make-frame (make-vect 0 0)
               (make-vect 200 0)
               (make-vect 0 100))))
(show-canvas (canvas-frame flip-vert-wave))  

; 将wave左右和上下翻转
(define shrink-to-upper-right-wave 
  ((shrink-to-upper-right wave-painter)
   (make-frame (make-vect 0 0)
               (make-vect 200 0)
               (make-vect 0 100))))
(show-canvas (canvas-frame shrink-to-upper-right-wave))

; 定义一个水平翻转的函数，可以将图像水平转动180度
(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))
(define flip-horiz-wave
  ((flip-horiz wave-painter)
   (make-frame (make-vect 0 0)
               (make-vect 200 0)
               (make-vect 0 100))))
(show-canvas (canvas-frame flip-horiz-wave))


; --------------------------2.51.scm----------------------------------
; 定义beside操作, 将两个图像水平放在一起
(define (beside painter1 painter2)
  (let* ((split-point (make-vect 0.5 0.0))
         (paint-left (transform-painter painter1
                                        (make-vect 0.0 0.0)
                                        split-point
                                        (make-vect 0.0 1.0)))
         (paint-right (transform-painter painter2
                                         split-point
                                         (make-vect 1.0 0.0)
                                         (make-vect 0.5 1.0))))
    (lambda (frame)
      (begin (paint-left frame))
             (paint-right frame))))

(define beside-2waves
  ((beside wave-painter 
           (flip-horiz wave-painter))
   (make-frame (make-vect 0 0)
               (make-vect 200 0)
               (make-vect 0 100))))
(display "beside-2waves\n")
(show-canvas (canvas-frame beside-2waves))

; 定义below操作，将两个图像上下联合在一起
(define (below painter1 painter2)
  (let* ((split-point (make-vect 0.0 0.5))
         (paint-down (transform-painter painter1
                                        (make-vect 0.0 0.0)
                                        (make-vect 1.0 0.0)
                                        split-point))
         (paint-up (transform-painter painter2
                                      split-point
                                      (make-vect 1.0 0.5)
                                      (make-vect 0.0 1.0))))
  (lambda (frame)
    (paint-up frame)
    (display "xxxxxxxxxxxx\n")
    (show-canvas (canvas-frame frame))
    (display "yyyyyyyyyyyy\n")
    frame)))
    ;(paint-down frame))))

(define below-2waves
  ((below wave-painter
          (flip-horiz wave-painter))
   (make-frame (make-vect 0 0)
               (make-vect 200 0)
               (make-vect 0 100))))
(display "below-2wave2\n")
(show-canvas (canvas-frame below-2waves))
