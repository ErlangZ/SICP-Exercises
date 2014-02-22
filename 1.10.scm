#lang racket
; 接下来的两个过程定义了一个方法，利用inc和dec过程，把两个正数加起来；inc是加1，dec是减1
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

(define (add a b)
  (if (= a 0)
      b
      (add (dec a) (inc b))))

;使用替换模型说明哪个过程是迭代的，哪个过程是递归的
; + 是递归 add是迭代