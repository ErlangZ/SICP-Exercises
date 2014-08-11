#lang racket
; 有一种二叉杠杆(binary mobile)由两个分支构成，一个左分支和一个右分支，每个分支上挂了一定的
; 砝码，也可能是挂了另一个杠杆。我们可以使用左右分支的数据来描述mobile。
(define (make-mobile left-branch right-branch)
  (list left-branch right-branch))

; 每个分支是由length和structure。length一定是一个数字，表示这条臂的长度，structure可能是
; 个数字(表示上边挂的重量)也可能是另一个mobile。

(define (make-branch weight structure)
  (list weight structure))

;a. 写一个相应的选择器，获取mobile的左臂和右臂
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cadr mobile))

; 针对branch写相应的选择器，获取branch的length和structure
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cadr branch))

;b. 使用定义的选择器，获取整个mobile的总重量
(define (total-weight mobile)
  (if (not (pair? mobile))
      mobile
      (let ((left (branch-structure (left-branch mobile)))
            (right (branch-structure (right-branch mobile))))
        (+ (if (pair? left) (total-weight left) left)
           (if (pair? right) (total-weight right) right)))))

; 正确答案是9
(total-weight
(make-mobile (make-branch 1.0 2.0)
             (make-branch 1.0 (make-mobile (make-branch 1.0 1.0)
                                           (make-branch 1.0 6.0)))))

;c. 如果一个mobile的左右力臂力矩(torque)相等，就是说这个mobile是平衡的。 如果mobile本身
; 是平衡的,并且每个子mobile都是平衡的，就说这个mobile是平衡的
(define (torque branch)
  (* (branch-length branch)
     (total-weight (branch-structure branch))))
(define (balanced? mobile)
  (if (not (pair? mobile)) 
      #t
      (and (= (torque (left-branch mobile)) (torque (right-branch mobile)))
           (balanced? (branch-structure (left-branch mobile)))
           (balanced? (branch-structure (right-branch mobile))))))

; 这个mobile就是平衡的
(balanced? 
(make-mobile (make-branch 5 1)
             (make-branch 1 (make-mobile (make-branch 2 3)
                                           (make-branch 3 2)))))
      
  


; 如果我们要变更mobile的数据结构，将数据改为pair类型，程序中有多大的改动呢？
; 改动比较小，就是selector往下的内容