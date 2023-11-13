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
  | run (ty : Ty) : Op
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
    | .run t => ⟨[t], [([t], t)], t⟩
    | .iterate _k => ⟨[.int], [([.int], .int)], .int⟩

#check uncurry

/-- Convert a function `f` which is a single loop iteration into a function
  that iterates and updates the loop counter. -/
def loop_counter_decorator (f : ℕ → α → α) : ℕ × α → ℕ × α :=
  fun (i, v) => (i + 1, f i v)

/-- loop_counter_decorator on a constant function -/
@[simp]
theorem loop_counter_decorator_constant (count : ℕ) (vstart : α) :
  (loop_counter_decorator fun _i v => v) (count, vstart) = (count + 1, vstart) := rfl

/-- iterate the loop_counter_decorator of a constant function. -/
theorem loop_counter_decorator_constant_iterate {α : Type} (k : ℕ) :
  ((loop_counter_decorator (fun (i : ℕ) (v : α) => v))^[k]) = fun args => (args.fst + k, args.snd) := by {
    funext ⟨i, v⟩
    induction k generalizing i v
    case h.zero =>
      simp
    case h.succ n ihn =>
      simp[ihn]
      linarith
  }

def to_loop_run (f : ℕ → α → α) (niters : ℕ) (val : α) : α :=
  (loop_counter_decorator f (niters,val)).2

#check Prod.mk
@[reducible]
noncomputable instance : OpDenote Op Ty where
  denote
    | .const n, _, _ => BitVec.ofInt 32 n
    | .add, .cons (a : BitVec 32) (.cons (b : BitVec 32) .nil), _ => a + b
    | .if _t, (.cons (cond : Bool) (.cons v .nil)), (.cons (f : _ → _) (.cons (g : _ → _) .nil)) =>
      let body := if cond then f else g
      body (Ctxt.Valuation.nil.snoc v)
    | .run _t, (.cons v .nil), (.cons (f : _ → _) .nil) =>
        f (Ctxt.Valuation.nil.snoc v)
    | .for ty, (.cons niter (.cons vstart .nil)), (.cons (f : _  → _) .nil) =>
        let f' (i : ℕ) (v : ⟦ty⟧) : ⟦ty⟧ :=
          f ∘  (Function.uncurry Ctxt.Valuation.ofPair) <| (i, v)
        let to_iterate := loop_counter_decorator (α := ⟦ty⟧) f'
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

def run {Γ : Ctxt _} {t : Ty} (v : Var Γ t) (body : Com Op [t] t) : Expr Op Γ t :=
  Expr.mk
    (op := .run t)
    (ty_eq := rfl)
    (args := .cons v .nil)
    (regArgs := HVector.cons body <| HVector.nil)

def for_ {Γ : Ctxt _} {t : Ty} (niter : Var Γ .nat) (v : Var Γ t) (body : Com Op [.nat, t] t) : Expr Op Γ t :=
  Expr.mk
    (op := .for t)
    (ty_eq := rfl)
    (args := .cons niter <| .cons v .nil)
    (regArgs := HVector.cons body <| HVector.nil)

/-- 'if' condition of a true variable evaluates to the then region body. -/
theorem if_true {t : Ty} (cond : Var Γ .bool) (hcond : Γv cond = true) (v : Var Γ t) (then_ else_ : Com Op [t] t) :
  Expr.denote (ScfRegion.if_ (t := t) cond v then_ else_) Γv =
  Expr.denote (ScfRegion.run (t := t) v then_) Γv := by
    simp[Expr.denote, if_, run]
    simp_peephole[hcond] at Γv
    simp[ite_true]

/-- 'if' condition of a false variable evaluates to the else region body. -/
theorem if_false {t : Ty} (cond : Var Γ .bool) (hcond : Γv cond = false) (v : Var Γ t) (then_ else_ : Com Op [t] t) :
  Expr.denote (ScfRegion.if_ (t := t) cond v then_ else_) Γv =
  Expr.denote (ScfRegion.run (t := t) v else_) Γv := by
    simp[Expr.denote, if_, run]
    simp_peephole[hcond] at Γv
    simp[ite_true]


/-- a region that returns the value immediately -/
abbrev RegionRet [Goedel Ty] (t : Ty) {Γ : Ctxt Ty} (v : Var Γ t) : Com Op Γ t := .ret v

/-- a for loop whose body immediately returns the loop variable is the same as
  just fetching the loop variable. -/
theorem for_return {t : Ty} (niters : Var Γ .nat) (v : Var Γ t) :
  Expr.denote (ScfRegion.for_ (t := t) niters v (RegionRet t ⟨1, by simp⟩)) Γv = Γv v := by
    simp[Expr.denote, run, for_]
    simp_peephole at Γv
    simp[Com.denote]
    rw[loop_counter_decorator_constant_iterate]

/-- Two adjacent for loops with the same loop body can be fused into a single for loop. -/
theorem for_fuse {t : Ty} (niters : Var Γ .nat) (v : Var Γ t) :
  Expr.denote (ScfRegion.for_ (t := t) niters v rgn) Γv = Γv v := by
    simp[Expr.denote, run, for_]
    simp_peephole at Γv
    sorry

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
