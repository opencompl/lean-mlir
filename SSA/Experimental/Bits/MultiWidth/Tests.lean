import SSA.Experimental.Bits.MultiWidth.Tactic

open MultiWidth


abbrev ty := BitVec (WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons 10))

theorem hty : ty = BitVec 10 := by
  unfold ty
  rfl

example (w : Nat) :
      w = (WidthExpr.var (wcard := 2) ⟨0, by simp⟩).toNat
      ((WidthExpr.Env.empty.cons u).cons w) := rfl


theorem foo (w : Nat) :
  w = WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons w) := rfl


theorem eg1 (w : Nat) (x : BitVec w) : x = x := by
  bv_multi_width

/--
warning: abstracted non-variable bitvector: ⏎
  → '1'
---
error: safety failure at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0))
  (MultiWidth.Nondep.Term.add
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 0))
    (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.var 0)))
-/
#guard_msgs in theorem eg2 (w : Nat) (x : BitVec w) : x = x + 1 := by
  bv_multi_width

theorem eg3 (u w : Nat) (x : BitVec w) :
    (x.zeroExtend u).zeroExtend u = x.zeroExtend u := by
  bv_multi_width (config := { niter := 2 })

theorem eg4 (u w : Nat) (x : BitVec w) :
    (x.signExtend u).signExtend u = x.signExtend u := by
  bv_multi_width (config := { niter := 0 })

theorem eg5 (u w : Nat) (x : BitVec w) :
    (x.signExtend u).zeroExtend u = x.signExtend u := by
  bv_multi_width (config := { niter := 0 })

theorem eg6 (u w : Nat) (x : BitVec w) :
    (x.zeroExtend u).signExtend u = x.zeroExtend u := by
  bv_multi_width (config := { niter := 0 })

/--
error: safety failure at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.zext
      (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 2))
      (MultiWidth.Nondep.WidthExpr.var 1))
    (MultiWidth.Nondep.WidthExpr.var 0))
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 2))
    (MultiWidth.Nondep.WidthExpr.var 0))
-/
#guard_msgs in theorem eg100 (u v w : Nat) (x : BitVec w) :
    (x.zeroExtend u).zeroExtend v = x.zeroExtend v := by
  bv_multi_width (config := { niter := 2 })
