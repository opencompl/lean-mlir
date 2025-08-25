import SSA.Projects.RISCV64.Semantics

open BitVec

/-!
  ## Dialect Pseudo-operation semantics
  This file contains the semantics for each modeled `RISCV-64` standard pseudo-instruction
  as defined by: https://github.com/riscv-non-isa/riscv-asm-manual/blob/main/src/asm-manual.adoc.
  Unlike `Semantics.lean` these semantics are not derived from the Sail semantics, as Sail does not
  model all pseudo-instructions. In particular, Sail only models pseudo-instructions if they are
  actually native instructions when certain extensions are enabled.
  If an instruction can be an architectural instruction in certain processor configurations and a
  pseudo-instruction in others (e.g., `sext.b`, `sext.h`, `zext.h`, `zext.w`), then we implement its
  semantics in `Semantics.lean`, where we model all architectural instructions.
  The semantic of pseudo-instructions reuse the semantics of their underlying base instructions.
-/

namespace RV64PseudoOpSemantics

@[simp_riscv]
def MV_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.ITYPE_pure64_RISCV_ADDI 0 rs1_val

@[simp_riscv]
def NOT_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.ITYPE_pure64_RISCV_XORI (-1) rs1_val

@[simp_riscv]
def NEG_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.RTYPE_pure64_RISCV_SUB rs1_val 0

@[simp_riscv]
def NEGW_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.RTYPEW_pure64_RISCV_SUBW rs1_val 0

@[simp_riscv]
def SEXTW_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.pure64_RISCV_ADDIW 0 rs1_val

@[simp_riscv]
def ZEXTB_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.ITYPE_pure64_RISCV_ANDI 255 rs1_val

@[simp_riscv]
def SEQZ_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.ITYPE_pure64_RISCV_SLTIU 1 rs1_val

@[simp_riscv]
def SNEZ_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.RTYPE_pure64_RISCV_SLTU rs1_val 0

@[simp_riscv]
def SLTZ_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.RTYPE_pure64_RISCV_SLT 0 rs1_val

@[simp_riscv]
def SGZT_pure64_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64Semantics.RTYPE_pure64_RISCV_SLT rs1_val 0

end RV64PseudoOpSemantics
