#lang racket
(provide make-interval)
(provide lower-bound)
(provide upper-bound)
(provide equal-interval)
(provide print-interval)

(define (make-interval x y)
  (if (> x y)
      (error "something is wrong with make-interval(%d,%d)" x y)
      (cons x y)))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))

(define (equal-interval x y)
  (and (= (lower-bound x) (lower-bound y))
       (= (upper-bound x) (upper-bound y))))

(define (print-interval interval)
  (display "(")
  (display (lower-bound interval))
  (display ",")
  (display (upper-bound interval))
  (display ")"))