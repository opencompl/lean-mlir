import Mathlib.Tactic.Ring

macro "alive_auto": tactic =>
  `(tactic|
      (
        intros
        (try simp (config := {decide := false}) [-Std.BitVec.ofNat_eq_ofNat])
        try ring_nf
      )
   )
