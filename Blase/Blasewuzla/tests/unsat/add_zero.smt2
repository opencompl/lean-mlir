; Prove: x + 0 = x  (additive identity)
; Assert the negation; solver outputs "unsat" iff the property holds for all widths.
(set-logic QF_BV)
(declare-const k Int)
(declare-const x (_ BitVec k))
(assert (not (= x (bvadd x (int_to_pbv k 0)))))
(check-sat)
