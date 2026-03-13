; Prove: (x << y) >> y == x when x has no bits above position (k - y),
; i.e., shifting left then right by the same variable amount recovers x
; when the shift doesn't overflow.
; We encode the no-overflow condition as a value constraint.
(set-logic ALL)
(declare-const k Int)
(declare-const x (_ BitVec k))
(declare-const y (_ BitVec k))
; no-overflow: shifting x left by y and back gives x
(assert (= (bvlshr (bvshl x y) y) x))
; claim: under no-overflow, (x << y) >> y == x (tautological with the above,
; but tests that variable shift parsing works end-to-end)
(assert (not (= (bvlshr (bvshl x y) y) x)))
(check-sat)
