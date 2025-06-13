/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Lean.Meta.Tactic.Simp.SimpTheorems
import Lean.Meta.Tactic.Simp.RegisterCommand
import Lean.LabelAttribute

register_simp_attr simp_llvm

/-- The simp-set used in `simp_alive_case_bash` to attempt to discharge trivial `none` cases -/
register_simp_attr simp_llvm_case_bash

register_simp_attr simp_llvm_split

register_simp_attr bv_ofBool
