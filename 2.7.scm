#lang racket
(provide add-interval)
(provide mul-interval)
(provide div-interval)
;Alysaa.P.Hacker正在设计一种可以帮助人们解决工程问题的系统。 她的系统的一个特征是可以计算非精确量，比如很多物理设备的参数就是非精确量，被称为精度。当计算机计算带精度的数据的时候，
;结果也是带精度的数。 电子工程师们会使用Alyssa的系统来计算电子精度。他们如果计算两个并联的电阻的等效阻值。 公式是Ｒp=1/(1/Ｒ1 + 1/Ｒ2)。通常阻值只能限定在生产商提供的数据范围之内。
;比如，你买到的电阻上边写着6.8ohm，精度范围10%，你只能确定电阻值在6.8-ohm +/- 10%范围内，就是说这个电阻值在6.12和7.48omhs之间。因此，如果你有一个6.8-ohm +/- 10%的电阻，还有一个
;4.7ohm+/-5%的电阻，并联起来之后，阻值可能在2.58ohm和2.97ohm之间（两个电阻分别取上限和下限，每个电阻越大，总电阻越大，而且这种变化时连续的）。

;Alysaa实现“区间计算”的想法是实现一系列运算操作，来将区间组合起来，“区间”是指代表一个非精确值的取值范围。加减乘除的结果也都是一个"区间"，代表了结果的范围。Alysaa假想出来一个有两个
;端点的区间，一个上界，一个下界。她也假设，给出区间的端点，她就可以使用这些数据构造make-interval。 Alyssa首先写出一个过程，可以对区间进行加法。她的理由是，两个区间的最小值和应该是
;结果的最小值，两个区间的最大值的和应该是结果的最大值。
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

;Alyssa还实现了两个区间的乘法运算，两个区间的积是通过找到边界结果的最大值和最小值来完成的。
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

;为了对两个区间进行除法操作，Alyssa将第一个区间乘以第二个区间的倒数。规定，区间的倒数上界是下界的倒数，倒数下界是上界的倒数。
(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

;Alyssa的程序不完整，因为她还没有给出区间抽象，请给出抽象
(define (make-interval x y) (cons x y))

;给出选择器upper-bound和lower-bound来完成这个实现
(define (upper-bound i)
  (car i))

(define (lower-bound i)
  (cdr i))