import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.EDSL
import Lean.Meta.Tactic.Simp.SimpTheorems
import Lean.Meta.Tactic.Simp.RegisterCommand
import Lean.LabelAttribute


open Lean
open Lean.Elab.Tactic

/-!
This file defines the `simp_lowering` tactic, which bundles the llvm tactics as well as the riscv simp tactic
and invokes bv_decide. The tactic is engineered to solve any instruction lowering patterns within the
domain solveable by bv_decide. We enahnced the llvm tactics to handle the Poison cases and the riscv tactic
simplifies riscv defintions such that the remaining statement is solveable by bv_decide.
It also defines the `simp_lowering` attribute, which can be used to tag semantic definition functions so that
they are automatically simplified when `simp_lowering` is invoked. Moreover to achieve this proof automation,
a rewriter implementor must tag its rewrites as @[simp_denote] such that the first innovcation of `simp_peephole`
within the `simp_lowering` tactic unfolds the defintions to allow further tactics to be applied.

The purpose of this tactic is to reduce proof size when reasoning about instruction lowerings.
-/

syntax "simp_lowering" : tactic
macro_rules
| `(tactic| simp_lowering) =>
  `(tactic|(
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    --Only run `bv_decide` if there are goals left
    try all_goals bv_decide

  ))
