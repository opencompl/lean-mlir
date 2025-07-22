import SSA.Experimental.Bits.MultiWidth.Tactic

open MultiWidth


abbrev ty := BitVec (WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons 10))

theorem hty : ty = BitVec 10 := by
  unfold ty
  rfl

example (w : Nat) :
      w = (WidthExpr.var (wcard := 2) ⟨0, by simp⟩).toNat
      ((WidthExpr.Env.empty.cons u).cons w) := rfl


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
info: proven by KInduction with 0 iterations
-/
#guard_msgs in theorem eg1 (w : Nat) (x : BitVec w) : x = x := by
  bv_multi_width

/--
info: fsm circuit size: 58
---
info: FSM state space size: 32
---
warning: abstracted non-variable bitvector: ⏎
  → '1'
---
error: safety failure at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.Term.var 0 { toNat := 0 })
  (MultiWidth.Nondep.Term.add
    (MultiWidth.Nondep.Term.var 0 { toNat := 0 })
    (MultiWidth.Nondep.Term.var 1 { toNat := 0 }))
-/
#guard_msgs in theorem eg2 (w : Nat) (x : BitVec w) : x = x + 1 := by
  bv_multi_width

theorem eg3 (u w : Nat) (x : BitVec w) :
    (x.zeroExtend u).zeroExtend u = x.zeroExtend u := by
  bv_multi_width

/--
info: fsm circuit size: 258
---
info: FSM state space size: 8589934592
---
error: safety failure at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.zext (MultiWidth.Nondep.Term.var 0 { toNat := 2 }) { toNat := 1 })
    { toNat := 0 })
  (MultiWidth.Nondep.Term.zext (MultiWidth.Nondep.Term.var 0 { toNat := 2 }) { toNat := 0 })
-/
#guard_msgs in theorem eg4 (u v w : Nat) (x : BitVec w) :
    (x.zeroExtend u).zeroExtend v = x.zeroExtend v := by
  bv_multi_width
