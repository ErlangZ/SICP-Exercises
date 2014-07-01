#lang racket
; 大多数的lisp实现都有一种叫做runtime的调用原语，这一调用返回一个整数，指明程序的调用时间。
; 下边的这个timed-prime-test过程，是使用一个整数n进行调用。它首先把n打印出来，然后看n是否
; 是一个素数，如果n是一个素数，这个函数会打印出三个星号，之后打印出运行时间。
(require "1.21.scm")
(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-milliseconds)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (begin 
        (report-prime n (- (current-milliseconds) start-time)) 
        n)
      0))

(define (report-prime prime elapsed-time)
  (display "prime is: ")  
  (display prime)
  (display " *** ")
  (display elapsed-time)
  (newline))

; 使用这个方法，写一个search-for-primes来检查一个连续整数区间内的素性。使用这个过程找到
; 三个最小的素数分别落在[1000,10000),[10000,100000),[100000,1000000)区间。记录下
; 测试每个区间需要的时间，因为上边的算法是O(sqrt(n))的复杂度，你可以期望第二个区间，所用
; 的时间近似是第一个区间的sqrt(10)倍。验证一下这个结论，计算机时间使用的时间同真正的算法
; 复杂度是成比例的吗？

(display "(sqrt 10)=")
(sqrt 10)

(define (search-for-primes lower-bound upper-bound)
  (display (format "\nLower:~a Upper:~a\n" lower-bound upper-bound))
  (search-for-primes-iter 0 lower-bound upper-bound))

(define (search-for-primes-iter found-num n upper-bound)
  (let* ((is-prime (= n (start-prime-test n (current-milliseconds))))
        (next-found-num (if is-prime (+ found-num 1) found-num)))
    (when (and (< found-num 3) (< n upper-bound))
        (search-for-primes-iter next-found-num (+ n 1) upper-bound))))
            
; 题目中的区间看不出来，在现在的硬件上，要把区间加大，就会发现近似是3.1倍速增长
(search-for-primes (expt 10 12) (expt 10 13))
(search-for-primes (expt 10 13) (expt 10 14))
(search-for-primes (expt 10 14) (expt 10 15))
(search-for-primes (expt 10 15) (expt 10 16))
(search-for-primes (expt 10 16) (expt 10 17))
(search-for-primes (expt 10 17) (expt 10 18))

