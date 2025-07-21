import SSA.Experimental.Bits.MultiWidth.Tactic

open MultiWidth


abbrev ty := BitVec (WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons 10))

theorem hty : ty = BitVec 10 := by
  unfold ty
  rfl

/-
set_option pp.analyze true
set_option pp.analyze.explicitHoles true
set_option pp.analyze.checkInstances true
set_option trace.Meta.check true
-/

theorem foo (w : Nat) :
  w = WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons w) := rfl

/--
info: fsm circuit size: 24
---
info: FSM state space size: 8
---
error: safety failure at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.Term.var 0 { toNat := 0 })
  (MultiWidth.Nondep.Term.var 0 { toNat := 0 })
-/
#guard_msgs in theorem eg1 (w : Nat) (x : BitVec w) : x = x := by
  bv_multi_width
