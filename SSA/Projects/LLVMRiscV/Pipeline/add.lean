import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-
Disabled due to simproc implementation not being re-evaluated correctly
on Lean version "4.20.0-nightly-2025-04-21" -/
set_option Elab.async true

@[simp_denote]
def add_riscv := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i64) -> (!i64)
    %0 = add %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

@[simp_denote]
def add_llvm_no_flags := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def add_llvm_nsw_flags := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs overflow<nsw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def add_llvm_nuw_flags := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs overflow<nuw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def add_llvm_nsw_nuw_flags := [LV| {
   ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs overflow<nsw,nuw> : i64
    llvm.return %1 : i64
  }]

def llvm_add_lower_riscv_noflags : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= add_llvm_no_flags
  rhs:= add_riscv

def llvm_add_lower_riscv_nsw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= add_llvm_nsw_flags
  rhs:= add_riscv

def llvm_add_lower_riscv_nuw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= add_llvm_nuw_flags
  rhs:= add_riscv

def llvm_add_lower_riscv_nuw_nsw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= add_llvm_nsw_nuw_flags
  rhs:= add_riscv

def add_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_add_lower_riscv_noflags,llvm_add_lower_riscv_nsw_flag, llvm_add_lower_riscv_nuw_flag,
  llvm_add_lower_riscv_nuw_nsw_flag]


/-! ### i1  -/

@[simp_denote]
def add_riscv_1 := [LV| {
  ^entry (%lhs: i1, %rhs: i1):
    %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i1) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i1) -> (!i64)
    %0 = add %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i1)
    llvm.return %1 : i1
  }]

@[simp_denote]
def add_llvm_no_flags_1 := [LV| {
    ^entry (%lhs: i1, %rhs: i1):
    %1 = llvm.add %lhs, %rhs : i1
    llvm.return %1 : i1
  }]

@[simp_denote]
def add_llvm_nsw_flags_1 := [LV| {
    ^entry (%lhs: i1, %rhs: i1):
    %1 = llvm.add %lhs, %rhs overflow<nsw> : i1
    llvm.return %1 : i1
  }]

@[simp_denote]
def add_llvm_nuw_flags_1 := [LV| {
    ^entry (%lhs: i1, %rhs: i1):
    %1 = llvm.add %lhs, %rhs overflow<nuw> : i1
    llvm.return %1 : i1
  }]

@[simp_denote]
def add_llvm_nsw_nuw_flags_1 := [LV| {
   ^entry (%lhs: i1, %rhs: i1):
    %1 = llvm.add %lhs, %rhs overflow<nsw,nuw> : i1
    llvm.return %1 : i1
  }]

def llvm_add_lower_riscv_noflags_1 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 1), Ty.llvm (.bitvec 1)] where
  lhs:= add_llvm_no_flags_1
  rhs:= add_riscv_1

def llvm_add_lower_riscv_nsw_flag_1 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 1), Ty.llvm (.bitvec 1)] where
  lhs:= add_llvm_nsw_flags_1
  rhs:= add_riscv_1

def llvm_add_lower_riscv_nuw_flag_1 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 1), Ty.llvm (.bitvec 1)] where
  lhs:= add_llvm_nuw_flags_1
  rhs:= add_riscv_1

def llvm_add_lower_riscv_nuw_nsw_flag_1 : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 1), Ty.llvm (.bitvec 1)] where
  lhs:= add_llvm_nsw_nuw_flags_1
  rhs:= add_riscv_1

def add_match_1 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_add_lower_riscv_noflags_1,llvm_add_lower_riscv_nsw_flag_1, llvm_add_lower_riscv_nuw_flag_1,
  llvm_add_lower_riscv_nuw_nsw_flag_1]



/-! ### i8  -/

@[simp_denote]
def add_riscv_8 := [LV| {
  ^entry (%lhs: i8, %rhs: i8):
    %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i8) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i8) -> (!i64)
    %0 = add %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i8)
    llvm.return %1 : i8
  }]

