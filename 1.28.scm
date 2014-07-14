#lang racket
; 费马测试有一种可以不被蒙蔽的变形，被称为Miller-Rabin测试。这种测试基于费马测试的一种可选
; 描述，如果n是一个素数，a是任何一个比n小的正整数，那么a^(n-1)次方都应当同1对n共轭。 使用
; Miller-Rabin测试检测一个数的素性，我们首先随机选取一个小于n的正整数，然后使用expmod来
; 计算它对n的n-1次幂。但是，在计算过程中，我们需要观察我们是否发现了一个解x，使得x^2同1对
; n共轭。可以证明，如果这种数存在，那么n肯定不是一个素数。 也可以证明，如果n是一个奇的合数
; ，那么比n小的数中，至少有一半，在以这种方式计算a^(n-1)的过程中，会发现"同1对n共轭的非奇
; 异平方根"。这就是为什么，Miller-Rabin测试不能被蒙蔽。 --平凡解实际上就是1和n-1

; 修改expmod过程，当它发现一个非奇异的平方根的时候，就发出一个信号（原文中建议返回0），再用
; 这个过程来进行费马测试。重新测试一下效果

(define (square x)
  (* x x))

(define (square-mod-with-check base m)
  (let ((square-base-remainder (remainder (square base) m)))
    (if (and (/= base 1) 
             (/= base (- m 1)) 
             (= 1 square-base-remainder))
        0
        square-base-remainder)))

(define (/= x y)
  (not (= x y)))

(define (expmod base exp m)
  (cond ((= exp 0) 
         1)
        ((even? exp)
         (square-mod-with-check (expmod base (/ exp 2) m) m))
        (else
         (remainder (* base (expmod base (- exp 1) m)) m))))


(define (fermat-test n) ; 为了说明这个方法的作用，检测[2,n)的所有数
  (foldr (lambda (x y) (and x y))
         #t
         (map (lambda (a) (= (expmod a (- n 1) n) 1))
              (range 2 (- n 1)))))

(fermat-test 2)
(fermat-test 3)
(fermat-test 4)
(fermat-test 5)
(fermat-test 6)
(fermat-test 17)
(fermat-test 20)
(fermat-test 561)
(fermat-test 1105)
(fermat-test 1729)
(fermat-test 2465)
(fermat-test 2821)
(fermat-test 6601) ; 561开始这几个数都是Carmichael数，
                   ; 在1.27题的检测中，都骗过了费马测试
(fermat-test 65537) ; 费马质数