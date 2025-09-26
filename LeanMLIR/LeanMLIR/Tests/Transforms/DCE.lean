
import LeanMLIR.Transforms.DCE

/-! ## Tests for the Dead Code Elimination (DCE) pass -/

namespace LeanMLIR.Tests.DCE
open _root_.DCE

/-- info: 'DCE.dce' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms dce

/-- A very simple type universe. -/
inductive ExTy
  | nat
  | bool
  deriving DecidableEq, Repr

@[reducible]
instance : TyDenote ExTy where
  toType
    | .nat => Nat
    | .bool => Bool

inductive ExOp :  Type
  | add : ExOp
  | beq : ExOp
  | cst : ℕ → ExOp
  deriving DecidableEq

abbrev Ex : Dialect where
  Op := ExOp
  Ty := ExTy

instance : DialectSignature Ex where
  signature
    | .add    => ⟨[.nat, .nat], [], [.nat], .pure⟩
    | .beq    => ⟨[.nat, .nat], [], [.bool], .pure⟩
    | .cst _  => ⟨[], [], [.nat], .pure⟩

@[reducible]
instance : DialectDenote Ex where
  denote
    | .cst n, _, _ => n ::ₕ .nil
    | .add, (a : Nat) ::ₕ b ::ₕ .nil, _ => a + b    ::ₕ .nil
    | .beq, (a : Nat) ::ₕ b ::ₕ .nil, _ => (a == b) ::ₕ .nil

def cst {Γ : Ctxt _} (n : ℕ) : Expr Ex Γ .pure [.nat] :=
  Expr.mk
    (op := .cst n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .nil)
    (regArgs := .nil)

def add {Γ : Ctxt _} (e₁ e₂ : Ctxt.Var Γ .nat) : Expr Ex Γ .pure [.nat] :=
  Expr.mk
    (op := .add)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

attribute [local simp] Ctxt.cons

def ex1_pre_dce : Com Ex ∅ .pure [.nat] :=
  Com.var (cst 1) <|
  Com.var (cst 2) <|
  Com.ret ⟨0, rfl⟩

def ex1_post_dce : Com Ex ∅ .pure [.nat] := (dce' ex1_pre_dce).val

def ex1_post_dce_expected : Com Ex ∅ .pure [.nat] :=
  Com.var (cst 2) <|
  Com.ret ⟨0, rfl⟩

theorem checkDCEasExpected :
  ex1_post_dce = ex1_post_dce_expected := by native_decide
