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

def icmp_ugt_riscv_i64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64 ):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> !i64
    %add1 = sltu %rhsr, %lhsr : !i64 -- place a one if rhsr less than lhsr and therefore lhsr bigger.
    %addl = "builtin.unrealized_conversion_cast"(%add1) : (!i64) -> (i1)
    llvm.return %addl : i1
  }]

def icmp_ugt_llvm_i64 : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
  .pure (.llvm (.bitvec 1))  := [LV| {
  ^entry (%lhs: i64, %rhs: i64 ):
    %1 = llvm.icmp.ugt %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

def icmp_ugt_riscv_eq_icmp_ugt_llvm_i64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_ugt_llvm_i64, rhs:= icmp_ugt_riscv_i64,
   correct := by
    unfold icmp_ugt_llvm_i64 icmp_ugt_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.setWidth_eq]
    rw [BitVec.signExtend_eq_setWidth_of_le]
    simp only [Nat.one_le_ofNat, BitVec.setWidth_setWidth_of_le, BitVec.setWidth_eq]
    omega
  }

def icmp_ugt_riscv_i32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32 ):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> !i64
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> !i64
    %add1 = sltu %rhsr, %lhsr : !i64 -- place a one if rhsr less than lhsr and therefore lhsr bigger.
    %addl = "builtin.unrealized_conversion_cast"(%add1) : (!i64) -> (i1)
    llvm.return %addl : i1
  }]

def icmp_ugt_llvm_i32 : Com LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
  .pure (.llvm (.bitvec 1))  := [LV| {
  ^entry (%lhs: i32, %rhs: i32 ):
    %1 = llvm.icmp.ugt %lhs, %rhs  : i32
    llvm.return %1 : i1
  }]

def icmp_ugt_riscv_eq_icmp_ugt_llvm : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_ugt_llvm_i32, rhs:= icmp_ugt_riscv_i32,
   correct := by
    unfold icmp_ugt_llvm_i32 icmp_ugt_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    simp
    rw [BitVec.signExtend_eq_setWidth_of_le]
    simp [Nat.one_le_ofNat, BitVec.setWidth_setWidth_of_le, BitVec.setWidth_eq]
    have hx := BitVec.isLt x
    have hx' := BitVec.isLt x'
    simp [BitVec.ult]
    bv_omega
    simp
  }
