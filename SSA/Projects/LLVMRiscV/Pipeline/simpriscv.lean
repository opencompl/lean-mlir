import SSA.Projects.LLVMRiscV.Pipeline.simpriscvattr
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.InstCombine.LLVM.EDSL
import Lean.Meta.Tactic.Simp.SimpTheorems
import Lean.Meta.Tactic.Simp.RegisterCommand
import Lean.LabelAttribute
import SSA.Projects.LLVMRiscV.LLVMAndRiscv

open Lean
open Lean.Elab.Tactic
open RV64Semantics
open LLVMRiscV
-- to do add all the semantics of riscv
attribute [simp_riscv]
 ADDIW_pure64 UTYPE_pure64_lui UTYPE_pure64_AUIPC RTYPE_pure64_RISCV_ADD castriscvToLLVM
 castLLVMToriscv RTYPE_pure64_RISCV_SRA_bv RTYPE_pure64_RISCV_SUB RTYPE_pure64_RISCV_AND
 MUL_pure64_ftt RTYPE_pure64_RISCV_OR REM_pure64_signed_bv DIV_pure64_signed_bv
 RTYPE_pure64_RISCV_SLL_bv RTYPE_pure64_RISCV_SRL_bv RTYPE_pure64_RISCV_SUB
 DIV_pure64_unsigned_bv REM_pure64_unsigned_bv RTYPE_pure64_RISCV_XOR DIV_pure64_signed_bv


syntax "simp_riscv" : tactic
macro "simp_riscv" : tactic =>
  `(tactic|(
      simp (config := {failIfUnchanged := false}) only [
          simp_riscv,

        ]
    ))
