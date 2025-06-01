/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Lean.Meta.Tactic.Simp.SimpTheorems
import Lean.Meta.Tactic.Simp.RegisterCommand
import Lean.LabelAttribute

-- A simpset to simplify SLLVM semantics
register_simp_attr simp_sllvm
