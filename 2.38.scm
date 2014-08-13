#lang racket
;accumulate函数实际上被称为fold-right

(define (fold-left op init sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter init sequence))

;(fold-left cons '() (list 1 2 3 4))
; 如上的定义是 (cons (cons (cons (cons '() 1) 2) 3) 4))))
; 而 (op (car rest) result) 则定义如下
;(cons 4 (cons 3 (cons 2 (cons 1 '()))

; fold-right 函数的定义是
(define (fold-right op init sequence)
  (if (null? sequence)
      init
      (op (car sequence)
          (fold-right op init (cdr sequence)))))

; (/ 1 (/ 2 (/ 3 1))) = 1/(2/3) = 3/2
(fold-right / 1 (list 1 2 3))
; (/ (/ (/ 1 1) 2) 3)) = (1/2)/3 = 1/6
(fold-left / 1 (list 1 2 3))

(fold-right list '() (list 1 2 3))
(fold-left  list '() (list 1 2 3))

; op 如果满足结合律+交换律，fold-right和fold-left的结果就是一样的
; 结合律 (x+y)+z=x+(y+z)
