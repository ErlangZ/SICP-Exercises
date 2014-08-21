#lang slideshow
; @brief 定义up-split
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (vc-append painter (hc-append smaller smaller)))))
        
