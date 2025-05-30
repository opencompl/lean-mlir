import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

open LLVMRiscV

/- ! This file implements the lowering for the llvm compare instructions.
Currently all flags except for eq ad neq are supported.-/

def icmp_ugt_riscv_i64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = sltu %rhsr, %lhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_ugt_llvm_i64 : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
  .pure (.llvm (.bitvec 1))  := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
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
    simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq]
    bv_decide
  }

def icmp_ugt_riscv_i32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = sltu %rhsr, %lhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_ugt_llvm_i32 : Com LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
  .pure (.llvm (.bitvec 1))  := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
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
    simp only [PoisonOr.toOption_getSome, BitVec.truncate_eq_setWidth, Nat.one_le_ofNat,
      BitVec.setWidth_setWidth_of_le, BitVec.setWidth_eq, InstCombine.bv_isRefinedBy_iff,
      BitVec.ofBool_eq_iff_eq]
    have hx := BitVec.isLt x
    have hx' := BitVec.isLt x'
    bv_decide
  }

def icmp_uge_llvm_i64 : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.uge %lhs, %rhs : i64
    llvm.return %1 : i1
  }]

def icmp_uge_riscv_i64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = sltu %lhsr, %rhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_uge_riscv_eq_icmp_uge_llvm_i64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_uge_llvm_i64, rhs:= icmp_uge_riscv_i64,
   correct := by
    unfold icmp_uge_llvm_i64 icmp_uge_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq, BitVec.reduceSignExtend,
      BitVec.xor_eq, BitVec.signExtend_xor]
    bv_decide
  }

def icmp_uge_llvm_i32 : Com LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.uge %lhs, %rhs  : i32
    llvm.return %1 : i1
  }]

def icmp_uge_riscv_i32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = sltu %lhsr, %rhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_uge_riscv_eq_icmp_uge_llvm_i32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_uge_llvm_i32, rhs:= icmp_uge_riscv_i32,
   correct := by
    unfold icmp_uge_llvm_i32 icmp_uge_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.reduceSignExtend, BitVec.xor_eq,
      BitVec.signExtend_xor]
    bv_decide
  }

def icmp_ult_llvm_i64 : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.ult %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

def icmp_ult_riscv_i64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = sltu %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_ult_riscv_eq_icmp_ult_llvm_i64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_ult_llvm_i64, rhs:= icmp_ult_riscv_i64,
   correct := by
    unfold icmp_ult_llvm_i64 icmp_ult_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq]
    bv_decide
  }

def icmp_ult_llvm_i32 : Com LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.ult %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

def icmp_ult_riscv_i32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32 ):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = sltu %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_ult_riscv_eq_icmp_ult_llvm_i32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_ult_llvm_i32, rhs:= icmp_ult_riscv_i32,
   correct := by
    unfold icmp_ult_llvm_i32 icmp_ult_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome]
    bv_decide
  }

def icmp_ule_llvm_i64 : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.ule %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

def icmp_ule_riscv_i64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = sltu %rhsr, %lhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_ule_riscv_eq_icmp_ule_llvm_i64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_ule_llvm_i64, rhs:= icmp_ule_riscv_i64,
   correct := by
    unfold icmp_ule_llvm_i64 icmp_ule_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq, BitVec.reduceSignExtend,
      BitVec.xor_eq, BitVec.signExtend_xor]
    bv_decide
  }

def icmp_ule_llvm_i32 : Com LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.ule %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

def icmp_ule_riscv_i32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = sltu %rhsr, %lhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_ule_riscv_eq_icmp_ule_llvm_i32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_ule_llvm_i32, rhs:= icmp_ule_riscv_i32,
   correct := by
    unfold icmp_ule_llvm_i32 icmp_ule_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.reduceSignExtend, BitVec.xor_eq,
      BitVec.signExtend_xor]
    bv_decide
  }

def icmp_sgt_llvm_i64 : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.sgt %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

