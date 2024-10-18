/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import SSA.Projects.InstCombine.ForLean
import SSA.Experimental.Bits.Fast.BitStream

namespace AutoStructs

/-!
# Term Language
This file defines the term language the decision procedure operates on,
and the denotation of these terms into operations on bitstreams -/

/-- A `Term` is an expression in the language our decision procedure operates on,
it represent an infinite bitstream (with free variables) -/
inductive Term : Type
| var : Nat → Term
/-- The constant `0` -/
| zero : Term
/-- The constant `-1` -/
| negOne : Term
/-- The constant `1` -/
| one : Term
/-- Bitwise and -/
| and : Term → Term → Term
/-- Bitwise or -/
| or : Term → Term → Term
/-- Bitwise xor -/
| xor : Term → Term → Term
/-- Bitwise complement -/
| not : Term → Term
-- /-- Append a single bit the start (i.e., least-significant end) of the bitstream -/
-- | ls (b : Bool) : Term → Term
/-- Addition -/
| add : Term → Term → Term
/-- Subtraction -/
| sub : Term → Term → Term
/-- Negation -/
| neg : Term → Term
/-- Increment (i.e., add one) -/
| incr : Term → Term
/-- Decrement (i.e., subtract one) -/
| decr : Term → Term
deriving Repr
-- /-- `repeatBit` is an operation that will repeat the infinitely repeat the
-- least significant `true` bit of the input.

-- That is `repeatBit t` is all-zeroes iff `t` is all-zeroes.
-- Otherwise, there is some number `k` s.t. `repeatBit t` is all-ones after
-- dropping the least significant `k` bits  -/
-- | repeatBit : Term → Term

instance : Inhabited Term where
  default := .zero

open Term

instance : Add Term := ⟨add⟩
instance : Sub Term := ⟨sub⟩
instance : One Term := ⟨one⟩
instance : Zero Term := ⟨zero⟩
instance : Neg Term := ⟨neg⟩

/-- `t.arity` is the max free variable id that occurs in the given term `t`,
and thus is an upper bound on the number of free variables that occur in `t`.

Note that the upper bound is not perfect:
a term like `var 10` only has a single free variable, but its arity will be `11` -/
@[simp] def Term.arity : Term → Nat
| (var n) => n+1
| zero => 0
| one => 0
| negOne => 0
| Term.and t₁ t₂ => max (arity t₁) (arity t₂)
| Term.or t₁ t₂ => max (arity t₁) (arity t₂)
| Term.xor t₁ t₂ => max (arity t₁) (arity t₂)
| Term.not t => arity t
-- | ls _ t => arity t
| add t₁ t₂ => max (arity t₁) (arity t₂)
| sub t₁ t₂ => max (arity t₁) (arity t₂)
| neg t => arity t
| incr t => arity t
| decr t => arity t
-- | repeatBit t => arity t


/--
Evaluate a term `t` to the BitVec it represents.

This differs from `Term.eval` in that `Term.evalFin` uses `Term.arity` to
determine the number of free variables that occur in the given term,
and only require that many bitstream values to be given in `vars`.
-/
@[simp] def Term.evalFin (t : Term) (vars : Fin (arity t) → BitVec w) : BitVec w :=
  match t with
  | var n => vars (Fin.last n)
  | zero    => BitVec.zero w
  | one     => 1
  | negOne  => -1
  | and t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ &&& x₂
  | or t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ ||| x₂
  | xor t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ ^^^ x₂
  | not t     => ~~~(t.evalFin vars)
  -- | ls b t    => (t.evalFin vars).concat b
  | add t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ + x₂
  | sub t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ - x₂
  | neg t       => -(Term.evalFin t vars)
  | incr t      => Term.evalFin t vars + 1
  | decr t      => Term.evalFin t vars - 1
  -- | repeatBit t => BitStream.repeatBit (Term.evalFin t vars)

@[simp] def Term.evalNat (t : Term) (vars : Nat → BitVec w) : BitVec w :=
  match t with
  | var n => vars (Fin.last n)
  | zero    => BitVec.zero w
  | one     => 1
  | negOne  => -1
  | and t₁ t₂ =>
      let x₁ := t₁.evalNat vars
      let x₂ := t₂.evalNat vars
      x₁ &&& x₂
  | or t₁ t₂ =>
      let x₁ := t₁.evalNat vars
      let x₂ := t₂.evalNat vars
      x₁ ||| x₂
  | xor t₁ t₂ =>
      let x₁ := t₁.evalNat vars
      let x₂ := t₂.evalNat vars
      x₁ ^^^ x₂
  | not t     => ~~~(t.evalNat vars)
  -- | ls b t    => (t.evalNat vars).concat b
  | add t₁ t₂ =>
      let x₁ := t₁.evalNat vars
      let x₂ := t₂.evalNat vars
      x₁ + x₂
  | sub t₁ t₂ =>
      let x₁ := t₁.evalNat vars
      let x₂ := t₂.evalNat vars
      x₁ - x₂
  | neg t       => -(Term.evalNat t vars)
  | incr t      => Term.evalNat t vars + 1
  | decr t      => Term.evalNat t vars - 1
  -- | repeatBit t => BitStream.repeatBit (Term.evalFin t vars)
