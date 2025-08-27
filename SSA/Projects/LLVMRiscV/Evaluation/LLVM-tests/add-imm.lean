import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open LLVMRiscV

/-!
  This file implements the `add-imm.ll` test case in the LLVM test suite:
  https://github.com/llvm/llvm-project/blob/b424207cdddfa2cbfc9129bbe0a31e47cb04e6dc/llvm/test/CodeGen/RISCV/add-imm.ll
-/


/-- ### add_positive_low_bound_reject -/
@[simp_denote]
def add_positive_low_bound_reject_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (2047) : i32
    %1 = llvm.add %a, %0 : i32
    llvm.return %1 :i32
  }]

@[simp_denote]
def add_positive_low_bound_reject_riscv :=
  [LV| {
    ^entry (%arg: i32):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = addiw %a, 2047 : !i64
    %1 =  "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 :i32
  }]

def add_positive_low_bound_reject_test: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_positive_low_bound_reject_llvm
  rhs := add_positive_low_bound_reject_riscv


/-- ### add_positive_low_bound_accept -/
@[simp_denote]
def add_positive_low_bound_accept_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (2048) : i32
    %1 = llvm.add %0, %a : i32
    llvm.return %1 :i32
  }]

@[simp_denote]
def add_positive_low_bound_accept_riscv :=
  [LV| {
    ^entry (%arg: i32):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = addi %a, 2047 : !i64
    %1 = addiw %0, 1 : !i64
    %2 =  "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 :i32
  }]

def add_positive_low_bound_accept_test: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_positive_low_bound_accept_llvm
  rhs := add_positive_low_bound_accept_riscv

/-- ###  add_positive_high_bound_accept -/
@[simp_denote]
def add_positive_high_bound_accept_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (4094) : i32
    %1 = llvm.add %0, %a : i32
    llvm.return %1 :i32
  }]

@[simp_denote]
def add_positive_high_bound_accept_riscv :=
  [LV| {
    ^entry (%arg: i32):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = addi %a, 2047 : !i64
    %1 = addiw %0, 2047 : !i64
    %2 =  "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 :i32
  }]

def add_positive_high_bound_accept_test: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_positive_high_bound_accept_llvm
  rhs := add_positive_high_bound_accept_riscv


/-- ### add_positive_high_bound_reject -/
@[simp_denote]
def add_positive_high_bound_reject_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (4095) : i32
    %1 = llvm.add %0, %a : i32
    llvm.return %1 :i32
  }]

@[simp_denote]
def add_positive_high_bound_reject_riscv :=
  [LV| {
    ^entry (%arg: i32):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = li (843949575) : !i64
    %1 = "lui"  (%0) {imm = 1 : !i64} : (!i64) -> (!i64)
    %2 = "addi"  (%1) {imm = -1 : !i64} : (!i64) -> (!i64)
    %3 = addw %2, %a: !i64
    %4 =  "builtin.unrealized_conversion_cast" (%3) : (!i64) -> (i32)
    llvm.return %4 :i32
  }]

def add_positive_high_bound_reject_test: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_positive_high_bound_reject_llvm
  rhs := add_positive_high_bound_reject_riscv


/-- ### add_negative_high_bound_reject -/
@[simp_denote]
def add_negative_high_bound_reject_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (-2048) : i32
    %1 = llvm.add  %a, %0 : i32
    llvm.return %1 :i32
  }]

@[simp_denote]
def add_negative_high_bound_reject_riscv :=
  [LV| {
    ^entry (%arg: i32):
    %a =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = "addiw"  (%a) {imm = -2048 : !i64} : (!i64) -> (!i64)
    %1 =  "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 :i32
  }]

def add_negative_high_bound_reject_test: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_negative_high_bound_reject_llvm
  rhs := add_negative_high_bound_reject_riscv


/-- ### add_negative_high_bound_accept -/
@[simp_denote]
def add_negative_high_bound_accept_llvm := [LV| {
  ^entry (%a: i32):
  %0 = llvm.mlir.constant (-2049) : i32
  %1 = llvm.add %a, %0 : i32
  llvm.return %1 : i32
}]

@[simp_denote]
def add_negative_high_bound_accept_riscv := [LV| {
  ^entry (%arg: i32):
  %0 =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
  %1 = "addiw"  (%0) {imm = -2048 : !i64} : (!i64) -> (!i64)
  %2 = "addiw"  (%1) {imm = -1 : !i64} : (!i64) -> (!i64)
  %3 =  "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
  llvm.return %3 : i32
}]

