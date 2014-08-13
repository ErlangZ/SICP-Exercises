#lang racket
; 计算两个向量的乘积
(define (dot-product v w)
  (foldr + 0 (map * v w)))

; [1 2 3].[3 4 5] = 1*3+2*4+3*5=3+8+15=26
(dot-product '(1 2 3) '(3 4 5))

; 计算向量和矩阵的乘积
(define (matrix-*-vector m v)
  (map (lambda (r) (dot-product r v)) m))

(matrix-*-vector '((1 2 3 4) (4 5 6 6) (6 7 8 9))
                 '(1 2 3 4))

; 计算矩阵的转置
(require "2.36.scm")
(define (transpose mat)
  (accumulate-n cons '() mat))

(transpose '[(1 2 3 4) (2 4 6 8)])


; 计算两个矩阵的乘积
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m)))

; 1 2 3 4     1 2   30 60
;          *  2 4 = 
;             3 6 
; 2 4 6 8     4 8   60 120
(matrix-*-matrix '[(1 2 3 4) (2 4 6 8)]
                 '[(1 2) (2 4) (3 6) (4 8)])
