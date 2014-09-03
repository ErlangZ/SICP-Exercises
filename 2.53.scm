#lang racket
; -----------------------2.53.scm-------------------------------------
; 单引号影响的就是'之后的一个对象
; @brief (list a b c) 就报错了
(list 'a 'b 'c)             ; '(a b c)

; @brief 生成一个只有含有符号的列表
(list 'george)              ; '(george)
(list (list 'george))       ; '((george))

; @brief 
(cdr '((x1 x2) (y1 y2)))    ; '((y1 y2))

; @brief
(cadr '((x1 x2) (y1 y2)))   ; '(y1 y2)

(pair? (car '(a short list))) ; #f

(memq 'red '((red shoes) (blue socks))) ;#f

(memq 'red '(red shoes blue socks)) ;'(red shoes blue socks)

