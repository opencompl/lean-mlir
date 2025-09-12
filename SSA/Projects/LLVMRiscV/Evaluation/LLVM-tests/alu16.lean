import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering


open LLVMRiscV

/-!
  This file implements the `alu16.ll` test case in the LLVM test suite:
  https://github.com/llvm/llvm-project/blob/b424207cdddfa2cbfc9129bbe0a31e47cb04e6dc/llvm/test/CodeGen/RISCV/alu16.ll
-/


/-- ### addi -/
@[simp_denote]
def addi_llvm := [LV| {
    ^entry (%a: i16):
    %0 = llvm.mlir.constant (1) : i16
    %1 = llvm.add %a, %0 : i16
    llvm.return %1 :i16
  }]

@[simp_denote]
def addi_riscv :=
  [LV| {
    ^entry (%arg: i16):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i16) -> (!i64)
    %0 = addi %a, 1 : !i64
    %1 =  "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def addi_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16)] where
  lhs := addi_llvm
  rhs := addi_riscv
<<<<<<< HEAD


/-- ### slti -/
@[simp_denote]
=======
  correct := by
    unfold addi_riscv addi_llvm
    simp_lowering
    bv_decide

/- # 2 -/
/-
; RV64I-LABEL: slti:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:    slti a0, a0, 2
; RV64I-NEXT:    ret
  %1 = icmp slt i16 %a, 2
  %2 = zext i1 %1 to i16
  ret i16 %2
}
-/
>>>>>>> faa6cc524 (first eval run)
def slti_llvm := [LV| {
    ^entry (%a: i16):
    %0 = llvm.mlir.constant (2) : i16
    %1 = llvm.icmp.slt %a, %0 : i16
    %2 = llvm.zext %1: i1 to i16
    llvm.return %2 :i16
  }]

@[simp_denote]
def slti_riscv :=
  [LV| {
    ^entry (%arg: i16):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i16) -> (!i64)
    %0 = slli %a, 48 : !i64
    %1 = srai %0, 48 : !i64
    %2 = slti %1, 2 : !i64
    %3 =  "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i16)
    llvm.return %3 :i16
  }]

def slti_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16)] where
  lhs := slti_llvm
  rhs := slti_riscv

<<<<<<< HEAD
<<<<<<< HEAD

/-- ### sltiu -/
@[simp_denote]
=======
=======
>>>>>>> sarah-eval
/- # 3 -/
/-
; RV64I-LABEL: sltiu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srli a0, a0, 48
; RV64I-NEXT:    sltiu a0, a0, 3
; RV64I-NEXT:    ret
  %1 = icmp ult i16 %a, 3
  %2 = zext i1 %1 to i16
  ret i16 %2
}
-/
>>>>>>> faa6cc524 (first eval run)
def sltiu_llvm := [LV| {
    ^entry (%a: i16):
    %0 = llvm.mlir.constant (3) : i16
    %1 = llvm.icmp.ult %a, %0 : i16
    %2 = llvm.zext %1: i1 to i16
    llvm.return %2 :i16
  }]

@[simp_denote]
def sltiu_riscv :=
  [LV| {
    ^entry (%arg: i16):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i16) -> (!i64)
    %0 = slli %a, 48 : !i64
    %1 = srli %0, 48 : !i64
    %2 = sltiu %1, 3 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i16)
    llvm.return %3 :i16
  }]

def sltiu_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16)] where
  lhs := sltiu_llvm
  rhs := sltiu_riscv
<<<<<<< HEAD


/-- ### sltiu_signext -/
@[simp_denote]
=======
  correct := by
    unfold sltiu_llvm sltiu_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- # 4 -/
/-
; Make sure we avoid an AND, if the input of an unsigned compare is known
; to be sign extended. This can occur due to InstCombine canonicalizing
; x s>= 0 && x s< 10 to x u< 10.
define i16 @sltiu_signext(i16 signext %a) nounwind {
; RV64I-LABEL: sltiu_signext:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sltiu a0, a0, 10
; RV64I-NEXT:    ret
  %1 = icmp ult i16 %a, 10
  %2 = zext i1 %1 to i16
  ret i16 %2
}
-/
>>>>>>> faa6cc524 (first eval run)
def sltiu_signext_llvm := [LV| {
    ^entry (%a: i16):
    %0 = llvm.mlir.constant (10) : i16
    %1 = llvm.icmp.ult %a, %0 : i16
    %2 = llvm.zext %1: i1 to i16
    llvm.return %2 :i16
  }]