def add_negative_high_bound_accept_test: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_negative_high_bound_accept_llvm
  rhs := add_negative_high_bound_accept_riscv

/-- ### add_negative_low_bound_accept -/
@[simp_denote]
def add_negative_low_bound_accept_llvm := [LV| {
  ^entry (%a: i32):
  %0 = llvm.mlir.constant (-4096) : i32
  %1 = llvm.add %a, %0 : i32
  llvm.return %1 : i32
}]

@[simp_denote]
def  add_negative_low_bound_accept_riscv := [LV| {
  ^entry (%arg: i32):
  %0 =  "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
  %1 = "addi"  (%0) {imm = -2048 : !i64} : (!i64) -> (!i64)
  %2 = "addiw"  (%1) {imm = -2048 : !i64} : (!i64) -> (!i64)
  %3 =  "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
  llvm.return %3 : i32
}]

def add_negative_low_bound_accept_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_negative_low_bound_accept_llvm
  rhs := add_negative_low_bound_accept_riscv

/-- ###  add_negative_low_bound_reject -/
@[simp_denote]
def add_negative_low_bound_reject_llvm := [LV| {
  ^entry (%a: i32):
  %0 = llvm.mlir.constant (-4097) : i32
  %1 = llvm.add %a, %0 : i32
  llvm.return %1 : i32
}]

@[simp_denote]
def add_negative_low_bound_reject_riscv := [LV| {
  ^entry (%arg: i32):
  %0 = li (843949575) : !i64 -- random value bc can make any assumption in the value of a1
  %1 = "lui" (%0) {imm = 1048575 : !i64} : (!i64) -> (!i64)
  %2 = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
  %3 = "addi" (%1) {imm = -1 : !i64} : (!i64) -> (!i64)
  %4 = addw %2, %3 : !i64
  %5 =  "builtin.unrealized_conversion_cast" (%4) : (!i64) -> (i32)
  llvm.return %5 : i32
}]

def add_negative_low_bound_reject_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_negative_low_bound_reject_llvm
  rhs := add_negative_low_bound_reject_riscv

/-- ###  add32_accept -/
@[simp_denote]
def add32_accept_llvm := [LV| {
  ^entry (%a: i32):
  %0 = llvm.mlir.constant (2999) : i32
  %1 = llvm.add %a, %0 : i32
  llvm.return %1 : i32
}]

@[simp_denote]
def add32_accept_riscv := [LV| {
  ^entry (%arg: i32):
  %0 = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
  %1 = "addi" (%0) {imm = 2047 : !i64} : (!i64) -> (!i64)
  %2 = addiw %1, 952 : !i64
  %3 =  "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
  llvm.return %3 : i32
}]

def add32_accept_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add32_accept_llvm
  rhs := add32_accept_riscv

/-- ###  add32_sext_accept -/
@[simp_denote]
def add32_sext_accept_llvm := [LV| {
  ^entry (%a: i32):
  %0 = llvm.mlir.constant (2999) : i32
  %1 = llvm.add %a, %0 : i32
  llvm.return %1 : i32
}]

@[simp_denote]
def add32_sext_accept_riscv := [LV| {
  ^entry (%arg: i32):
  %0 = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)-- sext performed here
  %1 = "addi" (%0) {imm = 2047 : !i64} : (!i64) -> (!i64)
  %2 = addiw %1, 952 : !i64
  %3 =  "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
  llvm.return %3 : i32
}]

def add32_sext_accept_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add32_sext_accept_llvm
  rhs :=  add32_sext_accept_riscv


/-- ### add64_accept -/
@[simp_denote]
def add64_accept_llvm := [LV| {
  ^entry (%a: i64):
  %0 = llvm.mlir.constant (2999) : i64
  %1 = llvm.add %a, %0 : i64
  llvm.return %1 : i64
}]

@[simp_denote]
def add64_accept_riscv := [LV| {
  ^entry (%arg: i64):
  %0 = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!i64)-- sext performed here
  %1 = addi %0, 2047 : !i64
  %2 = addi %1, 952 : !i64
  %3 =  "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
  llvm.return %3 : i64
}]

def add64_accept_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add64_accept_llvm
  rhs := add64_accept_riscv
