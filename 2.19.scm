#lang racket
; 重新考虑一下1.2.2章节的“硬币兑换”问题。可以很容易的使用程序来兑换硬币，我们可以计算出来兑换一英镑的方法有多少种。
; 兑换的情况分布在两个过程中 first-denomination和count-change。但是如果允许使用提供的一系列硬币来进行兑换就更好了。
(define us-coins (list 50 25 10 5 1))
(define another-us-coins (list 1 5 10 25 50))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))


;@brief 计算兑换硬币的方法数
;@param amount 要兑换的金额
;@param coin-values 可以使用硬币面额
;@return 兑换硬币的方法数
(define (cc amount coin-values)
  (define (no-more? coins)
    (null? coins))
  (define (except-first-denomination coins)
    (cdr coins))
  (define (first-denomination coins)
    (car coins))
  (cond ((= 0 amount) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount (first-denomination coin-values))
                coin-values)))))

(cc 100 us-coins)
(cc 100 another-us-coins)

; 由于实际上，这是枚举方法，硬币面额的顺序对结果没有影响