#lang racket

(car ''abracadabra) ; 返回 'quote
(cdr ''abracadabra) ; 返回 (list 'abracaabra) => '(abracadabra)
(list 'abracadabra) 