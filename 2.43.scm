#lang racket
; 可以看到将调用次序发生变化之后
;(append-map
; (lambda (new-row)
;   (map (lambda (rest-of-queens)
;          (adjoin-position new-row k rest-of-queens))
;        (queen-cols (- k 1))))
; (range 1 board-size))

; F(n) = S * F(n-1)
; F(n) = S^S * T
   