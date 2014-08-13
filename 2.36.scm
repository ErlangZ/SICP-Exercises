#lang racket
; 函数accumulte-n同accumulate函数很像；但是第三个参数是seqs，每一个seq都是相同长度，将
; 所有seq的第一个元素进行accumulate运算，之后的元素进行accumulate-n运算
(provide accumulate-n)

(define accumulate foldr)

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))

             