/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Lean.Meta.Tactic.Simp.SimpTheorems
import Lean.Meta.Tactic.Simp.RegisterCommand
import Lean.LabelAttribute

/--
`simp_llvm_ops` is a simp set which unfolds semantic operations in the LLVM dialect
namespace (e.g., as defined in `LLVM/Semantics.lean`).
-/
register_simp_attr simp_llvm_ops

/--
`simp_llvm_poison` is a simp set for reasoning about poison semantics in the LLVM dialect.
In particular, it contains rewrites about `PoisonOr` definitions like `isPoison`,
`getValue` and `ofParts` together with constructions that appear in the
*implementation* of LLVM operation semantics.

NOTE: this simpset is intended to be used *after* `simp_llvm`, so there is no
      need to add unfolding lemmas for LLVM operations in this simp set.
-/
register_simp_attr simp_llvm_poison


register_simp_attr bv_ofBool

/-! ## DEPRECATED
`simp_llvm_option`, `simp_llvm_wrap`, `simp_llvm_case_bash`, and `simp_llvm_split`
are deprecated simpsets and should not be used.
-/
register_simp_attr simp_llvm_option
register_simp_attr simp_llvm_wrap
/-- The simp-set used in `simp_alive_case_bash` to attempt to discharge trivial `none` cases -/
register_simp_attr simp_llvm_case_bash
register_simp_attr simp_llvm_split
