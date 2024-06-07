/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework
import SSA.Core.Tactic

/-
# Examples
This file contains a few very simple example dialects and rewrites, to showcase the framework
-/

open Ctxt (Var VarSet Valuation)
open TyDenote (toType)

namespace Examples

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
  deriving DecidableEq, Repr

instance : DialectSignature ExOp ExTy where
  signature
    | .add    => ⟨[.nat, .nat], [], .nat, .pure⟩
    | .beq    => ⟨[.nat, .nat], [], .bool, .pure⟩
    | .cst _  => ⟨[], [], .nat, .pure⟩

@[reducible]
instance : DialectDenote ExOp ExTy where
  denote
    | .cst n, _, _ => n
    | .add, .cons (a : Nat) (.cons b .nil), _ => a + b
    | .beq, .cons (a : Nat) (.cons b .nil), _ => a == b

abbrev Expr (Γ) (ty) := _root_.Expr ExOp Γ .pure ty
abbrev Com (Γ) (ty) := _root_.Com ExOp Γ .pure ty

def cst {Γ : Ctxt _} (n : ℕ) : Expr Γ .nat  :=
  Expr.mk
    (op := .cst n)
    (ty_eq := rfl)
    (eff_le := EffectKind.le_refl _)
    (args := .nil)
    (regArgs := .nil)

def add {Γ : Ctxt _} (e₁ e₂ : Var Γ .nat) : Expr Γ .nat :=
  Expr.mk
    (op := .add)
    (ty_eq := rfl)
    (eff_le := EffectKind.le_refl _)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

attribute [local simp] Ctxt.snoc

