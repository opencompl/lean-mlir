/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.Base
import SSA.Core.Util.Poison

namespace InstCombine
open LLVM.Ty

instance : DialectHRefinement LLVM LLVM where
  IsRefinedBy := @fun
    | bitvec w, bitvec w', (x : LLVM.IntW _), (y : LLVM.IntW _) =>
        if h : w = w' then
          x ⊑ h ▸ y
        else
          false

@[simp_denote]
theorem isRefinedBy_iff_of_width_eq (x y : LLVM.IntW w) :
    DialectHRefinement.IsRefinedBy (d := LLVM) (d' := LLVM) (t := bitvec w) (u := bitvec w) x y
    ↔ x ⊑ y := by
  simp [DialectHRefinement.IsRefinedBy]

@[simp_denote]
theorem isRefinedBy_iff_of_width_neq {x : LLVM.IntW w} {y : LLVM.IntW v} (h : w ≠ v) :
    DialectHRefinement.IsRefinedBy (d := LLVM) (d' := LLVM) (t := bitvec w) (u := bitvec v) x y
    ↔ False := by
  simp [DialectHRefinement.IsRefinedBy, h]
