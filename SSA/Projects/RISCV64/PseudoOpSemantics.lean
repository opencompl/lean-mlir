import SSA.Projects.RISCV64.Tactic.SimpRiscVAttr
import RISCV.Instructions

open BitVec

/-!
  ## Dialect Pseudo-operation semantics
  This file contains the semantics for each modeled `RISCV-64` standard pseudo-instruction
  as defined by: https://github.com/riscv-non-isa/riscv-asm-manual/blob/main/src/asm-manual.adoc.
   These semantics are not derived from the Sail semantics, as Sail does not
  model all pseudo-instructions. In particular, Sail only models pseudo-instructions if they are
  actually native instructions when certain extensions are enabled.
  If an instruction can be an architectural instruction in certain processor configurations and a
  pseudo-instruction in others (e.g., `sext.b`, `sext.h`, `zext.h`, `zext.w`), then we implement its
  semantics in `Semantics.lean`, where we model all architectural instructions.
  The semantic of pseudo-instructions reuse the semantics of their underlying base instructions.
-/

namespace RV64

@[simp_riscv]
def mv_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64.addi 0 rs1_val

@[simp_riscv]
def not_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64.xori (-1) rs1_val

@[simp_riscv]
def neg_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64.sub rs1_val 0

@[simp_riscv]
def negw_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64.subw rs1_val 0

@[simp_riscv]
def sextw_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64.addiw 0 rs1_val

@[simp_riscv]
def zextb_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64.andi 255 rs1_val

@[simp_riscv]
def zextw_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64.adduw 0 rs1_val

@[simp_riscv]
def seqz_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64.sltiu 1 rs1_val

@[simp_riscv]
def snez_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64.sltu rs1_val 0

@[simp_riscv]
def sltz_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64.slt 0 rs1_val

@[simp_riscv]
def sgtz_pseudo (rs1_val : BitVec 64) : BitVec 64 :=
  RV64.slt rs1_val 0
