/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Bool.Basic

inductive Term : Type
| var : Nat → Term
| zero : Term
| negOne : Term
| one : Term
| and : Term → Term → Term
| or : Term → Term → Term
| xor : Term → Term → Term
| not : Term → Term
| ls : Term → Term
| add : Term → Term → Term
| sub : Term → Term → Term
| neg : Term → Term
| incr : Term → Term
| decr : Term → Term

open Term

def zeroSeq : Nat → Bool := fun _ => false

def oneSeq : Nat → Bool := fun n => n == 0

def negOneSeq : Nat → Bool := fun _ => true

def andSeq : ∀ (_ _ : Nat → Bool), Nat → Bool := fun x y n => x n && y n

def orSeq : ∀ (_ _ : Nat → Bool), Nat → Bool := fun x y n => x n || y n

def xorSeq : ∀ (_ _ : Nat → Bool), Nat → Bool := fun x y n => xor (x n) (y n)

def notSeq : ∀ (_ : Nat → Bool), Nat → Bool := fun x n => !(x n)

def lsSeq (s : Nat → Bool) : Nat → Bool
  | 0 => false
  | (n+1) => s n

def addSeqAux (x y : Nat → Bool) : Nat → Bool × Bool
  | 0 => (_root_.xor (x 0) (y 0), x 0 && y 0)
  | n+1 =>
    let carry := (addSeqAux x y n).2
    let a := x (n + 1)
    let b := y (n + 1)
    (_root_.xor a (_root_.xor b carry), (a && b) || (b && carry) || (a && carry))

def addSeq (x y : Nat → Bool) : Nat → Bool :=
  fun n => (addSeqAux x y n).1

def subSeqAux (x y : Nat → Bool) : Nat → Bool × Bool
  | 0 => (_root_.xor (x 0) (y 0), !(x 0) && y 0)
  | n+1 =>
    let borrow := (subSeqAux x y n).2
    let a := x (n + 1)
    let b := y (n + 1)
    (_root_.xor a (_root_.xor b borrow), !a && b || ((!(_root_.xor a b)) && borrow))

def subSeq (x y : Nat → Bool) : Nat → Bool :=
  fun n => (subSeqAux x y n).1

def negSeqAux (x : Nat → Bool) : Nat → Bool × Bool
  | 0 => (x 0, !(x 0))
  | n+1 =>
    let borrow := (negSeqAux x n).2
    let a := x (n + 1)
    (_root_.xor (!a) borrow, !a && borrow)

def negSeq (x : Nat → Bool) : Nat → Bool :=
  fun n => (negSeqAux x n).1

def incrSeqAux (x : Nat → Bool) : Nat → Bool × Bool
  | 0 => (!(x 0), x 0)
  | n+1 =>
    let carry := (incrSeqAux x n).2
    let a := x (n + 1)
    (_root_.xor a carry, a && carry)

def incrSeq (x : Nat → Bool) : Nat → Bool :=
  fun n => (incrSeqAux x n).1

def decrSeqAux (x : Nat → Bool) : Nat → Bool × Bool
  | 0 => (!(x 0), !(x 0))
  | (n+1) =>
    let borrow := (decrSeqAux x n).2
    let a := x (n + 1)
    (_root_.xor a borrow, !a && borrow)

def decrSeq (x : Nat → Bool) : Nat → Bool :=
  fun n => (decrSeqAux x n).1

def Term.eval : ∀ (_ : Term) (_ : Nat → Nat → Bool), Nat → Bool
| var n, vars => vars n
| zero, _ => zeroSeq
| one, _ => oneSeq
| negOne, _ => negOneSeq
| and t₁ t₂, vars => andSeq (Term.eval t₁ vars) (Term.eval t₂ vars)
| or t₁ t₂, vars => orSeq (Term.eval t₁ vars) (Term.eval t₂ vars)
| xor t₁ t₂, vars => xorSeq (Term.eval t₁ vars) (Term.eval t₂ vars)
| not t, vars => notSeq (Term.eval t vars)
| ls t, vars => lsSeq (Term.eval t vars)
| add t₁ t₂, vars => addSeq (Term.eval t₁ vars) (Term.eval t₂ vars)
| sub t₁ t₂, vars => subSeq (Term.eval t₁ vars) (Term.eval t₂ vars)
| neg t, vars => negSeq (Term.eval t vars)
| incr t, vars => incrSeq (Term.eval t vars)
| decr t, vars => decrSeq (Term.eval t vars)

instance : Add Term := ⟨add⟩
instance : Sub Term := ⟨sub⟩
--instance : One Term := ⟨one⟩
--instance : Zero Term := ⟨zero⟩
instance : Neg Term := ⟨neg⟩
