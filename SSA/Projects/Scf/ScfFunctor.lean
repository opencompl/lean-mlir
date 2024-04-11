import Mathlib.Algebra.GroupPower.IterateHom
import Mathlib.Logic.Function.Iterate
import Mathlib.Tactic.Linarith
import SSA.Core.Framework
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.Util

open Std (BitVec)
open Ctxt(Var)

namespace ScfFunctor
/- disable proofs and types of proofs from showing to make proof states legible -/
set_option pp.proofs false
set_option pp.proofs.withType false

open TyDenote

/-- Describes that the dialect Op' has a type whose denotation is 'DenotedTy -/
class HasTy (Op' : Type) (DenotedTy : Type) [TyDenote Ty'] [OpSignature Op' Ty'] where
    ty : Ty'
    denote_eq : toType ty = DenotedTy := by rfl

abbrev HasBool (Op' : Type) [TyDenote Ty'] [OpSignature Op' Ty'] : Type := HasTy Op' Bool
abbrev HasInt (Op' : Type) [TyDenote Ty'] [OpSignature Op' Ty'] : Type := HasTy Op' Int
abbrev HasNat (Op' : Type) [TyDenote Ty'] [OpSignature Op' Ty'] : Type := HasTy Op' Nat


namespace ScfRegion

/-- only flow operations, parametric over arithmetic from another dialect Op'  -/
inductive Op (Op' : Type) [TyDenote Ty'] [OpSignature Op' Ty'] [OpDenote Op' Ty'] : Type _
  | coe (o : Op')
  | iterate (k : ℕ) -- fˆk
  | run (inputty : Ty')  -- f^k
  | if (inputty retty' : Ty')  -- if cond then true_body else false_body
  | for (ty : Ty')
  deriving DecidableEq, Repr

instance [TyDenote Ty'] [OpSignature Op' Ty'] [OpDenote Op' Ty'] : Coe Op' (Op Op') where
  coe o := .coe o

@[reducible]
instance [TyDenote Ty'] [OpSignature Op' Ty'] [OpDenote Op' Ty']
    [B : HasBool Op'] [N : HasNat Op'] [I : HasInt Op'] : OpSignature (Op Op') Ty' where
  signature
   | .coe o => signature o
    | .if t t' => ⟨[B.ty, t], [([t], t'), ([t], t')], t'⟩
    | .for t => ⟨[/-start-/I.ty, /-step-/I.ty, /-niters-/N.ty, t], [([I.ty, t], t)], t⟩
    | .run t => ⟨[t], [([t], t)], t⟩
    | .iterate _k => ⟨[I.ty], [([I.ty], I.ty)], I.ty⟩


/-- A loop body receives the current value of the loop induction variable, and the current loop carried value.
The loop body produces the value of this loop iteration.

Consider the loop: `for(int i = 0; i >= -10; i -= 2)`. In this case, the value `i` will be the sequence
of values `[0, -2, -4, -6, -8, -10]`. The value `i` is the loop induction variable.

This value is distinct from the *trip count*, which is the number of times the loop body has been executed so far, which is `[0, 1, 2, 3, 4]`.

The `LoopBody` does *not* provide access to the trip count, only to the loop induction variable.
-/
abbrev LoopBody (t : Type) : Type := Int → t → t

namespace LoopBody

/-- Convert a function `f` which is a single loop iteration into a function
  that iterates and updates the loop counter. -/
def CounterDecorator (δ: Int) (f : LoopBody α) : Int × α → Int × α :=
  fun (i, v) => (i + δ, f i v)


/-- A loop body is invariant if it does not depend on the index. -/
def IndexInvariant (f : LoopBody t) : Prop :=
  ∀ (i j : Int) (v : t), f i v = f j v

/-- Evaluating a loop index invariant function is the same as evaluating it at 0 -/
theorem eval (f : LoopBody t) (hf : LoopBody.IndexInvariant f) (i : Int) (v : t) :
  f i v = f 0 v := by unfold LoopBody.IndexInvariant at hf; rw [hf]

/-- Loop invariant functions can be simulated by a simpler function -/
def atZero (f : LoopBody t) : t → t := fun v => f 0 v

/-- If there exists a function `g : t → t` which agrees with `f`, then `f` is loop index invariant. -/
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

/-- iterating a loop invariant function gives a well understood answer: the iterates of the function. -/
@[simp]
theorem iterate {f : LoopBody t}
    (hf : LoopBody.IndexInvariant f)
    (δ : Int)
    (i₀ : Int)
    (v₀ : t) (k : ℕ) :
    (f.CounterDecorator δ)^[k] (i₀, v₀) = (i₀ + δ * k, (f.atZero)^[k] v₀) := by
  induction k generalizing i₀ v₀
  case zero => simp
  case succ i hi =>
    simp
    rw [hi]
    simp [LoopBody.CounterDecorator]
    simp [eval' hf]
    linarith

/-- the first component of iterating a loop invariant function -/
@[simp]
theorem iterate_fst {f : LoopBody t}
    (δ : Int) (hf : f.IndexInvariant) (i₀ : Int) (v₀ : t) (k : ℕ) :
    ((f.CounterDecorator δ)^[k] (i₀, v₀)).1 = i₀ + δ * k := by
  simp [hf];

/-- the second component of iterating a loop invariant function -/
@[simp]
theorem iterate_snd {f : LoopBody t}
    (δ : Int) (hf : f.IndexInvariant) (i₀ : Int) (v₀ : t) (k : ℕ) :
    ((f.CounterDecorator δ)^[k] (i₀, v₀)).2 = (f.atZero)^[k] v₀ := by
  simp [hf]

end LoopBody.IndexInvariant

namespace LoopBody.CounterDecorator
/-- iterated value of the fst of the tuple of CounterDecorator (ie, the loop counter) -/
@[simp]
theorem iterate_fst_val (δ: Int) (f : LoopBody α) (i₀ : Int) (v₀ : α) (k : ℕ) :
    ((f.CounterDecorator δ)^[k] (i₀, v₀)).1 = i₀ + k * δ := by
  induction k generalizing i₀ v₀
  case zero => simp
  case succ i hi =>
    simp
    rw [hi]
    simp [LoopBody.CounterDecorator]
    linarith

/-- evaluating a function that does not access the index (const_index_fn) -/
theorem const_index_fn_eval
    (δ : Int) (i : Int) (vstart : α) (f : LoopBody α) (f' : α → α) (hf : f = fun _ a => f' a) :
    (f.CounterDecorator δ) (i, vstart) = (i + δ, f' vstart) := by
  simp [LoopBody.CounterDecorator, hf]


/-- iterating a function that does not access the index (const_index_fn) -/
theorem const_index_fn_iterate (δ : Int)
    (i : Int) (vstart : α) (f : LoopBody α) (f' : α → α) (hf : f = fun _ a => f' a) (k : ℕ) :
    (f.CounterDecorator δ)^[k] (i, vstart) = (i + k * δ, f'^[k] vstart) := by
  obtain ⟨hf, hf'⟩ := f.eq_invariant_fn f' (by intros i v; rw [hf])
  rw [IndexInvariant.iterate hf]; simp
  apply And.intro
  . linarith
  . rw [hf']

/-- CounterDecorator on a constant function -/
@[simp]
theorem constant (δ : Int) (i : Int) (vstart : α) :
    (LoopBody.CounterDecorator δ fun _i v => v) (i, vstart) = (i + δ, vstart) := rfl

/-- iterate the CounterDecorator of a constant function. -/
theorem constant_iterate {α : Type} (k : ℕ) (δ : Int) :
    ((LoopBody.CounterDecorator δ (fun (i : Int) (v : α) => v))^[k]) =
    fun (args : ℤ × α) => (args.fst + k * δ, args.snd) := by
  funext ⟨i, v⟩
  induction k generalizing i v
  case h.zero =>
    simp
  case h.succ n ihn =>
    simp [ihn]
    linarith

def to_loop_run (δ : Int) (f : LoopBody α) (niters : ℕ) (val : α) : α :=
  (LoopBody.CounterDecorator δ f (niters,val)).2

end LoopBody.CounterDecorator

variable [TyDenote Ty'] [OpSignature Op' Ty'] [OpDenote Op' Ty']
  [B : HasBool Op'] [N : HasNat Op'] [Z : HasInt Op']

@[reducible]
instance : OpDenote (Op Op') Ty' where
  denote
    | .coe o', args', regArgs' =>
        let denote' := OpDenote.denote o'
        by
         exact denote' args' regArgs'
    | .if t t', (.cons (cond ) (.cons v .nil)),
         (.cons (f : Ctxt.Valuation [t] → ⟦t'⟧) (.cons (g : _ → _) .nil)) =>
         let body := if B.denote_eq ▸ cond then f else g
      body (Ctxt.Valuation.nil.snoc v)
    | .run _t, (.cons v .nil), (.cons (f : _ → _) .nil) =>
        f (Ctxt.Valuation.nil.snoc v)
    | .for ty, (.cons istart (.cons istep (.cons niter (.cons vstart .nil)))), (.cons (f : _  → _) .nil) =>
        let istart : ℤ := Z.denote_eq ▸ istart
        let istep : ℤ := Z.denote_eq ▸ istep
        let niter : ℕ := N.denote_eq ▸ niter
        let f' (i : ℤ) (v : ⟦ty⟧) : ⟦ty⟧ :=
          f ∘  (Function.uncurry Ctxt.Valuation.ofPair) <| (Z.denote_eq.symm ▸ i, v)
        let to_iterate := LoopBody.CounterDecorator (α := ⟦ty⟧) (δ := istep) (f := f')
        let loop_fn := niter.iterate (op := to_iterate)
        (loop_fn (istart, vstart)).2

    | .iterate k, (.cons (x) .nil), (.cons (f : _ → _) .nil) =>
      let x : ℤ := Z.denote_eq ▸ x
      let coe : ℤ = toType Z.ty := Z.denote_eq.symm
      let f' (v :  ℤ) : ℤ := coe ▸ f (Ctxt.Valuation.nil.snoc (cast coe v))
      Z.denote_eq ▸  (k.iterate f' x)
end ScfRegion

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

@[reducible]
instance : OpSignature Op Ty where
  signature
    | .axpy => ⟨[.int, .nat, .int], [], .int⟩
    | .neg => ⟨[.int], [], .int⟩
    | .const _ => ⟨[], [], .int⟩
    | .const_nat _ => ⟨[], [], .nat⟩
    | .add   => ⟨[.int, .int], [], .int⟩
    | .add_nat   => ⟨[.nat, .nat], [], .nat⟩


@[reducible]
instance : OpDenote Op Ty where
  denote
    | .const n, _, _ => n
    | .const_nat n, _, _ => n
    | .neg, .cons (a : ℤ ) .nil, _ => -a
    | .axpy, .cons (a : ℤ) (.cons (x : ℕ) (.cons (b : ℤ) .nil)), _ => a * (x : ℤ) + b
    | .add, .cons (a : ℤ) (.cons (b : ℤ) .nil), _ => a + b
    | .add_nat, .cons (a : ℕ) (.cons (b : ℕ) .nil), _ => a + b


instance : HasBool Op where ty := .bool
instance : HasNat Op where ty := .nat
instance : HasInt Op where ty := .int

end Arith

/-- Compose Scf on top of Arith -/
abbrev Op := ScfRegion.Op Arith.Op

def cst (n : ℤ) : Expr Op Γ .int  :=
  Expr.mk
    (op := .coe <| .const n)
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)

def cst_nat (n : ℕ) : Expr Op Γ .nat  :=
  Expr.mk
    (op := .coe <| .const_nat n)
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)

def add {Γ : Ctxt _} (e₁ e₂ : Var Γ .int) : Expr Op Γ .int :=
  Expr.mk
    (op := .coe <| .add)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

def add_nat (e₁ e₂ : Var Γ .nat) : Expr Op Γ .nat :=
  Expr.mk
    (op := .coe <| .add_nat)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

def axpy {Γ : Ctxt _} (a : Var Γ .int) (x : Var Γ .nat) (b: Var Γ .int) : Expr Op Γ .int :=
  Expr.mk
    (op := .coe <| .axpy)
    (ty_eq := rfl)
    (args := .cons a <| .cons x <| .cons b .nil)
    (regArgs := .nil)

def neg {Γ : Ctxt _} (a : Var Γ .int) : Expr Op Γ .int :=
  Expr.mk
    (op := .coe <| .neg)
    (ty_eq := rfl)
    (args := .cons a <| .nil)
    (regArgs := .nil)


def iterate {Γ : Ctxt _} (k : Nat) (input : Var Γ Arith.Ty.int) (body : Com Op [.int] .int) : Expr Op Γ .int :=
  Expr.mk
    (op := .iterate k)
    (ty_eq := rfl)
    (args := .cons input .nil)
    (regArgs := HVector.cons body HVector.nil)

def if_ {Γ : Ctxt _} {t t': Arith.Ty}
  (cond : Var Γ Arith.Ty.bool) (v : Var Γ t) (then_ else_ : Com Op [t] t') : Expr Op Γ t' :=
  Expr.mk
    (op := .if t t')
    (ty_eq := rfl)
    (args := .cons cond <| .cons v .nil)
    (regArgs := HVector.cons then_ <| HVector.cons else_ <| HVector.nil)

def run {Γ : Ctxt _} {t : Arith.Ty} (v : Var Γ t) (body : Com Op [t] t) : Expr Op Γ t :=
  Expr.mk
    (op := .run t)
    (ty_eq := rfl)
    (args := .cons v .nil)
    (regArgs := HVector.cons body <| HVector.nil)

def for_ {Γ : Ctxt Arith.Ty} {t : Arith.Ty}
    (start step : Var Γ Arith.Ty.int)
    (niter : Var Γ Arith.Ty.nat) (v : Var Γ t) (body : Com Op [.int, t] t) : Expr Op Γ t :=
  Expr.mk
    (op := .for t)
    (ty_eq := rfl)
    (args := .cons start <| .cons step <| .cons niter <| .cons v .nil)
    (regArgs := HVector.cons body <| HVector.nil)

/-- 'if' condition of a true variable evaluates to the then region body. -/
theorem if_true' {t : Arith.Ty} (cond : Var Γ Arith.Ty.bool) (hcond : Γv cond = true) (v : Var Γ t) (then_ else_ : Com Op [t] t) :
  Expr.denote (if_ (t := t) cond v then_ else_) Γv =
  Expr.denote (run (t := t) v then_) Γv := by
    simp [Expr.denote, if_, run]
    simp_peephole [hcond] at Γv
    simp [ite_true]
-- TODO: make a `PeepholeRewrite` for `if_true`.

/-- 'if' condition of a false variable evaluates to the else region body. -/
theorem if_false' {t : Arith.Ty} (cond : Var Γ Arith.Ty.bool) (hcond : Γv cond = false) (v : Var Γ t) (then_ else_ : Com Op [t] t) :
  Expr.denote (if_ (t := t) cond v then_ else_) Γv =
  Expr.denote (run (t := t) v else_) Γv := by
    simp [Expr.denote, if_, run]
    simp_peephole [hcond] at Γv
    simp [ite_true]

-- TODO: make a `PeepholeRewrite` for `if_false`.


/-- a region that returns the value immediately -/
abbrev RegionRet (t : Arith.Ty) {Γ : Ctxt Arith.Ty} (v : Var Γ t) : Com Op Γ t := .ret v

/-- a for loop whose body immediately returns the loop variable is the same as
  just fetching the loop variable. -/
theorem for_return {t : Arith.Ty} (istart istep: Var Γ Arith.Ty.int) (niters : Var Γ .nat) (v : Var Γ t) :
  Expr.denote (for_ (t := t) istart istep niters v (RegionRet t ⟨1, by simp⟩)) Γv = Γv v := by
    simp [Expr.denote, run, for_]
    simp_peephole at Γv
    simp [ScfRegion.LoopBody.CounterDecorator.constant_iterate]

/-# Repeatedly adding a constant in a loop is replaced with a multiplication.

We keep the increment outside the loop so that we don't need to deal with creating and deleting tuples for the "for" region body,
since our regions are isolatedFromAbove.
If we want to deal with creating and removing tuples, we can.

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

def lhs (vincrement : ℤ) : Com Op [/- nsteps -/ .nat, /- vstart -/ .int] .int :=
  /- c0 = -/ Com.lete (cst 0) <|
  /- loop_step = -/ Com.lete  (cst 1) <|
  /- v1 = -/ Com.lete (for_ (t := .int)
                        ⟨/- c0 -/ 1, by simp [Ctxt.snoc]⟩
                        ⟨/- loop_step -/ 0, by simp [Ctxt.snoc]⟩
                        ⟨/- nsteps -/ 2, by simp [Ctxt.snoc]⟩
                        ⟨/- vstart -/ 3, by simp [Ctxt.snoc]⟩ (
      Com.lete (cst vincrement) <|
      Com.lete (add ⟨0, by simp [Ctxt.snoc]⟩ ⟨2, by simp [Ctxt.snoc]⟩) -- fun v => (v + increment)
      <| Com.ret ⟨0, by simp [Ctxt.snoc]⟩)) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def rhs (vincrement : ℤ) : Com Op [/- nsteps -/ .nat, /- vstart -/ .int] .int :=
  Com.lete (cst vincrement) <|
  Com.lete (axpy ⟨0, by simp [Ctxt.snoc]⟩ ⟨1, by simp [Ctxt.snoc]⟩ ⟨2, by simp [Ctxt.snoc]⟩) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

abbrev instHadd : HAdd ⟦ScfFunctor.Arith.Ty.int⟧ ⟦ScfFunctor.Arith.Ty.int⟧ ⟦ScfFunctor.Arith.Ty.int⟧ := @instHAdd ℤ Int.instAddInt

open ScfRegion in
open Arith in
theorem correct :
    Com.denote (lhs v0) Γv = Com.denote (rhs v0) Γv := by
  simp only [lhs, cst, for_, Ctxt.get?, Var.zero_eq_last, Com.denote_lete, Com.denote_ret,
    Ctxt.Valuation.snoc_last, rhs, axpy]
  simp_peephole [add, iterate, for_, axpy, cst, cst_nat] at Γv
  intros A B
  simp only [Ctxt.Valuation.snoc, Var.casesOn, Ctxt.get?, Var.zero_eq_last, cast_eq]
  rw [ScfRegion.LoopBody.CounterDecorator.const_index_fn_iterate (f' := fun v => v0 + v)] <;> try rfl
  simp only [add_left_iterate, nsmul_eq_mul, Int.mul_comm]

#print axioms correct --  [propext, Classical.choice, Quot.sound]

-- TODO: add a PeepholeRewrite for this theorem.

end ForAddToMul

/- ## Reverse a loop, if the loop body does not depend on the loop. -/
namespace ForReversal
variable {t : Arith.Ty}
variable (rgn : Com Op [Arith.Ty.int, t] t)
/- region semantics does not depend on trip count. That is, the region is trip count invariant.
  In such cases, a region can be reversed. -/
variable (hrgn : ScfRegion.LoopBody.IndexInvariant (fun i v => Com.denote rgn <| Ctxt.Valuation.ofPair i v))

def lhs : Com Op [/- start-/ Arith.Ty.int, /- delta -/Arith.Ty.int, /- steps -/ Arith.Ty.nat, /- val -/ t] t :=
   /- v-/
   /- v1 = -/ Com.lete (for_ (t := t)
                         ⟨/- start -/ 0, by simp [Ctxt.snoc]⟩
                         ⟨/- delta -/1, by simp [Ctxt.snoc]⟩
                         ⟨/- steps -/ 2, by simp [Ctxt.snoc]⟩
                         ⟨/- v0 -/ 3, by simp [Ctxt.snoc]⟩  rgn) <|
   Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def rhs : Com Op [/- start-/ .int, /- delta -/.int, /- steps -/ .nat, /- v0 -/ t] t :=
  /- delta * steps + start-/
  Com.lete (axpy ⟨1, by simp [Ctxt.snoc]⟩ ⟨2, by simp [Ctxt.snoc]⟩ ⟨0, by simp [Ctxt.snoc]⟩) <|
  /- -delta -/
  Com.lete (neg ⟨2, by simp [Ctxt.snoc]⟩) <|
  Com.lete (for_ (t := t)
                        ⟨/- end -/ 2, by simp [Ctxt.snoc]⟩
                        ⟨/- -delta -/ 3, by simp [Ctxt.snoc]⟩
                        ⟨/- steps -/ 4, by simp [Ctxt.snoc]⟩
                        ⟨/- v0 -/ 5, by simp [Ctxt.snoc]⟩  rgn) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩


/-- rewrite a variable whose index is '> 0' to a new variable which is the 'snoc' of a smaller variable.
  this enables rewriting with `Ctxt.Valuation.snoc_toSnoc`. -/
theorem Ctxt.Var.toSnoc (ty snocty : Arith.Ty) (Γ : Ctxt Arith.Ty)  (V : Ctxt.Valuation Γ) {snocval : ⟦snocty⟧}
    {v: ℕ}
    {hvproof : Ctxt.get? Γ v = some ty}
    {var : Γ.Var ty}
    (hvar : var = ⟨v, hvproof⟩) :
    V var = (Ctxt.Valuation.snoc V snocval) ⟨v+1, by simp [Ctxt.snoc] at hvproof; simp [Ctxt.snoc, hvproof]⟩ := by
  simp [Ctxt.Valuation.snoc, hvar]

theorem correct : Com.denote (lhs rgn) Γv = Com.denote (rhs rgn) Γv := by
  simp [lhs, rhs, for_, axpy]
  simp_peephole at Γv

#print axioms correct --  [propext, Classical.choice, Quot.sound]

-- TODO: add a PeepholeRewrite for this theorem.

end ForReversal

/-## two adjacent loops with the same region body and correct trip counts can be fused together.

-- step 1: define with all variables as lean metavars, not rewriter metavars.
-- step 2: generalize to case with variables are rewriter metavars.

-/
namespace ForFusion


variable (rgn : Com Op [.int, t] t)
variable (niters1 niters2 : ℕ)
variable (start1 : ℤ)

def lhs : Com Op [/- v0 -/ t] t :=
  /- niters1 = -/ Com.lete (cst_nat niters1) <|
  /- start1 = -/ Com.lete (cst start1) <|
  /- c1 = -/ Com.lete (cst 1) <|
  -- start step niter v
  Com.lete (for_ (t := t) ⟨1, by simp [Ctxt.snoc]⟩ ⟨0, by simp [Ctxt.snoc]⟩ ⟨2, by simp [Ctxt.snoc]⟩ ⟨3, by simp [Ctxt.snoc]⟩ rgn) <|
  /- niters2 = -/ Com.lete (cst_nat niters2) <|
  /- start2 = -/ Com.lete (cst <| niters1 + start1) <|
  /- c1 = -/ Com.lete (cst 1) <|
  Com.lete (for_ (t := t) ⟨1, by simp [Ctxt.snoc]⟩ ⟨0, by simp [Ctxt.snoc]⟩ ⟨2, by simp [Ctxt.snoc]⟩ ⟨3, by simp [Ctxt.snoc]⟩ rgn) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def rhs : Com Op [/- v0 -/ t] t :=
  /- niters1 + niters2 = -/ Com.lete (cst_nat <| niters1 + niters2) <|
  /- start1 = -/ Com.lete (cst start1) <|
  /- c1 = -/ Com.lete (cst 1) <|
  -- start step niter v
  Com.lete (for_ (t := t) ⟨1, by simp [Ctxt.snoc]⟩ ⟨0, by simp [Ctxt.snoc]⟩ ⟨2, by simp [Ctxt.snoc]⟩ ⟨3, by simp [Ctxt.snoc]⟩ rgn) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩


open ScfRegion in
theorem correct :
    Com.denote (lhs rgn niters1 niters2 start1) Γv = Com.denote (rhs rgn niters1 niters2 start1) Γv := by
  simp [lhs, rhs, for_, axpy, cst]
  simp_peephole [add, iterate, for_, axpy, cst, cst_nat] at Γv
  intros a
  have swap_niters := add_comm (a := niters1) (b := niters2)
  set arg := ((LoopBody.CounterDecorator 1 fun i v =>
                Com.denote rgn (Ctxt.Valuation.snoc (Ctxt.Valuation.snoc default v) i))^[niters1]
            (start1, a)).2
  have H : (LoopBody.CounterDecorator 1 fun i v =>
        Com.denote rgn (Ctxt.Valuation.snoc (Ctxt.Valuation.snoc default v) i))^[niters1 + niters2]
    (start1, a) = (LoopBody.CounterDecorator 1 fun i v =>
        Com.denote rgn (Ctxt.Valuation.snoc (Ctxt.Valuation.snoc default v) i))^[niters2 + niters1]
    (start1, a) := by
      congr
  rw [H, Function.iterate_add_apply]
  congr
  rw [LoopBody.CounterDecorator.iterate_fst_val]
  linarith

end ForFusion

namespace IterateIdentity
attribute [local simp] Ctxt.snoc

/-- running `f(x) = x + x` 0 times is the identity. -/
def lhs : Com Op [.int] .int :=
  Com.lete (iterate (k := 0) ⟨0, by simp [Ctxt.snoc]⟩ (
      Com.lete (add ⟨0, by simp [Ctxt.snoc]⟩ ⟨0, by simp [Ctxt.snoc]⟩) -- fun x => (x + x)
      <| Com.ret ⟨0, by simp [Ctxt.snoc]⟩
  )) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def rhs : Com Op [.int] .int :=
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

attribute [local simp] Ctxt.snoc

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
      /-  ∀ (a : ℤ), (fun v => v + v)^[0] a = a -/
      simp [Function.iterate_zero]
      done
  }

end IterateIdentity
