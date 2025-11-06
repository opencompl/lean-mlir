import Blase
open BitVec
set_option warn.sorry false

theorem shiftl1 {v : Nat} (x : BitVec v) :
    x <<< 5 = x <<< 3 <<< 2 := by
  bv_multi_width

/--
error: CEX: Found exact counter-example at iteration 5 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.WidthExpr.var 0)
  (MultiWidth.Nondep.Term.shiftl
    (MultiWidth.Nondep.WidthExpr.var 0)
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0))
    5)
  (MultiWidth.Nondep.Term.shiftl
    (MultiWidth.Nondep.WidthExpr.var 0)
    (MultiWidth.Nondep.Term.shiftl
      (MultiWidth.Nondep.WidthExpr.var 0)
      (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0))
      3)
    3)
-/
#guard_msgs in theorem shiftl2 {v : Nat} (x : BitVec v) :
    x <<< 5 = x <<< 3 <<< 3 := by
  bv_multi_width

/--
trace: v : ℕ
x : BitVec v
⊢ x + (x <<< 1 + (x <<< 2 + (x <<< 3 + x <<< 4))) = x <<< 2
-/
#guard_msgs in theorem mul2shift {v : Nat} (x : BitVec v) :
    x * 31 = x * 4 := by
  simp [bv_multi_width_normalize]
  trace_state
  sorry

