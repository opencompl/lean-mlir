import SSA.Projects.RISCV64.Tactic.SimpRiscVAttr
import SSA.Projects.InstCombine.ForLean
import LeanMLIR.Dialects.LLVM.Syntax
import Lean.Meta.Tactic.Simp.SimpTheorems
import Lean.Meta.Tactic.Simp.RegisterCommand
import Lean.LabelAttribute
import RISCV.Instructions

open Lean
open Lean.Elab.Tactic

attribute [simp_riscv] RV64.addiw
attribute [simp_riscv] RV64.lui
attribute [simp_riscv] RV64.auipc
attribute [simp_riscv] RV64.slliw
attribute [simp_riscv] RV64.srliw
attribute [simp_riscv] RV64.sraiw
attribute [simp_riscv] RV64.slli
attribute [simp_riscv] RV64.srli
attribute [simp_riscv] RV64.srai
attribute [simp_riscv] RV64.addw
attribute [simp_riscv] RV64.subw
attribute [simp_riscv] RV64.sllw
attribute [simp_riscv] RV64.srlw
attribute [simp_riscv] RV64.sraw
attribute [simp_riscv] RV64.add
attribute [simp_riscv] RV64.slt
attribute [simp_riscv] RV64.sltu
attribute [simp_riscv] RV64.and
attribute [simp_riscv] RV64.or
attribute [simp_riscv] RV64.xor
attribute [simp_riscv] RV64.sll
attribute [simp_riscv] RV64.srl
attribute [simp_riscv] RV64.sub
attribute [simp_riscv] RV64.sra
attribute [simp_riscv] RV64.remw
attribute [simp_riscv] RV64.remuw
attribute [simp_riscv] RV64.rem
attribute [simp_riscv] RV64.remu
attribute [simp_riscv] RV64.mulhu
attribute [simp_riscv] RV64.mul
attribute [simp_riscv] RV64.mulhsu
attribute [simp_riscv] RV64.mulh
attribute [simp_riscv] RV64.mulw
attribute [simp_riscv] RV64.div
attribute [simp_riscv] RV64.divu
attribute [simp_riscv] RV64.divw
attribute [simp_riscv] RV64.divuw
attribute [simp_riscv] RV64.addi
attribute [simp_riscv] RV64.slti
attribute [simp_riscv] RV64.sltiu
attribute [simp_riscv] RV64.andi
attribute [simp_riscv] RV64.ori
attribute [simp_riscv] RV64.xori
attribute [simp_riscv] RV64.bclr
attribute [simp_riscv] RV64.bext
attribute [simp_riscv] RV64.binv
attribute [simp_riscv] RV64.bset
attribute [simp_riscv] RV64.bclri
attribute [simp_riscv] RV64.bexti
attribute [simp_riscv] RV64.binvi
attribute [simp_riscv] RV64.bseti
attribute [simp_riscv] RV64.adduw
attribute [simp_riscv] RV64.sh1adduw
attribute [simp_riscv] RV64.sh2adduw
attribute [simp_riscv] RV64.sh3adduw
attribute [simp_riscv] RV64.sh1add
attribute [simp_riscv] RV64.sh2add
attribute [simp_riscv] RV64.sh3add
attribute [simp_riscv] RV64.slliuw
attribute [simp_riscv] RV64.andn
attribute [simp_riscv] RV64.orn
attribute [simp_riscv] RV64.xnor
attribute [simp_riscv] RV64.clz
attribute [simp_riscv] RV64.clzw
attribute [simp_riscv] RV64.ctz
attribute [simp_riscv] RV64.ctzw
attribute [simp_riscv] RV64.max
attribute [simp_riscv] RV64.maxu
attribute [simp_riscv] RV64.min
attribute [simp_riscv] RV64.minu
attribute [simp_riscv] RV64.sextb
attribute [simp_riscv] RV64.sexth
attribute [simp_riscv] RV64.zexth
attribute [simp_riscv] RV64.rol
attribute [simp_riscv] RV64.rolw
attribute [simp_riscv] RV64.ror
attribute [simp_riscv] RV64.rori
attribute [simp_riscv] RV64.roriw
attribute [simp_riscv] RV64.rorw
attribute [simp_riscv] RV64.pack
attribute [simp_riscv] RV64.packh
attribute [simp_riscv] RV64.packw

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
