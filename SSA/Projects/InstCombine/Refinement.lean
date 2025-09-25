/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.Base
import LeanMLIR.Util.Poison

namespace InstCombine
open LLVM.Ty

@[simp, simp_denote]
instance instRefinement : DialectHRefinement LLVM LLVM where
  IsRefinedBy := @fun (bitvec _) (bitvec _) => by
    simp only [toType]; infer_instance
