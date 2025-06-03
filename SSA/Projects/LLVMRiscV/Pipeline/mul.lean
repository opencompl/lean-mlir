import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
open LLVMRiscV



/- # MUL RISCV  -/

def mul_riscv := [LV| {
    ^entry (%r1: i64, %r2: i64 ):
    %0 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> (!i64)
    %2 = mul %0, %1 : !i64
    %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

/- # MUL NO FLAG  -/

def mul_llvm_noflag := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount : i64
    llvm.return %1 : i64
  }]

/- # MUL FLAGS -/

def mul_llvm_nsw := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount overflow<nsw> : i64
    llvm.return %1 : i64
  }]

def mul_llvm_nuw := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount overflow<nuw> : i64
    llvm.return %1 : i64
  }]

def mul_llvm_flags := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount overflow<nsw,nuw> : i64
    llvm.return %1 : i64
  }]

def llvm_mul_lower_riscv_noflag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_noflag
  rhs := mul_riscv
  correct := by
    unfold mul_llvm_noflag mul_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.setWidth_eq, BitVec.signExtend_eq]
    bv_auto

def llvm_mul_lower_riscv_flags : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_flags
  rhs := mul_riscv
  correct := by
    unfold mul_llvm_flags mul_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.setWidth_eq, BitVec.signExtend_eq]
    bv_auto

def llvm_mul_lower_riscv_nsw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_nsw
  rhs := mul_riscv
  correct := by
    unfold mul_llvm_nsw mul_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.setWidth_eq, BitVec.signExtend_eq]
    bv_auto

def llvm_mul_lower_riscv_nuw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_nuw
  rhs := mul_riscv
  correct := by
    unfold mul_llvm_nuw mul_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.setWidth_eq, BitVec.signExtend_eq]
    bv_auto

def mul_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
<<<<<<< HEAD
  List.map (fun x => mkRewriteBin 64 64 (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
=======
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
>>>>>>> origin/main
  [llvm_mul_lower_riscv_noflag, llvm_mul_lower_riscv_flags, llvm_mul_lower_riscv_nsw_flag,
    llvm_mul_lower_riscv_nuw_flag]
