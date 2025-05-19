import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import Lean

open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V
/-
Disabled due to simproc implementation not being re-evaluated correctly
on Lean version "4.20.0-nightly-2025-04-21" -/
set_option Elab.async false

@[simp_denote]
private theorem valuation_var_last_eq.lemma {Ty : Type} [TyDenote Ty] {Γ : Ctxt Ty} {t : Ty} {s : Γ.Valuation} {x : TyDenote.toType t} : (s.snoc x) (Ctxt.Var.last Γ t) = x := by
  rfl

open Lean Meta Elab in
simproc [simp_denote] valuation_var_last_eq ((Ctxt.Valuation.snoc _ _) (Ctxt.Var.last _ _)) := fun e => do
  -- logInfo m!"Matched (Valuation.snoc s x) (Ctxt.Var.last Γ t) with {e}"
  let (_f, xs) := e.getAppFnArgs
  -- logInfo m!"f: {f}, xs: {xs}"
  let ty := xs[0]!
  let s := xs[4]!
  let x := xs[xs.size - 1 - 2]!
  let proof ← mkAppOptM ``valuation_var_last_eq.lemma #[.some ty, .none, .none, .none, .some s, .some x]
  return .visit {
    expr := x,
    proof? := proof
  }

theorem riscVArgsFromHybrid_nil_eq : riscvArgsFromHybrid (HVector.nil) = HVector.nil := rfl

open Lean Meta Elab in
/-- Convert a `List Expr` into an `Expr` by building calls to `List.nil` and `List.cons`.
Note that the `ToExpr` instance of `List` is insufficient, since it perform a *deep expression cast*,
where it converts any `List α` where `[ToExpr α]` into a `List Expr`. So, when given a list of expressions, like [.const Nat],
instead of building `[Nat]`, it builds `[Lean.Expr.Const ``Nat]` (i.e.., it seralizes the `Expr` as well!).
Instead, we want a shallow serialization, where we just build `List.cons (.const Nat) List.nil`.
-/
def listExprToExprShallow (type : Option Expr) : List Expr → MetaM Expr
| .nil => mkAppOptM ``List.nil #[type]
| .cons x xs => do
  let tailExpr ← listExprToExprShallow type xs -- sarah split this step up for her to understand it.
  mkAppOptM ``List.cons #[type, x, tailExpr]

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
-- TODO: This ought to be .cons rather than a wildcard -------------^^^
--       Unfortunately, then it the simproc again stops being applied when we'd
--       expect it to, despite liberal use of `no_index`.
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

def riscvArgsFromHybrid_cons_eq.lemma {ty  : RISCV64.RV64.Ty} {tys : List RISCV64.RV64.Ty}
    (x : TyDenote.toType (LLVMRiscV.Ty.riscv ty))
    (xs : HVector TyDenote.toType (tys.map LLVMRiscV.Ty.riscv)) :
  (riscvArgsFromHybrid (tys := ty :: tys) (HVector.cons x xs)) =
  HVector.cons (f := TyDenote.toType) (a := ty) (as := tys) x (riscvArgsFromHybrid xs)
   := rfl

open Lean Meta Elab in
/-- Extract out the raw LLVM type from the. -/
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

  logInfo m!"found (llvmArgsFromHybrid (HVector.cons ({x} : {xRealTy}) ({xs} : {xsRealTys})"
  let llvmTypeType := mkApp (mkConst ``Dialect.Ty []) (mkConst ``RISCV64.RV64 [])
  let xsRealTys ← listExprToExprShallow (.some llvmTypeType) xsRealTys
  logInfo m!"calling {``riscvArgsFromHybrid_cons_eq.lemma} with {xRealTy}, {xsRealTys}, {x}, {xs}"
  logInfo m!"XXXX"
  let proof := mkAppN (mkConst ``riscvArgsFromHybrid_cons_eq.lemma []) #[xRealTy, xsRealTys, x, xs]
  logInfo m!"YYYY"
  logInfo m!"built proof {proof}"
  let proof ← reduce proof
  logInfo m!"reduced proof to {proof}"
  let eq ← reduce (← inferType proof)
  logInfo m!"reduced type of proof (i.e. the equality) to {eq}"
  let .some (_ty, _lhs, rhs) := eq.eq?
    | throwError "unable to reduce application of riscvArgsFromHybrid_cons_eq.lemma to an equality, only reduced to '{eq}'."
  logInfo m!"final right-hand-side of equality is: {rhs}"
  return .visit {
    expr := rhs,
    proof? := .some proof
  }

