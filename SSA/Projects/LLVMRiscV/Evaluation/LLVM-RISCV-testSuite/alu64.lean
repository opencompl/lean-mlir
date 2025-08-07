import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open LLVMRiscV
/- define i64 @addi(i64 %a) nounwind {
; RV64I-LABEL: addi:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, 1
; RV64I-NEXT:    ret
  %1 = add i64 %a, 1
  ret i64 %1
}-/
def addi_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (1) : i64
    %1 = llvm.add %a, %0 : i64
    llvm.return %1 : i64
  }]

def addi_riscv_i64 :=
  [LV| {
    ^entry (%arg: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!i64)
    %0 = addi %a, 1 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def addi_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := addi_llvm_i64
  rhs := addi_riscv_i64
  correct := by
    unfold addi_llvm_i64 addi_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;

/- define i64 @slti(i64 %a) nounwind {
; RV64I-LABEL: slti:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slti a0, a0, 2
; RV64I-NEXT:    ret
  %1 = icmp slt i64 %a, 2
  %2 = zext i1 %1 to i64
  ret i64 %2
}-/
def slti_llvm_i64 :=
  [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (2) : i64
    %1 = llvm.icmp.slt %a, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    llvm.return %2 : i64
  }]

def slti_riscv_i64 :=
  [LV| {
    ^entry (%arg: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!i64)
    %1 = slti %a, 2 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i64)
    llvm.return %2 : i64
  }]

def slti_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := slti_llvm_i64
  rhs := slti_riscv_i64
  correct := by
    unfold slti_llvm_i64 slti_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;

/- define i64 @sltiu(i64 %a) nounwind {
; RV64I-LABEL: sltiu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sltiu a0, a0, 3
; RV64I-NEXT:    ret
  %1 = icmp ult i64 %a, 3
  %2 = zext i1 %1 to i64
  ret i64 %2
}-/

def sltiu_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (3) : i64
    %1 = llvm.icmp.ult %a, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    llvm.return %2 : i64
  }]

def sltiu_riscv_i64 :=
  [LV| {
    ^entry (%arg: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!i64)
    %1 = sltiu %a, 3 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i64)
    llvm.return %2 : i64
  }]

def sltiu_i32_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := sltiu_llvm_i64
  rhs := sltiu_riscv_i64
  correct := by
    unfold sltiu_llvm_i64 sltiu_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;


/- define i64 @xori(i64 %a) nounwind {
; RV64I-LABEL: xori:
; RV64I:       # %bb.0:
; RV64I-NEXT:    xori a0, a0, 4
; RV64I-NEXT:    ret

  %1 = xor i64 %a, 4
  ret i64 %1
}-/
def xori_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (4) : i64
    %1 = llvm.xor %a, %0 : i64
    llvm.return %1 : i64
  }]

def xori_riscv_i64 :=
  [LV| {
    ^entry (%arg: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!i64)
    %0 = xori %a, 4 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def xori_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := xori_llvm_i64
  rhs := xori_riscv_i64
  correct := by
    unfold xori_llvm_i64 xori_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;

/- define i64 @ori(i64 %a) nounwind {
; RV64I-LABEL: ori:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ori a0, a0, 5
; RV64I-NEXT:    ret

  %1 = or i64 %a, 5
  ret i64 %1
}-/
def ori_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (5) : i64
    %1 = llvm.or %a, %0 : i64
    llvm.return %1 : i64
  }]

def ori_riscv_i64 :=
  [LV| {
    ^entry (%arg: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!i64)
    %0 = ori %a, 5 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def ori_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := ori_llvm_i64
  rhs := ori_riscv_i64
  correct := by
    unfold ori_llvm_i64 ori_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;

/- define i64 @andi(i64 %a) nounwind {
; RV64I-LABEL: andi:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 6
; RV64I-NEXT:    ret
  %1 = and i64 %a, 6
  ret i64 %1
}-/

def andi_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (6) : i64
    %1 = llvm.and %a, %0 : i64
    llvm.return %1 : i64
  }]

