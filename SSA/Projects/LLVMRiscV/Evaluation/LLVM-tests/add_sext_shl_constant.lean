import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open LLVMRiscV

/-!
  This file implements the `add_sext_shl_constant.ll` test case in the LLVM test suite:
  https://github.com/llvm/llvm-project/blob/b424207cdddfa2cbfc9129bbe0a31e47cb04e6dc/llvm/test/CodeGen/RISCV/add_sext_shl_constant.ll
-/

/-- ###  add_shl_moreOneUse_sh1add -/
@[simp_denote]
def add_shl_moreOneUse_sh1add := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (1) : i32
    %1 = llvm.or %a, %0 : i32
    %2 = llvm.shl %1, %0 : i32
    %3 = llvm.add %2, %1 : i32
    llvm.return %3 : i32
  }]

@[simp_denote]
def add_shl_moreOneUse_sh1add_riscv_no_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = slli %a0, 1 : !i64
    %2 = ori %1, 2 : !i64
    %3 = add %2, %0 : !i64
    %4 = "builtin.unrealized_conversion_cast" (%3) : (!i64) -> (i32)
    llvm.return %4 : i32
  }]

@[simp_denote]
def add_shl_moreOneUse_sh1add_riscv_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = sh1add %0, %0 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def add_shl_moreOneUse_sh1add_ZBA_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh1add
  rhs := add_shl_moreOneUse_sh1add_riscv_ZBA


def add_shl_moreOneUse_sh1add_no_ZBA_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh1add
  rhs := add_shl_moreOneUse_sh1add_riscv_no_ZBA

/-- ### add_shl_moreOneUse_sh2add -/
@[simp_denote]
def add_shl_moreOneUse_sh2add := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (1) : i32
    %c2 = llvm.mlir.constant (2) : i32
    %1 = llvm.or %a, %0 : i32
    %2 = llvm.shl %1, %c2 : i32
    %3 = llvm.add %2, %1 : i32
    llvm.return %3 : i32
  }]

@[simp_denote]
def add_shl_moreOneUse_sh2add_riscv_no_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = slli %a0, 2 : !i64
    %2 = ori %1, 4 : !i64
    %3 = add %2, %0 : !i64
    %4 = "builtin.unrealized_conversion_cast" (%3) : (!i64) -> (i32)
    llvm.return %4 : i32
  }]

@[simp_denote]
def add_shl_moreOneUse_sh2add_riscv_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = sh2add %0, %0 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def add_shl_moreOneUse_sh2add_ZBA_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh2add
  rhs := add_shl_moreOneUse_sh2add_riscv_ZBA

def add_shl_moreOneUse_sh2add_no_ZBA_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh2add
  rhs := add_shl_moreOneUse_sh2add_riscv_no_ZBA

/-- ### add_shl_moreOneUse_sh3add -/
@[simp_denote]
def add_shl_moreOneUse_sh3add := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (1) : i32
    %c2 = llvm.mlir.constant (3) : i32
    %1 = llvm.or %a, %0 : i32
    %2 = llvm.shl %1, %c2 : i32
    %3 = llvm.add %2, %1 : i32
    llvm.return %3 : i32
  }]

@[simp_denote]
def add_shl_moreOneUse_sh3add_riscv_no_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = slli %a0, 3 : !i64
    %2 = ori %1, 8 : !i64
    %3 = add %2, %0 : !i64
    %4 = "builtin.unrealized_conversion_cast" (%3) : (!i64) -> (i32)
    llvm.return %4 : i32
  }]

@[simp_denote]
def add_shl_moreOneUse_sh3add_riscv_ZBA := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = sh3add %0, %0 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def add_shl_moreOneUse_sh3add_ZBA_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh3add
  rhs := add_shl_moreOneUse_sh3add_riscv_ZBA

def add_shl_moreOneUse_sh3add_no_ZBA_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_moreOneUse_sh3add
  rhs := add_shl_moreOneUse_sh3add_riscv_no_ZBA


/-- ### add_shl_sext -/
@[simp_denote]
def add_shl_sext_llvm := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (3) : i32
    %1 = llvm.add %a, %0 : i32
    %2 = llvm.shl %1, %a : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }]

@[simp_denote]
def add_shl_sext_riscv := [LV| {
    ^entry (%a: i32):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i32) -> (!i64)
    %0 = addi %a0, 3 : !i64
    %1 = sllw %0, %a0 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i64)
    llvm.return %2 : i64
  }]

def add_shl_sext_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 32)] where
  lhs := add_shl_sext_llvm
  rhs := add_shl_sext_riscv

/-- ### add_shl_moreOneUse_sh4add -/
@[simp_denote]
def add_shl_moreOneUse_sh4add_llvm := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (1) : i64
    %c4 = llvm.mlir.constant (4) : i64
    %1 = llvm.or %a, %0 : i64
    %2 = llvm.shl %1, %c4 : i64
    %3 = llvm.add %1, %2 : i64
    llvm.return %3 : i64
  }]

@[simp_denote]
def add_shl_moreOneUse_sh4add_riscv := [LV| {
    ^entry (%a: i64):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i64) -> (!i64)
    %0 = ori %a0, 1 : !i64
    %1 = slli %a0, 4 : !i64
    %2 = ori %1, 16 : !i64
    %3 = add %2, %0 : !i64
    %4 = "builtin.unrealized_conversion_cast" (%3) : (!i64) -> (i64)
    llvm.return %4 : i64
  }]

def add_shl_moreOneUse_sh4add_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_shl_moreOneUse_sh4add_llvm
  rhs :=add_shl_moreOneUse_sh4add_riscv

/-- ###  add_shl_rhs_constant -/
@[simp_denote]
def add_shl_rhs_constant_llvm := [LV| {
    ^entry (%a0: i64, %a1: i64):
    %0 = llvm.mlir.constant (1) : i64
    %c3 = llvm.mlir.constant (3) : i64
    %c8 = llvm.mlir.constant (-8) : i64
    %1 = llvm.add %a0, %0 : i64
    %2 = llvm.add %a1, %1 : i64
    %3 = llvm.shl %2, %c3 : i64
    %4 = llvm.add %3, %c8 : i64
    llvm.return %4 : i64
  }]

@[simp_denote]
def add_shl_rhs_constant_riscv := [LV| {
    ^entry (%a: i64, %b: i64):
    %a0 = "builtin.unrealized_conversion_cast" (%a) : (i64) -> (!i64)
    %a1 = "builtin.unrealized_conversion_cast" (%b) : (i64) -> (!i64)
    %0 = add %a0, %a1 : !i64
    %1 = slli %0, 3 : !i64
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i64)
    llvm.return %2 : i64
  }]

def add_shl_rhs_constant_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64),Ty.llvm (.bitvec 64) ] where
  lhs := add_shl_rhs_constant_llvm
  rhs := add_shl_rhs_constant_riscv
