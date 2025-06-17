import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
open LLVMRiscV



/- # MUL RISCV  -/
@[simp_denote]
def mul_riscv := [LV| {
    ^entry (%r1: i64, %r2: i64 ):
    %0 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> (!i64)
    %2 = mul  %1, %0 : !i64 -- this is because the semanitcs specify mul rs1 rs2 to be passed as multiplication rs2 rs1 which is defined as rs2 * rs1, hence to keep correct assembly syntax and semanitcs.
    %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

/- # MUL NO FLAG  -/
@[simp_denote]
def mul_llvm_noflag := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount : i64
    llvm.return %1 : i64
  }]

/- # MUL FLAGS -/
@[simp_denote]
def mul_llvm_nsw := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount overflow<nsw> : i64
    llvm.return %1 : i64
  }]
@[simp_denote]
def mul_llvm_nuw := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount overflow<nuw> : i64
    llvm.return %1 : i64
  }]
@[simp_denote]
def mul_llvm_flags := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount overflow<nsw,nuw> : i64
    llvm.return %1 : i64
  }]

def llvm_mul_lower_riscv_noflag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_noflag
  rhs := mul_riscv


example (a b : BitVec 128) : a * b = b * a := by bv_decide +acNf

-- a b : BitVec 64
-- ⊢ a * b = b * a
def llvm_mul_lower_riscv_flags : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_flags
  rhs := mul_riscv

def llvm_mul_lower_riscv_nsw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_nsw
  rhs := mul_riscv

def llvm_mul_lower_riscv_nuw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_nuw
  rhs := mul_riscv

def mul_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_mul_lower_riscv_noflag, llvm_mul_lower_riscv_flags, llvm_mul_lower_riscv_nsw_flag,
    llvm_mul_lower_riscv_nuw_flag]
