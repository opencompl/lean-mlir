import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-
Removing bitvec lemmas from the simp-set that simplify bitvector operations into toNat operations.
-/
attribute [-simp] BitVec.ushiftRight_eq' BitVec.shiftLeft_eq' BitVec.sshiftRight_eq'

/- # SRL, not exact
Logical right shift operation in LLVM: if exact flag is set,
then returns poison if any nonzero bit is shifted  -/

@[simp_denote]
def lshr_llvm_no_flag := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.lshr %x, %amount : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def srl_riscv := [LV| {
    ^entry (%x: i64, %amount: i64):
    %base = "builtin.unrealized_conversion_cast"(%x) : (i64) -> (!i64)
    %shamt = "builtin.unrealized_conversion_cast"(%amount) : (i64) -> (!i64)
    %res = srl %base, %shamt : !i64
    %y= "builtin.unrealized_conversion_cast"(%res) : (!i64) -> (i64)
    llvm.return %y : i64
  }]

@[simp_denote]
def llvm_srl_lower_riscv : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := lshr_llvm_no_flag
  rhs := srl_riscv

@[simp_denote]
def lshr_llvm_exact := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.lshr exact %x, %amount : i64
    llvm.return %1 : i64
  }]

def llvm_srl_lower_riscv_exact : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := lshr_llvm_exact
  rhs := srl_riscv

def srl_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_srl_lower_riscv_exact, llvm_srl_lower_riscv]
