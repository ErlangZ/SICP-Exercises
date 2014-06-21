#lang racket
;任意角度的sin值在r足够小的的时候，可以使用r来进行进行，r约等于sin(r)。而更普遍的有sin(r)=3*sin(r/3)-4*sin^3(r/3)，这个计算公式降低了sin函数的参数大小。在练习的时候，我们认为r小于0.1就是足够小了。
;这个想法可以使用如下的过程进行表述：
(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (begin (print "SINE")
         (if (not (> (abs angle) 0.1))
             angle
             (p (sine (/ angle 3.0))))))

(sine (/ 3.1415926 2))

;问题是 (sine 12.15)需要调用多少次函数
(sine 12.15)

;计算(sine a)的时候空间的增长情况是怎么样的？