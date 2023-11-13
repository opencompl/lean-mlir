import Mathlib.Logic.Function.Iterate
import SSA.Core.Framework
import SSA.Core.Util

set_option pp.proofs false
set_option pp.proofs.withType false

open Std (BitVec)
open Ctxt(Var)

namespace ScfRegion

inductive Ty
  | int
  | bool
  | nat
  deriving DecidableEq, Repr

@[reducible]
instance : Goedel Ty where
  toType
    | .int => BitVec 32
    | .bool => Bool
    | .nat => Nat

inductive Op :  Type
  | add : Op
  | const : (val : ℤ) → Op
  | iterate (k : ℕ) : Op
  | if (ty : Ty) : Op
  | for (ty : Ty) : Op
  deriving DecidableEq, Repr

@[reducible]
instance : OpSignature Op Ty where
  signature
    | .const _ => ⟨[], [], .int⟩
    | .if t => ⟨[.bool, t], [([t], t), ([t], t)], t⟩
    | .for t => ⟨[.nat, t], [([.nat, t], t)], t⟩
    | .add   => ⟨[.int, .int], [], .int⟩
    | .iterate _k => ⟨[.int], [([.int], .int)], .int⟩

/-- Convert a function `f` which is a single loop iteration into a function
  that iterates and updates the loop counter. -/
def to_loop_iterate (f : ℕ → α → α) : ℕ × α → ℕ × α :=
  fun (i, v) => (i + 1, f i v)

@[reducible]
noncomputable instance : OpDenote Op Ty where
  denote
    | .const n, _, _ => BitVec.ofInt 32 n
    | .add, .cons (a : BitVec 32) (.cons (b : BitVec 32) .nil), _ => a + b
    | .if _t, (.cons (cond : Bool) (.cons v .nil)), (.cons (f : _ → _) (.cons (g : _ → _) .nil)) =>
      let body := if cond then f else g
      body (Ctxt.Valuation.nil.snoc v)
    | .for _t, (.cons (niter : Nat) (.cons vstart .nil)), (.cons (f : _  → _) .nil) =>
        let f' (i : ℕ) (v : Goedel.toType _t) : Goedel.toType _t := f <| by {
            dsimp
            apply Ctxt.Valuation.snoc
            apply Ctxt.Valuation.snoc
            apply Ctxt.Valuation.nil
            exact v
            exact i
          }
        let to_iterate := to_loop_iterate (α := ⟦_t⟧) f'
        let loop_fn := niter.iterate (op := to_iterate)
        (loop_fn (0, vstart)).2

    | .iterate k, (.cons (x : BitVec 32) .nil), (.cons (f : _ → BitVec 32) .nil) =>
      let f' (v :  BitVec 32) : BitVec 32 := f  (Ctxt.Valuation.nil.snoc v)
      k.iterate f' x
      -- let f_k := Nat.iterate f' k
      -- f_k x

def cst {Γ : Ctxt _} (n : ℤ) : Expr Op Γ .int  :=
  Expr.mk
    (op := .const n)
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)

def add {Γ : Ctxt _} (e₁ e₂ : Var Γ .int) : Expr Op Γ .int :=
  Expr.mk
    (op := .add)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

def iterate {Γ : Ctxt _} (k : Nat) (input : Var Γ Ty.int) (body : Com Op [.int] .int) : Expr Op Γ .int :=
  Expr.mk
    (op := .iterate k)
    (ty_eq := rfl)
    (args := .cons input .nil)
    (regArgs := HVector.cons body HVector.nil)

def if_ {Γ : Ctxt _} {t : Ty} (cond : Var Γ .bool) (v : Var Γ t) (then_ else_ : Com Op [t] t) : Expr Op Γ t :=
  Expr.mk
    (op := .if t)
    (ty_eq := rfl)
    (args := .cons cond <| .cons v .nil)
    (regArgs := HVector.cons then_ <| HVector.cons else_ <| HVector.nil)

def for_ {Γ : Ctxt _} {t : Ty} (niter : Var Γ .nat) (v : Var Γ t) (body : Com Op [.nat, t] t) : Expr Op Γ t :=
  Expr.mk
    (op := .for t)
    (ty_eq := rfl)
    (args := .cons niter <| .cons v .nil)
    (regArgs := HVector.cons body <| HVector.nil)

attribute [local simp] Ctxt.snoc

/-- running `f(x) = x + x` 0 times is the identity. -/
def lhs : Com Op [.int] .int :=
  Com.lete (iterate (k := 0) ⟨0, by simp[Ctxt.snoc]⟩ (
      Com.lete (add ⟨0, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) -- fun x => (x + x)
      <| Com.ret ⟨0, by simp[Ctxt.snoc]⟩
  )) <|
  Com.ret ⟨0, by simp[Ctxt.snoc]⟩

def rhs : Com Op [.int] .int :=
  Com.ret ⟨0, by simp[Ctxt.snoc]⟩

attribute [local simp] Ctxt.snoc

set_option pp.proofs false in
set_option pp.proofs.withType false in
noncomputable def p1 : PeepholeRewrite Op [.int] .int:=
  { lhs := lhs, rhs := rhs, correct := by
      rw [lhs, rhs]
      funext Γv
      /-
      Com.denote
        (Com.lete
          (iterate 0 { val := 0, property := lhs.proof_1 }
            (Com.lete (add { val := 0, property := lhs.proof_1 } { val := 0, property := lhs.proof_1 })
              (Com.ret { val := 0, property := lhs.proof_2 })))
          (Com.ret { val := 0, property := lhs.proof_2 }))
        Γv =
      Com.denote (Com.ret { val := 0, property := rhs.proof_1 }) Γv
      -/
      simp_peephole [add, iterate] at Γv
      /-  ∀ (a : BitVec 32), (fun v => v + v)^[0] a = a -/
      simp [Function.iterate_zero]
      done
  }

end ScfRegion
