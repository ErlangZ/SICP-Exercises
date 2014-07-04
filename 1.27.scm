#lang racket
; 证明一下在角标47中给出的Carmichael数n，确实可以蒙蔽费马测试。验证一下是不是每一个a<n,
; a^n都同a对n共轭。
; 在1000,000,000以内已知仅有255个Carmichael数，比如561,1105,1729,2465,2821,6601
; 等

(define (square x)
  (* x x))

(define (fast-expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (fast-expmod base (/ exp 2) m)) 
                    m))
        (else
         (remainder (* base (fast-expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (foldl
   (lambda (x y) (and x y)) 
   #t
   (map (lambda (a) 
              (= (fast-expmod a n n) a))
        (range 2 n))))

; 好吧，这些数真的可以绕过去费马测试
(map fermat-test '(2 4 6 561 1105 1729 2465 2821 6601))