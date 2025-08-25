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
def sext_riscv_i1_to_i8 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> (!i64)
    %1 = slli %0, 63 : !i64
    %2 = srai %1, 63 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i8)
    llvm.return %res: i8
  }]

@[simp_denote]
def sext_llvm_i1_to_i8 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.sext %arg: i1 to i8
    llvm.return %0: i8
  }]

def llvm_sext_lower_riscv_i1_to_i8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 1)] :=
  {lhs:= sext_llvm_i1_to_i8, rhs:= sext_riscv_i1_to_i8 }


/-! ### i1 to i8 -/

@[simp_denote]
def sext_riscv_i1_to_i16 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> (!i64)
    %1 = slli %0, 63 : !i64
    %2 = srai %1, 63 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i16)
    llvm.return %res : i16
  }]

@[simp_denote]
def sext_llvm_i1_to_i16 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.sext %arg: i1 to i16
    llvm.return %0: i16
  }]

def llvm_sext_lower_riscv_i1_to_i16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 1)] :=
  {lhs:= sext_llvm_i1_to_i16, rhs:= sext_riscv_i1_to_i16}


/-! ### i1 to i32 -/

@[simp_denote]
def sext_riscv_i1_to_32 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> (!i64)
    %1 = slli %0, 63 : !i64
    %2 = srai %1, 63 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i32)
    llvm.return %res : i32
  }]

@[simp_denote]
def sext_llvm_i1_to_32 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.sext %arg: i1 to i32
    llvm.return %0: i32
  }]

def llvm_sext_lower_riscv_i1_to_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 1)] :=
  {lhs:= sext_llvm_i1_to_32, rhs:= sext_riscv_i1_to_32}


/-! ### i1 to i64 -/

@[simp_denote]
def sext_riscv_i1_to_64 := [LV| {
  ^entry (%arg: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i1) -> (!i64)
    %1 = slli %0, 63 : !i64
    %2 = srai %1, 63 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %res : i64
  }]

@[simp_denote]
def sext_llvm_i1_to_64 := [LV| {
  ^entry (%arg: i1):
    %0 = llvm.sext %arg: i1 to i64
    llvm.return %0: i64
  }]

def llvm_sext_lower_riscv_i1_to_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 1)] :=
  {lhs:= sext_llvm_i1_to_64, rhs:= sext_riscv_i1_to_64}


/-! ### i8 to i16 -/

@[simp_denote]
def sext_riscv_i8_to_i16 := [LV| {
  ^entry (%arg: i8):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i8) -> (!i64)
    %1 = slli %0, 56 : !i64
    %2 = srai %1, 56 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i16)
    llvm.return %res : i16
  }]

@[simp_denote]
def sext_llvm_i8_to_i16 := [LV| {
  ^entry (%arg: i8):
    %0 = llvm.sext %arg: i8 to i16
    llvm.return %0: i16
  }]

def llvm_sext_lower_riscv_i8_to_i16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 8)] :=
  {lhs:= sext_llvm_i8_to_i16, rhs:= sext_riscv_i8_to_i16}


/-! ### i8 to i32 -/

@[simp_denote]
def sext_riscv_i8_to_32 := [LV| {
  ^entry (%arg: i8):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i8) -> (!i64)
    %1 = slli %0, 56 : !i64
    %2 = srai %1, 56 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i32)
    llvm.return %res : i32
  }]

@[simp_denote]
def sext_llvm_i8_to_32 := [LV| {
  ^entry (%arg: i8):
    %0 = llvm.sext %arg: i8 to i32
    llvm.return %0: i32
  }]

def llvm_sext_lower_riscv_i8_to_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 8)] :=
  {lhs:= sext_llvm_i8_to_32, rhs:= sext_riscv_i8_to_32}


/-! ### i8 to i64 -/

@[simp_denote]
def sext_riscv_i8_to_64 := [LV| {
  ^entry (%arg: i8):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i8) -> (!i64)
    %1 = slli %0, 56 : !i64
    %2 = srai %1, 56 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %res : i64
  }]

@[simp_denote]
def sext_llvm_i8_to_64 := [LV| {
  ^entry (%arg: i8):
    %0 = llvm.sext %arg: i8 to i64
    llvm.return %0: i64
  }]

def llvm_sext_lower_riscv_i8_to_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 8)] :=
  {lhs:=sext_llvm_i8_to_64, rhs:= sext_riscv_i8_to_64}


/-! ### i16 to i32 -/

@[simp_denote]
def sext_riscv_i16_to_32 := [LV| {
  ^entry (%arg: i16):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i16) -> (!i64)
    %1 = slli %0, 48 : !i64
    %2 = srai %1, 48 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i32)
    llvm.return %res : i32
  }]

@[simp_denote]
def sext_llvm_i16_to_32 := [LV| {
  ^entry (%arg: i16):
    %0 = llvm.sext %arg: i16 to i32
    llvm.return %0: i32
  }]

def llvm_sext_lower_riscv_i16_to_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 16)] :=
  {lhs:= sext_llvm_i16_to_32, rhs:= sext_riscv_i16_to_32}


/-! ### i16 to i64 -/

@[simp_denote]
def sext_riscv_i16_to_64 := [LV| {
  ^entry (%arg: i16):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (i16) -> (!i64)
    %1 = slli %0, 48 : !i64
    %2 = srai %1, 48 : !i64
    %res = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %res : i64
  }]

@[simp_denote]
def sext_llvm_i16_to_64 := [LV| {
  ^entry (%arg: i16):
    %0 = llvm.sext %arg: i16 to i64
    llvm.return %0: i64
  }]

def llvm_sext_lower_riscv_i16_to_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 16)] :=
  {lhs:= sext_llvm_i16_to_64, rhs:= sext_riscv_i16_to_64}

def sext_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
    [  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sext_lower_riscv_i1_to_i8),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sext_lower_riscv_i1_to_i16),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sext_lower_riscv_i1_to_32),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sext_lower_riscv_i1_to_64),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sext_lower_riscv_i8_to_64),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sext_lower_riscv_i8_to_i16),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sext_lower_riscv_i8_to_32),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sext_lower_riscv_i16_to_32),
       mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sext_lower_riscv_i16_to_64),
   ]
