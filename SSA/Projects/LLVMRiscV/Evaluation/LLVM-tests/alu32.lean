import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open LLVMRiscV

/-! This file implements and verifies the alu32.ll test case from LLVM. -/
/--
define i32 @addi(i32 %a) nounwind {
; RV64I-LABEL: addi:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addiw a0, a0, 1
; RV64I-NEXT:    ret
  %1 = add i32 %a, 1
  ret i32 %1
}-/

def addi_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (1) : i32
    %1 = llvm.add %a, %0 : i32
    llvm.return %1 : i32
  }]

def addi_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = addiw %a, 1 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def addi_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := addi_llvm_i32
  rhs := addi_riscv_i32
  correct := by
    unfold addi_llvm_i32 addi_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; sorry

/- define i32 @slti(i32 %a) nounwind {
; RV64I-LABEL: slti:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    slti a0, a0, 2
; RV64I-NEXT:    ret
  %1 = icmp slt i32 %a, 2
  %2 = zext i1 %1 to i32
  ret i32 %2
}-/
def slti_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (2) : i32
    %1 = llvm.icmp.slt %a, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]
-- TO DO
def slti_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = "sext.w" (%a) : (!i64) -> (!i64)
    %1 = slti %0, 2 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def slti_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := slti_llvm_i32
  rhs := slti_riscv_i32
  correct := by
    unfold slti_llvm_i32 slti_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @sltiu(i32 %a) nounwind {
; RV64I-LABEL: sltiu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    sltiu a0, a0, 3
; RV64I-NEXT:    ret
  %1 = icmp ult i32 %a, 3
  %2 = zext i1 %1 to i32
  ret i32 %2
}-/
def sltiu_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (3) : i32
    %1 = llvm.icmp.ult %a, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

def sltiu_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = "sext.w" (%a) :(!i64) -> (!i64)
    %1 = sltiu %0, 3 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def sltiu_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := sltiu_llvm_i32
  rhs := sltiu_riscv_i32
  correct := by
    unfold sltiu_llvm_i32 sltiu_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @xori(i32 %a) nounwind {
; RV64I-LABEL: xori:
; RV64I:       # %bb.0:
; RV64I-NEXT:    xori a0, a0, 4
; RV64I-NEXT:    ret
  %1 = xor i32 %a, 4
  ret i32 %1
}-/
def xori_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (4) : i32
    %1 = llvm.xor %a, %0 : i32
    llvm.return %1 : i32
  }]

def xori_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = xori %a, 4 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def xori_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := xori_llvm_i32
  rhs := xori_riscv_i32
  correct := by
    unfold xori_llvm_i32 xori_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide


/- define i32 @ori(i32 %a) nounwind {
; RV64I-LABEL: ori:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ori a0, a0, 5
; RV64I-NEXT:    ret
  %1 = or i32 %a, 5
  ret i32 %1
}-/
def ori_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (5) : i32
    %1 = llvm.or %a, %0 : i32
    llvm.return %1 : i32
  }]

def ori_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = ori %a, 5 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def ori_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := ori_llvm_i32
  rhs := ori_riscv_i32
  correct := by
    unfold ori_llvm_i32 ori_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @andi(i32 %a) nounwind {
; RV64I-LABEL: andi:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 6
; RV64I-NEXT:    ret
  %1 = and i32 %a, 6
  ret i32 %1
}-/
def andi_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (6) : i32
    %1 = llvm.and %a, %0 : i32
    llvm.return %1 : i32
  }]

def andi_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = andi %a, 6 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

/- define i32 @slli(i32 %a) nounwind {
; RV64I-LABEL: slli:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slliw a0, a0, 7
; RV64I-NEXT:    ret
  %1 = shl i32 %a, 7
  ret i32 %1
}-/
def slli_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (7) : i32
    %1 = llvm.shl %a, %0 : i32
    llvm.return %1 : i32
  }]

def slli_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = slliw %a, 7 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def slli_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := slli_llvm_i32
  rhs := slli_riscv_i32
  correct := by
    unfold slli_llvm_i32 slli_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @srli(i32 %a) nounwind {
; RV64I-LABEL: srli:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srliw a0, a0, 8
; RV64I-NEXT:    ret
  %1 = lshr i32 %a, 8
  ret i32 %1
}-/
def srli_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (8) : i32
    %1 = llvm.lshr %a, %0 : i32
    llvm.return %1 : i32
  }]

