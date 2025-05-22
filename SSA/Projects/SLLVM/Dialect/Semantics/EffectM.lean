/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Core.Util.Poison
import SSA.Projects.SLLVM.Tactic.SimpSet

namespace LeanMLIR

structure MemoryState where
  -- TODO: actually implement memory state

instance : Refinement MemoryState := .ofEq

abbrev EffectM := StateT MemoryState PoisonOr

namespace EffectM

/-! ## Constructors -/

abbrev ub : EffectM α := PoisonOr.poison
abbrev value (a : α) : EffectM α := pure a

-- theorem pure_eq : pure
