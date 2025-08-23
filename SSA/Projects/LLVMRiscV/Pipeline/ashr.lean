import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV


/- # ASHR, not exact -/
@[simp_denote]
def ashr_llvm_no_flag := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.ashr %x, %amount : i64
    llvm.return %1 : i64
  }]

/- # ASHR,  exact -/
@[simp_denote]
def ashr_llvm_exact_flag := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.ashr exact %x, %amount : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def ashr_riscv := [LV| {
    ^entry (%x: i64, %amount: i64):
    %base = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
    %shamt = "builtin.unrealized_conversion_cast" (%amount) : (i64) -> (!i64)
    %res = sra %base, %shamt : !i64
    %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i64)
    llvm.return %y : i64
  }]

def llvm_ashr_lower_riscv_no_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := ashr_llvm_no_flag
  rhs := ashr_riscv

def llvm_ashr_lower_riscv_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := ashr_llvm_exact_flag
  rhs := ashr_riscv


def ashr_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_ashr_lower_riscv_no_flag,llvm_ashr_lower_riscv_flag]
