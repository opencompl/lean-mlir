/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Core.Util.Poison
import SSA.Projects.SLLVM.Tactic.SimpSet
import SSA.Projects.SLLVM.Dialect.Semantics.Memory

namespace LeanMLIR

def EffectM := StateT MemoryState PoisonOr

namespace EffectM

/-! ## Instances -/

instance : Monad EffectM        := by unfold EffectM; infer_instance
instance : LawfulMonad EffectM  := by unfold EffectM; infer_instance

instance : MonadState MemoryState EffectM   := by unfold EffectM; infer_instance
instance : MonadStateOf MemoryState EffectM := by unfold EffectM; infer_instance

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

@[simp, simp_denote, simp_sllvm]
lemma run_pure : StateT.run (pure x : EffectM α) s = .value (x, s) := rfl

@[simp, simp_denote, simp_sllvm]
lemma run_ub : StateT.run (ub : EffectM α) s = .poison := rfl

@[simp, simp_denote, simp_sllvm]
lemma run_bind (x : EffectM α) :
    StateT.run (x >>= f : EffectM β) s
    = StateT.run x s >>= (fun p => StateT.run (f p.1) p.2) :=
  rfl

@[simp, simp_denote, simp_sllvm]
lemma run_map (x : EffectM α) :
    StateT.run (f <$> x : EffectM β) s = (fun p => (f p.1, p.2)) <$> StateT.run x s := rfl

/-! ## Refinement -/
section Refinement
variable {α β} [HRefinement α β]

instance : HRefinement (EffectM α) (EffectM β) :=
  inferInstanceAs <| HRefinement (StateT _ PoisonOr _) (StateT _ PoisonOr _)

@[simp, simp_denote]
lemma isRefinedBy_iff (x : EffectM α) (y : EffectM β) :
  x ⊑ y ↔ ∀ s, StateT.run x s ⊑ StateT.run y s := by rfl

end Refinement

/-! ## Memory Semantics -/
section LoadStore
