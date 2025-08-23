import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/- # AND -/
@[simp_denote]
def and_llvm := [LV| {
  ^entry (%lhs: i64, %rhs: i64 ):
  %1 = llvm.and %lhs, %rhs : i64
  llvm.return %1 : i64
  }]

@[simp_denote]
def and_riscv := [LV| {
  ^entry (%lhs: i64, %rhs: i64 ):
  %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i64) -> (!i64)
  %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i64) -> (!i64)
  %0 = and %lhsr, %rhsr : !i64
  %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
  llvm.return %1 : i64
  }]

def llvm_and_lower_riscv : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= and_llvm
  rhs:= and_riscv

def and_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_and_lower_riscv]

/- # AND i1 -/

@[simp_denote]
def and_llvm_1 := [LV| {
  ^entry (%lhs: i1, %rhs: i1 ):
  %1 = llvm.and %lhs, %rhs : i1
  llvm.return %1 : i1
  }]

@[simp_denote]
def and_riscv_1 := [LV| {
  ^entry (%lhs: i1, %rhs: i1):
  %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i1) -> (!i64)
  %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i1) -> (!i64)
  %0 = and %lhsr, %rhsr : !i64
  %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i1)
  llvm.return %1 : i1
  }]

def llvm_and_lower_riscv_1 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 1), Ty.llvm (.bitvec 1)] where
  lhs:= and_llvm_1
  rhs:= and_riscv_1

def and_match_1 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_and_lower_riscv_1]

/- # AND i8 -/

@[simp_denote]
def and_llvm_8 := [LV| {
  ^entry (%lhs: i8, %rhs: i8 ):
  %1 = llvm.and %lhs, %rhs : i8
  llvm.return %1 : i8
  }]

@[simp_denote]
def and_riscv_8 := [LV| {
  ^entry (%lhs: i8, %rhs: i8):
  %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i8) -> (!i64)
  %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i8) -> (!i64)
  %0 = and %lhsr, %rhsr : !i64
  %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i8)
  llvm.return %1 : i8
  }]

def llvm_and_lower_riscv_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs:= and_llvm_8
  rhs:= and_riscv_8

def and_match_8 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_and_lower_riscv_8]

  /- # AND i16 -/

@[simp_denote]
def and_llvm_16 := [LV| {
  ^entry (%lhs: i16, %rhs: i16 ):
  %1 = llvm.and %lhs, %rhs : i16
  llvm.return %1 : i16
  }]

@[simp_denote]
def and_riscv_16 := [LV| {
  ^entry (%lhs: i16, %rhs: i16):
  %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i16) -> (!i64)
  %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i16) -> (!i64)
  %0 = and %lhsr, %rhsr : !i64
  %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
  llvm.return %1 : i16
  }]

def llvm_and_lower_riscv_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs:= and_llvm_16
  rhs:= and_riscv_16

def and_match_16 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_and_lower_riscv_16]

  /- # AND i32 -/

@[simp_denote]
def and_llvm_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
  %1 = llvm.and %lhs, %rhs : i32
  llvm.return %1 : i32
  }]

@[simp_denote]
def and_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
  %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i32) -> (!i64)
  %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i32) -> (!i64)
  %0 = and %lhsr, %rhsr : !i64
  %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
  llvm.return %1 : i32
  }]

def llvm_and_lower_riscv_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs:= and_llvm_32
  rhs:= and_riscv_32

def and_match_32 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_and_lower_riscv_32]
