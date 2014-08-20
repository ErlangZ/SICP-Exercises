#lang racket
; 定义一个函数生成唯一的pair (i,j)， 令 1<=j<i<=n
; (define (append-map proc lists)
;         (accumulate append '() (map proc lists))) 
(define (unique-pairs n)
  (append-map (lambda (i)
               (map (lambda (j) (list j i))
                    (range 1 i)))
             (range 1 (+ n 1))))

(unique-pairs 10)

; 使用sum-pairs重新定义prime-sum-pairs算法
(define (prime? n)
  (not (ormap (lambda (i) (= 0 (remainder n i)))
              (range 2 (+ (exact-ceiling (sqrt n)) 1)))))
; 检验一下结果
(filter prime? (range 2 20))

(define (prime-sum? pair)
  (prime? (+ ( car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (filter prime-sum? (unique-pairs n)))
; 检验一下结果
(prime-sum-pairs 10)

               