(set-logic ALL)
(declare-const k Int)
(declare-fun %y () (_ BitVec k))
(declare-fun %x () (_ BitVec k))
(assert (not (= (bvxor (bvand %x %y) (bvnot (int_to_pbv k 0))) (bvor (bvxor %x (bvnot (int_to_pbv k 0))) (bvxor %y (bvnot (int_to_pbv k 0)))))))
(check-sat)

