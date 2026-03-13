; Prove: -1 << n is a negative number (when n < k), i.e., its sign bit is set.
; This tests bvshl with (int_to_pbv k n) as the shift amount,
; where n is a width variable (not a numeric literal).
; bvneg(1) = -1 (all ones). Shifting left by n clears the bottom n bits
; but keeps the sign bit set, so the result is still negative.
(set-logic ALL)
(declare-const k Int)
(declare-const n Int)
(assert (< n k))
(assert (not
  (bvslt (bvshl (bvneg (int_to_pbv k 1)) (int_to_pbv k n)) (int_to_pbv k 0))
))
(check-sat)
