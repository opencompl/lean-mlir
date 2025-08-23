import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-! # SHL (shift left) nsw nuw -/

@[simp_denote]
def shl_llvm := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl %x, %y : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def shl_llvm_nsw := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl %x, %y overflow<nsw> : i64
    llvm.return %1 : i64
  }]


@[simp_denote]
def shl_llvm_nuw := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl %x, %y overflow<nuw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def shl_llvm_nsw_nuw := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl  %x, %y overflow<nsw,nuw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def shl_riscv := [LV| {
    ^entry (%reg1: i64, %reg2: i64 ):
    %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i64) -> (!i64)
    %2 = sll %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

@[simp_denote]
def llvm_shl_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm
  rhs := shl_riscv

def llvm_shl_lower_riscv_nsw: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm_nsw
  rhs := shl_riscv

def llvm_shl_lower_riscv_nuw: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm_nuw
  rhs := shl_riscv

def llvm_shl_lower_riscv_nsw_nuw: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm_nsw_nuw
  rhs := shl_riscv

def shl_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_shl_lower_riscv, llvm_shl_lower_riscv_nsw, llvm_shl_lower_riscv_nsw_nuw, llvm_shl_lower_riscv_nuw]

/-! # SHL i32 -/

@[simp_denote]
def shl_llvm_32 := [LV| {
    ^entry (%x: i32, %y: i32):
    %1 = llvm.shl %x, %y : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def shl_llvm_nsw_32 := [LV| {
    ^entry (%x: i32, %y: i32):
    %1 = llvm.shl %x, %y overflow<nsw> : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def shl_llvm_nuw_32 := [LV| {
    ^entry (%x: i32, %y: i32):
    %1 = llvm.shl %x, %y overflow<nuw> : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def shl_llvm_nsw_nuw_32 := [LV| {
    ^entry (%x: i32, %y: i32):
    %1 = llvm.shl  %x, %y overflow<nsw,nuw> : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def shl_riscv_32 := [LV| {
    ^entry (%reg1: i32, %reg2: i32 ):
    %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i32) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i32) -> (!i64)
    %2 = sll %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i32)
    llvm.return %3 : i32
  }]

@[simp_denote]
def llvm_shl_lower_riscv_32: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := shl_llvm_32
  rhs := shl_riscv_32

def llvm_shl_lower_riscv_nsw_32: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := shl_llvm_nsw_32
  rhs := shl_riscv_32

def llvm_shl_lower_riscv_nuw_32: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := shl_llvm_nuw_32
  rhs := shl_riscv_32

def llvm_shl_lower_riscv_nsw_nuw_32: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := shl_llvm_nsw_nuw_32
  rhs := shl_riscv_32

def shl_match_32 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_shl_lower_riscv_32, llvm_shl_lower_riscv_nsw_32, llvm_shl_lower_riscv_nsw_nuw_32, llvm_shl_lower_riscv_nuw_32]

/-! # SHL i16 -/

@[simp_denote]
def shl_llvm_16 := [LV| {
    ^entry (%x: i16, %y: i16):
    %1 = llvm.shl %x, %y : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def shl_llvm_nsw_16 := [LV| {
    ^entry (%x: i16, %y: i16):
    %1 = llvm.shl %x, %y overflow<nsw> : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def shl_llvm_nuw_16 := [LV| {
    ^entry (%x: i16, %y: i16):
    %1 = llvm.shl %x, %y overflow<nuw> : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def shl_llvm_nsw_nuw_16 := [LV| {
    ^entry (%x: i16, %y: i16):
    %1 = llvm.shl  %x, %y overflow<nsw,nuw> : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def shl_riscv_16 := [LV| {
    ^entry (%reg1: i16, %reg2: i16 ):
    %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i16) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i16) -> (!i64)
    %2 = sll %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i16)
    llvm.return %3 : i16
  }]

@[simp_denote]
def llvm_shl_lower_riscv_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := shl_llvm_16
  rhs := shl_riscv_16

def llvm_shl_lower_riscv_nsw_16: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := shl_llvm_nsw_16
  rhs := shl_riscv_16

def llvm_shl_lower_riscv_nuw_16: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := shl_llvm_nuw_16
  rhs := shl_riscv_16

def llvm_shl_lower_riscv_nsw_nuw_16: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := shl_llvm_nsw_nuw_16
  rhs := shl_riscv_16

def shl_match_16 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_shl_lower_riscv_16, llvm_shl_lower_riscv_nsw_16, llvm_shl_lower_riscv_nsw_nuw_16, llvm_shl_lower_riscv_nuw_16]

/-! # SHL i8 -/

@[simp_denote]
def shl_llvm_8 := [LV| {
    ^entry (%x: i8, %y: i8):
    %1 = llvm.shl %x, %y : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def shl_llvm_nsw_8 := [LV| {
    ^entry (%x: i8, %y: i8):
    %1 = llvm.shl %x, %y overflow<nsw> : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def shl_llvm_nuw_8 := [LV| {
    ^entry (%x: i8, %y: i8):
    %1 = llvm.shl %x, %y overflow<nuw> : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def shl_llvm_nsw_nuw_8 := [LV| {
    ^entry (%x: i8, %y: i8):
    %1 = llvm.shl  %x, %y overflow<nsw,nuw> : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def shl_riscv_8 := [LV| {
    ^entry (%reg1: i8, %reg2: i8 ):
    %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i8) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i8) -> (!i64)
    %2 = sll %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i8)
    llvm.return %3 : i8
  }]

@[simp_denote]
def llvm_shl_lower_riscv_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := shl_llvm_8
  rhs := shl_riscv_8

def llvm_shl_lower_riscv_nsw_8: LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := shl_llvm_nsw_8
  rhs := shl_riscv_8

def llvm_shl_lower_riscv_nuw_8: LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := shl_llvm_nuw_8
  rhs := shl_riscv_8

def llvm_shl_lower_riscv_nsw_nuw_8: LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := shl_llvm_nsw_nuw_8
  rhs := shl_riscv_8

def shl_match_8 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_shl_lower_riscv_8, llvm_shl_lower_riscv_nsw_8, llvm_shl_lower_riscv_nsw_nuw_8, llvm_shl_lower_riscv_nuw_8]
