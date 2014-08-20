#lang racket
; 八皇后问题， 棋盘是8*8

; 定义空的结果
(define empty-board '())

; 将已有的结果集进行扩展
; 一个位置是一个pair : (row . col)
; (adjoin-position 1 1 '()) -> '([1 1])
; (adjoin-position 4 5 '([1 2]) -> '([4 5] [1 2])
(define (adjoin-position new-row new-col rest-of-queens)
   (append (list (list new-row new-col)) rest-of-queens))

(adjoin-position 3 2 '((1 2) (2 6))) ; -> '((3 2) (1 2) (2 6))
(adjoin-position 3 2 '((1 2)))       ; -> '((3 2) (1 2))
(adjoin-position 3 2 '())          ; -> '((3 2))

; @brief 判定一个列表中的元素是否是唯一的
; @比如(3 5 3)->false (3 2 1)->true ()->true
(define (unique? ls)
  (if (<= (length ls) 1)
      #t
      (let ((sorted-ls (sort ls <)))
        (and (not (= (car sorted-ls) (cadr sorted-ls))) 
             (unique? (cdr sorted-ls))))))

; @brief 判定一个位置当前是不是安全的
(define (safe? now-col positions)
  (if (<= (length positions) 1) 
      #t ; '() 或者 (1 2) 位置一定是安全的 
      (and 
       (unique? (map car positions))
       (unique? (map cadr positions))
       (unique? (map (lambda (position) (- (cadr position) (car position))) 
                     positions))
       (unique? (map (lambda (position) (+ (cadr position) (car position)))
                     positions)))))
 
;'((1 . 4) (2 . 2) (3 . 3)), now-col=3 ->显然不安全
(safe? 3 '((1 4) (2 2) (3 3)))
;'((1 . 5) (2 . 3) (3 . 7)), now-col=3 ->显然是安全的
(safe? 3 '((1 6) (2 3) (3 7)))
(safe? 1 '((1 1) (2 1)))


(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter 
         (lambda (positions) (safe? k positions))
         (append-map
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (range 1 (+ board-size 1))))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(queens 8) 
