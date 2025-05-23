import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

import Lean

open LLVMRiscV
open RV64Semantics
open InstCombine(LLVM)


/- # MUL RISCV  -/

def mul_riscv := [LV| {
    ^entry (%r1: i64, %r2: i64 ):
      %0 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> !i64
      %1 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> !i64
      %2 = mul %0, %1 : !i64
      %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

/- # MUL NO FLAG  -/

def mul_llvm_noflag : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.mul %x, %amount : i64
      llvm.return %1 : i64
  }]

/- # MUL FLAGS -/

def mul_llvm_nsw : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.mul %x, %amount overflow<nsw> : i64
      llvm.return %1 : i64
  }]

def mul_llvm_nuw : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.mul %x, %amount overflow<nuw> : i64
      llvm.return %1 : i64
  }]

def mul_llvm_flags : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %amount: i64 ):
      %1 = llvm.mul %x, %amount overflow<nsw,nuw> : i64
      llvm.return %1 : i64
  }]

def llvm_mul_lower_riscv_noflag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := mul_llvm_noflag, rhs := mul_riscv ,
    correct :=  by
    unfold mul_llvm_noflag mul_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.setWidth_eq, BitVec.signExtend_eq]
    bv_auto
  }

/- # MUL with  FLAG -/

--nsw and nuw flags
def llvm_mul_lower_riscv_flags : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := mul_llvm_flags, rhs := mul_riscv ,
    correct := by
    unfold mul_llvm_flags mul_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.setWidth_eq, BitVec.signExtend_eq]
    bv_auto
   }

def llvm_mul_lower_riscv_nsw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := mul_llvm_nsw, rhs := mul_riscv ,
    correct := by
    unfold mul_llvm_nsw mul_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.setWidth_eq, BitVec.signExtend_eq]
    bv_auto
  }

def llvm_mul_lower_riscv_nuw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := mul_llvm_nuw, rhs := mul_riscv ,
    correct := by
    unfold mul_llvm_nuw mul_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.setWidth_eq, BitVec.signExtend_eq]
    bv_auto
  }
