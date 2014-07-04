#lang racket
; Alyssa P. Hacker觉得我们在expmod 中做了很多额外的工作。既然我们已经知道了怎么快速
; 计算exp，那不如我们直接用下边的方法计算
(define (fake-expmod base exp m)
  (remainder (fast-exp base exp) m))
; 她的想法是对的吗？这个过程同上一个过程算的一样快吗？ 

(define (fast-exp base exp)
  (cond ((= exp 0) 1)
        ((even? exp) (square (fast-exp base (/ exp 2))))
        (else (* base (fast-exp base (- exp 1))))))

(define (square x)
  (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (display-time proc base exp m)
  (let ((start-time (current-milliseconds))
        (result (proc base exp m)))
    (display (format "base=~a, exp=~a, mod=~a, Result is ~a, using millseconds ~a\n" 
                     base exp m result
                     (- (current-milliseconds) start-time)))))


(display-time fake-expmod 2 100000000 3)
(display-time expmod 2 10000000000000000 3)
; 这么做程序变慢了，而且结果很容易溢出。 我不确定解释器的底层实现，对大数运算有没有特殊处理
; 如果是的话，那么肯定这就是问题所在。