/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Mathlib.Data.List.AList
import Mathlib.Data.Vector.Basic

import SSA.Core.Util.Poison
import SSA.Projects.SLLVM.Tactic.SimpSet

namespace LeanMLIR.SLLVM

/-!
# Memory

This is a very rough approximation of the Alive memory model.
-/

structure BlockId where
  address : BitVec 64
  deriving Inhabited, DecidableEq

/--
NOTE: we only implement *logical* pointers so far, which means we don't support
  integer-to-pointer casts
-/
inductive Pointer
  /-- NOTE: `offset` is an *unsigned* offset into the block -/
  | logical (bid : BlockId) (offset : BitVec 64)
  deriving Inhabited

structure MemBlock where
  size  : BitVec 64
  bytes : BitVec (8 * size.toNat)
  deriving Inhabited

structure MemoryState where
  blocks : AList (fun (_ : BlockId) => MemBlock)
  block_zero (bid : BlockId) : bid.address = 0#_ → blocks.lookup bid = none

/-! ## MemoryState Instances -/

instance : Inhabited MemoryState where
  default := {
    blocks := ∅
    block_zero := by simp
  }

/-! ## Memory Refinement -/

instance : Refinement MemoryState where
  IsRefinedBy s t := s.blocks.entries = t.blocks.entries

@[simp, simp_sllvm]
theorem MemoryState.isRefinedBy_iff (s t : MemoryState) :
  s ⊑ t ↔ s.blocks.entries = t.blocks.entries := by rfl

/-!
# EffectM
-/

def EffectM := StateT MemoryState PoisonOr

namespace EffectM

/-! ## Instances -/

instance : Monad EffectM        := by unfold EffectM; infer_instance
instance : LawfulMonad EffectM  := by unfold EffectM; infer_instance

/-! ## Constructors -/

abbrev ub : EffectM α := fun _ => PoisonOr.poison
abbrev poison : EffectM (PoisonOr α) := pure PoisonOr.poison
abbrev value (a : α) : EffectM (PoisonOr α) := pure (PoisonOr.value a)

/-! ## Lemmas -/

@[simp, simp_sllvm]
theorem pure_eq (x : α) (s) : (pure x : EffectM _) s = .value (x, s) := rfl

@[simp, simp_sllvm]
theorem bind_eq (x : EffectM α) (f : α → EffectM β) (s) :
    (x >>= f) s = x s >>= (fun (x, s) => f x s) := rfl

/-! ## Refinement -/

instance [HRefinement α α] : Refinement (EffectM α) where
  IsRefinedBy (x y : StateT _ PoisonOr _) := x ⊑ y
