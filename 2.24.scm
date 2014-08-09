#lang racket
; (list 1 (list 2 (list 3 4))的结果是 
;      o
;   1     o
;      2     o
;         3     4

(list 1 (list 2 (list 3 4)))

; 注意这同 (list 1 2 3 4) 非常不同
;       o
;    1     o
;       2     o
;          3     o
;             4     nil
(list 1 2 3 4)