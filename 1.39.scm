#lang racket
; tan函数实际上也是可以用连续分数进行表示。 tan (x) = x/1-(x^2/3-x^2...)
(define (continued-fraction N D K)
  (define (continued-fraction-iter N D K i)
    (if (= i K)
        (D i)
        (/ (N i)
           (- (D i) (continued-fraction-iter N D K (+ i 1))))))
  (continued-fraction-iter N D K 1))

(define (tan x)
  (continued-fraction (lambda (i) (expt x i))
                      (lambda (i) (- (* i 2) 1.0))
                      5000))

(tan 2) ; 似乎这个公式只能计算 0-90度之间的结果
(tan 1) ; = 1.55
(tan 0.785); = 1
(tan 0) ; = 0
(tan -1)
                