def ex1 : Com ∅ .nat :=
  Com.var (cst 1) <|
  Com.var (add ⟨0, by simp [Ctxt.snoc]⟩ ⟨0, by simp [Ctxt.snoc]⟩ ) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def ex2 : Com ∅ .nat :=
  Com.var (cst 1) <|
  Com.var (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  Com.var (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  Com.var (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
  Com.var (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
  Com.ret ⟨0, by simp⟩

-- a + b => b + a
def m : Com (.ofList [.nat, .nat]) .nat :=
  .var (add ⟨0, by simp⟩ ⟨1, by simp⟩) (.ret ⟨0, by simp⟩)
def r : Com (.ofList [.nat, .nat]) .nat :=
  .var (add ⟨1, by simp⟩ ⟨0, by simp⟩) (.ret ⟨0, by simp⟩)

open Ctxt (Var Valuation DerivedCtxt) in
def p1 : PeepholeRewrite ExOp [.nat, .nat] .nat :=
  { lhs := m, rhs := r, correct :=
    by
      rw [m, r]
      funext Γv
      simp_peephole [add, cst] at Γv
      intros a b
      rw [Nat.add_comm]
    }

example : rewritePeepholeAt p1 1 ex1 = (
  Com.var (cst 1)  <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩)  <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩)  <|
     .ret ⟨0, by simp⟩) := by rfl

-- a + b => b + a
example : rewritePeepholeAt p1 0 ex1 = ex1 := by rfl

example : rewritePeepholeAt p1 1 ex2 = (
  Com.var (cst 1)   <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .var (add ⟨2, by simp⟩ ⟨0, by simp⟩) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩ ) <|
     .ret ⟨0, by simp⟩) := by rfl

example : rewritePeepholeAt p1 2 ex2 = (
  Com.var (cst 1)   <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
     .var (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
     .var (add ⟨1, by simp⟩ ⟨2, by simp⟩) <|
     .var (add ⟨2, by simp⟩ ⟨2, by simp⟩) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .ret ⟨0, by simp⟩) := by rfl

example : rewritePeepholeAt p1 3 ex2 = (
  Com.var (cst 1)   <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .var (add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .var (add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p1 4 ex2 = (
  Com.var (cst 1)   <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .var (add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

def ex2' : Com ∅ .nat :=
  Com.var (cst 1) <|
  Com.var (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
  Com.var (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
  Com.var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
  Com.var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
  Com.ret ⟨0, by simp⟩

-- a + b => b + (0 + a)
def r2 : Com (.ofList [.nat, .nat]) .nat :=
  .var (cst 0) <|
  .var (add ⟨0, by simp⟩ ⟨1, by simp⟩) <|
  .var (add ⟨3, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩

def p2 : PeepholeRewrite ExOp [.nat, .nat] .nat:=
  { lhs := m, rhs := r2, correct :=
    by
      rw [m, r2]
      funext Γv
      simp_peephole [add, cst] at Γv
      intros a b
      rw [Nat.zero_add]
      rw [Nat.add_comm]
    }

example : rewritePeepholeAt p2 1 ex2' = (
     .var (cst 1) <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (cst 0) <|
     .var (add ⟨0, by simp⟩ ⟨2, by simp⟩  ) <|
     .var (add ⟨3, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 2 ex2 = (
  Com.var (cst  1) <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (cst  0) <|
     .var (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .var (add ⟨3, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 3 ex2 = (
  Com.var (cst  1) <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .var (cst  0) <|
     .var (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .var (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 4 ex2 = (
  Com.var (cst  1) <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .var (cst  0) <|
     .var (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .var (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

-- a + b => (0 + a) + b
def r3 : Com (.ofList [.nat, .nat]) .nat :=
  .var (cst 0) <|
  .var (add ⟨0, by simp⟩ ⟨1, by simp⟩) <|
  .var (add ⟨0, by simp⟩ ⟨3, by simp⟩) <|
  .ret ⟨0, by simp⟩

def p3 : PeepholeRewrite ExOp [.nat, .nat] .nat:=
  { lhs := m, rhs := r3, correct :=
    by
      rw [m, r3]
      funext Γv
      simp_peephole [add, cst] at Γv
      intros a b
      rw [Nat.zero_add]
    }

example : rewritePeepholeAt p3 1 ex2 = (
  Com.var (cst  1) <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (cst  0) <|
     .var (add ⟨0, by simp⟩ ⟨2, by simp⟩  ) <|
     .var (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .var (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 2 ex2 = (
  Com.var (cst  1) <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (cst  0) <|
     .var (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .var (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .var (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 3 ex2 = (
  Com.var (cst  1) <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .var (cst  0) <|
     .var (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .var (add ⟨0, by simp⟩ ⟨4, by simp⟩  ) <|
     .var (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 4 ex2 = (
  Com.var (cst  1) <|
     .var (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .var (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .var (cst  0) <|
     .var (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .var (add ⟨0, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

def ex3 : Com ∅ .nat :=
  .var (cst 1) <|
  .var (cst 0) <|
  .var (cst 2) <|
  .var (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .var (add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .var (add ⟨1, by simp⟩ ⟨0, by simp⟩) <| --here
  .var (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩

def p4 : PeepholeRewrite ExOp [.nat, .nat] .nat:=
  { lhs := r3, rhs := m, correct :=
    by
      rw [m, r3]
      funext Γv
      simp_peephole [add, cst] at Γv
      intros a b
      rw [Nat.zero_add]
    }

example : rewritePeepholeAt p4 5 ex3 = (
  .var (cst 1) <|
  .var (cst 0) <|
  .var (cst 2) <|
  .var (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .var (add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .var (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .var (add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .var (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩) := rfl

end Examples

namespace RegionExamples

/-- A very simple type universe. -/
inductive ExTy
  | nat
  deriving DecidableEq, Repr

@[reducible]
instance : TyDenote ExTy where
  toType
    | .nat => Nat

inductive ExOp :  Type
  | add : ExOp
  | runK : ℕ → ExOp
  deriving DecidableEq, Repr

instance : DialectSignature ExOp ExTy where
  signature
  | .add    => ⟨[.nat, .nat], [], .nat, .pure⟩
  | .runK _ => ⟨[.nat], [([.nat], .nat)], .nat, .pure⟩


@[reducible]
instance : DialectDenote ExOp ExTy where
  denote
    | .add, .cons (a : Nat) (.cons b .nil), _ => a + b
    | .runK (k : Nat), (.cons (v : Nat) .nil), (.cons rgn _nil) =>
      k.iterate (fun val => rgn (fun _ty _var => val)) v

abbrev Expr (Γ) (ty) := _root_.Expr ExOp Γ .pure ty
abbrev Com (Γ) (ty) := _root_.Com ExOp Γ .pure ty

def add {Γ : Ctxt _} (e₁ e₂ : Var Γ .nat) : Expr Γ .nat :=
  Expr.mk
    (op := .add)
    (ty_eq := rfl)
    (eff_le := EffectKind.pure_le _)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

def rgn {Γ : Ctxt _} (k : Nat) (input : Var Γ .nat) (body : Com [ExTy.nat] ExTy.nat) :
    Expr Γ .nat :=
  Expr.mk
    (op := .runK k)
    (ty_eq := rfl)
    (eff_le := EffectKind.pure_le _)
    (args := .cons input .nil)
    (regArgs := HVector.cons (body.castPureToEff _) HVector.nil)

attribute [local simp] Ctxt.snoc

/-- running `f(x) = x + x` 0 times is the identity. -/
def ex1_lhs : Com [.nat] .nat :=
  Com.var (rgn (k := 0) ⟨0, by simp[Ctxt.snoc]⟩ (
      Com.var (add ⟨0, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) -- fun x => (x + x)
      <| Com.ret ⟨0, by simp[Ctxt.snoc]⟩
  )) <|
  Com.ret ⟨0, by simp[Ctxt.snoc]⟩

def ex1_rhs : Com [.nat] .nat :=
  Com.ret ⟨0, by simp[Ctxt.snoc]⟩

def p1 : PeepholeRewrite ExOp [.nat] .nat:=
  { lhs := ex1_lhs, rhs := ex1_rhs, correct := by
      rw [ex1_lhs, ex1_rhs]
      funext Γv
      simp_peephole [add, rgn] at Γv
      simp
      done
  }

def p1_run : Com [.nat] .nat :=
  rewritePeepholeAt p1 0 ex1_lhs

/-
RegionExamples.ExOp.runK 0[[%0]]
return %1
-/
-- #eval p1_run

/-- running `f(x) = x + x` 1 times does return `x + x`. -/
def ex2_lhs : Com [.nat] .nat :=
  Com.var (rgn (k := 1) ⟨0, by simp[Ctxt.snoc]⟩ (
      Com.var (add ⟨0, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) -- fun x => (x + x)
      <| Com.ret ⟨0, by simp[Ctxt.snoc]⟩
  )) <|
  Com.ret ⟨0, by simp[Ctxt.snoc]⟩

def ex2_rhs : Com [.nat] .nat :=
    Com.var (add ⟨0, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) -- fun x => (x + x)
    <| Com.ret ⟨0, by simp[Ctxt.snoc]⟩

def p2 : PeepholeRewrite ExOp [.nat] .nat:=
  { lhs := ex2_lhs, rhs := ex2_rhs, correct := by
      rw [ex2_lhs, ex2_rhs]
      funext Γv
      simp_peephole [add, rgn] at Γv
      simp
      sorry
      /-
        This example is broken because we had to introduce `impure` Coms for the regions.
        We should fix the main framework so that pure expressions can have pure regions, then this
        example should be fixed as well.
      -/
  }

end RegionExamples