def andi_riscv_i64 :=
  [LV| {
    ^entry (%arg: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!i64)
    %0 = andi %a, 6 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def andi_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := andi_llvm_i64
  rhs := andi_riscv_i64
  correct := by
    unfold andi_llvm_i64 andi_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;

/-define i64 @slli(i64 %a) nounwind {
; RV64I-LABEL: slli:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 7
; RV64I-NEXT:    ret
  %1 = shl i64 %a, 7
  ret i64 %1
}-/

def slli_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (7) : i64
    %1 = llvm.shl %a, %0 : i64
    llvm.return %1 : i64
  }]

def slli_riscv_i64 :=
  [LV| {
    ^entry (%arg: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!i64)
    %0 = slli %a, 7 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def slli_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := slli_llvm_i64
  rhs := slli_riscv_i64
  correct := by
    unfold slli_llvm_i64 slli_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;

/- define i64 @srli(i64 %a) nounwind {
; RV64I-LABEL: srli:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srli a0, a0, 8
; RV64I-NEXT:    ret
;

  %1 = lshr i64 %a, 8
  ret i64 %1
}-/
def srli_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (8) : i64
    %1 = llvm.lshr %a, %0 : i64
    llvm.return %1 : i64
  }]

def srli_riscv_i64 :=
  [LV| {
    ^entry (%arg: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!i64)
    %0 = srli %a, 8 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def srli_i32_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := srli_llvm_i64
  rhs := srli_riscv_i64
  correct := by
    unfold srli_llvm_i64 srli_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;

/- define i64 @srai(i64 %a) nounwind {
; RV64I-LABEL: srai:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srai a0, a0, 9
; RV64I-NEXT:    ret

  %1 = ashr i64 %a, 9
  ret i64 %1
} -/
def srai_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (9) : i64
    %1 = llvm.ashr %a, %0 : i64
    llvm.return %1 : i64
  }]

def srai_riscv_i64 :=
  [LV| {
    ^entry (%arg: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!i64)
    %0 = srai %a, 9 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def srai_i32_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := srai_llvm_i64
  rhs := srai_riscv_i64
  correct := by
    unfold srai_llvm_i64 srai_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;

/- define i64 @add(i64 %a, i64 %b) nounwind {
; RV64I-LABEL: add:
; RV64I:       # %bb.0:
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret

  %1 = add i64 %a, %b
  ret i64 %1
}-/
def add_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.add %a, %b : i64
    llvm.return %0 : i64
  }]

def add_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64, %arg1: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %0 = add %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def add_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := add_llvm_i64
  rhs := add_riscv_i64
  correct := by
    unfold add_llvm_i64 add_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;

/- define i64 @sub(i64 %a, i64 %b) nounwind {
; RV64I-LABEL: sub:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sub a0, a0, a1
; RV64I-NEXT:    ret
;
  %1 = sub i64 %a, %b
  ret i64 %1
}-/
def sub_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.sub %a, %b : i64
    llvm.return %0 : i64
  }]

def sub_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64, %arg1: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %0 = sub %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def sub_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := sub_llvm_i64
  rhs := sub_riscv_i64
  correct := by
    unfold sub_llvm_i64 sub_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;
/-
define i64 @sll(i64 %a, i64 %b) nounwind {
; RV64I-LABEL: sll:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sll a0, a0, a1
; RV64I-NEXT:    ret

  %1 = shl i64 %a, %b
  ret i64 %1
}
-/
def sll_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.shl %a, %b : i64
    llvm.return %0 : i64
  }]

def sll_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64, %arg1: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %0 = sllw %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def sll_i32_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := sll_llvm_i64
  rhs := sll_riscv_i64
  correct := by
    unfold sll_llvm_i64 sll_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;
    sorry -- same problem