@[simp_denote]
def sltiu_signext_riscv :=
  [LV| {
    ^entry (%arg: i16):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i16) -> (!i64)
    %0 = sltiu %a, 10 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def sltiu_signext_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16)] where
  lhs := sltiu_signext_llvm
  rhs := sltiu_signext_riscv
<<<<<<< HEAD


/-- ### xori -/
@[simp_denote]
=======
  correct := by
    unfold sltiu_signext_llvm sltiu_signext_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- # 5 -/
/-
define i16 @xori(i16 %a) nounwind {
; RV64I-LABEL: xori:
; RV64I:       # %bb.0:
; RV64I-NEXT:    xori a0, a0, 4
; RV64I-NEXT:    ret
  %1 = xor i16 %a, 4
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def xori_llvm := [LV| {
    ^entry (%a: i16):
    %0 = llvm.mlir.constant (4) : i16
    %1 = llvm.xor %a, %0 : i16
    llvm.return %1 :i16
  }]

@[simp_denote]
def xori_riscv :=
  [LV| {
    ^entry (%arg: i16):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i16) -> (!i64)
    %0 =xori %a, 4 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def xori_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16)] where
  lhs := xori_llvm
  rhs := xori_riscv
<<<<<<< HEAD


/-- ### ori -/
@[simp_denote]
=======
  correct := by
    unfold xori_llvm xori_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- # 6 -/
/-
define i16 @ori(i16 %a) nounwind {
; RV64I-LABEL: ori:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ori a0, a0, 5
; RV64I-NEXT:    ret
  %1 = or i16 %a, 5
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def ori_llvm := [LV| {
    ^entry (%a: i16):
    %0 = llvm.mlir.constant (5) : i16
    %1 = llvm.or %a, %0 : i16
    llvm.return %1 :i16
  }]

@[simp_denote]
def ori_riscv :=
  [LV| {
    ^entry (%arg: i16):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i16) -> (!i64)
    %0 =ori %a, 5 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def ori_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16)] where
  lhs := ori_llvm
  rhs := ori_riscv
<<<<<<< HEAD


/-- ### andi -/
@[simp_denote]
=======
  correct := by
    unfold ori_llvm ori_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- # 7 -/
/-
define i16 @andi(i16 %a) nounwind {
; RV64I-LABEL: andi:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 6
; RV64I-NEXT:    ret
  %1 = and i16 %a, 6
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def andi_llvm := [LV| {
    ^entry (%a: i16):
    %0 = llvm.mlir.constant (6) : i16
    %1 = llvm.and %a, %0 : i16
    llvm.return %1 :i16
  }]

@[simp_denote]
def andi_riscv :=
  [LV| {
    ^entry (%arg: i16):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i16) -> (!i64)
    %0 =andi %a, 6 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def andi_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16)] where
  lhs := andi_llvm
  rhs := andi_riscv
<<<<<<< HEAD


/-- ### slli -/
@[simp_denote]
=======
  correct := by
    unfold andi_llvm andi_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- # 8 -/
/-
define i16 @slli(i16 %a) nounwind {
; RV64I-LABEL: slli:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 7
; RV64I-NEXT:    ret
  %1 = shl i16 %a, 7
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def slli_llvm := [LV| {
    ^entry (%a: i16):
    %0 = llvm.mlir.constant (7) : i16
    %1 = llvm.shl %a, %0 : i16
    llvm.return %1 :i16
  }]

@[simp_denote]
def slli_riscv :=
  [LV| {
    ^entry (%arg: i16):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i16) -> (!i64)
    %0 =slli %a, 7 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def slli_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16)] where
  lhs := slli_llvm
  rhs := slli_riscv
<<<<<<< HEAD


/-- ### srli -/
@[simp_denote]
=======
  correct := by
    unfold slli_llvm slli_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- # 9 -/
/-
define i16 @srli(i16 %a) nounwind {
; RV64I-LABEL: srli:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srli a0, a0, 54
; RV64I-NEXT:    ret
  %1 = lshr i16 %a, 6
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def srli_llvm := [LV| {
    ^entry (%a: i16):
    %0 = llvm.mlir.constant (6) : i16
    %1 = llvm.lshr %a, %0 : i16
    llvm.return %1 :i16
  }]

@[simp_denote]
def srli_riscv :=
  [LV| {
    ^entry (%arg: i16):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i16) -> (!i64)
    %0 =slli %a, 48 : !i64
    %1 =srli %0, 54 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i16)
    llvm.return %2 :i16
  }]

