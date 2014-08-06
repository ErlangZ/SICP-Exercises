#lang racket
; 在调试完程序之后，Alyssa把程序给一个潜在的用户看，这位用户抱怨她的程序做的不对。
; 他想要一个程序可以处理用中心值和附加值表示的数，比如3.5+/-0.15而不是[3.35,3.65]。
; Alyssa回到了电脑前，重写了一个构造器和选择器，修复了这个问题。
(require "interval-arthmetic.scm")

(define (make-center-with c w)
  (make-interval (- c w) (+ c w)))

(define (center interval)
  (/ (+ (lower-bound interval) (upper-bound interval))
     2))

(define (width interval)
  (/ (- (upper-bound interval) (lower-bound interval))
     2))

; 但是Alyssa的用户都是工程师。真正的工程师一般都是用百分百来表示误差， 3.5 +/- 15%
(define (make-center-percent c p)
  (let ((per (/ p 100)))
        (make-interval (- c (* per c)) (+ c (* per c)))))

; center 和上个定义是一样的

(define (percent interval)
  (/ (width interval) (center interval)))