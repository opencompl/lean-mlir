import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.Tactic
open MLIR AST

namespace AliveAutoGenerated

abbrev ICom.Refinement (src tgt : Com (φ:=0) Γ t) (h : Goedel.toType t = Option α := by rfl) : Prop :=
  ∀ Γv, Bitvec.Refinement (h ▸ src.denote Γv) (h ▸ tgt.denote Γv)

infixr:90 " ⊑ "  => ICom.Refinement

namespace OnlyReturn
def lhs (w : Nat) :=
[mlir_icom (w)| {
^bb0(%C1 : _):
  "llvm.return" (%C1) : (_) -> ()
}]

def rhs (w : Nat):=
[mlir_icom (w)| {
^bb0(%C1 : _):
  "llvm.return" (%C1) : (_) -> ()
}]

open Ctxt (Var) in
theorem refinement (w : Nat) : lhs w ⊑ rhs w := by
  unfold lhs rhs
  intro (Γv : ([.bitvec w] : List InstCombine.Ty) |> Ctxt.Valuation)
  simp [ICom.denote, IExpr.denote, HVector.denote, Var.zero_eq_last, Var.succ_eq_toSnoc,
        Ctxt.snoc, Ctxt.Valuation.snoc_last, Ctxt.ofList, Ctxt.Valuation.snoc_toSnoc,
        HVector.map, OpDenote.denote, IExpr.op_mk, IExpr.args_mk, ICom.Refinement,
        Bind.bind, DialectMorphism.mapTy, MOp.instantiateCom,
        InstCombine.MTy.instantiate, ConcreteOrMVar.instantiate, Vector.get, List.get]
  generalize Γv (Var.last [] (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w))) = x
  -- simp_alive
  apply Bitvec.Refinement.refl
end OnlyReturn


namespace AddCommutative
def lhs (w : Nat) :=
[mlir_icom (w)| {
^bb0(%X : _, %Y: _):
  %Z = "llvm.add" (%X, %Y) : (_, _) -> (_)
  "llvm.return" (%Z) : (_) -> ()
}]

def rhs (w : Nat):=
[mlir_icom (w)| {
^bb0(%X : _, %Y: _):
  %Z = "llvm.add" (%Y, %X) : (_, _) -> (_)
  "llvm.return" (%Z) : (_) -> ()
}]

open Ctxt (Var) in
theorem refinement (w : Nat) : lhs w ⊑ rhs w := by
  unfold lhs rhs
  intro (Γv : ([.bitvec w, .bitvec w] : List InstCombine.Ty) |> Ctxt.Valuation)
  simp [ICom.denote, IExpr.denote, HVector.denote, Var.zero_eq_last, Var.succ_eq_toSnoc,
        Ctxt.snoc, Ctxt.Valuation.snoc_last, Ctxt.ofList, Ctxt.Valuation.snoc_toSnoc,
        HVector.map, OpDenote.denote, IExpr.op_mk, IExpr.args_mk, ICom.Refinement,
        Bind.bind, DialectMorphism.mapTy, MOp.instantiateCom,
        InstCombine.MTy.instantiate, ConcreteOrMVar.instantiate, Vector.get, List.get]
  sorry
end AddCommutative


-- Name:AddSub:1043
-- precondition: true
/-
  %Y = and %Z, C1
  %X = xor %Y, C1
  %LHS = add %X, 1
  %r = add %LHS, %RHS

=>
  %or = or %Z, ~C1
  %Y = and %Z, C1
  %X = xor %Y, C1
  %LHS = add %X, 1
  %r = sub %RHS, %or

-/
def AddSub_1043_src (w : Nat) :=
[mlir_icom (w)| {
^bb0(%C1 : _, %Z : _, %RHS : _):
  %v1 = "llvm.and" (%Z,%C1) : (_, _) -> (_)
  %v2 = "llvm.xor" (%v1,%C1) : (_, _) -> (_)
  %v3 = "llvm.mlir.constant" () { value = 1 : _ } :() -> (_)
  %v4 = "llvm.add" (%v2,%v3) : (_, _) -> (_)
  %v5 = "llvm.add" (%v4,%RHS) : (_, _) -> (_)
  "llvm.return" (%v5) : (_) -> ()
}]