def srli_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16)] where
  lhs := srli_llvm
  rhs := srli_riscv
<<<<<<< HEAD


/-- ### srai -/
@[simp_denote]
=======
  correct := by
    unfold srli_llvm srli_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- # 10 -/
/-
define i16 @srai(i16 %a) nounwind {
; RV64I-LABEL: srai:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 57
; RV64I-NEXT:    ret
  %1 = ashr i16 %a, 9
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def srai_llvm := [LV| {
    ^entry (%a: i16):
    %0 = llvm.mlir.constant (9) : i16
    %1 = llvm.ashr %a, %0 : i16
    llvm.return %1 :i16
  }]

@[simp_denote]
def srai_riscv :=
  [LV| {
    ^entry (%arg: i16):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i16) -> (!i64)
    %0 =slli %a, 48 : !i64
    %1 =srai %0, 57 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i16)
    llvm.return %2 :i16
  }]

def srai_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16)] where
  lhs := srai_llvm
  rhs := srai_riscv
<<<<<<< HEAD


/-- ### add -/
@[simp_denote]
=======
  correct := by
    unfold srai_llvm srai_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- # 11 -/
/-
define i16 @add(i16 %a, i16 %b) nounwind {
; RV64I-LABEL: add:
; RV64I:       # %bb.0:
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
  %1 = add i16 %a, %b
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def add_llvm_i16:= [LV| {
    ^entry (%a: i16,%b: i16 ):
    %0 = llvm.add %a, %b : i16
    llvm.return %0 :i16
  }]

@[simp_denote]
def add_riscv_i16 :=
  [LV| {
    ^entry (%arg0: i16, %arg1: i16 ):
    %a =  "builtin.unrealized_conversion_cast" (%arg0) : (i16) -> (!i64)
    %b =  "builtin.unrealized_conversion_cast" (%arg1) : (i16) -> (!i64)
    %0 =add %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def add_i16_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16) ] where
  lhs := add_llvm_i16
  rhs := add_riscv_i16
<<<<<<< HEAD


/-- ### sub -/
@[simp_denote]
=======
  correct := by
    unfold add_llvm_i16 add_riscv_i16
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- # 12 -/
/-
define i16 @sub(i16 %a, i16 %b) nounwind {
; RV64I-LABEL: sub:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sub a0, a0, a1
; RV64I-NEXT:    ret
  %1 = sub i16 %a, %b
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def sub_llvm_i16:= [LV| {
    ^entry (%a: i16,%b: i16 ):
    %0 = llvm.sub %a, %b : i16
    llvm.return %0 :i16
  }]

@[simp_denote]
def sub_riscv_i16 :=
  [LV| {
    ^entry (%arg0: i16, %arg1: i16 ):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i16) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i16) -> (!i64)
    %0 =sub %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def sub_i16_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16) ] where
  lhs := sub_llvm_i16
  rhs := sub_riscv_i16
  correct := by
    unfold sub_llvm_i16 sub_riscv_i16
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

<<<<<<< HEAD
<<<<<<< HEAD

/-- ### sll -/
@[simp_denote]
=======
=======
>>>>>>> sarah-eval
/- # 12 -/
/-
define i16 @sll(i16 %a, i16 %b) nounwind {
; RV64I-LABEL: sll:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sll a0, a0, a1
; RV64I-NEXT:    ret
  %1 = shl i16 %a, %b
  ret i16 %1
}-/
>>>>>>> faa6cc524 (first eval run)
def sll_llvm_i16:= [LV| {
    ^entry (%a: i16,%b: i16 ):
    %0 = llvm.shl %a, %b : i16
    llvm.return %0 :i16
  }]

@[simp_denote]
def sll_riscv_i16 :=
  [LV| {
    ^entry (%arg0: i16, %arg1: i16 ):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i16) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i16) -> (!i64)
    %0 =sll %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def sll_i16_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16) ] where
  lhs := sll_llvm_i16
  rhs := sll_riscv_i16
  correct := by
    unfold sll_llvm_i16 sll_riscv_i16
    simp_lowering
    bv_decide

<<<<<<< HEAD
<<<<<<< HEAD

