import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-
Disabled due to simproc implementation not being re-evaluated correctly
on Lean version "4.20.0-nightly-2025-04-21" -/
set_option Elab.async true

/- # ADD, RiscV  -/
@[simp_denote]
def add_riscv := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i64) -> (!i64)
    %0 = add %lhsr, %rhsr : !i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %1 : i64
  }]

/- # ADD, no flag  -/
@[simp_denote]
def add_llvm_no_flags := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs : i64
    llvm.return %1 : i64
  }]

/- # ADD, with flags  -/
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

/- this defines the peephole rewrites for the add instruction which will be merged with all
the other rewrites  -/
def add_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_add_lower_riscv_noflags,llvm_add_lower_riscv_nsw_flag, llvm_add_lower_riscv_nuw_flag,
  llvm_add_lower_riscv_nuw_nsw_flag]

-- supporting the i32 type

/- # ADD i32 , no flag  -/

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

/- # ADD i32, with flags  -/
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

def llvm_add_lower_riscv_noflags_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs:= add_llvm_no_flags_32
  rhs:= add_riscv_32


def llvm_add_lower_riscv_nsw_flag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs:= add_llvm_nsw_flags_32
  rhs:= add_riscv_32


def llvm_add_lower_riscv_nuw_flag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs:= add_llvm_nuw_flags_32
  rhs:= add_riscv_32

def llvm_add_lower_riscv_nuw_nsw_flag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs:= add_llvm_nsw_nuw_flags_32
  rhs:= add_riscv_32

/- this defines the peephole rewrites for the add i32 instruction which will be merged with all
the other rewrites  -/
def add_match_32 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_add_lower_riscv_noflags_32,llvm_add_lower_riscv_nsw_flag_32, llvm_add_lower_riscv_nuw_flag_32,
  llvm_add_lower_riscv_nuw_nsw_flag_32]

-- supporting the i16 type
/- # ADD i16 , no flag  -/

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

/- # ADD i32, with flags  -/
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

/- this defines the peephole rewrites for the add i16 instruction which will be merged with all
the other rewrites  -/
def add_match_16 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_add_lower_riscv_noflags_16,llvm_add_lower_riscv_nsw_flag_16, llvm_add_lower_riscv_nuw_flag_16,
  llvm_add_lower_riscv_nuw_nsw_flag_16]

-- supporting the i8 type
/- # ADD i8 , no flag  -/

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

/- # ADD i8, with flags  -/
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

/- this defines the peephole rewrites for the add i16 instruction which will be merged with all
the other rewrites  -/
def add_match_8 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_add_lower_riscv_noflags_8,llvm_add_lower_riscv_nsw_flag_8, llvm_add_lower_riscv_nuw_flag_8,
  llvm_add_lower_riscv_nuw_nsw_flag_8]


-- supporting the i1 type
/- # ADD i1 , no flag  -/

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

/- # ADD i1, with flags  -/
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

/- this defines the peephole rewrites for the add i16 instruction which will be merged with all
the other rewrites  -/
def add_match_1 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_add_lower_riscv_noflags_1,llvm_add_lower_riscv_nsw_flag_1, llvm_add_lower_riscv_nuw_flag_1,
  llvm_add_lower_riscv_nuw_nsw_flag_1]


-- thesis example :
-- intro to get feeling
def intro_example_lhs := [LV| {
    ^entry (%arg: i64, %amount: i64):
    %0 = llvm.shl %arg, %amount : i64
    %1 = llvm.lshr %0, %amount : i64
    llvm.return %1 : i64
  }]

def intro_example_rhs := [LV| {
    ^entry (%arg: i64, %amount: i64):
    llvm.return %arg : i64
  }]

def rewrite00 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= [LV| {
    ^entry (%arg: i64, %amount: i64):
    %0 = llvm.shl %arg, %amount : i64
    %1 = llvm.lshr %0, %amount : i64
    llvm.return %1 : i64
  }]

  rhs:= [LV| {
    ^entry (%arg: i64, %amount: i64):
    llvm.return %arg : i64
  }]
  correct := by
    simp_lowering
    sorry
    --bv_decide

    -- us this as an counterexample

-- working example
@[simp_denote]
def intro_example_correct_lhs := [LV| {
  ^entry (%arg0: i64):
    %c = llvm.mlir.constant (4) : i64
    %1 = llvm.mul %arg0, %c : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def intro_example_correct_rhs := [LV| {
  ^entry (%arg0: i64):
    %r1 = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!riscv.reg)
    %c = slli %r1, 2 : !riscv.reg
    %rd = "builtin.unrealized_conversion_cast" (%c) : (!riscv.reg) -> (i64)
    llvm.return %rd : i64
  }]

def selection00 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs:= [LV| {
  ^entry (%arg0: i64):
    %c = llvm.mlir.constant (4) : i64
    %1 = llvm.mul %arg0, %c : i64
    llvm.return %1 : i64
  }]
  rhs:= [LV| {
  ^entry (%arg0: i64):
    %r1 = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!riscv.reg)
    %c = slli %r1, 2 : !riscv.reg
    %rd = "builtin.unrealized_conversion_cast" (%c) : (!riscv.reg) -> (i64)
    llvm.return %rd : i64
  }]

