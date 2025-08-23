import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.RISCV64.Tactic.SimpRiscVAttr
import SSA.Projects.RISCV64.Semantics

open BitVec

/-!
  ## Dialect Pseudo-operation semantics
  This file contains the semantics for each modelled `RISCV-64` standart pseudoinstruction
  as defined by : https://github.com/riscv-non-isa/riscv-asm-manual/blob/main/src/asm-manual.adoc
  Unlike Semantics.lean these semanitcs are dervied from the Sail semanitics does not modell
  all pseudoinstructions. To be precise, Sail only models pseudoinstructions if they are actually
  native instructions when certain extensions are enabled.
  If any instruction can be psuedoinstruction in some processor configurations and a pseud instruction
  in others, then we implemented their semanitcs in the Semanitcs.lean file where we modell all architectural
  instructions
  The semantic defintions reuse the semanitcs of their underlying base instructions.
  The following list of instructions are hardware or psuedo ops depending the processor :
  sext.b
  sext.h
  zext.h
  zext.w
-/

namespace RV64PseudoOpSemantics

@[simp_riscv]
def MV_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.ITYPE_pure64_RISCV_ADDI  0 rs1_val

@[simp_riscv]
def NOT_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.ITYPE_pure64_RISCV_XORI  (-1) rs1_val

@[simp_riscv]
def NEG_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
   RV64Semantics.RTYPE_pure64_RISCV_SUB (rs1_val)  (0)

@[simp_riscv]
def NEGW_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
   RV64Semantics.RTYPEW_pure64_RISCV_SUBW (rs1_val)  (0)

@[simp_riscv]
def SEXTW_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.pure64_RISCV_ADDIW 0 (rs1_val)

@[simp_riscv]
def ZEXTB_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
   RV64Semantics.ITYPE_pure64_RISCV_ANDI 255 (rs1_val)

@[simp_riscv]
def SEQZ_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
   RV64Semantics.ITYPE_pure64_RISCV_SLTIU  1 (rs1_val)

@[simp_riscv]
def SNEZ_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
     RV64Semantics.RTYPE_pure64_RISCV_SLTU (rs1_val) 0

@[simp_riscv]
def SLTZ_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.RTYPE_pure64_RISCV_SLT (0)  (rs1_val)

@[simp_riscv]
def SGZT_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.RTYPE_pure64_RISCV_SLT (rs1_val) (0)

end RV64PseudoOpSemantics