/-- ### slt -/
@[simp_denote]
=======
=======
>>>>>>> sarah-eval
/- # 13 -/
/-
define i16 @slt(i16 %a, i16 %b) nounwind {
; RV64I-LABEL: slt:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a1, a1, 48
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a1, a1, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:    slt a0, a0, a1
; RV64I-NEXT:    ret
  %1 = icmp slt i16 %a, %b
  %2 = zext i1 %1 to i16
  ret i16 %2
}
-/
>>>>>>> faa6cc524 (first eval run)
def slt_llvm := [LV| {
    ^entry (%a: i16, %b: i16 ):
    %0 = llvm.icmp.slt %a, %b : i16
    %1 = llvm.zext %0: i1 to i16
    llvm.return %1 :i16
  }]

@[simp_denote]
def slt_riscv :=
  [LV| {
    ^entry (%arg0: i16, %arg1: i16 ):
    %a0 =  "builtin.unrealized_conversion_cast" (%arg0) : (i16) -> (!i64)
    %a1 =  "builtin.unrealized_conversion_cast" (%arg1) : (i16) -> (!i64)
    %0 = slli %a1, 48 : !i64
    %1 = slli %a0, 48 : !i64
    %2 = srai %1, 48 : !i64
    %3 = srai %0, 48 : !i64
    %4 = slt %2, %3 : !i64
    %5 = "builtin.unrealized_conversion_cast" (%4) : (!i64) -> (i16)
    llvm.return %5 :i16
  }]

def slt_signext_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16) ] where
  lhs := slt_llvm
  rhs := slt_riscv

<<<<<<< HEAD
<<<<<<< HEAD

/-- ### sltu -/
@[simp_denote]
=======
=======
>>>>>>> sarah-eval
/- # 14 -/
/-
define i16 @sltu(i16 %a, i16 %b) nounwind {
; RV64I-LABEL: sltu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    lui a2, 16
; RV64I-NEXT:    addi a2, a2, -1
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    sltu a0, a0, a1
; RV64I-NEXT:    ret
  %1 = icmp ult i16 %a, %b
  %2 = zext i1 %1 to i16
  ret i16 %2
}
-/
>>>>>>> faa6cc524 (first eval run)
def sltu_llvm := [LV| {
    ^entry (%a: i16, %b: i16 ):
    %0 = llvm.icmp.ult %a, %b : i16
    %1 = llvm.zext %0: i1 to i16
    llvm.return %1 :i16
  }]

@[simp_denote]
def sltu_riscv :=
  [LV| {
    ^entry (%arg0: i16, %arg1: i16):
    %a0 = "builtin.unrealized_conversion_cast" (%arg0) : (i16) -> (!i64)
    %a1 = "builtin.unrealized_conversion_cast" (%arg1) : (i16) -> (!i64)
    %0 = li (149595403036) : !i64 -- random value bc reg can hold anything
    %1 = "lui" (%0) {imm = 16 : !i64} : (!i64) -> (!i64)
    %2 = "addi" (%1) {imm = -1 : !i64} : (!i64) -> (!i64)
    %3 = and %2, %a1 : !i64
    %4 = and %2, %a0 : !i64
    %5 = sltu %4, %3 : !i64
    %6 = "builtin.unrealized_conversion_cast" (%5) : (!i64) -> (i16)
    llvm.return %6 :i16
  }]

def sltu_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16) ] where
  lhs := sltu_llvm
  rhs := sltu_riscv
<<<<<<< HEAD


/-- ### xor -/
@[simp_denote]
=======
  correct := by
    unfold sltu_llvm sltu_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- # 15 -/
/-
define i16 @xor(i16 %a, i16 %b) nounwind {
; RV64I-LABEL: xor:
; RV64I:       # %bb.0:
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    ret
  %1 = xor i16 %a, %b
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def xor_llvm_i16:= [LV| {
    ^entry (%a: i16,%b: i16 ):
    %0 = llvm.xor %a, %b : i16
    llvm.return %0 :i16
  }]

@[simp_denote]
def xor_riscv_i16 :=
  [LV| {
    ^entry (%arg0: i16, %arg1: i16 ):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i16) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i16) -> (!i64)
    %0 = xor %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def xor_i16_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16) ] where
  lhs := xor_llvm_i16
  rhs := xor_riscv_i16
<<<<<<< HEAD


