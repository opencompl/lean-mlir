/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework
import SSA.Core.Util.Poison
import SSA.Projects.InstCombine.Base

/-!
## Refinement of LLVM values
-/

namespace InstCombine
open LLVM (IntW)

local instance : Refinement (BitVec w) := .ofEq

instance : DialectHRefinement LLVM LLVM where
  IsTypeCompatible := Eq
  IsRefinedBy := @fun
  | .bitvec w, _, Eq.refl _ => fun (x y : PoisonOr _) => x ⊑ y

instance : LawfulDialectRefinement LLVM where
  isTypeCompatible_rfl _ := rfl
