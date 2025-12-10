import Blase

/-- error: (bvjunk predicate) -/
#guard_msgs in theorem testConcrete (x y : BitVec 6) (z : BitVec 8) :
      x.zeroExtend _ + y.signExtend _ = z := by
  bv_multi_width_print_smt_lib

/-- error: (bvjunk predicate) -/
#guard_msgs in theorem testConcrete2 (x : BitVec 3) (y : BitVec 4) :
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  intros
  bv_multi_width_print_smt_lib

/-- error: (bvjunk predicate) -/
#guard_msgs in theorem generalize2 :
      ∀ (v w : Nat) (x : BitVec v) (y : BitVec w),
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  -- TODO: make this enter under binders with a with forallTelescoping.
  bv_multi_width_print_smt_lib

/-- error: (bvjunk predicate) -/
#guard_msgs in theorem generalize3 :
      ∀ (v w : Nat) (x : BitVec v) (y : BitVec w),
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  intros
  bv_multi_width_print_smt_lib
