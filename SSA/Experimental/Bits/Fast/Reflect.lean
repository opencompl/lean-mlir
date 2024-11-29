/-
Released under Apache 2.0 license as described in the file LICENSE.


This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

Authors: Siddharth Bhat
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.FiniteStateMachine

/--
Denote a bitstream into the underlying bitvector.
-/
def BitStream.denote (s : BitStream) (w : Nat) : BitVec w := s.toBitVec w

@[simp] theorem BitStream.denote_zero : BitStream.denote BitStream.zero w = 0#w := by
  simp [denote, toBitVec]
  sorry

@[simp] theorem BitStream.denote_negOne : BitStream.denote BitStream.negOne w = BitVec.allOnes w := by
  simp [denote, toBitVec]
  sorry


/-- Denote a Term into its underlying bitvector -/
def Term.denote (t : Term) (vars : ℕ → BitStream) (w : Nat) : BitVec w :=
  match t with
  | var n => (vars n).denote w
  | zero => 0#w
  | negOne => BitVec.allOnes w
  | one  => 1#w
  | and a b => (a.denote vars w) &&& (b.denote vars w)
  | or a b => (a.denote vars w) ||| (b.denote vars w)
  | xor a b => (a.denote vars w) ^^^ (b.denote vars w)
  | not a => ~~~ (a.denote vars w)
  | add a b => (a.denote vars w) + (b.denote vars w)
  | sub a b => (a.denote vars w) - (b.denote vars w)
  | neg a => - (a.denote vars w)
  | incr a => (a.denote vars w) + 1#w
  | decr a => (a.denote vars w) - 1#w
  | ls bit a => (a.denote vars w).shiftConcat bit

theorem Term.eval_eq_denote (t : Term) (vars : ℕ → BitStream) (w : Nat) :
    (t.eval vars).denote w = t.denote vars w := by
  induction t generalizing vars w
  · simp [eval, denote]
  · simp [eval, denote]
  · simp [eval, denote]
  · simp [eval, denote]
    sorry
  repeat sorry

def Predicate.denote (p : Predicate) (vars : ℕ → BitStream) (w : Nat) : Prop :=
  match p with
  | .eq t₁ t₂ => t₁.denote vars w = t₂.denote vars w
  | .neq t₁ t₂ => t₁.denote vars w ≠ t₂.denote vars w
  | .isNeg t => (t.denote vars w).slt (0#w)
  | .land  p q => p.denote vars w ∧ q.denote vars w
  | .lor  p q => p.denote vars w ∨ q.denote vars w

/--
The semantics of a predicate:
The predicate, when evaluated, at index `i` is false iff the denotation is true.
-/
theorem Predicate.eval_eq_denote (p : Predicate) (vars : ℕ → BitStream) (w : Nat) :
    (p.eval vars w = false) ↔ p.denote vars w := by
  induction p generalizing vars w
  repeat sorry

def Reflect.Map.empty : ℕ → BitStream := fun _ => BitStream.zero
def Reflect.Map.set (s : BitStream) (ix : ℕ)  (m : ℕ → BitStream) := fun j => if j = ix then s else m ix

/-
Armed with the above, we write a proof by reflection principle.
This is adapted from Bits/Fast/Tactic.lean, but is cleaned up to build 'nice' looking environments
for reflection, rather than ones based on hashing the 'fvar', which can also have weird corner cases due to hash collisions.
-/
