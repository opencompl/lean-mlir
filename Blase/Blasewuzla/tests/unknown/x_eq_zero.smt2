; x = 0 is not a tautology; solver should output "unknown"
; (Asserting the negation of something that's not always true.)
(set-logic QF_BV)
(declare-const k Int)
(declare-const x (_ BitVec k))
(assert (not (= x (int_to_pbv k 0))))
(check-sat)