@[simp_denote]
def add_llvm_no_flags_8 := [LV| {
    ^entry (%lhs: i8, %rhs: i8):
    %1 = llvm.add %lhs, %rhs : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def add_llvm_nsw_flags_8 := [LV| {
    ^entry (%lhs: i8, %rhs: i8):
    %1 = llvm.add %lhs, %rhs overflow<nsw> : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def add_llvm_nuw_flags_8 := [LV| {
    ^entry (%lhs: i8, %rhs: i8):
    %1 = llvm.add %lhs, %rhs overflow<nuw> : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def add_llvm_nsw_nuw_flags_8 := [LV| {
   ^entry (%lhs: i8, %rhs: i8):
    %1 = llvm.add %lhs, %rhs overflow<nsw,nuw> : i8
    llvm.return %1 : i8
  }]

def llvm_add_lower_riscv_noflags_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs:= add_llvm_no_flags_8
  rhs:= add_riscv_8


def llvm_add_lower_riscv_nsw_flag_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs:= add_llvm_nsw_flags_8
  rhs:= add_riscv_8


def llvm_add_lower_riscv_nuw_flag_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs:= add_llvm_nuw_flags_8
  rhs:= add_riscv_8

def llvm_add_lower_riscv_nuw_nsw_flag_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs:= add_llvm_nsw_nuw_flags_8
  rhs:= add_riscv_8

def add_match_8 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_add_lower_riscv_noflags_8,llvm_add_lower_riscv_nsw_flag_8, llvm_add_lower_riscv_nuw_flag_8,
  llvm_add_lower_riscv_nuw_nsw_flag_8]


/-! ### i16  -/

@[simp_denote]
def add_riscv_16 := [LV| {
  ^entry (%lhs: i16, %rhs: i16):
    %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i16) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i16) -> (!i64)
    %0 = add %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i16)
    llvm.return %1 : i16
  }]

@[simp_denote]
def add_llvm_no_flags_16 := [LV| {
    ^entry (%lhs: i16, %rhs: i16):
    %1 = llvm.add %lhs, %rhs : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def add_llvm_nsw_flags_16 := [LV| {
    ^entry (%lhs: i16, %rhs: i16):
    %1 = llvm.add %lhs, %rhs overflow<nsw> : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def add_llvm_nuw_flags_16 := [LV| {
    ^entry (%lhs: i16, %rhs: i16):
    %1 = llvm.add %lhs, %rhs overflow<nuw> : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def add_llvm_nsw_nuw_flags_16 := [LV| {
   ^entry (%lhs: i16, %rhs: i16):
    %1 = llvm.add %lhs, %rhs overflow<nsw,nuw> : i16
    llvm.return %1 : i16
  }]

def llvm_add_lower_riscv_noflags_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs:= add_llvm_no_flags_16
  rhs:= add_riscv_16


def llvm_add_lower_riscv_nsw_flag_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs:= add_llvm_nsw_flags_16
  rhs:= add_riscv_16


def llvm_add_lower_riscv_nuw_flag_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs:= add_llvm_nuw_flags_16
  rhs:= add_riscv_16

def llvm_add_lower_riscv_nuw_nsw_flag_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs:= add_llvm_nsw_nuw_flags_16
  rhs:= add_riscv_16

def add_match_16 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_add_lower_riscv_noflags_16,llvm_add_lower_riscv_nsw_flag_16, llvm_add_lower_riscv_nuw_flag_16,
  llvm_add_lower_riscv_nuw_nsw_flag_16]


/-! ### i32  -/

@[simp_denote]
def add_riscv_32 := [LV| {
  ^entry (%lhs: i32, %rhs: i32):
    %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i32) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i32) -> (!i64)
    %0 = add %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
    llvm.return %1 : i32
  }]

@[simp_denote]
def add_llvm_no_flags_32 := [LV| {
    ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.add %lhs, %rhs : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def add_llvm_nsw_flags_32 := [LV| {
    ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.add %lhs, %rhs overflow<nsw> : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def add_llvm_nuw_flags_32 := [LV| {
    ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.add %lhs, %rhs overflow<nuw> : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def add_llvm_nsw_nuw_flags_32 := [LV| {
   ^entry (%lhs: i32, %rhs: i32):
    %1 = llvm.add %lhs, %rhs overflow<nsw,nuw> : i32
    llvm.return %1 : i32
  }]

def llvm_add_lower_riscv_noflags_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)]
where
  lhs:= add_llvm_no_flags_32
  rhs:= add_riscv_32


def llvm_add_lower_riscv_nsw_flag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)]
where
  lhs:= add_llvm_nsw_flags_32
  rhs:= add_riscv_32


def llvm_add_lower_riscv_nuw_flag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)]
where
  lhs:= add_llvm_nuw_flags_32
  rhs:= add_riscv_32

def llvm_add_lower_riscv_nuw_nsw_flag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)]
where
  lhs:= add_llvm_nsw_nuw_flags_32
  rhs:= add_riscv_32

def add_match_32 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_add_lower_riscv_noflags_32,llvm_add_lower_riscv_nsw_flag_32, llvm_add_lower_riscv_nuw_flag_32,
  llvm_add_lower_riscv_nuw_nsw_flag_32]
