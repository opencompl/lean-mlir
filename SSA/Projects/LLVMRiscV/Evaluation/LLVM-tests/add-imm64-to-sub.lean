import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open LLVMRiscV
/-
define i64 @add_b31(i64 %x) {
; NOZBS-LABEL: add_b31:
; NOZBS:       # %bb.0:
; NOZBS-NEXT:    lui a1, 524288
; NOZBS-NEXT:    sub a0, a0, a1
; NOZBS-NEXT:    ret
;
; ZBS-LABEL: add_b31:
; ZBS:       # %bb.0:
; ZBS-NEXT:    bseti a1, zero, 31
; ZBS-NEXT:    add a0, a0, a1
; ZBS-NEXT:    ret
  %add = add i64 %x, 2147483648
  ret i64 %add
}
-/
-- add_b31
def add_b31_llvm_i64 := [LV| {
  ^entry (%x: i64):
    %0 = llvm.mlir.constant (2147483648) : i64
    %1 = llvm.add %x, %0 : i64
    llvm.return %1 : i64
  }]

def add_b31_riscv_i64 :=
  [LV| {
  ^entry (%x: i64):
    %random = li (574385585755) : !i64
    %0 = "lui" (%random) {imm = 524288 : !i64} : (!i64) -> (!i64)
    %a0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
    %1 = sub %a0, %0 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i64)
    llvm.return %2 : i64
  }]

def add_b31_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_b31_llvm_i64
  rhs := add_b31_riscv_i64
  correct := by
    unfold add_b31_llvm_i64 add_b31_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
/-
define i64 @add_b32(i64 %x) {
; NOZBS-LABEL: add_b32:
; NOZBS:       # %bb.0:
; NOZBS-NEXT:    li a1, -1
; NOZBS-NEXT:    slli a1, a1, 32
; NOZBS-NEXT:    add a0, a0, a1
; NOZBS-NEXT:    ret
;
; ZBS-LABEL: add_b32:
; ZBS:       # %bb.0:
; ZBS-NEXT:    bseti a1, zero, 32
; ZBS-NEXT:    sub a0, a0, a1
; ZBS-NEXT:    ret
  %add = add i64 %x, -4294967296
  ret i64 %add
}
-/
-- add_b32
def add_b32_llvm_i64 := [LV| {
  ^entry (%x: i64):
    %0 = llvm.mlir.constant (-4294967296) : i64
    %1 = llvm.add %x, %0 : i64
    llvm.return %1 : i64
  }]

