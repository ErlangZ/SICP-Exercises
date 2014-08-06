#lang racket
; 证明我们可以只使用数和算术操作来表示非负整数对，如果我们使用(2^a * 3^b)来表示一个整数对。
; 唯一性证明
; 已知(m, n) != (p, q) ==> (m != p || n != q) ==> (2^m != 2^p || 2^n != 3^q)
; 1.) 如果 m != p 而 n == q, 则 2^m * 3^n != 2^p * 3^q。反过来也是一样
; 2.) 如果 m != p && n != q, 则
; 则 2^m * 3^n != 2^p * 3^q

; 递推关系证明
; A1 = 0, B1 = 0 是我们可以用这个表达式来表示的
; 已知 (An,Bm) <- (2^An * 3^Bn)
; (An+1, Bm) <- (2^An+1 * 3^Bn+1) <- 2*(2^An * 3^Bn)
; (An, Bm+1) <- 3*（2^An * 3^Bn) <- 3*(2^An * 3^Bn)
; 可以用(2^a * 3^b) 来表示任何一个指数对

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car z)
  (if (not (= 0 (remainder z 2)))
      0
      (+ 1 (car (/ z 2)))))

(define (cdr z)
  (if (not (= 0 (remainder z 3)))
      0
      (+ 1 (cdr (/ z 3)))))

(car (cons 3 5))
(cdr (cons 3 5))
      