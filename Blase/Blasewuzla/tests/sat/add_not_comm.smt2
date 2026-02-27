; x = 1 is satisfiable (holds when x=1, fails when x≠1).
; The solver finds a counterexample and outputs "sat".
(set-logic QF_BV)
(declare-const k Int)
(declare-const x (_ BitVec k))
(assert (= x (int_to_pbv k 1)))
(check-sat)
