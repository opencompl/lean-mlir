import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/- # sext instruction lowering-/
@[simp_denote]
def zext_riscv_i1_to_i8 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> !i64
    %1 = andi %0, 1 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i8)
    llvm.return %res: i8
  }]

@[simp_denote]
def zext_llvm_i1_to_i8 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.zext %arg: i1 to i8
    llvm.return %0: i8
  }]

def llvm_zext_lower_riscv_i1_to_i8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 1)] :=
  {lhs:= zext_llvm_i1_to_i8, rhs:= zext_riscv_i1_to_i8}

@[simp_denote]
def zext_riscv_i1_to_i16 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> !i64
    %1 = andi %0, 1 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i16)
    llvm.return %res : i16
  }]

@[simp_denote]
def zext_llvm_i1_to_i16 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.zext %arg: i1 to i16
    llvm.return %0: i16
  }]

def llvm_zext_lower_riscv_i1_to_i16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 1)] :=
  {lhs:= zext_llvm_i1_to_i16, rhs:= zext_riscv_i1_to_i16}

@[simp_denote]
def zext_riscv_i1_to_i32 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> !i64
    %1 = andi %0, 1 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i32)
    llvm.return %res : i32
  }]

@[simp_denote]
def zext_llvm_i1_to_i32 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.zext %arg: i1 to i32
    llvm.return %0: i32
  }]

def llvm_zext_lower_riscv_i1_to_i32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 1)] :=
  {lhs:= zext_llvm_i1_to_i32, rhs:= zext_riscv_i1_to_i32}

@[simp_denote]
def zext_riscv_i1_to_i64 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> (!i64)
    %1 = andi %0, 1 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i64)
    llvm.return %res : i64
  }]

@[simp_denote]
def zext_llvm_i1_to_i64 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.zext %arg: i1 to i64
    llvm.return %0: i64
  }]

def llvm_zext_lower_riscv_i1_to_i64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1)] :=
  {lhs:= zext_llvm_i1_to_i64, rhs:= zext_riscv_i1_to_i64}

@[simp_denote]
def zext_riscv_i8_to_i64 := [LV| {
  ^entry (%arg: i8):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i8) -> (!i64)
    %1 = andi %0, 255 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i64)
    llvm.return %res : i64
  }]

@[simp_denote]
def zext_llvm_i8_to_i64 := [LV| {
  ^entry (%arg: i8):
    %0 = llvm.zext %arg: i8 to i64
    llvm.return %0: i64
  }]

def llvm_zext_lower_riscv_i8_to_i64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 8)] :=
  {lhs:= zext_llvm_i8_to_i64, rhs:= zext_riscv_i8_to_i64}

@[simp_denote]
def zext_riscv_i8_to_i16 := [LV| {
  ^entry (%arg: i8):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i8) -> (!i64)
    %1 = andi %0, 255 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i16)
    llvm.return %res : i16
  }]

@[simp_denote]
def zext_llvm_i8_to_i16 := [LV| {
  ^entry (%arg: i8):
    %0 = llvm.zext %arg: i8 to i16
    llvm.return %0: i16
  }]

def llvm_zext_lower_riscv_i8_to_i16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 8)] :=
  {lhs:= zext_llvm_i8_to_i16, rhs:= zext_riscv_i8_to_i16}

@[simp_denote]
def zext_riscv_i8_to_i32 := [LV| {
  ^entry (%arg: i8):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i8) -> (!i64)
    %1 = andi %0, 255 : !i64
    %res = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i32)
    llvm.return %res : i32
  }]

@[simp_denote]
def zext_llvm_i8_to_i32 := [LV| {
  ^entry (%arg: i8):
    %0 = llvm.zext %arg: i8 to i32
    llvm.return %0: i32
  }]

def llvm_zext_lower_riscv_i8_to_i32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 8)] :=
  {lhs:= zext_llvm_i8_to_i32, rhs:= zext_riscv_i8_to_i32}

@[simp_denote]
def zext_riscv_i16_to_i64 := [LV| {
  ^entry (%arg: i16):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i16) -> (!i64)
    %1 = slli %0, 48 : !i64
    %2 = srli %1, 48 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %res : i64
  }]

@[simp_denote]
def zext_llvm_i16_to_i64 := [LV| {
  ^entry (%arg: i16):
    %0 = llvm.zext %arg: i16 to i64
    llvm.return %0: i64
  }]

def llvm_zext_lower_riscv_i16_to_i64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 16)] :=
  {lhs:= zext_llvm_i16_to_i64, rhs:= zext_riscv_i16_to_i64}

@[simp_denote]
def zext_riscv_i16_to_i32 := [LV| {
  ^entry (%arg: i16):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i16) -> (!i64)
    %1 = slli %0, 48 : !i64
    %2 = srli %1, 48 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i32)
    llvm.return %res : i32
  }]

@[simp_denote]
def zext_llvm_i16_to_i32 := [LV| {
  ^entry (%arg: i16):
    %0 = llvm.zext %arg: i16 to i32
    llvm.return %0: i32
  }]

def llvm_zext_lower_riscv_i16_to_i32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 16)] :=
  {lhs:= zext_llvm_i16_to_i32, rhs:= zext_riscv_i16_to_i32}

def zext_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
    [  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_i1_to_i8),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_i1_to_i16),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_i1_to_i32),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_i1_to_i64),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_i8_to_i64),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_i8_to_i16),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_i8_to_i32),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_i16_to_i32),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_zext_lower_riscv_i16_to_i64),
    ]
