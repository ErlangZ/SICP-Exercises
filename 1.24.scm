#lang racket
; 修改timed-prime-test过程，使用费马测试对习题1.22中得到的12个素数进行测试。因为费马测试,
; 只有对数时间复杂度，你可以期望在1,000,000附近的素数测试时间，同线性检测1,000附近的素数所
; 用的时间长短类似。
(require "1.23.scm")

(define (square x)
  (* x x))

(define (fast-expmod n e m)
  (cond ((= e 0) 1)
        ((even? e) 
         (remainder (square (fast-expmod n (/ e 2) m)) m))
        (else 
         (remainder (* n (fast-expmod n (- e 1) m)) m))))

(define (prime?-fermat-test n)
  (prime?-fermat-test-iter 0 10 n))

(define (prime?-fermat-test-iter index limit n)
  (cond 
    ((>= index limit) 
         #t)
    ((not (= 1 
             (fast-expmod (+ 1 (random (min 4294967087 (- n 1)))) 
                          (- n 1) 
                          n))) 
         #f)
    (else (prime?-fermat-test-iter (+ 1 index) limit n))))

(display "Fermat Test.\n")
(timed-test-prime prime?-fermat-test 1000000000000037)
(timed-test-prime prime?-fermat-test 1000000000000091)
(timed-test-prime prime?-fermat-test 1000000000000159)
(timed-test-prime prime?-fermat-test 10000000000000061)
(timed-test-prime prime?-fermat-test 10000000000000069)
(timed-test-prime prime?-fermat-test 10000000000000079)
(timed-test-prime prime?-fermat-test 100000000000000003)