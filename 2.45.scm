#lang slideshow
; @brief 定义split函数
(define (split get-part1 get-part2)
  (lambda (painter n)
    (if (= n 1)
        (painter (* n 2))
        (let ((smaller ((split get-part1 get-part2) painter (- n 1))))
          (get-part1 (painter (* n 2)) (get-part2 smaller smaller))))))

(define up-split (split vc-append hc-append))
(define right-split (split hc-append vc-append))

; 我们试试吧^.^
(up-split circle 10)
(right-split circle 10)