def srli_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = srliw %a, 8 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def srli_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := srli_llvm_i32
  rhs := srli_riscv_i32
  correct := by
    unfold srli_llvm_i32 srli_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-; This makes sure SimplifyDemandedBits doesn't prevent us from matching SRLIW
; on RV64.
define i32 @srli_demandedbits(i32 %0) {
; RV64I-LABEL: srli_demandedbits:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srliw a0, a0, 3
; RV64I-NEXT:    ori a0, a0, 1
; RV64I-NEXT:    ret
  %2 = lshr i32 %0, 3
  %3 = or i32 %2, 1
  ret i32 %3
}-/
def srli_demandedbits_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (3) : i32
    %1 = llvm.lshr %a, %0 : i32
    %2 = llvm.mlir.constant (1) : i32
    %3 = llvm.or %1, %2 : i32
    llvm.return %3 : i32
  }]

def srli_demandedbits_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = srliw %a, 3 : !i64
    %1 = ori %0, 1 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def srli_demandedbits_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := srli_demandedbits_llvm_i32
  rhs := srli_demandedbits_riscv_i32
  correct := by
    unfold srli_demandedbits_llvm_i32 srli_demandedbits_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @srai(i32 %a) nounwind {
RISCV64I-LABEL: srai:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sraiw a0, a0, 9
; RV64I-NEXT:    ret
  %1 = ashr i32 %a, 9
  ret i32 %1
}-/
def srai_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (9) : i32
    %1 = llvm.ashr %a, %0 : i32
    llvm.return %1 : i32
  }]

def srai_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = sraiw %a, 9 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def srai_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := srai_llvm_i32
  rhs := srai_riscv_i32
  correct := by
    unfold srai_llvm_i32 srai_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @add(i32 %a, i32 %b) nounwind {
; RV64I-LABEL: add:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = add i32 %a, %b
  ret i32 %1
}
-/
def add_llvm_i32 := [LV| {
  ^entry (%a: i32, %b: i32):
    %0 = llvm.add %a, %b : i32
    llvm.return %0 : i32
  }]

