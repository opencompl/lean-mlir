/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Core.Util.Poison
import SSA.Projects.SLLVM.Tactic.SimpSet

namespace LeanMLIR

structure MemoryState where
  -- TODO: actually implement memory state
  deriving Inhabited

instance : Refinement MemoryState := .ofEq
@[simp, simp_sllvm]
theorem MemoryState.isRefinedBy_iff (s t : MemoryState) : s ⊑ t ↔ s = t := by rfl

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

@[simp] theorem map_ub (f : α → β) : f <$> ub = ub := rfl
@[simp] theorem ub_bind (f : α → EffectM β) : ub >>= f = ub := rfl

@[simp] theorem bind_ub (x : EffectM α) : x >>= (fun _ => @ub β) = ub := by
  funext; simp

@[simp] theorem seq_ub (x : EffectM (α → β)) : x <*> ub = ub := by
  rw [seq_eq_bind]; simp

/-! ## Refinement -/

instance [HRefinement α α] : Refinement (EffectM α) where
  IsRefinedBy (x y : StateT _ PoisonOr _) := x ⊑ y