set_option pp.proofs false
#check AddSub_1043_src
#reduce AddSub_1043_src

#check Com

def AddSub_1043_tgt (w : Nat):=
[mlir_icom (w)| {
^bb0(%C1 : _, %Z : _, %RHS : _):
  %v1 = "llvm.not" (%C1) : (_) -> (_)
  %v2 = "llvm.or" (%Z,%v1) : (_, _) -> (_)
  %v3 = "llvm.and" (%Z,%C1) : (_, _) -> (_)
  %v4 = "llvm.xor" (%v3,%C1) : (_, _) -> (_)
  %v5 = "llvm.mlir.constant" () { value = 1 : _ } :() -> (_)
  %v6 = "llvm.add" (%v4,%v5) : (_, _) -> (_)
  %v7 = "llvm.sub" (%RHS,%v2) : (_, _) -> (_)
  "llvm.return" (%v7) : (_) -> ()
}]

#check Option.bind
theorem MOp.MOp.instantiateCom_unary_bitvec (w : Nat) :
  (MLIR.AST.MOp.instantiateCom (φ := 1)
    { val := [w], property := rfl : Vector Nat 1 }).mapTy (InstCombine.MTy.bitvec (Width.mvar 0)) =
    InstCombine.MTy.bitvec (Width.concrete w) := by
  simp[MOp.instantiateCom, InstCombine.MTy.instantiate, ConcreteOrMVar.instantiate,
      Vector.get]


theorem DerivedContext.ofContext_empty {φ : ℕ} : DerivedContext.ofContext (φ := φ) [] = ⟨[], .zero _⟩ := by
  simp[DerivedContext.ofContext]

theorem List.nthLe_unary_0 (w : α) :
  List.nthLe [w] 0 (by simp) = w := rfl

-- theorem Valuation_snoc {Ty : Type} [Goedel Ty]
--   (Γ' : Ctxt Ty) (α : Ty) (Γv : Ctxt.Valuation (α :: Γ')) :
--   { val : ⟦α⟧ × Ctxt.Valuation Γ' // Γv = val.snd.snoc val.fst } := by
--   simp[Ctxt.Valuation] at Γv
--   let v1 := Γv (Ctxt.Var.last Γ')
--   constructor



set_option pp.proofs false in
set_option pp.proofs.withType false in
-- set_option maxHeartbeats 900000 in
open Ctxt (Var) in
theorem AddSub_1043_refinement (w : Nat) : AddSub_1043_src w ⊑ AddSub_1043_tgt w := by
  /- unfolding -/
  unfold AddSub_1043_src
  unfold AddSub_1043_tgt
  /- simplification -/
  dsimp only[]
  unfold ICom.Refinement
  intros Γv
  simp only[ICom.denote, IExpr.denote, HVector.denote, OpDenote.denote, InstCombine.Op.denote, HVector.toPair, pairMapM,
    HVector.toTuple]
  simp[bind, Option.bind, pure]
  simp[DerivedContext.ofContext, DerivedContext.snoc, Ctxt.snoc] -- cannot rewrite with simp theorem 'motive is not type correct'
  simp[MOp.instantiateCom, InstCombine.MTy.instantiate, ConcreteOrMVar.instantiate,
      Vector.get, HVector.toSingle, HVector.toTuple]
  simp[List.nthLe]

  generalize V0 : Γv (Var.last _ _) = v0
  generalize V1 : Γv (Var.last _ _).toSnoc = v1
  generalize V2 : Γv (Var.last _ _).toSnoc.toSnoc = v2
  simp[Goedel.toType] at v0 v1 v2

  /- cases on variables, eliminating trivial `none` cases. -/
  cases v0 <;> simp <;>
  cases v1 <;> simp <;>
  cases v2 <;> simp
  /- rename inaccessibles. -/
  rename_i a b c





end AliveAutoGenerated