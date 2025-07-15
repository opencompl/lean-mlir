import SSA.Experimental.Bits.MultiWidth.Tactic

open MultiWidth


abbrev ty := BitVec (WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons 10))

theorem hty : ty = BitVec 10 := by
  unfold ty
  rfl

set_option pp.analyze true
set_option pp.analyze.explicitHoles true
set_option pp.analyze.checkInstances true
set_option trace.Meta.check true

theorem foo (w : Nat) :
  w = WidthExpr.toNat (WidthExpr.var (Fin.mk 0 (by simp))) (WidthExpr.Env.empty.cons w) := rfl

/--
info: before out: Term.Ctx.Env.empty (WidthExpr.Env.empty.cons w) (Term.Ctx.empty _)
---
info: after out: Term.Ctx.Env.cons (Term.Ctx.Env.empty (WidthExpr.Env.empty.cons w) (Term.Ctx.empty _)) _ x ⋯
---
info: produced out: fun wenv tenv =>
  Predicate.toProp (wcard := 1) (wenv := wenv) (tctx := (Term.Ctx.empty _).cons (WidthExpr.var ⟨_, ⋯⟩)) tenv
    (Predicate.binRel (wcard := 1) (ctx := (Term.Ctx.empty _).cons (WidthExpr.var ⟨_, ⋯⟩)) (w := WidthExpr.var ⟨_, ⋯⟩)
        BinaryRelationKind.eq
        (MultiWidth.Term.var (wcard := 1) (tctx := (Term.Ctx.empty _).cons (WidthExpr.var ⟨_, ⋯⟩)) (⟨0, ⋯⟩ : Fin 1))
        (MultiWidth.Term.var (wcard := 1) (tctx := (Term.Ctx.empty _).cons (WidthExpr.var ⟨_, ⋯⟩)) (⟨0, ⋯⟩ : Fin 1)) :
      MultiWidth.Predicate ((Term.Ctx.empty 1).cons (WidthExpr.var (⟨0, ⋯⟩ : Fin 1))))
---
error: type expected
  WidthExpr.Env.empty.cons w
-/
theorem eg1 (w : Nat) (x : BitVec w) : x = x := by
  bv_multi_width