/-
define i64 @slt(i64 %a, i64 %b) nounwind {
; RV64I-LABEL: slt:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slt a0, a0, a1
; RV64I-NEXT:    ret

  %1 = icmp slt i64 %a, %b
  %2 = zext i1 %1 to i64
  ret i64 %2
}
-/
def slt_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.icmp.slt %a, %b : i64
    %1 = llvm.zext %0 : i1 to i64
    llvm.return %1 : i64
  }]

def slt_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64, %arg1: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %2 = slt %a, %b : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def slt_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := slt_llvm_i64
  rhs := slt_riscv_i64
  correct := by
    unfold slt_llvm_i64 slt_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;
/-
define i64 @sltu(i64 %a, i64 %b) nounwind {
; RV64I-LABEL: sltu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sltu a0, a0, a1
; RV64I-NEXT:    ret
;
  %1 = icmp ult i64 %a, %b
  %2 = zext i1 %1 to i64
  ret i64 %2
}
-/
def sltu_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.icmp.ult %a, %b : i64
    %1 = llvm.zext %0 : i1 to i64
    llvm.return %1 : i64
  }]

def sltu_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64, %arg1: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %2 = sltu %a, %b : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def sltu_i32_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := sltu_llvm_i64
  rhs := sltu_riscv_i64
  correct := by
    unfold sltu_llvm_i64 sltu_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;
/-
define i64 @xor(i64 %a, i64 %b) nounwind {
; RV64I-LABEL: xor:
; RV64I:       # %bb.0:
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    ret
  %1 = xor i64 %a, %b
  ret i64 %1
}

-/
def xor_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.xor %a, %b : i64
    llvm.return %0 : i64
  }]

def xor_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64, %arg1: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %0 = xor %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def xor_i32_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := xor_llvm_i64
  rhs := xor_riscv_i64
  correct := by
    unfold xor_llvm_i64 xor_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
/-
define i64 @srl(i64 %a, i64 %b) nounwind {
; RV64I-LABEL: srl:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srl a0, a0, a1
; RV64I-NEXT:    ret
  %1 = lshr i64 %a, %b
  ret i64 %1
}
-/
def srl_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.lshr %a, %b : i64
    llvm.return %0 : i64
  }]

def srl_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64, %arg1: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %0 = srl %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def srl_i32_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := srl_llvm_i64
  rhs := srl_riscv_i64
  correct := by
    unfold srl_llvm_i64 srl_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
/-
define i64 @sra(i64 %a, i64 %b) nounwind {
; RV64I-LABEL: sra:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sra a0, a0, a1
; RV64I-NEXT:    ret

  %1 = ashr i64 %a, %b
  ret i64 %1
}-/
def sra_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.ashr %a, %b : i64
    llvm.return %0 : i64
  }]

def sra_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64, %arg1: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %0 = sra %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def sra_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := sra_llvm_i64
  rhs := sra_riscv_i64
  correct := by
    unfold sra_llvm_i64 sra_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
/-
define i64 @or(i64 %a, i64 %b) nounwind {
; RV64I-LABEL: or:
; RV64I:       # %bb.0:
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    ret

  %1 = or i64 %a, %b
  ret i64 %1
}
-/
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
/-
define i64 @and(i64 %a, i64 %b) nounwind {
; RV64I-LABEL: and:
; RV64I:       # %bb.0:
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    ret

  %1 = and i64 %a, %b
  ret i64 %1
}
-/

def and_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.and %a, %b : i64
    llvm.return %0 : i64
  }]

def and_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64, %arg1: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %0 = and %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def and_i32_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := and_llvm_i64
  rhs := and_riscv_i64
  correct := by
    unfold and_llvm_i64 and_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
/-
define signext i32 @addiw(i32 signext %a) nounwind {
; RV64I-LABEL: addiw:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addiw a0, a0, 123
; RV64I-NEXT:    ret
;
  %1 = add i32 %a, 123
  ret i32 %1
}
-/

/-
define signext i32 @slliw(i32 signext %a) nounwind {
; RV64I-LABEL: slliw:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slliw a0, a0, 17
; RV64I-NEXT:    ret
  %1 = shl i32 %a, 17
  ret i32 %1
}
-/

