import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open LLVMRiscV

/-!
  This file implements the `alu64.ll` test case in the LLVM test suite:
  https://github.com/llvm/llvm-project/blob/b424207cdddfa2cbfc9129bbe0a31e47cb04e6dc/llvm/test/CodeGen/RISCV/alu64.ll
-/

/-- ### addi -/
@[simp_denote]
def addi_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (1) : i64
    %1 = llvm.add %a, %0 : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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


/-- ### slti -/
@[simp_denote]
def slti_llvm_i64 :=
  [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (2) : i64
    %1 = llvm.icmp.slt %a, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    llvm.return %2 : i64
  }]

@[simp_denote]
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


/-- ### sltiu -/
@[simp_denote]
def sltiu_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (3) : i64
    %1 = llvm.icmp.ult %a, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    llvm.return %2 : i64
  }]

@[simp_denote]
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


/-- ### xori -/
@[simp_denote]
def xori_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (4) : i64
    %1 = llvm.xor %a, %0 : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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


/-- ### ori -/
@[simp_denote]
def ori_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (5) : i64
    %1 = llvm.or %a, %0 : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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


/-- ### andi -/
@[simp_denote]
def andi_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (6) : i64
    %1 = llvm.and %a, %0 : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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


/-- ### slli -/
@[simp_denote]
def slli_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (7) : i64
    %1 = llvm.shl %a, %0 : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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


/-- ### srli -/
@[simp_denote]
def srli_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (8) : i64
    %1 = llvm.lshr %a, %0 : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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


/-- ### srai -/
@[simp_denote]
def srai_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %0 = llvm.mlir.constant (9) : i64
    %1 = llvm.ashr %a, %0 : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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


/-- ### add -/
@[simp_denote]
def add_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.add %a, %b : i64
    llvm.return %0 : i64
  }]

@[simp_denote]
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


/-- ### sub -/
@[simp_denote]
def sub_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.sub %a, %b : i64
    llvm.return %0 : i64
  }]

@[simp_denote]
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

/-- ### sll -/
@[simp_denote]
def sll_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.shl %a, %b : i64
    llvm.return %0 : i64
  }]

@[simp_denote]
def sll_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64, %arg1: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %0 = sll %a, %b : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

def sll_i32_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := sll_llvm_i64
  rhs := sll_riscv_i64

/-- ### slt -/
@[simp_denote]
def slt_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.icmp.slt %a, %b : i64
    %1 = llvm.zext %0 : i1 to i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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


/-- ### sltu -/
@[simp_denote]
def sltu_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.icmp.ult %a, %b : i64
    %1 = llvm.zext %0 : i1 to i64
    llvm.return %1 : i64
  }]

@[simp_denote]
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


/-- ### xor -/
@[simp_denote]
def xor_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.xor %a, %b : i64
    llvm.return %0 : i64
  }]

@[simp_denote]
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


/-- ### srl -/
@[simp_denote]
def srl_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.lshr %a, %b : i64
    llvm.return %0 : i64
  }]

@[simp_denote]
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


/-- ### sra -/
@[simp_denote]
def sra_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.ashr %a, %b : i64
    llvm.return %0 : i64
  }]

@[simp_denote]
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


/-- ### or -/
@[simp_denote]
def or_llvm_i32 := [LV| {
    ^entry (%a: i32, %b: i32):
    %0 = llvm.or %a, %b : i32
    llvm.return %0 : i32
  }]

@[simp_denote]
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


/-- ### and -/
@[simp_denote]
def and_llvm_i64 := [LV| {
    ^entry (%a: i64, %b: i64):
    %0 = llvm.and %a, %b : i64
    llvm.return %0 : i64
  }]

@[simp_denote]
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


/- ### addiw
  Can't be implemented because Lean-MLIR does not support the intrinsic as in `i32 signext %a`
-/

/- ### slliw
  Can't be implemented because Lean-MLIR does not support the intrinsic as in `i32 signext %a`
-/

/- ### srliw
  Can't be implemented.
  TODO: check why
-/


