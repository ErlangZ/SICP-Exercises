#lang racket
; 写一个函数找到所有由小于n的正整数组成的有序三元组，i,j,k，他们的和等于s
(define (split s n)
  (filter (lambda (triple)
            (= s (+ (car triple)
                    (cadr triple)
                    (caddr triple))))
          (append-map (lambda (s-1)
                 (append-map (lambda (s-2)
                               (map (lambda (s-3) (list s-3 s-2 s-1))
                                    (range 1 (+ s-2 1))))
                             (range 1 (+ s-1 1))))
                 (range 1 n))))

(split 10 8)
                  
     