def add_riscv_i32 :=
  [LV| {
  ^entry (%arg0: i32, %arg1: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %0 = addw %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def add_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := add_llvm_i32
  rhs := add_riscv_i32
  correct := by
    unfold add_llvm_i32 add_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @sub(i32 %a, i32 %b) nounwind {
; RV64I-LABEL: sub:
; RV64I:       # %bb.0:
; RV64I-NEXT:    subw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = sub i32 %a, %b
  ret i32 %1
}-/
def sub_llvm_i32 := [LV| {
  ^entry (%a: i32, %b: i32):
    %0 = llvm.sub %a, %b : i32
    llvm.return %0 : i32
  }]

def sub_riscv_i32 :=
  [LV| {
  ^entry (%arg0: i32, %arg1: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %0 = subw %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def sub_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := sub_llvm_i32
  rhs := sub_riscv_i32
  correct := by
    unfold sub_llvm_i32 sub_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @sub_negative_constant_lhs(i32 %a) nounwind {
; RV64I-LABEL: sub_negative_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, -2
; RV64I-NEXT:    subw a0, a1, a0
; RV64I-NEXT:    ret
  %1 = sub i32 -2, %a
  ret i32 %1
} -/
def sub_negative_constant_lhs_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (-2) : i32
    %1 = llvm.sub %0, %a : i32
    llvm.return %1 : i32
  }]

def sub_negative_constant_lhs_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %a1 = "li" () {imm = -2 : !i64} : (!i64) -> (!i64)
    %1 = subw %a1, %a : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def sub_negative_constant_lhs_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := sub_negative_constant_lhs_llvm_i32
  rhs := sub_negative_constant_lhs_riscv_i32
  correct := by
    unfold sub_negative_constant_lhs_llvm_i32 sub_negative_constant_lhs_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @sll(i32 %a, i32 %b) nounwind {
; RV64I-LABEL: sll:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sllw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = shl i32 %a, %b
  ret i32 %1
}-/
def sll_llvm_i32 := [LV| {
  ^entry (%a: i32, %b: i32):
    %0 = llvm.shl %a, %b : i32
    llvm.return %0 : i32
  }]

def sll_riscv_i32 :=
  [LV| {
  ^entry (%arg0: i32, %arg1: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %0 = sllw %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def sll_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := sll_llvm_i32
  rhs := sll_riscv_i32
  correct := by
    unfold sll_llvm_i32 sll_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;
    sorry -- same problem

/- define i32 @sll_negative_constant_lhs(i32 %a) nounwind {
; RV64I-LABEL: sll_negative_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, -1
; RV64I-NEXT:    sllw a0, a1, a0
; RV64I-NEXT:    ret
  %1 = shl i32 -1, %a
  ret i32 %1
}-/
def sll_negative_constant_lhs_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (-1) : i32
    %1 = llvm.shl %0, %a : i32
    llvm.return %1 : i32
  }]

def sll_negative_constant_lhs_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 =  "li" () {imm = -1 : !i64} : (!i64) -> (!i64)
    %1 = sllw %0, %a : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def sll_negative_constant_lhs_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := sll_negative_constant_lhs_llvm_i32
  rhs := sll_negative_constant_lhs_riscv_i32
  correct := by
    unfold sll_negative_constant_lhs_llvm_i32 sll_negative_constant_lhs_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;sorry

/- define i32 @slt(i32 %a, i32 %b) nounwind {
; RV64I-LABEL: slt:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a1, a1
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    slt a0, a0, a1
; RV64I-NEXT:    ret
  %1 = icmp slt i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}-/
def slt_llvm_i32 := [LV| {
  ^entry (%a: i32, %b: i32):
    %0 = llvm.icmp.slt %a, %b : i32
    %1 = llvm.zext %0 : i1 to i32
    llvm.return %1 : i32
  }]

def slt_riscv_i32 :=
  [LV| {
  ^entry (%arg0: i32, %arg1: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %0 = sext.w %a : !i64
    %1 = sext.w %b : !i64
    %2 = slt %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
    llvm.return %3 : i32
  }]

def slt_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := slt_llvm_i32
  rhs := slt_riscv_i32
  correct := by
    unfold slt_llvm_i32 slt_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @sltu(i32 %a, i32 %b) nounwind {
; RV64I-LABEL: sltu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a1, a1
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    sltu a0, a0, a1
; RV64I-NEXT:    ret
  %1 = icmp ult i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}-/
def sltu_llvm_i32 := [LV| {
  ^entry (%a: i32, %b: i32):
    %0 = llvm.icmp.ult %a, %b : i32
    %1 = llvm.zext %0 : i1 to i32
    llvm.return %1 : i32
  }]

def sltu_riscv_i32 :=
  [LV| {
  ^entry (%arg0: i32, %arg1: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %0 = "sext.w" %a : !i64
    %1 = "sext.w" %b : !i64
    %2 = sltu %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
    llvm.return %3 : i32
  }]

def sltu_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := sltu_llvm_i32
  rhs := sltu_riscv_i32
  correct := by
    unfold sltu_llvm_i32 sltu_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @xor(i32 %a, i32 %b) nounwind {
; RV64I-LABEL: xor:
; RV64I:       # %bb.0:
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    ret
  %1 = xor i32 %a, %b
  ret i32 %1
}-/
def xor_llvm_i32 := [LV| {
  ^entry (%a: i32, %b: i32):
    %0 = llvm.xor %a, %b : i32
    llvm.return %0 : i32
  }]

def xor_riscv_i32 :=
  [LV| {
  ^entry (%arg0: i32, %arg1: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %0 = xor %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def xor_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := xor_llvm_i32
  rhs := xor_riscv_i32
  correct := by
    unfold xor_llvm_i32 xor_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @srl(i32 %a, i32 %b) nounwind {
; RV64I-LABEL: srl:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srlw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = lshr i32 %a, %b
  ret i32 %1
}-/
def srl_llvm_i32 := [LV| {
  ^entry (%a: i32, %b: i32):
    %0 = llvm.lshr %a, %b : i32
    llvm.return %0 : i32
  }]

def srl_riscv_i32 :=
  [LV| {
  ^entry (%arg0: i32, %arg1: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %0 = srlw %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def srl_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := srl_llvm_i32
  rhs := srl_riscv_i32
  correct := by
    unfold srl_llvm_i32 srl_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @srl_negative_constant_lhs(i32 %a) nounwind {
; RV64I-LABEL: srl_negative_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, -1
; RV64I-NEXT:    srlw a0, a1, a0
; RV64I-NEXT:    ret
  %1 = lshr i32 -1, %a
  ret i32 %1
}-/
def srl_negative_constant_lhs_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (-1) : i32
    %1 = llvm.lshr %0, %a : i32
    llvm.return %1 : i32
  }]

def srl_negative_constant_lhs_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = "li" () {imm = -1 : !i64} : (!i64) -> (!i64)
    %1 = srlw %0, %a : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def srl_negative_constant_lhs_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := srl_negative_constant_lhs_llvm_i32
  rhs := srl_negative_constant_lhs_riscv_i32
  correct := by
    unfold srl_negative_constant_lhs_llvm_i32 srl_negative_constant_lhs_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @sra(i32 %a, i32 %b) nounwind {
; RV64I-LABEL: sra:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sraw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = ashr i32 %a, %b
  ret i32 %1
}-/
def sra_llvm_i32 := [LV| {
  ^entry (%a: i32, %b: i32):
    %0 = llvm.ashr %a, %b : i32
    llvm.return %0 : i32
  }]

def sra_riscv_i32 :=
  [LV| {
  ^entry (%arg0: i32, %arg1: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %0 = sraw %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def sra_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := sra_llvm_i32
  rhs := sra_riscv_i32
  correct := by
    unfold sra_llvm_i32 sra_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @sra_negative_constant_lhs(i32 %a) nounwind {
; RV64I-LABEL: sra_negative_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    lui a1, 524288
; RV64I-NEXT:    sraw a0, a1, a0
; RV64I-NEXT:    ret
  %1 = ashr i32 2147483648, %a
  ret i32 %1
}-/
def sra_negative_constant_lhs_llvm_i32 := [LV| {
  ^entry (%a: i32):
    %0 = llvm.mlir.constant (2147483648) : i32
    %1 = llvm.ashr %0, %a : i32
    llvm.return %1 : i32
  }]

def sra_negative_constant_lhs_riscv_i32 :=
  [LV| {
  ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %b = li (484394305) : !i64
    %0 = "lui" (%b) {imm = 524288 : !i64} : (!i64) -> (!i64)
    %1 = sraw %0, %a : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def sra_negative_constant_lhs_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := sra_negative_constant_lhs_llvm_i32
  rhs := sra_negative_constant_lhs_riscv_i32
  correct := by
    unfold sra_negative_constant_lhs_llvm_i32 sra_negative_constant_lhs_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;
    sorry

/- define i32 @or(i32 %a, i32 %b) nounwind {
; RV64I-LABEL: or:
; RV64I:       # %bb.0:
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    ret
  %1 = or i32 %a, %b
  ret i32 %1
}-/
def or_llvm_i32 := [LV| {
  ^entry (%a: i32, %b: i32):
    %0 = llvm.or %a, %b : i32
    llvm.return %0 : i32
  }]

def or_riscv_i32 :=
  [LV| {
  ^entry (%arg0: i32, %arg1: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %0 = or %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def or_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := or_llvm_i32
  rhs := or_riscv_i32
  correct := by
    unfold or_llvm_i32 or_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- define i32 @and(i32 %a, i32 %b) nounwind {
; RV64I-LABEL: and:
; RV64I:       # %bb.0:
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    ret
  %1 = and i32 %a, %b
  ret i32 %1
}-/
def and_llvm_i32 := [LV| {
  ^entry (%a: i32, %b: i32):
    %0 = llvm.and %a, %b : i32
    llvm.return %0 : i32
  }]

def and_riscv_i32 :=
  [LV| {
  ^entry (%arg0: i32, %arg1: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %0 = and %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def and_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := and_llvm_i32
  rhs := and_riscv_i32
  correct := by
    unfold and_llvm_i32 and_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