/-- ### sraiw -/
@[simp_denote]
def sraiw_llvm_i64 := [LV| {
    ^entry (%a: i64):
    %32 = llvm.mlir.constant (32) : i64
    %41 = llvm.mlir.constant (41) : i64
    %0 = llvm.shl %a, %32 : i64
    %1 = llvm.ashr %0, %41: i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def sraiw_riscv_i64 := [LV| {
    ^entry (%arg: i64):
    %0 = "builtin.unrealized_conversion_cast" (%arg) : (i64) -> (!riscv.reg)
    %1 = sraiw %0, 9 : !riscv.reg
    %2 = "builtin.unrealized_conversion_cast" (%1) : (!riscv.reg) -> (i64)
    llvm.return %2 : i64
  }]

def sraiw_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := sraiw_llvm_i64
  rhs := sraiw_riscv_i64


/- ### sextw
  Can't be implemented.
  TODO: check why
-/

/- ### addw
  Can't be implemented.
  TODO: check why
-/

/- ### subw
  Can't be implemented.
  TODO: check why
-/

/- ### sllw
  Can't be implemented.
  TODO: check why
-/

/- ### srlw
  Can't be implemented.
  TODO: check why
-/


/- ### sraw
  Can't be implemented.
  TODO: check why
-/


/-- ### add_hi_and_lo_negone -/
@[simp_denote]
def add_hi_and_lo_negone_llvm_i64 := [LV| {
    ^entry (%arg: i64):
    %1 = llvm.mlir.constant (-1) : i64
    %0 = llvm.add %arg, %1 overflow<nsw> : i64
    llvm.return %0 : i64
  }]

@[simp_denote]
def add_hi_and_lo_negone_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!riscv.reg)
    %0 = li (0) : !riscv.reg
    %1= li (1) : !riscv.reg
    %2 = sub %0, %1 : !riscv.reg  -- load -1 into %1 becaue can't encode (-1) for the moment
    %3 = add %a, %2 : !riscv.reg
    %4 = "builtin.unrealized_conversion_cast" (%3) : (!riscv.reg) -> (i64)
    llvm.return %4 : i64
  }]

def add_hi_and_lo_negone_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_hi_and_lo_negone_llvm_i64
  rhs := add_hi_and_lo_negone_riscv_i64


/-- ### add_hi_zero_lo_negone -/
@[simp_denote]
def add_hi_zero_lo_negone_llvm_i64 := [LV| {
    ^entry (%0: i64):
    %4294967295 = llvm.mlir.constant (4294967295) : i64
    %1 = llvm.add %0, %4294967295 : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def add_hi_zero_lo_negone_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!riscv.reg)
    %0 = li (0) : !riscv.reg
    %1= li (1) : !riscv.reg
    %2 = sub %0, %1 : !riscv.reg  -- load -1 into %1 becaue can't encode (-1) for the moment
    %3 = srli %2, 32 : !riscv.reg
    %4 = add %a, %3 : !riscv.reg
    %5 = "builtin.unrealized_conversion_cast" (%4) : (!riscv.reg) -> (i64)
    llvm.return %5 : i64
  }]

def add_hi_one_lo_negone_i32_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_hi_zero_lo_negone_llvm_i64
  rhs :=add_hi_zero_lo_negone_riscv_i64

/-- ### add_lo_negone -/
@[simp_denote]
def add_lo_negone_llvm_i64 := [LV| {
    ^entry (%arg: i64):
    %4294967297 = llvm.mlir.constant (4294967297) : i64
    %0 = llvm.mlir.constant (0) : i64
    %1 =llvm.sub %0, %4294967297 : i64
    %2 = llvm.add %1, %arg overflow<nsw> : i64
    llvm.return %2 : i64
  }]

@[simp_denote]
def add_lo_negone_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!riscv.reg)
    %0 = li (0) : !riscv.reg
    %1= li (1) : !riscv.reg
    %2 = sub %0, %1 : !riscv.reg  -- load -1 into %1 becaue can't encode (-1) for the moment
    %3 = slli %2, 32 : !riscv.reg
    %4 = add %3, %2 : !riscv.reg
    %5 = add %a, %4 : !riscv.reg
    %6 = "builtin.unrealized_conversion_cast" (%5) : (!riscv.reg) -> (i64)
    llvm.return %6 : i64
  }]

def add_lo_negone_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_lo_negone_llvm_i64
  rhs := add_lo_negone_riscv_i64

/-- ### add_hi_one_lo_negone -/
@[simp_denote]
def add_hi_one_lo_negone_llvm_i64 := [LV| {
    ^entry (%arg: i64):
    %8589934591 = llvm.mlir.constant (8589934591) : i64
    %1 = llvm.add %arg, %8589934591 overflow<nsw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def add_hi_one_lo_negone_riscv_i64 :=
  [LV| {
    ^entry (%arg0: i64):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!riscv.reg)
    %0 = li (0) : !riscv.reg
    %1= li (1) : !riscv.reg
    %2 = sub %0, %1 : !riscv.reg  -- load -1 into %1 becaue can't encode (-1) for the moment
    %3 = srli %2, 31 : !riscv.reg
    %4 = add %3, %a : !riscv.reg
    %5 = "builtin.unrealized_conversion_cast" (%4) : (!riscv.reg) -> (i64)
    llvm.return %5 : i64
  }]

def add_hi_one_lo_negone_i64_test : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := add_hi_one_lo_negone_llvm_i64
  rhs := add_hi_one_lo_negone_riscv_i64
