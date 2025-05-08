import SSA.Projects.RISCV64.Pipeline.LLVMAndRiscV
import SSA.Projects.RISCV64.Pipeline.Refinement
import Lean

open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V

/-
Disabled due to simproc implementation not being re-evaluated correctly
on Lean version "4.20.0-nightly-2025-04-21" -/
set_option Elab.async false

  --  (Ctxt.Valuation.nil::ᵥe) (Ctxt.Var.last [] (Ty.llvm (InstCombine.MTy.bitvec 64)))
@[simp_denote]
private theorem valuation_var_last_eq.lemma {Ty : Type} [TyDenote Ty] {Γ : Ctxt Ty} {t : Ty} {s : Γ.Valuation} {x : TyDenote.toType t} : (s.snoc x) (Ctxt.Var.last Γ t) = x := by
  rfl

#check Ctxt.Valuation.snoc


/-! # Instruction lowering patterns
    This file contains a collection of instruction lowerings that are performed by
    LLVM and make explicit what is performed by the LLVM backkend.
     -/
/-
f: Ctxt.Valuation.snoc, xs: [Ty,
 instTyDenoteTyLLVMPlusRiscV,
 [],
 Ty.llvm (InstCombine.Ty.bitvec 64),
 Ctxt.Valuation.nil,
 e,
 Ty.llvm (InstCombine.Ty.bitvec 64),
 Ctxt.Var.last [] (Ty.llvm (InstCombine.MTy.bitvec 64))]
-/
open Lean Meta Elab in
simproc [simp_denote] valuation_var_last_eq ((Ctxt.Valuation.snoc _ _) (Ctxt.Var.last _ _)) := fun e => do
  -- logInfo m!"Matched (Valuation.snoc s x) (Ctxt.Var.last Γ t) with {e}"
  let (_f, xs) := e.getAppFnArgs
  -- logInfo m!"f: {f}, xs: {xs}"
  let ty := xs[0]!
  let s := xs[4]!
  let x := xs[xs.size - 1 - 2]!
  -- logInfo m!"x: {x}"
  -- TODO: @alexkeizer, don't kill me for this :D I was lazy, so I just write down the full implicit match.
  -- We should probably decide which arguments are implicit, and then only pass these as explicit args.
  let proof ← mkAppOptM ``valuation_var_last_eq.lemma #[.some ty, .none, .none, .none, .some s, .some x]
  return .visit {
    expr := x,
    -- proof? := ← mkSorry (← mkEq x rhs) .true -- TODO: replace with call to valuation_var_last_eq.lemma.
    proof? := proof
  }
  -- let_expr ((Ctxt.Valuation.snoc _V x) (Ctxt.Var.last _ _)) := x

  -- let args ←
  -- let_expr ((Ctxt.Valuation.snoc _V x) (Ctxt.Var.last _ _)) := x




-- open Lean Meta Elab in
-- simproc [simp_denote] valuation_var_last_eq ((Ctxt.Valuation.snoc _ _) (Ctxt.Var.last _ _)) := fun e => do
--   let_expr Ctxt.Valuation.snoc Ty instDenote Γ t s x _v := e
--     | return .continue
--   return .visit {
--     expr := x,
--     proof? := some <| mkAppN (mkConst ``valuation_var_last_eq.lemma) #[Ty, instDenote, Γ, t, s, x]
--   }


theorem riscVArgsFromHybrid_nil_eq : riscvArgsFromHybrid (HVector.nil) = HVector.nil := rfl

-- LLVMRiscV.llvmArgsFromHybrid {tys : List LLVM.Ty} :
--   @HVector Ty (@TyDenote.toType Ty instTyDenoteTyLLVMPlusRiscV) (@List.map LLVM.Ty Ty Ty.llvm tys) →
--     @HVector LLVM.Ty (@TyDenote.toType LLVM.Ty InstCombine.instTyDenoteTy) tys
set_option pp.explicit true in
#check llvmArgsFromHybrid
#check HVector.cons
#synth Lean.ToExpr (List Lean.Expr)

#check Lean.instToExprListOfToLevel


open Lean Meta Elab in
/-- Convert a `List Expr` into an `Expr` by building calls to `List.nil` and `List.cons`.
Note that the `ToExpr` instance of `List` is insufficient, since it perform a *deep expression cast*,
where it converts any `List α` where `[ToExpr α]` into a `List Expr`. So, when given a list of expressions, like [.const Nat],
instead of building `[Nat]`, it builds `[Lean.Expr.Const ``Nat]` (i.e.., it seralizes the `Expr` as well!).
Instead, we want a shallow serialization, where we just build `List.cons (.const Nat) List.nil`.
-/
def listExprToExprShallow (type : Option Expr) : List Expr → MetaM Expr
| .nil => mkAppOptM ``List.nil #[type]
| .cons x xs => do mkAppOptM ``List.cons #[type, x, ← listExprToExprShallow type xs]

open Lean Meta Elab in
#check Lean.Environment

def f (n : Nat) : Bool := n % 2 == 0

def g : ∀ (_ : Nat), Bool := fun n => n % 2 == 0
def h : ∀ (w : Nat), BitVec w  :=
  -- | value
  fun (w : Nat) => 0#w

