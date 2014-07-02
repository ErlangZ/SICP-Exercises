#lang racket
; 在本章开头的smallest-divisor过程进行了大量无用的测试。实际上，在检测完能否被2整除之后，
; 没有必要继续检测n是否可以整除更大的偶数了。也就是说，待测试的序列不应该是2,3,4,5,6...；
; 而应该是2,3,5,7,9...要使用这种方法，需要定义一个next过程，测试一下当前的数是否是2；若
; 是2则返回3，若不是2，则加2之后返回。修改smallest-divisor，使用(next test-divisor)
; 来替代(+ test-divisor 1)。相应的timed-prime-test也替换为这一个版本的运算方法，然后
; 重新进行上题中的测试，观察一下程序的运行时间有何变化。砍掉了一半的运算量，程序是否有一倍的
; 提速呢？如果不是一倍的提升，那么中间提升的系数是多少呢？怎么解释这个系数同2的差异呢？
(provide timed-test-prime)

(define (prime? next-proce n)
  (= (smallest-divisor next-proce n) n))

(define (smallest-divisor next-proce n)
  (smallest-divisor-iter next-proce 2 n))

(define (smallest-divisor-iter next-proce test-divisor n)
  (cond ((> (* test-divisor test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (smallest-divisor-iter next-proce
                                     (next-proce test-divisor) 
                                     n))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (timed-test-prime prime-proce n)
  (let ((start-time (current-milliseconds))
        (result (prime-proce n)))
    (display (format "Num ~A is ~A prime. Time:~A\n"
                     n 
                     result
                     (- (current-milliseconds) start-time)))))

(define (skip n)
  (if (= n 2) 3 (+ n 2)))

(define (step n) 
  (+ n 1))

(define (prime?-fast n)
  (prime? skip n))

(define (prime?-slow n)
  (prime? step n))


(timed-test-prime prime?-fast 1000000000000037)
(timed-test-prime prime?-fast 1000000000000091)
(timed-test-prime prime?-fast 1000000000000159)

(timed-test-prime prime?-slow 1000000000000037)
(timed-test-prime prime?-slow 1000000000000091)
(timed-test-prime prime?-slow 1000000000000159)

; 这两个版本之间倒是几乎有两倍的差异，可为什么我实现的版本，比原题目中给出的版本慢了一倍？