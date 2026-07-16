import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open LLVMRiscV

/-!
  This file implements the `alu32.ll` test case in the LLVM test suite:
  https://github.com/llvm/llvm-project/blob/b424207cdddfa2cbfc9129bbe0a31e47cb04e6dc/llvm/test/CodeGen/RISCV/alu32.ll
-/

/-- addi -/
@[simp_denote]
def addi_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (1) : i32
    %1 = llvm.add %a, %0 : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
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


/-- ### slti -/
@[simp_denote]
def slti_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (2) : i32
    %1 = llvm.icmp.slt %a, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

@[simp_denote]
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


/-- ### sltiu -/
@[simp_denote]
def sltiu_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (3) : i32
    %1 = llvm.icmp.ult %a, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

@[simp_denote]
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


/-- ### xori -/
@[simp_denote]
def xori_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (4) : i32
    %1 = llvm.xor %a, %0 : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
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


/-- ### ori -/
@[simp_denote]
def ori_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (5) : i32
    %1 = llvm.or %a, %0 : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
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


/-- ### andi -/
@[simp_denote]
def andi_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (6) : i32
    %1 = llvm.and %a, %0 : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def andi_riscv_i32 :=
  [LV| {
    ^entry (%arg: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg) : (i32) -> (!i64)
    %0 = andi %a, 6 : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

def andi_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32)] where
  lhs := andi_llvm_i32
  rhs := andi_riscv_i32

/-- ### slli -/
@[simp_denote]
def slli_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (7) : i32
    %1 = llvm.shl %a, %0 : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
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


/-- ### srli -/
@[simp_denote]
def srli_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (8) : i32
    %1 = llvm.lshr %a, %0 : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
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

/-- ### srli_demandedbits -/
@[simp_denote]
def srli_demandedbits_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (3) : i32
    %1 = llvm.lshr %a, %0 : i32
    %2 = llvm.mlir.constant (1) : i32
    %3 = llvm.or %1, %2 : i32
    llvm.return %3 : i32
  }]

@[simp_denote]
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

/-- ### srai -/
@[simp_denote]
def srai_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (9) : i32
    %1 = llvm.ashr %a, %0 : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
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

/-- ### add -/
@[simp_denote]
def add_llvm_i32 := [LV| {
    ^entry (%a: i32, %b: i32):
    %0 = llvm.add %a, %b : i32
    llvm.return %0 : i32
  }]

@[simp_denote]
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

/-- ### sub -/
@[simp_denote]
def sub_llvm_i32 := [LV| {
    ^entry (%a: i32, %b: i32):
    %0 = llvm.sub %a, %b : i32
    llvm.return %0 : i32
  }]

@[simp_denote]
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


/-- ### sub -/
@[simp_denote]
def sub_negative_constant_lhs_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (-2) : i32
    %1 = llvm.sub %0, %a : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
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

/-- ### sll -/
@[simp_denote]
def sll_llvm_i32 := [LV| {
    ^entry (%a: i32, %b: i32):
    %0 = llvm.shl %a, %b : i32
    llvm.return %0 : i32
  }]

@[simp_denote]
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

/-- ### sll_negative_constant_lhs -/
@[simp_denote]
def sll_negative_constant_lhs_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (-1) : i32
    %1 = llvm.shl %0, %a : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
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

/-- ### slt -/
@[simp_denote]
def slt_llvm_i32 := [LV| {
    ^entry (%a: i32, %b: i32):
    %0 = llvm.icmp.slt %a, %b : i32
    %1 = llvm.zext %0 : i1 to i32
    llvm.return %1 : i32
  }]

@[simp_denote]
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


/-- ### sltu -/
@[simp_denote]
def sltu_llvm_i32 := [LV| {
    ^entry (%a: i32, %b: i32):
    %0 = llvm.icmp.ult %a, %b : i32
    %1 = llvm.zext %0 : i1 to i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def sltu_riscv_i32 :=
  [LV| {
    ^entry (%arg0: i32, %arg1: i32):
    %a = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %b = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %0 = "sext.w" (%a) : (!i64) -> (!i64)
    %1 = "sext.w" (%b) : (!i64) -> (!i64)
    %2 = sltu %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
    llvm.return %3 : i32
  }]

def sltu_i32_test : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := sltu_llvm_i32
  rhs := sltu_riscv_i32

/-- ### xor -/
@[simp_denote]
def xor_llvm_i32 := [LV| {
    ^entry (%a: i32, %b: i32):
    %0 = llvm.xor %a, %b : i32
    llvm.return %0 : i32
  }]

@[simp_denote]
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


/-- ### srl -/
@[simp_denote]
def srl_llvm_i32 := [LV| {
    ^entry (%a: i32, %b: i32):
    %0 = llvm.lshr %a, %b : i32
    llvm.return %0 : i32
  }]

@[simp_denote]
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


/-- ### srl_negative_constant_lhs -/
@[simp_denote]
def srl_negative_constant_lhs_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (-1) : i32
    %1 = llvm.lshr %0, %a : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
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


/-- ### sra -/
@[simp_denote]
def sra_llvm_i32 := [LV| {
    ^entry (%a: i32, %b: i32):
    %0 = llvm.ashr %a, %b : i32
    llvm.return %0 : i32
  }]

@[simp_denote]
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


/-- ### sra_negative_constant_lhs -/
@[simp_denote]
def sra_negative_constant_lhs_llvm_i32 := [LV| {
    ^entry (%a: i32):
    %0 = llvm.mlir.constant (2147483648) : i32
    %1 = llvm.ashr %0, %a : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
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
def and_llvm_i32 := [LV| {
    ^entry (%a: i32, %b: i32):
    %0 = llvm.and %a, %b : i32
    llvm.return %0 : i32
  }]

@[simp_denote]
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