def add_b32_riscv_i64_no_ZBS :=
  [LV| {
  ^entry (%x: i64):
    %0 ="li"() {imm = -1 : !i64} : (!i64) -> (!i64)
    %1 = slli %0, 32 : !i64
    %a0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
    %2 = add %a0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def add_b32_riscv_i64_ZBS :=
  [LV| {
  ^entry (%x: i64):
    %zero ="li"() {imm = 0 : !i64} : (!i64) -> (!i64)
    %a1 = bseti %zero, 32 : !i64
    %a0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
    %0 = sub %a0, %a1 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def add_b32_test_no_ZBS : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_b32_llvm_i64
  rhs := add_b32_riscv_i64_no_ZBS
  correct := by
    unfold add_b32_llvm_i64 add_b32_riscv_i64_no_ZBS
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;

def add_b32_test_ZBS : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_b32_llvm_i64
  rhs := add_b32_riscv_i64_ZBS
  correct := by
    unfold add_b32_llvm_i64 add_b32_riscv_i64_ZBS
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide

/-
define i64 @sub_0xffffffffff(i64 %x) {
; CHECK-LABEL: sub_0xffffffffff:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, -1
; CHECK-NEXT:    srli a1, a1, 24
; CHECK-NEXT:    sub a0, a0, a1
; CHECK-NEXT:    ret
  %sub = sub i64 %x, 1099511627775
  ret i64 %sub
}
-/
-- sub_0xffffffffff
def sub_0xffffffffff_llvm_i64 := [LV| {
  ^entry (%x: i64):
    %0 = llvm.mlir.constant (1099511627775) : i64
    %1 = llvm.sub %x, %0 : i64
    llvm.return %1 : i64
  }]

def sub_0xffffffffff_riscv_i64 :=
  [LV| {
  ^entry (%x: i64):
    %0 = "li"() {imm = -1 : !i64} : (!i64) -> (!i64)
    %1 = srli %0, 24 : !i64
    %a0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
    %2 = sub %a0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def sub_0xffffffffff_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := sub_0xffffffffff_llvm_i64
  rhs :=  sub_0xffffffffff_riscv_i64
  correct := by
    unfold sub_0xffffffffff_llvm_i64  sub_0xffffffffff_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp;
/-
define i64 @add_multiuse(i64 %x) {
; CHECK-LABEL: add_multiuse:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, -1
; CHECK-NEXT:    slli a1, a1, 40
; CHECK-NEXT:    addi a1, a1, 1
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    and a0, a0, a1
; CHECK-NEXT:    ret
  %add = add i64 %x, -1099511627775
  %and = and i64 %add, -1099511627775
  ret i64 %and
}
-/
-- add_multiuse
def add_multiuse_llvm_i64 := [LV| {
  ^entry (%x: i64):
    %0 = llvm.mlir.constant (-1099511627775) : i64
    %1 = llvm.add %x, %0 : i64
    %2 = llvm.and %1, %0 : i64
    llvm.return %2 : i64
  }]

def add_multiuse_riscv_i64 :=
  [LV| {
  ^entry (%x: i64):
    %0 = "li"() {imm = -1 : !i64} : (!i64) -> (!i64)
    %1 = slli %0, 40 : !i64
    %2 = addi %1, 1 : !i64
    %a0  = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
    %3 = add %a0, %2 : !i64
    %4 = and %3, %2 : !i64
    %5 = "builtin.unrealized_conversion_cast" (%4) : (!i64) -> (i64)
    llvm.return %5 : i64
  }]

def add_multiuse_riscv_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_multiuse_llvm_i64
  rhs :=  add_multiuse_riscv_i64
  correct := by
    unfold add_multiuse_llvm_i64  add_multiuse_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
/-
define i64 @add_multiuse_const(i64 %x, i64 %y) {
; CHECK-LABEL: add_multiuse_const:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, -1
; CHECK-NEXT:    srli a2, a2, 24
; CHECK-NEXT:    sub a0, a0, a2
; CHECK-NEXT:    sub a1, a1, a2
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    ret
  %a = add i64 %x, -1099511627775
  %b = add i64 %y, -1099511627775
  %xor = xor i64 %a, %b
  ret i64 %xor
}-/
-- add_multiuse_const
def add_multiuse_const_llvm_i64 := [LV| {
  ^entry (%x: i64, %y: i64):
    %0 = llvm.mlir.constant (-1099511627775) : i64
    %1 = llvm.add %x, %0 : i64
    %2 = llvm.add %y, %0 : i64
    %3 = llvm.xor %1, %2 : i64
    llvm.return %3 : i64
  }]

def add_multiuse_const_riscv_i64 :=
  [LV| {
  ^entry (%x: i64, %y: i64):
    %0 = "li"() {imm = -1 : !i64} : (!i64) -> (!i64)
    %1 = srli %0, 24 : !i64
    %a0 = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
    %2 = sub %a0, %1 : !i64
    %a1 = "builtin.unrealized_conversion_cast" (%y) : (i64) -> (!i64)
    %3 = sub %a1, %1 : !i64
    %4 = xor %2, %3 : !i64
    %5 = "builtin.unrealized_conversion_cast" (%4) : (!i64) -> (i64)
    llvm.return %5 : i64
  }]

def add_multiuse_const_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64) ] where
  lhs := add_multiuse_const_llvm_i64
  rhs := add_multiuse_const_riscv_i64
  correct := by
    unfold add_multiuse_const_llvm_i64  add_multiuse_const_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals simp; bv_decide