def icmp_sgt_riscv_i64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = slt %rhsr, %lhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_sgt_riscv_eq_icmp_sht_llvm_i64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_sgt_llvm_i64, rhs:= icmp_sgt_riscv_i64,
   correct := by
    unfold icmp_sgt_llvm_i64 icmp_sgt_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq]
    bv_decide
  }

def icmp_sgt_llvm_i32 : Com LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.sgt %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

def icmp_sgt_riscv_i32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = slt %rhsr, %lhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_sgt_riscv_eq_icmp_sgt_llvm_i32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_sgt_llvm_i32, rhs:= icmp_sgt_riscv_i32,
   correct := by
    unfold icmp_sgt_llvm_i32 icmp_sgt_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome]
    bv_decide
  }

def icmp_sge_llvm_i64 : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.sge %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

def icmp_sge_riscv_i64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = slt %lhsr, %rhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_sge_riscv_eq_icmp_sgt_llvm_i64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_sge_llvm_i64, rhs:= icmp_sge_riscv_i64,
   correct := by
    unfold icmp_sge_llvm_i64 icmp_sge_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq, BitVec.reduceSignExtend,
      BitVec.xor_eq, BitVec.signExtend_xor]
    bv_decide
  }

def icmp_sge_llvm_i32 : Com LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.sge %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

def icmp_sge_riscv_i32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = slt %lhsr, %rhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_sge_riscv_eq_icmp_sgt_llvm_i32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_sge_llvm_i32, rhs:= icmp_sge_riscv_i32,
   correct := by
    unfold icmp_sge_llvm_i32 icmp_sge_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.reduceSignExtend, BitVec.xor_eq,
      BitVec.signExtend_xor]
    bv_decide
  }

def icmp_slt_llvm_i64 : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.slt %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

def icmp_slt_riscv_i64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = slt %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_slt_riscv_eq_icmp_slt_llvm_i64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_slt_llvm_i64, rhs:= icmp_slt_riscv_i64,
   correct := by
    unfold icmp_slt_llvm_i64 icmp_slt_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq]
    bv_decide
  }

def icmp_slt_llvm_i32 : Com LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.slt %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

def icmp_slt_riscv_i32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = slt %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

def icmp_slt_riscv_eq_icmp_slt_llvm_i32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_slt_llvm_i32, rhs:= icmp_slt_riscv_i32,
   correct := by
    unfold icmp_slt_llvm_i32 icmp_slt_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome]
    bv_decide
  }

def icmp_sle_llvm_i64 : Com LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.icmp.sle %lhs, %rhs  : i64
    llvm.return %1 : i1
  }]

def icmp_sle_riscv_i64 := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> (!i64)
    %0 = slt %rhsr, %lhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_sle_riscv_eq_icmp_sle_llvm_i64 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs:= icmp_sle_llvm_i64, rhs:= icmp_sle_riscv_i64,
   correct := by
    unfold icmp_sle_llvm_i64 icmp_sle_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq, BitVec.reduceSignExtend,
      BitVec.xor_eq, BitVec.signExtend_xor]
    bv_decide
  }

def icmp_sle_llvm_i32 : Com LLVMPlusRiscV [.llvm (.bitvec 32), .llvm (.bitvec 32)]
  .pure (.llvm (.bitvec 1)) := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.icmp.sle %lhs, %rhs : i32
    llvm.return %1 : i1
  }]

def icmp_sle_riscv_i32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i32) -> (!i64)
    %0 = slt  %rhsr, %lhsr : !i64
    %1 = xori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i1)
    llvm.return %2 : i1
  }]

def icmp_sle_riscv_eq_icmp_sle_llvm_i32 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs:= icmp_sle_llvm_i32, rhs:= icmp_sle_riscv_i32,
   correct := by
    unfold icmp_sle_llvm_i32 icmp_sle_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [PoisonOr.toOption_getSome, BitVec.reduceSignExtend, BitVec.xor_eq,
      BitVec.signExtend_xor]
    bv_decide
  }
