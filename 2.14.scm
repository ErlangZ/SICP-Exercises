#lang racket
; 在辛苦的工作之后，Alyssa.P.Hacker终于交付了她的系统。几年以后，她把这件事已经完全忘掉了。
; 突然接到了一个Lem E.Tweakit用户打了的怒气冲冲的电话。Lem发现两个在算术上完全
; 相同的等式 (R1*R2)/(R1+R2) 和 1/(1/R1+1/R2)给出了不同的结果, 这种情况很严重。

(require "2.7.scm")
(require "interval-arthmetic.scm")
;(require "2.16.scm")

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define (width interval)
  (/
   (- (cdr interval) (car interval))
   2))

; 演示结果确实是不同的。。。
(width (par1 (make-interval 2 3)(make-interval 7 8)))
(width (par2 (make-interval 2 3)(make-interval 7 8)))

(par1 (make-interval 2 3)(make-interval -8 -7))
(par2 (make-interval 2 3)(make-interval -8 -7))

(par1 (make-interval 2 3)(make-interval -7 8))
(par2 (make-interval 2 3)(make-interval -7 8))

