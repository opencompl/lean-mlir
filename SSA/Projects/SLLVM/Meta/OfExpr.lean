/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Lean
import SSA.Core.Framework.Trace
import SSA.Projects.SLLVM.Dialect.Basic


-- TODO: upstream these LawfulBEq instances, maybe?
section ForLean

instance : LawfulBEq Lean.Name where
  eq_of_beq := by intro a b; induction a <;> cases b <;> simp_all
  rfl := by intro name; induction name <;> simp_all

instance : LawfulBEq Lean.FVarId where
  eq_of_beq := by
    intro ⟨x⟩ ⟨y⟩ (h : x == y)
    congr; exact eq_of_beq h
  rfl := @fun ⟨name⟩ => (LawfulBEq.rfl : name == name)

instance : LawfulBEq Lean.Literal where
  eq_of_beq := by
    rintro (x|x) (y|y) h
    <;> first
        | contradiction
        | congr 1; exact eq_of_beq h
  rfl := by rintro (x|x) <;> (show x == x; exact LawfulBEq.rfl)

deriving instance DecidableEq for Lean.Name
deriving instance DecidableEq for Lean.FVarId
deriving instance DecidableEq for Lean.Literal
deriving instance DecidableEq for Lean.MVarId
deriving instance DecidableEq for Lean.LevelMVarId
deriving instance DecidableEq for Lean.Level
deriving instance DecidableEq for Lean.BinderInfo
deriving instance DecidableEq for Substring
deriving instance DecidableEq for Lean.SourceInfo
deriving instance DecidableEq for Lean.Syntax.Preresolved

instance : LawfulBEq Substring := sorry
instance : LawfulBEq Lean.Syntax.Preresolved := sorry

namespace Lean.Syntax

#check SourceInfo

def structEq' : Syntax → Syntax → Bool
  | Syntax.missing, Syntax.missing => true
  | Syntax.node _ k args, Syntax.node _ k' args' =>
      k == k' && structEqAux args.toList args'.toList
  | Syntax.atom _ val, Syntax.atom _ val' => val == val'
  | Syntax.ident _ rawVal val preresolved, Syntax.ident _ rawVal' val' preresolved' =>
    rawVal == rawVal' && val == val' && preresolved == preresolved'
  | _, _ => false
where
  structEqAux : List Syntax → List Syntax → Bool
  | x::xs, y::ys => structEq' x y && structEqAux xs ys
  | [], [] => true
  | _, _ => false

