; x <_u y is not a tautology; solver should output "unknown"
(set-logic QF_BV)
(declare-const k Int)
(declare-const x (_ BitVec k))
(declare-const y (_ BitVec k))
(assert (not (bvult x y)))
(check-sat)
