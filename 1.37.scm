#lang racket
; 有限的continued-fraction的表达式形式是f_1=(/ n_1 (+ d_1 (f_2))), f_n=d_n
; 举个例子，我们可以证明如果n_i和di都是1,有限的continued-fraction的结果是1/fan, fan是
; 黄金分割率。
; a. 这是递归过程
(define (continued-fraction n-term d-term K)
;  (display (format "N_~a:~a D_~a:~a\n" k (n-term k) k (d-term k)))
  (define (continued-fraction n-term d-term k)
    (if (= k K)
        (d-term k)
        (/ (n-term k) 
           (+ (d-term k) (continued-fraction n-term d-term (+ k 1))))))
  (continued-fraction n-term d-term 1))

; 这么就算出来了
(continued-fraction (lambda (i) 1.0)
                    (lambda (i) 1.0)
                    10)

; 原文中提问，k要设置成多大，精度才足够--应该是13
(map (lambda (k)
       (continued-fraction (lambda (i) 1.0)
                           (lambda (i) 1.0)
                           k))
     '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))

; b. 按照题目的意思，把这个过程转换为迭代过程. 按照这个计算公式，如果改为迭代，k就只能从0
; 向上增长
(define (continued-fraction-2 n-term d-term K)
  (define (continued-fraction-iter n-term d-term i result)
    (if (= 0 i) 
        result
        (continued-fraction-iter n-term d-term (- i 1)
                                 (/ (n-term i)
                                    (+ (d-term i) result)))))
  (continued-fraction-iter n-term d-term K (d-term K)))

(continued-fraction-2 (lambda (i) 1.0)
                      (lambda (i) 1.0)
                      10)

;///////////////////////////1.38.scm///////////////////////////////////////
; 1737年，有个瑞士的数学家欧拉给出了一个De Fractionibus Continus，给出了e-2的结果。
; N_i都是1，D_i是以连续序列1,2,1,1,4,1,1,6,1,1,8,....。我们用continued-fraction
; 函数来算这个结果。
;(map (lambda (i) (if (= 2 (remainder i 3)) (* 2 (/ (+ i 1) 3)) 1))
;     '(1 2 3 4 5 6 7 8 9 10 11))
(+ 2
   (continued-fraction-2 (lambda (i) 1.0)
                         (lambda (i)
                           (if (= 2 (remainder i 3))
                               (* 2.0 (/ (+ i 1) 3))
                               1.0))
                          15))

                           