open structEq' in
theorem structEq'_rfl {s : Syntax} : structEq' s s = true := by
  apply structEq'.induct
    (motive_1 := fun xs xs' => xs' = xs → structEq'.structEqAux xs xs = true)
    (motive_2 := fun x x' => x' = x → structEq' x x = true)
  · intro; rfl
  · simp_all [structEq']
  · simp [structEq']
  · simp [structEq']
  · rintro _ s h_missing h_node h_atom h_ident rfl
    apply False.elim
    cases s
    · apply h_missing; rfl; rfl
    · apply h_node; rfl; rfl
    · apply h_atom; rfl; rfl
    · apply h_ident; rfl; rfl
  · simp_all [structEqAux]
  · simp [structEqAux]
  · rintro _ xs h_cons h_nil rfl
    apply False.elim
    cases xs
    · apply h_nil; rfl; rfl
    · apply h_cons; rfl; rfl
  · rfl

open structEq' in
theorem eq_of_structEq' : structEq' s t → s = t := by
  stop
  apply structEq'.induct
    (motive_1 := fun xs xs' => structEqAux xs xs' → xs = xs')
    (motive_2 := fun x x' => structEq' x x' → x = x')
  · intro; rfl
  · stop
    simp only [Array.toList_inj, structEq', Bool.and_eq_true, beq_iff_eq, node.injEq, and_imp]
    rintro _ _ _ _ _ _ ih _ h
    simp_all

instance : DecidableEq Lean.Syntax := fun s t =>
  if h : structEq' s t then
    .isTrue <| eq_of_structEq' h
  else
    .isFalse <| by rintro rfl; apply h <| structEq'_rfl

end Lean.Syntax





deriving instance DecidableEq for Lean.DataValue

deriving instance DecidableEq for Lean.KVMap

deriving instance DecidableEq for Lean.Expr

end ForLean

namespace StructuredLLVM
open Lean (MetaM MessageData)

protected abbrev Meta.ExceptM := Except MessageData

def NatOrFVar.ofExpr (e : Lean.Expr) : Meta.ExceptM NatOrFVar :=
  if let some n := e.nat? then
    .ok <| .inl n
  else if let .fvar id := e then
    .ok <| .inr id
  else
    .error m!"Expected either Nat literal or free variable, found: {e}"


namespace Meta
open StructuredLLVM.Meta (ExceptM)

/--
Convert a normalized(!) Lean expression of type `SLLVM.Ty` into an object
of type `MetaSLLVM.Ty`.
-/
def tyOfExpr (e : Lean.Expr) : ExceptM MetaSLLVM.Ty :=
  open SLLVM.PreTy in
  match_expr e with
  | bitvec _ w => do .ok <| .bitvec (← NatOrFVar.ofExpr w)
  | ptr        => do .ok <| .ptr
  | unit       => do .ok <| .unit
  | _ => .error m!"Unrecognized SLLVM type: {e}"

/--
Convert a normalized(!) Lean expression of type `SLLVM.Op` into an object
of type `MetaSLLVM.Op`.
-/
def opOfExpr (e : Lean.Expr) : ExceptM MetaSLLVM.Op :=
  open SLLVM.PreOp in
  match_expr e with
  | bv_add _ w => do .ok <| .bv_add (← NatOrFVar.ofExpr w)
  | ptr_add    => do .ok <| .ptr_add
  | load _ ty  => do
      let ty ← tyOfExpr ty
      .ok <| .load ty
  | store _ ty => do
      let ty ← tyOfExpr ty
      .ok <| .store ty
  | _ => .error m!"Unrecognized SLLVM operation: {e}"

def ctxtOfExpr (e : Lean.Expr) : ExceptM <| Ctxt MetaSLLVM.Ty := do
  let some ⟨_, Γ⟩ := Lean.Expr.listLit? e
    | .error m!"Expected a normalized list literal, found:\n\t{e}"
  Γ.mapM tyOfExpr

open Lean.Expr (const) in
def varOfExpr (Γ : Ctxt MetaSLLVM.Ty) (ty : MetaSLLVM.Ty) (e : Lean.Expr) :
    ExceptM <| Γ.Var ty := do
  let i ← @id (ExceptM _) <| match_expr e with
    | Subtype.mk _α _p val _prop => .ok val
    | Ctxt.Var.mk _Ty _Γ _t val _prop => .ok val
    | _ =>
      .error m!"Expected an application of {const ``Subtype.mk [0]} or {const ``Ctxt.Var.mk []}, \
                found: \n\t{e}"
  let some i := Lean.Expr.nat? i
    | .error m!"Expected Nat literal, found: {i}"
  if h : Γ.get? i = ty then
    .ok ⟨i, h⟩
  else
    .error m!""

def effectOfExpr (eff : Lean.Expr) : ExceptM EffectKind := do
  let some eff := EffectKind.litExpr? eff
    | .error m!"Expected an {Lean.Expr.const ``EffectKind []} literal, found:\n\t{eff}"
  return eff

/--

-/
def argsOfExpr (Γ Δ : Ctxt MetaSLLVM.Ty) (e : Lean.Expr) : ExceptM <| HVector (Γ.Var) Δ :=
  match Δ with
  | [] =>
    if !e.isAppOf ``HVector.nil then
      .error m!"Expected application of {Lean.Expr.const ``HVector.nil []}, found: {e}"
    else
      .ok .nil
  | t :: Δ => do
    let (fn, args) := e.getAppFnArgs
    if fn != ``HVector.cons then
      .error m!"Expected application of {Lean.Expr.const ``HVector.cons []}, found: {e}"
    else
      let x ← varOfExpr Γ t args[4]!
      let xs ← argsOfExpr Γ Δ args[5]!
      .ok <| x ::ₕ xs

/--
Convert a normalized(!) Lean expression of type `Expr SLLVM ..` into an object
of type `Expr MetaSLLVM ..`.
-/
def exprOfExpr (Γ) (eff) (ty) (e : Lean.Expr) : ExceptM (Expr MetaSLLVM Γ eff ty) := do
  let_expr Expr.mk _d _sig _eff _Γ _ty op _ty_eq _eff_le args _regArgs := e
    | .error m!"Expected an application of {Lean.Expr.const ``Expr.mk []}, found:\n\t{e}"
  let op ← opOfExpr op
  let args ← argsOfExpr Γ (DialectSignature.sig op) args

  if eff_le : ¬DialectSignature.effectKind op ≤ eff then
    .error m!"Failed to verify that operation `repr op` has effect `{eff}`;
              The signature decalres effect `{DialectSignature.effectKind op}`.
              This could indicate a malformed expression."
  else if ty_eq : ty ≠ DialectSignature.outTy op then
    .error m!"Failed to verify that operation `repr op` has return type `{repr ty}`;
              The signature decalres return type `{repr <| DialectSignature.outTy op}`.
              This could indicate a malformed expression."
  else
    have eff_le : _ ≤ _ := by simpa only [Decidable.not_not] using eff_le
    have ty_eq := by simpa using ty_eq

    let regArgs :=
      have : DialectSignature.regSig op = [] := by
        cases op <;> rfl
      this ▸ .nil
    return ⟨op, ty_eq, eff_le, args, regArgs⟩

partial def comOfExpr (e : Lean.Expr) : ExceptM (Σ Γ eff ty, Com MetaSLLVM Γ eff ty) :=
  match_expr e with
  | Com.ret _d _sig Γ ty eff v => do
      let Γ ← ctxtOfExpr Γ
      let eff ← effectOfExpr eff
      let ty ← tyOfExpr ty
      let v ← varOfExpr Γ ty v
      .ok ⟨Γ, eff, ty, Com.ret v⟩
  | Com.var _d _sig _Γ _eff _α _β e body => do
      let ⟨Δ, eff, β, body'⟩ ← comOfExpr body
      match Δ with
      | [] => .error m!"Malformed program! Body is expected to have at least one free variable, \
                        but found an empty context for:\n\t{body}"
      | α :: Γ  =>
        let e ← exprOfExpr Γ eff α e
        .ok ⟨Γ, eff, β, Com.var e body'⟩
  | _ => .error m!"Expected an application of Com.var or Com.ret, found:\n\t{e}"

instance : MonadLift Meta.ExceptM MetaM where
  monadLift := fun
    | .error e  => throwError e
    | .ok v     => return v
