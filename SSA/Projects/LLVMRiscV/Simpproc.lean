import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import Lean

open LLVMRiscV
open RV64Semantics
open InstCombine(LLVM)

/-!
  This file contains simplification procedures to simplify proof goals within the `LLVMPlusRiscV` dialect.
  These simpprocs are needed because the usual simplifier fails to remove the framework overhead
  given the new additional mappings used for the hybrid dialect.
  As an example, consider the following:

  `toType _ = BitVec 64`

  To a human reader, it's obvious that these two sides should be equal by substituting `_` with
  .bv 64. However, Lean can not infer this, meaning that the standard simplifier fails to simplify such
  statements in a proof goal. With the simpprocs we explicitly tell the tactic how to simplify such
  patterns for `riscvArgsFromHybrid` and `llvmArgsFromHybrid`.
-/

/-
Disabled due to simproc implementation not being re-evaluated correctly
on Lean version "4.20.0-nightly-2025-04-21" -/
set_option Elab.async false

@[simp_denote]
private theorem valuation_var_last_eq.lemma {Ty : Type} [TyDenote Ty] {Γ : Ctxt Ty} {t : Ty}
  {s : Γ.Valuation} {x : TyDenote.toType t} : (s.cons x) (Ctxt.Var.last Γ t) = x := by
  rfl

open Lean Meta Elab in
simproc [simp_denote] valuation_var_last_eq ((Ctxt.Valuation.cons _ _) (Ctxt.Var.last _ _)) := fun e => do
  let (_f, xs) := e.getAppFnArgs
  let Ty := xs[0]!
  let instTyDenote := xs[1]!
  let Γ := xs[2]!
  let t := xs[3]!
  let x := xs[4]!
  let V := xs[5]!
  let proof := mkAppN (mkConst ``valuation_var_last_eq.lemma) #[
      Ty, instTyDenote, Γ, t, V, x
    ]
  return .visit {
    expr := x,
    proof? := proof
  }

theorem riscVArgsFromHybrid_nil_eq : riscvArgsFromHybrid (HVector.nil) = HVector.nil := rfl

open Lean Meta Elab in
@[simp_denote]
def llvmArgsFromHybrid_nil_eq :
  (llvmArgsFromHybrid HVector.nil) = HVector.nil := rfl

def llvmArgsFromHybrid_cons_eq.lemma {ty  : LLVM.Ty} {tys : List LLVM.Ty}
    (x : TyDenote.toType (LLVMRiscV.Ty.llvm ty))
    (xs : HVector TyDenote.toType (tys.map LLVMRiscV.Ty.llvm)) :
  (llvmArgsFromHybrid (tys := ty :: tys) (HVector.cons x xs)) =
  HVector.cons (f := TyDenote.toType) (a := ty) (as := tys) x (llvmArgsFromHybrid xs)
   := rfl

open Lean Meta Elab Qq in
simproc [simp_denote] llvmArgsFromHybrid_cons_eq (llvmArgsFromHybrid (_) ) := fun e => do
-- TODO: This ought to be .cons rather than a wildcard --------------^^^
--       Unfortunately, then it the simproc again stops being applied when we'd
--       expect it to, despite liberal use of `no_index`. (commented by Alex)
  let_expr llvmArgsFromHybrid tys' lhs := e
    | return .continue
  let_expr HVector.cons _α _f _as _a x xs := lhs
    | return .continue
  let ty : Q(LLVM.Ty) ← mkFreshExprMVar q(LLVM.Ty)
  let tys : Q(List LLVM.Ty) ← mkFreshExprMVar q(List LLVM.Ty)
  let expected : Expr := q($ty :: $tys)
  withTransparency (.default) <| do
    if !(← isDefEq tys' expected) then
      throwError "Failed to unify {tys'} with {expected}"
  let expr : Lean.Expr :=
    let x : Q(⟦$ty⟧) := x
    let xs : Q(HVector TyDenote.toType (List.map LLVMRiscV.Ty.llvm $tys)) := xs
    q(HVector.cons (f := TyDenote.toType) (a := $ty) (as := $tys) $x (llvmArgsFromHybrid $xs))
  let proof := mkAppN (mkConst ``llvmArgsFromHybrid_cons_eq.lemma []) #[ty, tys, x, xs]
  return .visit { expr, proof? := some proof }

@[simp_denote]
def riscvArgsFromHybrid_nil_eq :
  (riscvArgsFromHybrid HVector.nil) = HVector.nil := rfl
@[simp_denote]
def riscvArgsFromHybrid_cons_eq.lemma {ty  : RISCV64.RV64.Ty} {tys : List RISCV64.RV64.Ty}
    (x : TyDenote.toType (LLVMRiscV.Ty.riscv ty))
    (xs : HVector TyDenote.toType (tys.map LLVMRiscV.Ty.riscv)) :
  (riscvArgsFromHybrid (tys := ty :: tys) (HVector.cons x xs)) =
  HVector.cons (f := TyDenote.toType) (a := ty) (as := tys) x (riscvArgsFromHybrid xs)
   := rfl

open Lean Meta Elab in

/-- Extracting out the raw LLVM type. -/
def extractRiscvTy (x : Expr) : SimpM Expr := do
  let_expr Ty.riscv xRealTy := (← reduce x)
    | throwError m! "expected type of {x} to be `Ty.riscv _`, but got {x}"
  return xRealTy

open Lean Meta Elab in
simproc [simp_denote] riscvArgsFromHybrid_cons_eq (riscvArgsFromHybrid _) := fun e => do
  let_expr riscvArgsFromHybrid _ lhs := e
    | throwError m!"unable to find riscvArgsFromHybrid in {e}"
  let_expr HVector.cons _α _f as a x xs := lhs
    | throwError m!"unable to find HVector.cons in {lhs}"
  let xRealTy ← extractRiscvTy a
  let some (_, xsRealTys) := Expr.listLit? (← reduce as)
    | return .continue
  let xsRealTys ←  xsRealTys.mapM extractRiscvTy
  let llvmTypeType := mkApp (mkConst ``Dialect.Ty []) (mkConst ``RISCV64.RV64 [])
  let xsRealTys ←  Lean.Meta.mkListLit llvmTypeType xsRealTys
  let proof := mkAppN (mkConst ``riscvArgsFromHybrid_cons_eq.lemma []) #[xRealTy, xsRealTys, x, xs]
  let proof ← reduce proof
  let eq ← reduce (← inferType proof)
  let .some (_ty, _lhs, rhs) := eq.eq?
    | throwError "unable to reduce application of riscvArgsFromHybrid_cons_eq.lemma to an
      equality, only reduced to '{eq}'."
  return .visit {
    expr := rhs,
    proof? := .some proof
  }

/-- Simplify the proof goals for the hybrid dialect.-/
@[simp_denote]
theorem valuation_var_cons_eq.lemma {Ty : Type} [TyDenote Ty] {Γ : Ctxt Ty} {t t' : Ty}
  {s : Γ.Valuation} {x : TyDenote.toType t} {v : Γ.Var t'} :
  (s.cons x) (Ctxt.Var.toCons v) = s v := rfl