/-
define signext i32 @srliw(i32 %a) nounwind {
; RV64I-LABEL: srliw:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srliw a0, a0, 8
; RV64I-NEXT:    ret
  %1 = lshr i32 %a, 8
  ret i32 %1
}-/

/-
define signext i32 @sraiw(i32 %a) nounwind {
; RV64I-LABEL: sraiw:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sraiw a0, a0, 9
; RV64I-NEXT:    ret
;
  %1 = ashr i32 %a, 9
  ret i32 %1
}
-/

/-
define i64 @sraiw_i64(i64 %a) nounwind {
; RV64I-LABEL: sraiw_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sraiw a0, a0, 9
; RV64I-NEXT:    ret

  %1 = shl i64 %a, 32
  %2 = ashr i64 %1, 41
  ret i64 %2
}
-/

/-
define signext i32 @sextw(i32 zeroext %a) nounwind {
; RV64I-LABEL: sextw:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    ret

  ret i32 %a
}
-/

/-
define signext i32 @addw(i32 signext %a, i32 signext %b) nounwind {
; RV64I-LABEL: addw:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = add i32 %a, %b
  ret i32 %1
}

-/

/-
define signext i32 @subw(i32 signext %a, i32 signext %b) nounwind {
; RV64I-LABEL: subw:
; RV64I:       # %bb.0:
; RV64I-NEXT:    subw a0, a0, a1
; RV64I-NEXT:    ret

  %1 = sub i32 %a, %b
  ret i32 %1
}
-/

/-
define signext i32 @sllw(i32 signext %a, i32 zeroext %b) nounwind {
; RV64I-LABEL: sllw:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sllw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = shl i32 %a, %b
  ret i32 %1
}
-/

/-
define signext i32 @srlw(i32 signext %a, i32 zeroext %b) nounwind {
; RV64I-LABEL: srlw:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srlw a0, a0, a1
; RV64I-NEXT:    ret

  %1 = lshr i32 %a, %b
  ret i32 %1
}
-/

/-
define signext i32 @sraw(i64 %a, i32 zeroext %b) nounwind {
; RV64I-LABEL: sraw:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sraw a0, a0, a1
; RV64I-NEXT:    ret

  %1 = trunc i64 %a to i32
  %2 = ashr i32 %1, %b
  ret i32 %2
}
-/

/-
define i64 @add_hi_and_lo_negone(i64 %0) {
; RV64I-LABEL: add_hi_and_lo_negone:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    ret

  %2 = add nsw i64 %0, -1
  ret i64 %2
}
-/

/-
define i64 @add_hi_zero_lo_negone(i64 %0) {
; RV64I-LABEL: add_hi_zero_lo_negone:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, -1
; RV64I-NEXT:    srli a1, a1, 32
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret

  %2 = add i64 %0, 4294967295
  ret i64 %2
}
-/

/-
define i64 @add_lo_negone(i64 %0) {
; RV64I-LABEL: add_lo_negone:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, -1
; RV64I-NEXT:    slli a1, a1, 32
; RV64I-NEXT:    addi a1, a1, -1
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
  %2 = add nsw i64 %0, -4294967297
  ret i64 %2
}
-/

/-
define i64 @add_hi_one_lo_negone(i64 %0) {
; RV64I-LABEL: add_hi_one_lo_negone:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, -1
; RV64I-NEXT:    srli a1, a1, 31
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
  %2 = add nsw i64 %0, 8589934591
  ret i64 %2
}
-/
def add_hi_one_lo_negone_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %c = llvm.mlir.constant (8589934591) : i64
    %0 = llvm.add nsw %a, %c : i64
    llvm.return %0 : i64
  }]

def add_hi_one_lo_negone_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %0 = and %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def add_hi_one_lo_negone_i32_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_hi_one_lo_negone_llvm_i64
  rhs := add_hi_one_lo_negone_riscv_i64
  correct := by
    unfold add_hi_one_lo_negone_llvm_i64 add_hi_one_lo_negone_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