def h' : (w : Nat) → BitVec w  :=
  -- | value
  fun (w : Nat) => 0#w

-- let x := xdef in rest <-> (fun x => rest) xdef

/-#
Let versus Lambda in DTT (dependent type theory)
namespace LetVersusLam
inductive Matrix : Nat → Nat → Type where
| id : (n : Nat) → Matrix n n

def f (n : Nat) : Matrix n n :=
  let m := n
  let out : Matrix m n := Matrix.id n -- n : Nat, m : Nat, m = n |- Matrix.id n is well-typed
  out

def f' (n : Nat) : Matrix n n :=
  (fun m =>
    -- n : Nat, m : Nat |- Matrix.id n is well typed
    let out : Matrix m n := Matrix.id n
    out) n
end LetVersusLam
-/

#eval show String from toString (`Nat.Abs)

@[simp_denote]
def llvmArgsFromHybrid_nil_eq :
  (llvmArgsFromHybrid HVector.nil) = HVector.nil := rfl

def llvmArgsFromHybrid_cons_eq.lemma {ty  : LLVM.Ty} {tys : List LLVM.Ty}
    (x : TyDenote.toType (LLVMRiscV.Ty.llvm ty))
    (xs : HVector TyDenote.toType (tys.map LLVMRiscV.Ty.llvm)) :
  (llvmArgsFromHybrid (tys := ty :: tys) (HVector.cons x xs)) =
  HVector.cons (f := TyDenote.toType) (a := ty) (as := tys) x (llvmArgsFromHybrid xs)
   := rfl


open Lean Meta Elab in
/-- Extract out the raw LLVM type from the. -/
def extractLLVMTy (x : Expr) : SimpM Expr := do
  let_expr Ty.llvm xRealTy := (← reduce x)
    | throwError m! "expected type of {x} to be `Ty.llvm _`, but got {x}"
  return xRealTy

open Lean Meta Elab in
simproc [simp_denote] llvmArgsFromHybrid_cons_eq (llvmArgsFromHybrid _) := fun e => do
  let_expr llvmArgsFromHybrid _ lhs := e
    | throwError m!"unable to find llvmArgsFromHybrid in {e}"
  let_expr HVector.cons _α _f as a x xs := lhs
    | throwError m!"unable to find HVector.cons in {lhs}"
  let xRealTy ← extractLLVMTy a
  let some (_, xsRealTys) := Expr.listLit? (← reduce as)
    | return .continue
  let xsRealTys ←  xsRealTys.mapM extractLLVMTy

  logInfo m!"found (llvmArgsFromHybrid (HVector.cons ({x} : {xRealTy}) ({xs} : {xsRealTys})"
  let llvmTypeType := mkApp (mkConst ``Dialect.Ty []) (mkConst ``InstCombine.LLVM [])
  let xsRealTys ← listExprToExprShallow (.some llvmTypeType) xsRealTys

  logInfo m!"calling {``llvmArgsFromHybrid_cons_eq.lemma} with {xRealTy}, {xsRealTys}, {x}, {xs}"
  logInfo m!"XXXX"
  let proof := mkAppN (mkConst ``llvmArgsFromHybrid_cons_eq.lemma []) #[xRealTy, xsRealTys, x, xs]
  logInfo m!"YYYY"
  logInfo m!"built proof {proof}"
  let proof ← reduce proof
  logInfo m!"reduced proof to {proof}"
  let eq ← reduce (← inferType proof)
  logInfo m!"reduced type of proof (i.e. the equality) to {eq}"
  let .some (_ty, _lhs, rhs) := eq.eq?
    | throwError "unable to reduce application of 'llvmArgsFromHybrid_cons_eq.lemma' to an equality, only reduced to '{eq}'."
  logInfo m!"final right-hand-side of equality is: {rhs}"
  return .visit {
    expr := rhs,
    proof? := .some proof
  }

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

@[simp_denote]
theorem valuation_var_snoc_eq.lemma {Ty : Type} [TyDenote Ty] {Γ : Ctxt Ty} {t t' : Ty} {s : Γ.Valuation} {x : TyDenote.toType t} {v : Γ.Var t'} :
  (s.snoc x) (Ctxt.Var.toSnoc v) = s v := rfl

def and_llvm := [LV| {
    ^entry (%lhs: i64):
      %1 = llvm.and %lhs, %lhs : i64
      llvm.return %1 : i64
  }]
def and_riscv := [LV| {
    ^entry (%lhs: i64):
      %1 = llvm.and %lhs, %lhs : i64
      llvm.return %1 : i64
  }]
def llvm_and_lower_riscv1 : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64)] :=
  {lhs:= and_llvm , rhs:= and_riscv ,
   correct := by
    unfold and_llvm and_riscv
    simp_peephole
    simp [builtin.unrealized_conversion_cast.riscvToLLVM,  builtin.unrealized_conversion_cast.LLVMToriscv]
    simp [LLVM.and, RTYPE_pure64_RISCV_AND]
    rintro (_|foo) (_|bar)
    · simp
    · simp
    · simp
    · simp
      simp only [LLVM.and?, BitVec.Refinement.some_some]
      bv_decide
    }
