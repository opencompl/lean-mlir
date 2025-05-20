/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.InstCombine.LLVM.EDSL
import Lean.Meta.Tactic.Simp.SimpTheorems
import Lean.Meta.Tactic.Simp.RegisterCommand
import Lean.LabelAttribute

open Lean
open Lean.Elab.Tactic

register_simp_attr simp_riscv

attribute [simp_riscv]
  pure_bind
  BitVec.ofInt_neg_one
  PoisonOr.bind_if_then_poison_eq_ite_bind
  PoisonOr.bind_if_else_poison_eq_ite_bind

/- Simplify away the `InstCombine` specific semantics. -/
macro "simp_riscv" : tactic =>
  `(tactic|(
      simp (config := {failIfUnchanged := false}) only [
          simp_riscv,
          (BitVec.ofInt_ofNat)
        ]
    ))
