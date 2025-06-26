/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Logic.Function.Iterate
import Mathlib.Tactic.Linarith
import SSA.Core.Framework
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.Util

open Ctxt(Var)

namespace ScfFunctor

open TyDenote

/-- Describes that the dialect Op' has a type whose denotation is 'DenotedTy -/
class HasTy (d : Dialect) (DenotedTy : Type) [TyDenote d.Ty] [DialectSignature d] where
    ty : d.Ty
    denote_eq : toType ty = DenotedTy := by rfl

abbrev HasBool (d : Dialect) [TyDenote d.Ty] [DialectSignature d] : Type := HasTy d Bool
abbrev HasInt (d : Dialect) [TyDenote d.Ty] [DialectSignature d] : Type := HasTy d Int
abbrev HasNat (d : Dialect) [TyDenote d.Ty] [DialectSignature d] : Type := HasTy d Nat


/-- only flow operations, parametric over arithmetic from another dialect Op'  -/
inductive Scf.Op (Op' Ty' : Type) (m') [TyDenote Ty'] [DialectSignature ⟨Op', Ty', m'⟩]
    [DialectDenote ⟨Op', Ty', m'⟩] : Type _
  | coe (o : Op')
  | iterate (k : ℕ) -- fˆk
  | run (inputty : Ty')  -- f^k
  | if (inputty retty' : Ty')  -- if cond then true_body else false_body
  | for (ty : Ty')
  deriving DecidableEq, Repr

-- TODO: this probably doesn't need `DialectDenote`
def Scf (d : Dialect) [TyDenote d.Ty] [DialectSignature d] [DialectDenote d] : Dialect where
  Op := Scf.Op d.Op d.Ty d.m
  Ty := d.Ty
  m  := d.m

namespace Scf

section InheritedInstances
variable {d : Dialect} [TyDenote d.Ty] [DialectSignature d] [DialectDenote d]

instance [inst : Monad d.m] : Monad (Scf d).m := inst
instance [Monad d.m] [inst : LawfulMonad d.m] : LawfulMonad (Scf d).m := inst

instance : TyDenote (Scf d).Ty := inferInstanceAs (TyDenote d.Ty)

instance [DecidableEq d.Op] [DecidableEq d.Ty] : DecidableEq (Scf d).Op :=
  inferInstanceAs (DecidableEq <| Scf.Op ..)

-- Assert that a `DecidableEq (Scf d).Ty` instance already exists
example [DecidableEq d.Ty] : DecidableEq (Scf d).Ty := inferInstance

end InheritedInstances

instance {d : Dialect} [TyDenote d.Ty] [DialectSignature d] [DialectDenote d] :
    Coe d.Op (Scf d).Op where
  coe o := .coe o

@[reducible]
instance [TyDenote d.Ty] [DialectSignature d] [DialectDenote d]
    [B : HasBool d] [N : HasNat d] [I : HasInt d] : DialectSignature (Scf d) where
   signature
   | .coe o => signature (d:=d) o
    | .if t t' => ⟨[B.ty, t], [([t], t'), ([t], t')], t', .impure⟩
      --    /----------------------------------------------^^^^^^
      --    | Morally, an `if` should be pure, so long as its regions are pure, and impure otherwise
      --    | However, with the current setup,
      --    | only impure operations are able to access their regions,
      --    | thus we make `if` (together with the other SCF operations) unconditionally impure
    | .for t => ⟨[/-start-/I.ty, /-step-/I.ty, /-niters-/N.ty, t], [([I.ty, t], t)], t, .impure⟩
    | .run t => ⟨[t], [([t], t)], t, .impure⟩
    | .iterate _k => ⟨[I.ty], [([I.ty], I.ty)], I.ty, .impure⟩


/-- A loop body receives the current value of the loop induction variable, and
the current loop carried value.  The loop body produces the value of this loop
iteration.

Consider the loop: `for(int i = 0; i >= -10; i -= 2)`. In this case, the value
`i` will be the sequence of values `[0, -2, -4, -6, -8, -10]`. The value `i` is
the loop induction variable.

This value is distinct from the *trip count*, which is the number of times the
loop body has been executed so far, which is `[0, 1, 2, 3, 4]`.

The `LoopBody` does *not* provide access to the trip count, only to the loop induction variable.
-/
abbrev LoopBody (t : Type) : Type := Int → t → t

namespace LoopBody

/-- Convert a function `f` which is a single loop iteration into a function
  that iterates and updates the loop counter. -/
def counterDecorator (δ : Int) (f : LoopBody α) : Int × α → Int × α :=
  fun (i, v) => (i + δ, f i v)


/-- A loop body is invariant if it does not depend on the index. -/
def IndexInvariant (f : LoopBody t) : Prop :=
  ∀ (i j : Int) (v : t), f i v = f j v

/-- Evaluating a loop index invariant function is the same as evaluating it at 0 -/
theorem eval (f : LoopBody t) (hf : LoopBody.IndexInvariant f) (i : Int) (v : t) :
  f i v = f 0 v := by unfold LoopBody.IndexInvariant at hf; rw [hf]

/-- Loop invariant functions can be simulated by a simpler function -/
def atZero (f : LoopBody t) : t → t := fun v => f 0 v

/-- If there exists a function `g : t → t` which agrees with `f`, then `f` is
loop index invariant. -/
theorem eq_invariant_fn
    (f : LoopBody t) (g : t → t) (hf : ∀ (i : Int) (v : t), f i v = g v) :
    LoopBody.IndexInvariant f ∧ atZero f = g:= by
  apply And.intro
  case left =>
    intros i j v
    rw [hf i v, hf j v]
  case right =>
    unfold atZero
    funext v
    rw [hf 0 v]

end LoopBody

namespace LoopBody.IndexInvariant

/-- Evaluating a loop index invariant function is the same as evaluating it at `atZero` -/
@[simp]
theorem eval' {f : LoopBody t} (hf : LoopBody.IndexInvariant f) (i : Int) (v : t) :
    f i v = f.atZero v := by
  unfold LoopBody.IndexInvariant at hf; rw [LoopBody.atZero, hf]

/-- iterating a loop invariant function gives a well understood answer: the
iterates of the function. -/
@[simp]
theorem iterate {f : LoopBody t}
    (hf : LoopBody.IndexInvariant f)
    (δ : Int)
    (i₀ : Int)
    (v₀ : t) (k : ℕ) :
    (f.counterDecorator δ)^[k] (i₀, v₀) = (i₀ + δ * k, (f.atZero)^[k] v₀) := by
  induction k generalizing i₀ v₀
  case zero => simp
  case succ i hi =>
    simp only [Function.iterate_succ, Function.comp_apply, Nat.cast_add, Nat.cast_one]
    rw [hi]
    simp only [counterDecorator, eval' hf, Prod.mk.injEq, and_true]
    linarith

/-- the first component of iterating a loop invariant function -/
@[simp]
theorem iterate_fst {f : LoopBody t}
    (δ : Int) (hf : f.IndexInvariant) (i₀ : Int) (v₀ : t) (k : ℕ) :
    ((f.counterDecorator δ)^[k] (i₀, v₀)).1 = i₀ + δ * k := by
  simp [hf];

/-- the second component of iterating a loop invariant function -/
@[simp]
theorem iterate_snd {f : LoopBody t}
    (δ : Int) (hf : f.IndexInvariant) (i₀ : Int) (v₀ : t) (k : ℕ) :
    ((f.counterDecorator δ)^[k] (i₀, v₀)).2 = (f.atZero)^[k] v₀ := by
  simp [hf]

end LoopBody.IndexInvariant

namespace LoopBody.counterDecorator
/-- iterated value of the fst of the tuple of counterDecorator (ie, the loop counter) -/
@[simp]
theorem iterate_fst_val (δ: Int) (f : LoopBody α) (i₀ : Int) (v₀ : α) (k : ℕ) :
    ((f.counterDecorator δ)^[k] (i₀, v₀)).1 = i₀ + k * δ := by
  induction k generalizing i₀ v₀
  case zero => simp
  case succ i hi =>
    simp only [Function.iterate_succ, Function.comp_apply, Nat.cast_add, Nat.cast_one,
      hi, counterDecorator]
    linarith

/-- evaluating a function that does not access the index (const_index_fn) -/
theorem const_index_fn_eval
    (δ : Int) (i : Int) (vstart : α) (f : LoopBody α) (f' : α → α) (hf : f = fun _ a => f' a) :
    (f.counterDecorator δ) (i, vstart) = (i + δ, f' vstart) := by
  simp [counterDecorator, hf]


/-- iterating a function that does not access the index (const_index_fn) -/
theorem const_index_fn_iterate (δ : Int)
    (i : Int) (vstart : α) (f : LoopBody α) (f' : α → α) (hf : f = fun _ a => f' a) (k : ℕ) :
    (f.counterDecorator δ)^[k] (i, vstart) = (i + k * δ, f'^[k] vstart) := by
  obtain ⟨hf, hf'⟩ := f.eq_invariant_fn f' (by intros i v; rw [hf])
  rw [IndexInvariant.iterate hf]; simp
  apply And.intro
  · linarith
  · rw [hf']

/-- counterDecorator on a constant function -/
@[simp]
theorem constant (δ : Int) (i : Int) (vstart : α) :
    (counterDecorator δ fun _i v => v) (i, vstart) = (i + δ, vstart) := rfl

/-- iterate the counterDecorator of a constant function. -/
theorem constant_iterate {α : Type} (k : ℕ) (δ : Int) :
    ((counterDecorator δ (fun (_ : Int) (v : α) => v))^[k]) =
    fun (args : ℤ × α) => (args.fst + k * δ, args.snd) := by
  funext ⟨i, v⟩
  induction k generalizing i v
  case h.zero =>
    simp
  case h.succ n ihn =>
    simp only [Function.iterate_succ, Function.comp_apply, constant, ihn, Nat.cast_add,
      Nat.cast_one, Prod.mk.injEq, and_true]
    linarith

def to_loop_run (δ : Int) (f : LoopBody α) (niters : ℕ) (val : α) : α :=
  (counterDecorator δ f (niters,val)).2

end LoopBody.counterDecorator

variable [TyDenote d.Ty] [DialectSignature d] [DialectDenote d]
  [B : HasBool d] [N : HasNat d] [Z : HasInt d]

open Ctxt (Valuation) in
@[reducible]
instance [Monad d.m] : DialectDenote (Scf d) where
  denote
    | .coe o', args', regArgs' =>
        let denote' := DialectDenote.denote o'
        by
         exact denote' args' regArgs'
    | .if t t', (.cons (cond ) (.cons v .nil)),
         (.cons (f : Ctxt.Valuation [t] → d.m ⟦t'⟧) (.cons (g : _ → _) .nil)) =>
         let body := if B.denote_eq ▸ cond then f else g
      body (Ctxt.Valuation.nil.snoc v)
    | .run _t, (.cons v .nil), (.cons (f : _ → _) .nil) =>
        f (Ctxt.Valuation.nil.snoc v)
    | .for ty, (.cons istart (.cons istep (.cons niter (.cons vstart .nil)))),
        (.cons (f : _  → _) .nil) =>
        let istart : ℤ := Z.denote_eq ▸ istart
        let istep : ℤ := Z.denote_eq ▸ istep
        let niter : ℕ := N.denote_eq ▸ niter
        let f' : LoopBody (d.m ⟦ty⟧) := fun i v => do
          let v ← v
          let i := Z.denote_eq.symm ▸ i
          f (Valuation.ofPair i v)
        let to_iterate := f'.counterDecorator (α := d.m ⟦ty⟧) (δ := istep)
        let loop_fn := niter.iterate (op := to_iterate)
        (loop_fn (istart, pure vstart)).2

    | .iterate k, (.cons (x) .nil), (.cons (f : _ → _) .nil) =>
      let x : ℤ := Z.denote_eq ▸ x
      let coe : ℤ = toType Z.ty := Z.denote_eq.symm
      let f' (v : d.m ℤ) : d.m ℤ := do
        let v ← v
        coe ▸ f (Ctxt.Valuation.nil.snoc (cast coe v))
      Z.denote_eq ▸ (k.iterate f' (pure x))
end Scf

namespace Arith

inductive Ty
| int
| bool
| nat
 deriving DecidableEq, Repr

instance : TyDenote Ty where
  toType
    | .int => ℤ
    | .bool => Bool
    | .nat => Nat

inductive Op
  | add : Op /-- a + b-/
  | add_nat : Op /- a + b on nats-/
  | axpy : Op /- a * x + y -/
  | neg : Op /- -a -/
  | const : (val : ℤ) → Op
  | const_nat : (val : ℕ) → Op

set_option linter.dupNamespace false in
abbrev Arith : Dialect := {Op, Ty}

@[reducible]
instance : DialectSignature Arith where
  signature
    | .axpy => ⟨[.int, .nat, .int], [], .int, .pure⟩
    | .neg => ⟨[.int], [], .int, .pure⟩
    | .const _ => ⟨[], [], .int, .pure⟩
    | .const_nat _ => ⟨[], [], .nat, .pure⟩
    | .add   => ⟨[.int, .int], [], .int, .pure⟩
    | .add_nat   => ⟨[.nat, .nat], [], .nat, .pure⟩


@[reducible]
instance : DialectDenote Arith where
  denote
    | .const n, _, _ => n
    | .const_nat n, _, _ => n
    | .neg, .cons (a : ℤ ) .nil, _ => -a
    | .axpy, .cons (a : ℤ) (.cons (x : ℕ) (.cons (b : ℤ) .nil)), _ => a * (x : ℤ) + b
    | .add, .cons (a : ℤ) (.cons (b : ℤ) .nil), _ => a + b
    | .add_nat, .cons (a : ℕ) (.cons (b : ℕ) .nil), _ => a + b


instance : HasBool Arith where ty := .bool
instance : HasNat Arith where ty := .nat
instance : HasInt Arith where ty := .int

end Arith
export Arith (Arith)

/-- Compose Scf on top of Arith -/
abbrev ScfArith := Scf Arith

@[simp_denote] def cst (n : ℤ) : Expr ScfArith Γ .pure .int  :=
  Expr.mk
    (op := .coe <| .const n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .nil)
    (regArgs := .nil)

@[simp_denote] def cst_nat (n : ℕ) : Expr ScfArith Γ .pure .nat  :=
  Expr.mk
    (op := .coe <| .const_nat n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .nil)
    (regArgs := .nil)

@[simp_denote] def add {Γ : Ctxt _} (e₁ e₂ : Var Γ .int) : Expr ScfArith Γ .pure .int :=
  Expr.mk
    (op := .coe <| .add)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

@[simp_denote] def add_nat (e₁ e₂ : Var Γ .nat) : Expr ScfArith Γ .pure .nat :=
  Expr.mk
    (op := .coe <| .add_nat)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

@[simp_denote] def axpy {Γ : Ctxt _} (a : Var Γ .int) (x : Var Γ .nat) (b: Var Γ .int) :
    Expr ScfArith Γ .pure .int :=
  Expr.mk
    (op := .coe <| .axpy)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons x <| .cons b .nil)
    (regArgs := .nil)

@[simp_denote] def neg {Γ : Ctxt _} (a : Var Γ .int) : Expr ScfArith Γ .pure .int :=
  Expr.mk
    (op := .coe <| .neg)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

@[simp_denote] def iterate {Γ : Ctxt _} (k : Nat) (input : Var Γ Arith.Ty.int)
    (body : Com ScfArith [.int] .impure .int) : Expr ScfArith Γ .impure .int :=
  Expr.mk
    (op := .iterate k)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons input .nil)
    (regArgs := HVector.cons body HVector.nil)

@[simp_denote] def if_ {Γ : Ctxt _} {t t': Arith.Ty}
  (cond : Var Γ Arith.Ty.bool) (v : Var Γ t) (then_ else_ : Com ScfArith [t] .impure t') :
    Expr ScfArith Γ .impure t' :=
  Expr.mk
    (op := .if t t')
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons cond <| .cons v .nil)
    (regArgs := HVector.cons then_ <| HVector.cons else_ <| HVector.nil)

@[simp_denote]
def run {Γ : Ctxt _} {t : Arith.Ty} (v : Var Γ t) (body : Com ScfArith [t] .impure t) :
    Expr ScfArith Γ .impure t :=
  Expr.mk
    (op := .run t)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons v .nil)
    (regArgs := HVector.cons body <| HVector.nil)

@[simp_denote] def for_ {Γ : Ctxt Arith.Ty} {t : Arith.Ty}
    (start step : Var Γ Arith.Ty.int)
    (niter : Var Γ Arith.Ty.nat) (v : Var Γ t) (body : Com ScfArith [.int, t] .impure t) :
      Expr ScfArith Γ .impure t :=
  Expr.mk
    (op := .for t)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons start <| .cons step <| .cons niter <| .cons v .nil)
    (regArgs := HVector.cons body <| HVector.nil)


/-- 'if' condition of a true variable evaluates to the then region body. -/
theorem if_true' {t : Arith.Ty} (cond : Var Γ Arith.Ty.bool) (hcond : Γv cond = true) (v : Var Γ t)
    (then_ else_ : Com ScfArith [t] .impure t) :
    Expr.denote (if_ (t := t) cond v then_ else_) Γv
    = Expr.denote (run (t := t) v then_) Γv := by
-- TODO: make a `PeepholeRewrite` for `if_true`.
  simp_peephole
  simp [hcond]

/-- 'if' condition of a false variable evaluates to the else region body. -/
theorem if_false' {t : Arith.Ty} (cond : Var Γ Arith.Ty.bool) (hcond : Γv cond = false)
    (v : Var Γ t) (then_ else_ : Com ScfArith [t] .impure t) :
    Expr.denote (if_ (t := t) cond v then_ else_) Γv
    = Expr.denote (run (t := t) v else_) Γv := by
  -- TODO: make a `PeepholeRewrite` for `if_false`.
  simp_peephole
  simp [hcond]

/-- a region that returns the value immediately -/
@[simp_denote] def RegionRet (t : Arith.Ty) {Γ : Ctxt Arith.Ty} (v : Var Γ t) :
    Com ScfArith Γ .impure t := .ret v

/-- a for loop whose body immediately returns the loop variable is the same as
  just fetching the loop variable. -/
theorem for_return {t : Arith.Ty} (istart istep: Var Γ Arith.Ty.int)
    (niters : Var Γ .nat) (v : Var Γ t) :
    Expr.denote (for_ (t := t) istart istep niters v (RegionRet t ⟨1, by simp⟩)) Γv = Γv v := by
  simp_peephole
  simp [Scf.LoopBody.counterDecorator.constant_iterate]

/-# Repeatedly adding a constant in a loop is replaced with a multiplication.

We keep the increment outside the loop so that we don't need to deal with
creating and deleting tuples for the "for" region body, since our regions are
isolatedFromAbove.  If we want to deal with creating and removing tuples, we
can.

**TODO:** create a tuple for passing the increment variable into the loop

lhs
----
  out = for i in range(0, nsteps, δ=1) with k0 {
    ^entry(k):
      yield k + increment
  }
  return out

rhs
----
  out = k0 + increment * nsteps
-/
namespace ForAddToMul

def lhs (vincrement : ℤ) : Com ScfArith [/- nsteps -/ .nat, /- vstart -/ .int] .impure .int :=
  /- c0 = -/ Com.letPure (cst 0) <|
  /- loop_step = -/ Com.letPure  (cst 1) <|
  /- v1 = -/ Com.var (for_ (t := .int)
                        ⟨/- c0 -/ 1, rfl⟩
                        ⟨/- loop_step -/ 0, rfl⟩
                        ⟨/- nsteps -/ 2, rfl⟩
                        ⟨/- vstart -/ 3, rfl⟩ (
      Com.letPure (cst vincrement) <|
      Com.letPure (add ⟨0, rfl⟩ ⟨2, rfl⟩) -- fun v => (v + increment)
      <| Com.ret ⟨0, rfl⟩)) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def rhs (vincrement : ℤ) : Com ScfArith [/- nsteps -/ .nat, /- vstart -/ .int] .pure .int :=
  Com.var (cst vincrement) <|
  Com.var (axpy ⟨0, by simp [Ctxt.snoc]⟩ ⟨1, by simp [Ctxt.snoc]⟩ ⟨2, by simp [Ctxt.snoc]⟩) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

abbrev instHadd : HAdd ⟦ScfFunctor.Arith.Ty.int⟧ ⟦ScfFunctor.Arith.Ty.int⟧
  ⟦ScfFunctor.Arith.Ty.int⟧ := @instHAdd ℤ Int.instAdd

open Scf in
open Arith in
theorem correct : Com.denote (lhs v0) = Com.denote (rhs v0) := by
  unfold lhs rhs
  simp_peephole

  intros A B
  rw [Scf.LoopBody.counterDecorator.const_index_fn_iterate (f' := fun v => v0 + v)] <;> try rfl
  simp only [add_left_iterate, nsmul_eq_mul, Int.mul_comm]

/-- info: 'ScfFunctor.ForAddToMul.correct' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms correct

-- TODO: add a PeepholeRewrite for this theorem.

end ForAddToMul

/- ## Reverse a loop, if the loop body does not depend on the loop. -/
namespace ForReversal
variable {t : Arith.Ty}
variable (rgn : Com ScfArith [Arith.Ty.int, t] .impure t)
/- region semantics does not depend on trip count. That is, the region is trip count invariant.
  In such cases, a region can be reversed. -/
variable (hrgn : Scf.LoopBody.IndexInvariant (fun i v => Com.denote rgn <|
    Ctxt.Valuation.ofPair i v))

def lhs :
    let Γ := [/- start-/ Arith.Ty.int, /- delta -/Arith.Ty.int,
      /- steps -/ Arith.Ty.nat, /- val -/ t]
    Com ScfArith Γ .impure t :=
  /- v -/
  /- v1 = -/ Com.var (for_ (t := t)
                        ⟨/- start -/ 0, by rfl⟩
                        ⟨/- delta -/1, by rfl⟩
                        ⟨/- steps -/ 2, by simp⟩
                        ⟨/- v0 -/ 3, by simp⟩  rgn) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def rhs : Com ScfArith [/- start-/ .int, /- delta -/.int, /- steps -/ .nat, /- v0 -/ t] .impure t :=
  /- delta * steps + start-/
  Com.letPure (axpy ⟨1, by simp⟩ ⟨2, by simp⟩ ⟨0, by simp⟩) <|
  /- -delta -/
  Com.letPure (neg ⟨2, by simp [Ctxt.snoc]⟩) <|
  Com.var (for_ (t := t)
                        ⟨/- end -/ 2, by simp [Ctxt.snoc]⟩
                        ⟨/- -delta -/ 3, by simp [Ctxt.snoc]⟩
                        ⟨/- steps -/ 4, by simp [Ctxt.snoc]⟩
                        ⟨/- v0 -/ 5, by simp [Ctxt.snoc]⟩  rgn) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩


/-- rewrite a variable whose index is '> 0' to a new variable which is the
'snoc' of a smaller variable.  this enables rewriting with
`Ctxt.Valuation.snoc_toSnoc`. -/
theorem Ctxt.Var.toSnoc (ty snocty : Arith.Ty) (Γ : Ctxt Arith.Ty)  (V : Ctxt.Valuation Γ)
    {snocval : ⟦snocty⟧}
    {v: ℕ}
    {hvproof : Ctxt.get? Γ v = some ty}
    {var : Γ.Var ty}
    (hvar : var = ⟨v, hvproof⟩) :
    V var = (Ctxt.Valuation.snoc V snocval) ⟨v+1, by
      simp at hvproof; simp [Ctxt.snoc, hvproof]⟩ := by
  simp [Ctxt.Valuation.snoc, hvar]

theorem correct : Com.denote (lhs rgn) Γv = Com.denote (rhs rgn) Γv := by
  unfold lhs rhs
  simp_peephole

/-- info:
'ScfFunctor.ForReversal.correct' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms correct

-- TODO: add a PeepholeRewrite for this theorem.

end ForReversal

/-## two adjacent loops with the same region body and correct trip counts can be fused together.

-- step 1: define with all variables as lean metavars, not rewriter metavars.
-- step 2: generalize to case with variables are rewriter metavars.

-/
namespace ForFusion


variable (rgn : Com ScfArith [.int, t] .impure t)
variable (niters1 niters2 : ℕ)
variable (start1 : ℤ)

def lhs : Com ScfArith [/- v0 -/ t] .impure t :=
  /- niters1 = -/ Com.letPure (cst_nat niters1) <|
  /- start1 = -/ Com.letPure (cst start1) <|
  /- c1 = -/ Com.letPure (cst 1) <|
  -- start step niter v
  Com.var (for_ (t := t) ⟨1, by rfl⟩ ⟨0, by rfl⟩ ⟨2, by rfl⟩ ⟨3, by rfl⟩ rgn) <|
  /- niters2 = -/ Com.letPure (cst_nat niters2) <|
  /- start2 = -/ Com.letPure (cst <| niters1 + start1) <|
  /- c1 = -/ Com.letPure (cst 1) <|
  Com.var (for_ (t := t) ⟨1, by rfl⟩ ⟨0, by rfl⟩ ⟨2, by rfl⟩ ⟨3, by rfl⟩ rgn) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def rhs : Com ScfArith [/- v0 -/ t] .impure t :=
  /- niters1 + niters2 = -/ Com.letPure (cst_nat <| niters1 + niters2) <|
  /- start1 = -/ Com.letPure (cst start1) <|
  /- c1 = -/ Com.letPure (cst 1) <|
  -- start step niter v
  Com.var (for_ (t := t) ⟨1, by simp [Ctxt.snoc]⟩ ⟨0, by
      simp [Ctxt.snoc]⟩ ⟨2, by simp [Ctxt.snoc]⟩ ⟨3, by simp [Ctxt.snoc]⟩ rgn) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩


open Scf in
theorem correct :
    Com.denote (lhs rgn niters1 niters2 start1) =
      Com.denote (rhs rgn niters1 niters2 start1) := by
  unfold lhs rhs
  simp_peephole
  intros a
  rw [Nat.add_comm, Function.iterate_add_apply]
  congr
  rw [LoopBody.counterDecorator.iterate_fst_val]
  linarith

--/-- info:
--'ScfFunctor.ForFusion.correct' depends on axioms: [propext, Classical.choice, Quot.sound]
---/
--#guard_msgs in #print axioms correct


end ForFusion

namespace IterateIdentity
attribute [local simp] Ctxt.snoc

/-- running `f(x) = x + x` 0 times is the identity. -/
def lhs : Com ScfArith [.int] .impure .int :=
  Com.var (iterate (k := 0) ⟨0, by rfl⟩ (
      Com.letPure (add ⟨0, by rfl⟩ ⟨0, by rfl⟩) -- fun x => (x + x)
      <| Com.ret ⟨0, by rfl⟩
  )) <|
  Com.ret ⟨0, by rfl⟩

def rhs : Com ScfArith [.int] .impure .int :=
  Com.ret ⟨0, by rfl⟩

attribute [local simp] Ctxt.snoc

-- TODO: Sadly we've lost the ability to phrase this as a `PeepHoleRewrite`, since we mandate
--       that peephole must be pure, but we also have engineered the framework such that (for now)
--       only impure operations can access their regions. We should revisit this peephole once
--       we've addressed the latter shortcoming.
--
-- noncomputable def p1 : PeepholeRewrite Op [.int] .int:=
--   { lhs := lhs, rhs := rhs, correct := by
--       rw [lhs, rhs]
--       funext Γv
--       /-
--       Com.denote
--         (Com.var
--           (iterate 0 { val := 0, property := lhs.proof_1 }
--             (Com.var (add { val := 0, property := lhs.proof_1 } { val := 0,
--                 property := lhs.proof_1 })
--               (Com.ret { val := 0, property := lhs.proof_2 })))
--           (Com.ret { val := 0, property := lhs.proof_2 }))
--         Γv =
--       Com.denote (Com.ret { val := 0, property := rhs.proof_1 }) Γv
--       -/
--       simp_peephole [add, iterate] at Γv
--       /-  ∀ (a : ℤ), (fun v => v + v)^[0] a = a -/
--       simp [Function.iterate_zero]
--       done
--   }

end IterateIdentity

end ScfFunctor
