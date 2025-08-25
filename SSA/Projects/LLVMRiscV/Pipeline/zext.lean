import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.sext` instruction for the extension of
  types:
  - i1 to i8, i16, i32, i64
  - i8 to i16, i32, i64
  - i16 to i32, i64
-/

/-! ### i1 to i8 -/

@[simp_denote]
def zext_riscv_1_to_8 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> !i64
    %1 = andi %0, 1 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i8)
    llvm.return %res: i8
  }]

@[simp_denote]
def zext_llvm_1_to_8 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.zext %arg: i1 to i8
    llvm.return %0: i8
  }]

def llvm_zext_lower_riscv_1_to_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 1)] :=
  {lhs:= zext_llvm_1_to_8, rhs:= zext_riscv_1_to_8}


/-! ### i1 to i16 -/

@[simp_denote]
def zext_riscv_1_to_16 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> !i64
    %1 = andi %0, 1 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i16)
    llvm.return %res : i16
  }]

@[simp_denote]
def zext_llvm_1_to_16 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.zext %arg: i1 to i16
    llvm.return %0: i16
  }]

def llvm_zext_lower_riscv_1_to_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 1)] :=
  {lhs:= zext_llvm_1_to_16, rhs:= zext_riscv_1_to_16}


/-! ### i1 to i32 -/

@[simp_denote]
def zext_riscv_1_to_32 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> !i64
    %1 = andi %0, 1 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i32)
    llvm.return %res : i32
  }]

@[simp_denote]
def zext_llvm_1_to_32 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.zext %arg: i1 to i32
    llvm.return %0: i32
  }]

def llvm_zext_lower_riscv_1_to_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 1)] :=
  {lhs:= zext_llvm_1_to_32, rhs:= zext_riscv_1_to_32}


/-! ### i1 to i64 -/

@[simp_denote]
def zext_riscv_1_to_64 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> (!i64)
    %1 = andi %0, 1 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i64)
    llvm.return %res : i64
  }]

@[simp_denote]
def zext_llvm_1_to_64 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.zext %arg: i1 to i64
    llvm.return %0: i64
  }]

def llvm_zext_lower_riscv_1_to_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1)] :=
  {lhs:= zext_llvm_1_to_64, rhs:= zext_riscv_1_to_64}


/-! ### i8 to i16 -/

@[simp_denote]
def zext_riscv_8_to_16 := [LV| {
  ^entry (%arg: i8):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i8) -> (!i64)
    %1 = andi %0, 255 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i16)
    llvm.return %res : i16
  }]

@[simp_denote]
def zext_llvm_8_to_16 := [LV| {
  ^entry (%arg: i8):
    %0 = llvm.zext %arg: i8 to i16
    llvm.return %0: i16
  }]

def llvm_zext_lower_riscv_8_to_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 8)] :=
  {lhs:= zext_llvm_8_to_16, rhs:= zext_riscv_8_to_16}

/-! ### i8 to i32 -/

@[simp_denote]
def zext_riscv_8_to_32 := [LV| {
  ^entry (%arg: i8):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i8) -> (!i64)
    %1 = andi %0, 255 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i32)
    llvm.return %res : i32
  }]

@[simp_denote]
def zext_llvm_8_to_32 := [LV| {
  ^entry (%arg: i8):
    %0 = llvm.zext %arg: i8 to i32
    llvm.return %0: i32
  }]

def llvm_zext_lower_riscv_8_to_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 8)] :=
  {lhs:= zext_llvm_8_to_32, rhs:= zext_riscv_8_to_32}

/-! ### i8 to i64 -/

@[simp_denote]
def zext_riscv_8_to_64 := [LV| {
  ^entry (%arg: i8):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i8) -> (!i64)
    %1 = andi %0, 255 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i64)
    llvm.return %res : i64
  }]

@[simp_denote]
def zext_llvm_8_to_64 := [LV| {
  ^entry (%arg: i8):
    %0 = llvm.zext %arg: i8 to i64
    llvm.return %0: i64
  }]

def llvm_zext_lower_riscv_8_to_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 8)] :=
  {lhs:= zext_llvm_8_to_64, rhs:= zext_riscv_8_to_64}


/-! ### i16 to i32 -/

@[simp_denote]
def zext_riscv_16_to_32 := [LV| {
  ^entry (%arg: i16):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i16) -> (!i64)
    %1 = zext.h %0 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i32)
    llvm.return %res : i32
  }]

@[simp_denote]
def zext_llvm_16_to_32 := [LV| {
  ^entry (%arg: i16):
    %0 = llvm.zext %arg: i16 to i32
    llvm.return %0: i32
  }]

def llvm_zext_lower_riscv_16_to_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 16)] :=
  {lhs:= zext_llvm_16_to_32, rhs:= zext_riscv_16_to_32}


/-! ### i16 to i64 -/

@[simp_denote]
def zext_riscv_16_to_64 := [LV| {
  ^entry (%arg: i16):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i16) -> (!i64)
    %1 = zext.h %0 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i64)
    llvm.return %res : i64
  }]

@[simp_denote]
def zext_llvm_16_to_64 := [LV| {
  ^entry (%arg: i16):
    %0 = llvm.zext %arg: i16 to i64
    llvm.return %0: i64
  }]

def llvm_zext_lower_riscv_16_to_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 16)] :=
  {lhs:= zext_llvm_16_to_64, rhs:= zext_riscv_16_to_64}

def zext_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_1_to_8),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_1_to_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_1_to_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_1_to_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_8_to_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_8_to_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_8_to_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_16_to_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_16_to_64),
]
