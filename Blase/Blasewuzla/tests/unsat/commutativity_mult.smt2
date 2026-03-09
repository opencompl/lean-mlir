; {
;   "name": "commutativity_mult",
;   "preconditions": [],
;   "lhs": "(bw r ( * (bw p a) (bw q b)))",
;   "rhs": "(bw r ( * (bw q b) (bw p a)))"
; }
(set-logic QF_BV)
(declare-const p Int)
(declare-const q Int)
(declare-const r Int)

(declare-const pq Int)
(assert (= pq (+ p q))) ; TODO: add '+' and '-' for arbitrary width variables.

;; --- END PREAMBLE ---

(declare-const a (_ BitVec p))
(declare-const b (_ BitVec q))

(assert (not (=
  (pzero_extend r (bvmul (pzero_extend pq a) (pzero_extend pq b)))
  (pzero_extend r (bvmul (pzero_extend pq b) (pzero_extend pq a)))
)))

(check-sat)
