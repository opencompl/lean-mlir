import SSA.Experimental.Bits.MultiWidth.Tactic

open MultiWidth


abbrev ty := BitVec (WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons 10))

theorem hty : ty = BitVec 10 := by
  unfold ty
  rfl

set_option pp.analyze true
set_option pp.analyze.explicitHoles true
set_option pp.analyze.checkInstances true

theorem foo (w : Nat) :
  w = WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons w) := rfl

/--
info: before out: Term.Ctx.Env.empty (WidthExpr.Env.empty.cons w) (Term.Ctx.empty _)
---
error: Application type mismatch: In the application
  Term.Ctx.Env.cons (Term.Ctx.Env.empty (WidthExpr.Env.empty.cons w) (Term.Ctx.empty _)) _ x ⋯
the argument
  Eq.refl _
has type
  WidthExpr.toNat (WidthExpr.var (Fin.mk 0)) (WidthExpr.Env.empty.cons w) =
    WidthExpr.toNat (WidthExpr.var (Fin.mk _)) (WidthExpr.Env.empty.cons w) : Prop
but is expected to have type
  w = WidthExpr.toNat (WidthExpr.var (Fin.mk _)) (WidthExpr.Env.empty.cons w) : Prop
-/
#guard_msgs in theorem eg1 (w : Nat) (x : BitVec w) : x = x := by
  bv_multi_width
  sorry