/-- ### srl -/
@[simp_denote]
=======
  correct := by
    unfold xor_llvm_i16 xor_riscv_i16
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/- # 16 -/
/-
define i16 @srl(i16 %a, i16 %b) nounwind {
; RV64I-LABEL: srl:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srli a0, a0, 48
; RV64I-NEXT:    srl a0, a0, a1
; RV64I-NEXT:    ret
  %1 = lshr i16 %a, %b
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def srl_llvm_i16 := [LV| {
    ^entry (%a: i16, %b: i16 ):
    %0 = llvm.lshr %a, %b : i16
    llvm.return %0 :i16
  }]

@[simp_denote]
def srl_riscv_i16 :=
  [LV| {
    ^entry (%arg0: i16, %arg1: i16):
    %a0 = "builtin.unrealized_conversion_cast" (%arg0) : (i16) -> (!i64)
    %a1 = "builtin.unrealized_conversion_cast" (%arg1) : (i16) -> (!i64)
    %0 = slli %a0, 48 : !i64
    %1 = srli %0, 48 : !i64
    %2 = srl %1, %a1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i16)
    llvm.return %3 :i16
  }]

def srl_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16) ] where
  lhs := srl_llvm_i16
  rhs := srl_riscv_i16
<<<<<<< HEAD


/-- ### sra -/
@[simp_denote]
=======
  correct := by
    unfold srl_llvm_i16 srl_riscv_i16
    simp_lowering
    bv_decide

/- # 17 -/
/-
define i16 @sra(i16 %a, i16 %b) nounwind {
; RV64I-LABEL: sra:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:    sra a0, a0, a1
; RV64I-NEXT:    ret
  %1 = ashr i16 %a, %b
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def sra_llvm_i16 := [LV| {
    ^entry (%a: i16, %b: i16 ):
    %0 = llvm.ashr %a, %b : i16
    llvm.return %0 :i16
  }]

@[simp_denote]
def sra_riscv_i16 :=
  [LV| {
    ^entry (%arg0: i16, %arg1: i16):
    %a0 = "builtin.unrealized_conversion_cast" (%arg0) : (i16) -> (!i64)
    %a1 = "builtin.unrealized_conversion_cast" (%arg1) : (i16) -> (!i64)
    %0 = slli %a0, 48 : !i64
    %1 = srai %0, 48 : !i64
    %2 = sra %1, %a1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i16)
    llvm.return %3 :i16
  }]

def sra_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16) ] where
  lhs := sra_llvm_i16
  rhs := sra_riscv_i16
<<<<<<< HEAD


/-- ### or -/
@[simp_denote]
=======
  correct := by
    unfold sra_llvm_i16 sra_riscv_i16
    simp_lowering
    bv_decide

/- # 18 -/
/-
define i16 @or(i16 %a, i16 %b) nounwind {
; RV64I-LABEL: or:
; RV64I:       # %bb.0:
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    ret
  %1 = or i16 %a, %b
  ret i16 %1
}
-/
>>>>>>> faa6cc524 (first eval run)
def or_llvm_i16:= [LV| {
    ^entry (%a: i16,%b: i16 ):
    %0 = llvm.or %a, %b : i16
    llvm.return %0 :i16
  }]

@[simp_denote]
def or_riscv_i16 :=
  [LV| {
    ^entry (%arg0: i16, %arg1: i16 ):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i16) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i16) -> (!i64)
    %0 = or %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def or_i16_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16) ] where
  lhs := or_llvm_i16
  rhs := or_riscv_i16

<<<<<<< HEAD
<<<<<<< HEAD

/-- ### and -/
@[simp_denote]
=======
=======
>>>>>>> sarah-eval
/- # 19 -/
/-define i16 @and(i16 %a, i16 %b) nounwind {
; RV64I-LABEL: and:
; RV64I:       # %bb.0:
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    ret
  %1 = and i16 %a, %b
  ret i16 %1
}-/
>>>>>>> faa6cc524 (first eval run)
def and_llvm_i16:= [LV| {
    ^entry (%a: i16,%b: i16 ):
    %0 = llvm.and %a, %b : i16
    llvm.return %0 :i16
  }]

@[simp_denote]
def and_riscv_i16 :=
  [LV| {
    ^entry (%arg0: i16, %arg1: i16 ):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i16) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i16) -> (!i64)
    %0 = and %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 :i16
  }]

def and_i16_test: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16) ] where
  lhs := and_llvm_i16
  rhs := and_riscv_i16
