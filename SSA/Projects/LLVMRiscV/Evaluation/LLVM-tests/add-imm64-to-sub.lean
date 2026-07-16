import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open LLVMRiscV

/-!
  This file implements the `add-imm.ll` test case in the LLVM test suite:
  https://github.com/llvm/llvm-project/blob/b424207cdddfa2cbfc9129bbe0a31e47cb04e6dc/llvm/test/CodeGen/RISCV/add-imm64-to-sub.ll
-/

/-- ###  add_b31 -/
@[simp_denote]
def add_b31_llvm_i64 := [LV| {
    ^entry (%x: i64):
    %0 = llvm.mlir.constant (2147483648) : i64
    %1 = llvm.add %x, %0 : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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

@[simp_denote]
def add_b31_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_b31_llvm_i64
  rhs := add_b31_riscv_i64


/-- ### add_b32 -/
@[simp_denote]
def add_b32_llvm_i64 := [LV| {
    ^entry (%x: i64):
    %0 = llvm.mlir.constant (-4294967296) : i64
    %1 = llvm.add %x, %0 : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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

@[simp_denote]
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

def add_b32_test_no_ZBS_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_b32_llvm_i64
  rhs := add_b32_riscv_i64_no_ZBS


def add_b32_test_ZBS_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_b32_llvm_i64
  rhs := add_b32_riscv_i64_ZBS


/-- ### sub_0xffffffffff -/
@[simp_denote]
def sub_0xffffffffff_llvm_i64 := [LV| {
    ^entry (%x: i64):
    %0 = llvm.mlir.constant (1099511627775) : i64
    %1 = llvm.sub %x, %0 : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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


/-- ### add_multiuse -/
@[simp_denote]
def add_multiuse_llvm_i64 := [LV| {
    ^entry (%x: i64):
    %0 = llvm.mlir.constant (-1099511627775) : i64
    %1 = llvm.add %x, %0 : i64
    %2 = llvm.and %1, %0 : i64
    llvm.return %2 : i64
  }]

@[simp_denote]
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


/-- ### add_multiuse_const -/
@[simp_denote]
def add_multiuse_const_llvm_i64 := [LV| {
    ^entry (%x: i64, %y: i64):
    %0 = llvm.mlir.constant (-1099511627775) : i64
    %1 = llvm.add %x, %0 : i64
    %2 = llvm.add %y, %0 : i64
    %3 = llvm.xor %1, %2 : i64
    llvm.return %3 : i64
  }]

@[simp_denote]
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
