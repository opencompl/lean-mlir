import Blase

/--
error: (bveq (var 0) (add (var 0) (zext (var 0 (var 1)) (var 0)) (var 1 (var 0))) (add (var 0) (var 1 (var 0)) (zext (var 0 (var 1)) (var 0))))
-/
#guard_msgs in theorem generalize1 (x : BitVec 3) (y : BitVec 4) : 
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  intros
  bv_multi_width_print_smt_lib

/-- error: (pvar 0) -/
#guard_msgs in theorem generalize2 : 
      ∀ (v w : Nat) (x : BitVec v) (y : BitVec w),
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  -- TODO: make this enter under binders with a with forallTelescoping.
  bv_multi_width_print_smt_lib

/--
error: (bveq (var 0) (add (var 0) (zext (var 0 (var 1)) (var 0)) (var 1 (var 0))) (add (var 0) (var 1 (var 0)) (zext (var 0 (var 1)) (var 0))))
-/
#guard_msgs in theorem generalize3 : 
      ∀ (v w : Nat) (x : BitVec v) (y : BitVec w),
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  intros
  bv_multi_width_print_smt_lib
