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
info: proven by KInduction with 0 iterations
-/
#guard_msgs in theorem eg1 (w : Nat) (x : BitVec w) : x = x := by
  bv_multi_width

/--
info: fsm circuit size: 24
---
info: FSM state space size: 8
---
info: proven by KInduction with 0 iterations
---
error: (kernel) application type mismatch
  id
    (Decide.Predicate.toProp_of_decide
      (Predicate.binRel BinaryRelationKind.eq (MultiWidth.Term.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩)
        (MultiWidth.Term.var ⟨1, of_decide_eq_true (id (Eq.refl true))⟩))
      (Lean.ofReduceBool eg2._mkEqRflNativeDecideProof_1_1 true (Eq.refl true))
      (((Term.Ctx.Env.empty (WidthExpr.Env.empty.cons w) (Term.Ctx.empty 1)).cons
            (WidthExpr.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩) x
            (Eq.refl
              ((WidthExpr.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩).toNat (WidthExpr.Env.empty.cons w)))).cons
        (WidthExpr.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩) (x + 1)
        (Eq.refl ((WidthExpr.var ⟨0, of_decide_eq_true (id (Eq.refl true))⟩).toNat (WidthExpr.Env.empty.cons w)))))
argument has type
  Predicate.toProp
    (((Term.Ctx.Env.empty (WidthExpr.Env.empty.cons w) (Term.Ctx.empty 1)).cons (WidthExpr.var ⟨0, ⋯⟩) x ⋯).cons
      (WidthExpr.var ⟨0, ⋯⟩) (x + 1) ⋯)
    (Predicate.binRel BinaryRelationKind.eq (MultiWidth.Term.var ⟨0, ⋯⟩) (MultiWidth.Term.var ⟨1, ⋯⟩))
but function has type
  x = x + 1 → x = x + 1
-/
#guard_msgs in theorem eg2 (w : Nat) (x : BitVec w) : x = x + 1 := by
  bv_multi_width
