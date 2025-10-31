import Blase

/--
error: (bveq (wvar 0) (add (wvar 0) (zext (bvvar 0 (wvar 1)) (wvar 0)) (bvvar 1 (wvar 0))) (add (wvar 0) (bvvar 1 (wvar 0)) (zext (bvvar 0 (wvar 1)) (wvar 0))))
-/
#guard_msgs in theorem generalize1 (x : BitVec 3) (y : BitVec 4) : 
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  intros
  bv_multi_width_print_smt_lib

/--
error: (bveq (wvar 0) (add (wvar 0) (zext (bvvar 0 (wvar 1)) (wvar 0)) (bvvar 1 (wvar 0))) (add (wvar 0) (bvvar 1 (wvar 0)) (zext (bvvar 0 (wvar 1)) (wvar 0))))
-/
#guard_msgs in theorem generalize2 : 
      ∀ (v w : Nat) (x : BitVec v) (y : BitVec w),
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  -- TODO: make this enter under binders with a with forallTelescoping.
  bv_multi_width_print_smt_lib

/--
error: (bveq (wvar 0) (add (wvar 0) (zext (bvvar 0 (wvar 1)) (wvar 0)) (bvvar 1 (wvar 0))) (add (wvar 0) (bvvar 1 (wvar 0)) (zext (bvvar 0 (wvar 1)) (wvar 0))))
-/
#guard_msgs in theorem generalize3 : 
      ∀ (v w : Nat) (x : BitVec v) (y : BitVec w),
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  intros
  bv_multi_width_print_smt_lib
