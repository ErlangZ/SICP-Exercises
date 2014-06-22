#lang racket
; 有一种很聪明的算法来以对数复杂度计算斐波那契数。回想一下之前计算fib-iter的时候,a<-a+b,
; b<-a。调用这一转换T，从(0 1)开始观察连续n次调用T之后，就可以得到Fib(n+1)和Fib(n)。换句
; 话说，斐波那契数列是调用了T^n之后得到的，这种转换是从(0 1)开始的。

; 现在我们将T看成是Tpq中的一个特列，p=0，q=1；Tpq是可以将(a,b)转换为a<-(bq+aq+ap),
; b<-(bp+aq)。证明一下，我们连续调用两次Tpq同一次调用Ｔp＇q＇的效果是一样的，其中p'和q'都
; 是关于pq的。这给了我们一个明确的方法来计算T^n，先计算出T^n，就可以以指数复杂度直接计算出
; Fib(n+1)和Fib(n)

; T = [p+q q; q p] = 

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a 
                   b
                   (+ (* p p) (* q q)) ;p'=p^2+q^2
                   (+ (* 2 p q) (* q q)) ;q'=2pq+q^2
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

(map fib '(1 2 3 4 5 6 7 8 9 10))
