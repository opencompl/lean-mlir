import SSA.Projects.RISCV64.Tactic.SimpRiscVAttr
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.InstCombine.LLVM.EDSL
import Lean.Meta.Tactic.Simp.SimpTheorems
import Lean.Meta.Tactic.Simp.RegisterCommand
import Lean.LabelAttribute


open Lean
open Lean.Elab.Tactic

attribute [simp_riscv] HVector.reduceGetN

/-!
This file defines the `simp_riscv` tactic, which unfolds and simplifies the RISC-V semantic definitions.
It also defines the `simp_riscv` attribute, used to tag semantic definition functions so that
they are automatically simplified when `simp_riscv` is invoked.

The purpose of this tactic is to reduce proof size when reasoning about instruction lowerings.
-/
macro "simp_riscv" : tactic =>
  `(tactic|(
      simp (config := {failIfUnchanged := false}) only [
          simp_riscv
        ]
    ))
