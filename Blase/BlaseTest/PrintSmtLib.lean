import Blase

/--
error: (bveq (wconst 8) (add (wconst 8) (setwidth (bvvar 0 (wconst 6)) (wconst 8)) (sext (bvvar 1 (wconst 6)) (wconst 8))) (bvvar 2 (wconst 8)))
-/
#guard_msgs in theorem testConcrete (x y : BitVec 6) (z : BitVec 8) :
      x.zeroExtend _ + y.signExtend _ = z := by
  bv_multi_width_print_smt_lib

/--
error: (bveq (wconst 4) (add (wconst 4) (setwidth (bvvar 0 (wconst 3)) (wconst 4)) (bvvar 1 (wconst 4))) (add (wconst 4) (bvvar 1 (wconst 4)) (setwidth (bvvar 0 (wconst 3)) (wconst 4))))
-/
#guard_msgs in theorem testConcrete2 (x : BitVec 3) (y : BitVec 4) :
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  intros
  bv_multi_width_print_smt_lib

/--
error: (bveq (wvar 0) (add (wvar 0) (setwidth (bvvar 0 (wvar 1)) (wvar 0)) (bvvar 1 (wvar 0))) (add (wvar 0) (bvvar 1 (wvar 0)) (setwidth (bvvar 0 (wvar 1)) (wvar 0))))
-/
#guard_msgs in theorem generalize2 :
      ∀ (v w : Nat) (x : BitVec v) (y : BitVec w),
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  -- TODO: make this enter under binders with a with forallTelescoping.
  bv_multi_width_print_smt_lib

/--
error: (bveq (wvar 0) (add (wvar 0) (setwidth (bvvar 0 (wvar 1)) (wvar 0)) (bvvar 1 (wvar 0))) (add (wvar 0) (bvvar 1 (wvar 0)) (setwidth (bvvar 0 (wvar 1)) (wvar 0))))
-/
#guard_msgs in theorem generalize3 :
      ∀ (v w : Nat) (x : BitVec v) (y : BitVec w),
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  intros
  bv_multi_width_print_smt_lib


