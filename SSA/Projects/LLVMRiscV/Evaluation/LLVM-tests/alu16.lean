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


/-- ### slti -/
@[simp_denote]
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


/-- ### sltiu -/
@[simp_denote]
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


/-- ### sltiu_signext -/
@[simp_denote]
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


/-- ### xori -/
@[simp_denote]
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


/-- ### ori -/
@[simp_denote]
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


/-- ### andi -/
@[simp_denote]
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


/-- ### slli -/
@[simp_denote]
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


/-- ### srli -/
@[simp_denote]
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


/-- ### srai -/
@[simp_denote]
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


/-- ### add -/
@[simp_denote]
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


/-- ### sub -/
@[simp_denote]
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


/-- ### sll -/
@[simp_denote]
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


/-- ### slt -/
@[simp_denote]
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


/-- ### sltu -/
@[simp_denote]
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


/-- ### xor -/
@[simp_denote]
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


/-- ### srl -/
@[simp_denote]
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


/-- ### sra -/
@[simp_denote]
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


/-- ### or -/
@[simp_denote]
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


/-- ### and -/
@[simp_denote]
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
