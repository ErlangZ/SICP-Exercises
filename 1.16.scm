#lang racket
; 定义一个迭代过程来计算b^n，计算复杂度要求是对数级别的。
; 提示：注意到(b^(n/2))^2 = (b^2)^(n/2)。 
; 在状态之间除了要记录基数b和指数n之外，还要记录一个值a，令a*b^n的结果从一个状态
; 到另一个状态是不会发生变化的。在一开始的时候a的值是1，最后只需要将a的值返回就是最后的结果。
(define (expt-fast base n)
  (expt-fast-iter 1 base n))

(define (expt-fast-iter result base n)
  (if (= n 0) 
      result
      (if (even? n)
          (expt-fast-iter result 
                          (* base base) 
                          (/ n 2))
          (expt-fast-iter (* result base) 
                          (* base base)
                          (/ (- n 1) 2)))))
; 总结，在状态和状态之间定义一个不变量，是将程序改为迭代模式的一种有效方法。