@[simp]
theorem poisonOr_mk_some_eq_value (x : α) : { toOption := some x } = PoisonOr.value x := rfl

@[simp_denote]
theorem liftM_eq_some (α : Type u) : @liftM Id Option _  α = some := by rfl

@[simp_denote]
theorem valuation_var_snoc_eq.lemma {Ty : Type} [TyDenote Ty] {Γ : Ctxt Ty} {t t' : Ty} {s : Γ.Valuation} {x : TyDenote.toType t} {v : Γ.Var t'} :
  (s.snoc x) (Ctxt.Var.toSnoc v) = s v := rfl

def add_riscv1 := [LV| {
  ^entry (%lhs: i64, %rhs: i64 ):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> !i64
    %add1 = add %lhsr, %rhsr : !i64
    %addl = "builtin.unrealized_conversion_cast" (%add1) : (!i64) -> (i64)
    llvm.return %addl : i64
  }]

def add_llvm_no_flags : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%lhs: i64, %rhs: i64 ):
      %1 = llvm.add   %lhs, %rhs  : i64
      llvm.return %1 : i64
  }]
@[simp]
theorem PoisonOr_eq_squb (a b : PoisonOr α) : PoisonOr.IsRefinedBy a b ↔ a ⊑ b := by rfl

/- # Debug: single llvm op -/
def single_bin_op_lhs := [LV| {
  ^entry ():
    %0 = llvm.mlir.constant (0) : i64
    llvm.return  %0 : i64
  }]
def single_bin_op_rhs := [LV| {
  ^entry ():
    %0 = llvm.mlir.constant (0) : i64
    llvm.return  %0 : i64
  }]
def single_llvm_bin_op : LLVMPeepholeRewriteRefine [] :=
    {lhs:= single_bin_op_lhs , rhs:= single_bin_op_rhs
      ,correct := by
      unfold  single_bin_op_lhs single_bin_op_rhs
      simp -- Replace with a general simplification tactic or another meaningful tactic
  }

/- # Debug: single riscv op -/
def riscv_lhs := [LV| {
  ^entry ():
    %0 = li (1) : !i64
    ret  %0 : !i64
  }]
def riscv_rhs := [LV| {
  ^entry ():
    %0 = li (0) : !i64
    ret  %0 : !i64
  }]

/- # Debug: casts -/
def cast_op_lhs := [LV| {
  ^entry (%lhs: !i64):
        %0 = "builtin.unrealized_conversion_cast"(%lhs) : (!i64) -> i64
        --%1 = "builtin.unrealized_conversion_cast" (%0) : (i64) -> (!i64)
      llvm.return  %0 : i64
  }]

def cast_op_rhs := [LV| {
  ^entry (%lhs: !i64):
        %0 = "builtin.unrealized_conversion_cast"(%lhs) : (!i64) -> i64
        --%1 = "builtin.unrealized_conversion_cast" (%0) : (i64) -> (!i64)
      llvm.return  %0 : i64
  }]

attribute [simp_denote] MLIR.AST.Op.ParsedArgs.ofList

-- Here we get the motive not type correct error.
def single_cast_op : LLVMPeepholeRewriteRefine [Ty.riscv (.bv)] :=
  {lhs:= cast_op_lhs , rhs:= cast_op_rhs ,
   correct := by
    unfold cast_op_lhs cast_op_rhs
    simp_peephole
    simp only [MLIR.AST.Op.ParsedArgs.toHVector, MLIR.AST.Op.ParsedArgs.toHVector.go]
    rw [List.reverse_cons]
    sorry
  }

/- This example causes an expontially huge proof goal, it is inlining the wholeparsing code.
simp peephole also does not apply.
-/
def test1: LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
    {lhs:= add_riscv1 , rhs:= add_llvm_no_flags
      ,correct := by
      unfold  add_riscv1 add_llvm_no_flags
      simp_peephole
      simp only [MLIR.AST.Op.ParsedArgs.toHVector, MLIR.AST.Op.ParsedArgs.toHVector.go]
      simp only  [castriscvToLLVM]
      simp_peephole
      simp only  [PoisonOr_eq_squb]
      simp [PoisonOr.value_isRefinedBy_value]
  }
