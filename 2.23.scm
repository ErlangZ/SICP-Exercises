#lang racket
; for-each函数和map很像，它也是接受一个函数并且，把它映射到列表上，但是区别在于，它实际上并
; 不返回一个有效的值。这个函数更多的是针对函数的副作用（比如打印）
(define (for-each proc ls)
  (if (null? ls)
      #f
      (begin (proc (car ls))
             (for-each proc (cdr ls)))))
(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))