@[simp] def Term.evalFinStream (t : Term) (vars : Fin (arity t) → BitStream) : BitStream :=
  match t with
  | var n => vars (Fin.last n)
  | zero    => BitStream.zero
  | one     => BitStream.one
  | negOne  => BitStream.negOne
  | and t₁ t₂ =>
      let x₁ := t₁.evalFinStream (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFinStream (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ &&& x₂
  | or t₁ t₂ =>
      let x₁ := t₁.evalFinStream (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFinStream (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ ||| x₂
  | xor t₁ t₂ =>
      let x₁ := t₁.evalFinStream (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFinStream (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ ^^^ x₂
  | not t     => ~~~(t.evalFinStream vars)
  | add t₁ t₂ =>
      let x₁ := t₁.evalFinStream (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFinStream (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ + x₂
  | sub t₁ t₂ =>
      let x₁ := t₁.evalFinStream (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFinStream (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ - x₂
  | neg t       => -(Term.evalFinStream t vars)
  | incr t      => BitStream.incr (Term.evalFinStream t vars)
  | decr t      => BitStream.decr (Term.evalFinStream t vars)

inductive RelationOrdering
| lt | le | gt | ge
deriving Repr

inductive Relation
| eq
| signed (ord : RelationOrdering)
| unsigned (ord : RelationOrdering)
deriving Repr

@[simp]
def evalRelation {w} (rel : Relation) (bv1 bv2 : BitVec w) : Bool :=
  match rel with
  | .eq => bv1 = bv2
  | .signed .lt => bv1 <ₛ bv2
  | .signed .le => bv1 ≤ₛ bv2
  | .signed .gt => bv1 >ₛ bv2
  | .signed .ge => bv1 ≥ₛ bv2
  | .unsigned .lt => bv1 <ᵤ bv2
  | .unsigned .le => bv1 ≤ᵤ bv2
  | .unsigned .gt => bv1 >ᵤ bv2
  | .unsigned .ge => bv1 ≥ᵤ bv2

inductive Binop
| and | or | impl | equiv
deriving Repr

@[simp]
def evalBinop (op : Binop) (b1 b2 : Bool) : Bool :=
  match op with
  | .and => b1 && b2
  | .or => b1 || b2
  | .impl => b1 -> b2
  | .equiv => b1 <-> b2

@[simp]
def evalBinop' (op : Binop) (b1 b2 : Prop) : Prop :=
  match op with
  | .and => b1 ∧ b2
  | .or => b1 ∨ b2
  | .impl => b1 → b2
  | .equiv => b1 ↔ b2
inductive Unop
| neg
deriving Repr

inductive Formula : Type
| atom : Relation → Term → Term → Formula
| msbSet : Term → Formula
| unop : Unop → Formula → Formula
| binop : Binop → Formula → Formula → Formula
deriving Repr

instance : Inhabited Formula := ⟨Formula.msbSet default⟩

@[simp]
def Formula.arity : Formula → Nat
| atom _ t1 t2 => max t1.arity t2.arity
| msbSet t => t.arity
| unop _ φ => φ.arity
| binop _ φ1 φ2 => max φ1.arity φ2.arity

@[simp]
def Formula.sat {w : Nat} (φ : Formula) (ρ : Fin φ.arity → BitVec w) : Bool :=
  match φ with
  | .atom rel t1 t2 =>
    let bv1 := t1.evalFin (fun n => ρ $ Fin.castLE (by simp [arity]) n)
    let bv2 := t2.evalFin (fun n => ρ $ Fin.castLE (by simp [arity]) n)
    evalRelation rel bv1 bv2
  | .unop .neg φ => !φ.sat ρ
  | .binop op φ1 φ2 =>
    let b1 := φ1.sat (fun n => ρ $ Fin.castLE (by simp [arity]) n)
    let b2 := φ2.sat (fun n => ρ $ Fin.castLE (by simp [arity]) n)
    evalBinop op b1 b2
  | .msbSet t => (t.evalFin ρ).msb

@[simp]
def Formula.sat' {w : Nat} (φ : Formula) (ρ : Nat → BitVec w) : Prop :=
  match φ with
  | .atom rel t1 t2 =>
    let bv1 := t1.evalNat ρ
    let bv2 := t2.evalNat ρ
    evalRelation rel bv1 bv2
  | .unop .neg φ => ¬ φ.sat' ρ
  | .binop op φ1 φ2 =>
    let b1 := φ1.sat' ρ
    let b2 := φ2.sat' ρ
    evalBinop' op b1 b2
  | .msbSet t => (t.evalNat ρ).msb

@[simp]
abbrev envOfArray {w} (a : Array (BitVec w)) : Nat → BitVec w := fun n => a.getD n 0

@[simp]
abbrev envOfList {w} (a : List (BitVec w)) : Nat → BitVec w := fun n => a.getD n 0
