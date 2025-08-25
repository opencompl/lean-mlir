import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.trunc` instruction for truncation:
  - from i32 to i8
  - from i32 to i16
  - from i64 to i32
-/

/-! ### i32 to i8 -/

@[simp_denote]
def trunc_llvm_i32_to_i8 := [LV| {
  ^entry (%lhs: i32):
    %0 = llvm.trunc %lhs : i32 to i8
    llvm.return %0 : i8
  }]

@[simp_denote]
def trunc_riscv_i32_to_i8 := [LV| {
  ^entry (%lhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %2= "builtin.unrealized_conversion_cast"(%lhsr) : (!i64) -> (i8)
    llvm.return %2 : i8
  }]

def llvm_trunc_riscv_i32_to_i8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 32)] :=
  {lhs:= trunc_llvm_i32_to_i8, rhs:= trunc_riscv_i32_to_i8}

@[simp_denote]
def trunc_llvm_i32_to_i8_nuw := [LV| {
  ^entry (%lhs: i32):
    %0 = llvm.trunc %lhs overflow<nuw> : i32 to i8
    llvm.return %0 : i8
  }]

@[simp_denote]
def trunc_riscv_i32_to_i8_nuw := [LV| {
  ^entry (%lhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %2= "builtin.unrealized_conversion_cast"(%lhsr) : (!i64) -> (i8)
    llvm.return %2 : i8
  }]

def llvm_trunc_riscv_i32_to_i8_nuw : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 32)] :=
  {lhs:= trunc_llvm_i32_to_i8_nuw, rhs:= trunc_riscv_i32_to_i8_nuw}

@[simp_denote]
def trunc_llvm_i32_to_i8_nsw := [LV| {
  ^entry (%lhs: i32):
    %0 = llvm.trunc %lhs overflow<nsw> : i32 to i8
    llvm.return %0 : i8
  }]

@[simp_denote]
def trunc_riscv_i32_to_i8_nsw := [LV| {
  ^entry (%lhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %2= "builtin.unrealized_conversion_cast"(%lhsr) : (!i64) -> (i8)
    llvm.return %2 : i8
  }]

def llvm_trunc_riscv_i32_to_i8_nsw : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 32)] :=
  {lhs:= trunc_llvm_i32_to_i8_nsw, rhs:= trunc_riscv_i32_to_i8_nsw}

@[simp_denote]
def trunc_llvm_i32_to_i8_nsw_nuw := [LV| {
  ^entry (%lhs: i32):
    %0 = llvm.trunc %lhs overflow<nsw,nuw> : i32 to i8
    llvm.return %0 : i8
  }]

@[simp_denote]
def trunc_riscv_i32_to_i8_nsw_nuw := [LV| {
  ^entry (%lhs: i32):
  %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
  %2= "builtin.unrealized_conversion_cast"(%lhsr) : (!i64) -> (i8)
    llvm.return %2 : i8
  }]

def llvm_trunc_riscv_i32_to_i8_nuw_nsw : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 32)] :=
  {lhs:= trunc_llvm_i32_to_i8_nsw_nuw, rhs:= trunc_riscv_i32_to_i8_nsw_nuw}


/-! ### i32 to i16 -/

@[simp_denote]
def trunc_llvm_i32_to_i16 := [LV| {
  ^entry (%lhs: i32):
    %0 = llvm.trunc %lhs : i32 to i16
    llvm.return %0 : i16
  }]

@[simp_denote]
def trunc_riscv_i32_to_i16 := [LV| {
  ^entry (%lhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i32) -> (!i64)
    %0= "builtin.unrealized_conversion_cast"(%lhsr) : (!i64) -> (i16)
    llvm.return %0 : i16
  }]

def llvm_trunc_riscv_i32_to_i16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 32)] :=
  {lhs:=  trunc_llvm_i32_to_i16, rhs:= trunc_riscv_i32_to_i16
  }


/-! ### i64 to i32 -/

@[simp_denote]
def trunc_llvm_i64_to_i32 := [LV| {
  ^entry (%lhs: i64):
    %0 = llvm.trunc %lhs : i64 to i32
    llvm.return %0 : i32
  }]

@[simp_denote]
def trunc_riscv_to_i32 := [LV| {
  ^entry (%lhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %2= "builtin.unrealized_conversion_cast"(%lhsr) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def llvm_trunc_riscv_i64_to_i32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 64)] :=
  {lhs:= trunc_llvm_i64_to_i32, rhs:= trunc_riscv_to_i32}

@[simp_denote]
def trunc_llvm_i64_to_i32_nuw := [LV| {
  ^entry (%lhs: i64):
    %0 = llvm.trunc %lhs overflow<nuw> : i64 to i32
    llvm.return %0 : i32
  }]

@[simp_denote]
def trunc_riscv_to_i32_nuw := [LV| {
  ^entry (%lhs: i64 ):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %2= "builtin.unrealized_conversion_cast"(%lhsr) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def llvm_trunc_riscv_i64_to_i32_nuw : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 64)] :=
  {lhs:= trunc_llvm_i64_to_i32_nuw, rhs:= trunc_riscv_to_i32_nuw }

@[simp_denote]
def trunc_llvm_i64_to_i32_nsw := [LV| {
  ^entry (%lhs: i64):
    %0 = llvm.trunc %lhs overflow<nsw> : i64 to i32
    llvm.return %0 : i32
  }]

@[simp_denote]
def trunc_riscv_to_i32_nsw := [LV| {
  ^entry (%lhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
    %2= "builtin.unrealized_conversion_cast"(%lhsr) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def llvm_trunc_riscv_i64_to_i32_nsw : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 64)] :=
  {lhs:= trunc_llvm_i64_to_i32_nsw, rhs:= trunc_riscv_to_i32_nsw }

@[simp_denote]
def trunc_llvm_i64_to_i32_nsw_nuw := [LV| {
  ^entry (%lhs: i64):
    %0 = llvm.trunc %lhs overflow<nsw,nuw> : i64 to i32
    llvm.return %0 : i32
  }]

@[simp_denote]
def trunc_riscv_to_i32_nsw_nuw := [LV| {
  ^entry (%lhs: i64):
  %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> (!i64)
  %2= "builtin.unrealized_conversion_cast"(%lhsr) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def llvm_trunc_riscv_i64_to_i32_nuw_nsw : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 64)] :=
  {lhs:= trunc_llvm_i64_to_i32_nsw_nuw, rhs:= trunc_riscv_to_i32_nsw_nuw}


def trunc_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=[
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_trunc_riscv_i32_to_i16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_trunc_riscv_i64_to_i32_nuw_nsw),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_trunc_riscv_i64_to_i32_nuw),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_trunc_riscv_i64_to_i32_nsw),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_trunc_riscv_i64_to_i32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_trunc_riscv_i32_to_i8_nuw_nsw),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_trunc_riscv_i32_to_i8_nsw),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_trunc_riscv_i32_to_i8_nuw),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_trunc_riscv_i32_to_i8)
]
