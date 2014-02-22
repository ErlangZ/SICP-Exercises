#lang racket
; 硬币兑换问题。 迭代的解决斐波那契算法并不困难，下边这个问题就不一样了：我们对1美元的兑换有多少种方式呢？假定可以使用的面值有$0.5,$0.25,$0.1,$0.05,$0.01。我们能写出一个程序计算
; 兑换硬币的方法数目吗？这个问题有一个简单的递归解法。假设我们给定的面值顺序如上，那他们遵循如下的计算方式。
; 使用k种硬币兑换a美元的方式 等于 1) 使用除了第一种面值之外的硬币兑换k元的方法 加上 2) 使用所有面额的硬币，兑换a-d价值的钱币的方法，d是第一种钱币的面值
;然后给出递归定义， a=0 ->那么仅仅有一种方式来兑换硬币； a<0->那么没有方式兑换硬币； n=0-》我们没有方式来兑换硬币

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))
                 (cc (- amount (first-denomination kinds-of-coins)) 
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 100)
(count-change 10)
(count-change 3)


; 如上这种方式会带来很低效的运算过程
; 注释中提到一种tabulation/memorization的方法，就是将中间过程记录下来，每次函数调用之前都查询一下这个值是否存在，以此来解决这个问题。

; 我们来自底向上的解决这个问题。 硬币面额一直都是5种。
; 0元的硬币有1种方式兑换，1元硬币在试过1-5种面值的方案之后n>=0 ==> F(n)= sum[F(n-d1), F(n-d2)...,F(n-d5)], n<0==>F(n)=0

;cc-iter使用了迭代的方式进行兑换 
;coins-ls是硬币的面额； i-1-result-ls F(0~n-1)的结果; i是当前的搜索金额; n是全局的搜索面额
(define (count-change-iter n)
  (cc-iter '(1 5 10 25 50) '(1) 1 n))

; 这个思路是不对的，要用尾递归来解决

; (define (cc-iter coins-ls i-1-result-ls i n)
;   
;   (if (= (- i 1) n); n=i+1 ==> i-1-result-ls的tail就是结果
;       
;       (list-ref i-1-result-ls n)
;       
;       (cc-iter coins-ls
;                (append i-1-result-ls
;                        (list (foldr +        
;                                     0 
;                                     (map (lambda (c)
;                                            (cond ((< i c) 0)
;                                                  (else 1)))
;                                          coins-ls))))
;                (+ i 1)
;                n

(map count-change (build-list 20 values))
(map count-change-iter (build-list 20 values))
(count-change-iter 100)

