#lang racket
; 这道题的背景和题目描述请参加1.29.pdf

; 我先来定义一个sum函数,这里的sum就真的是数学里的求和符号
(define (sum f lower upper next)
  (if (> lower upper) 
      0
      (+ (f lower) (sum f (next lower) upper next))))

; 观察一下这个函数，我要计算 1^3+2^3+3^3=1+8+27。为了方便起见，定义几个小辅助函数
(define (cube x) (* x x x))
(define (inc x) (+ x 1))
(sum cube 1 3 inc); 结果=36，这个函数应该还是没有什么问题的
(sum cube 1 1 inc); 结果=1

; 题目中给出了数据积分的辛普森法则，正如pdf文件中探讨的，实际上这是使用二次函数的积分来近似
; h = upper-lower/N
; Int = h/3(y_0 + 4*y_1 + 2*y_2 + 4*y_3 + 2*y_4 + ...+y_N) 
;     = h/3 * sum(y_0+4*y_1+y_2)...
;     = h/3 * sum[f(x) + 4*f(x+dx) + f(x+2dx)]...

(define (integral f lower upper dx)
  (define (F x)
    (+ (f x) 
       (* 4 (f (+ x dx)))
       (f (+ x dx dx))))
  (define (next x)
    (+ x dx dx))
  (* (sum F lower upper next) (/ dx 3)))

(integral cube 0 1 0.01)
(integral cube 0 1 0.001)


;***************************************1.30.scm*****************************
; 不难看出，原来的sum函数是线性递归的过程，递归深度优先。我们给他改成迭代过程
(define (sum-2.0 f lower upper next)
  (define (sum-iter f lower upper next result)
    (if (> lower upper)
        result
        (sum-iter f (next lower) upper next (+ (f lower) result))))
  (sum-iter f lower upper next 0))

(sum-2.0 cube 1 3 inc)
(sum-2.0 cube 1 1 inc)

; *************************************1.31.scm*****************************
; sum是一系列可以抽象成高阶过程的抽象中，最简单的一种。写一个同质的product函数，可以计算
; 一系列连续函数的乘积。用这个product函数，实现一个factorial阶乘函数。在计算一个pi/4的近
; 似式，关于这个函数请参见pdf的探讨。
(define (product f a b next)
  (define (product-iter f a b next result)
    (if (> a b) 
        result
        (product-iter f (next a) b next (* result (f a)))))
  (product-iter f a b next 1))
; 仿照书上的例子，定义一个identity函数，返回自身
(define (identity x) x)
; 定义阶乘函数
(define (factorial n)
  (product identity 1 n inc))
(factorial 5);=1*2*3*4*5=120
(factorial 1);=1
(factorial 100);这是个巨大的值，而且堆栈没有溢出

;pi/4=2/3 * 4/3 * 4/5 * 6/5.... 定义一个函数来近似pi吧
(define (square x) (* x x)) ;定义平方函数
(define (skip-one x) (+ x 2));定义一个跳一步的函数
(define (appro-pi n)
  (* 4
     (product (lambda (x)
                (/ (* x (+ x 2)) 
                   (square (+ x 1))))
              2.
              n
              skip-one)))
(appro-pi 1000);得到3.141749705738071...

; 这题还要求使用递归再设计一次product
(define (product-recursive f a b next)
  (if (> a b)
      1
      (* (f a) (product-recursive f (next a) b next))))
(product-recursive identity 1 5 inc)
;/////////////////////////////////1.32///////////////////////////////////
; 可以看到sum和product实际上是一种更为一般的符号accumulate的推广
; (accumulate combiner null-value term a next b)
; combiner 实际上如何处理两个term, sum符号里combiner是+,product符号里是*
; null-value 是指定无值计算时候值，sum符号里null-value是0，product符号里是1
; term相当于f，a是下界，b是上界，next是如何将一个值skip到下一个值
; 注：drracket里没有定义accumulate，需要定义一个
(define (accumulate combiner null-value term a b next)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) b next))))
;用accumulate定义一个新的sum、product
(define (sum-new f a b next)
  (accumulate + 0 f a b next))
(define (product-new f a b next)
  (accumulate * 1 f a b next))
;检测1+2+3=6和1*2..*5=120
(sum-new identity 1 3 inc)
(product-new identity 1 5 inc)

; 定义一个线性迭代版本的accumulate
(define (accumulate-new combiner null-value term a b next)
  (define (accumulate-new-iter combiner result term a b next)
    (if (> a b)
        result
        (accumulate-new-iter combiner 
                             (combiner result (term a)) 
                             term (next a) b next)))
  (accumulate-new-iter combiner null-value term a b next))

(accumulate-new * 1 identity 1 5 inc)
(accumulate-new + 0 identity 1 3 inc)

;//////////////////////////////////1.33/////////////////////////////////////
; 如果引入一个filter符号，可以实现一个filtered-accumulate，只过滤[a,b)中某些特定的值
(define (filtered-accumulate combiner null-value term a b next filter)
  (if (> a b)
      null-value
      (combiner (if (filter a) (term a) null-value)
                (filtered-accumulate combiner null-value 
                                   term (next a) b next filter))))
; a.原题中要求计算a到b的素数平方和，我们计算1..10的奇数平方和吧
; 1+3*3+5*5+7*7+9*9=1+9+25+49+81=165
(filtered-accumulate + 0 square 1 10 inc odd?)
; b.比n小的同n互素的所有数的积
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (relatively-prime-product n)
  (define (relatively-prime? x)
    (= (gcd n x) 1))
  (filtered-accumulate * 1 identity 1 n inc relatively-prime?))
;n=7 1*2*3*4*5*6=720
(relatively-prime-product 7)
;n=6 1*5=5
(relatively-prime-product 6)
