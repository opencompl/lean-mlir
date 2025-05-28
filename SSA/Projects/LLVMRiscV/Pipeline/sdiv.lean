import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-! # SDIV no exact   -/

def sdiv_llvm_no_exact := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.sdiv %x, %y : i64
    llvm.return %1 : i64
  }]

def sdiv_riscv := [LV| {
    ^entry (%reg1: i64, %reg2: i64):
    %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i64) -> (!i64)
    %2 = div %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def llvm_sdiv_lower_riscv_no_flag: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := sdiv_llvm_no_exact
  rhs := sdiv_riscv
  correct := by
    unfold sdiv_llvm_no_exact sdiv_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    by_cases onX2 : x' = 0#64 <;> simp [onX2]

/-! # SDIV exact  -/
def sdiv_llvm_exact := [LV| {
    ^entry (%x: i64, %y: i64 ):
    %1 = llvm.sdiv exact %x, %y : i64
    llvm.return %1 : i64
  }]

def llvm_sdiv_lower_riscv_exact : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := sdiv_llvm_exact
  rhs := sdiv_riscv
  correct := by
    unfold sdiv_llvm_exact sdiv_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    by_cases onX2 : x' = 0#64 <;> simp [onX2]
    by_cases hx : x.smod x' = 0#64
    simp only [hx, ↓reduceIte, Nat.ofNat_pos, PoisonOr.if_then_poison_isRefinedBy_iff, not_and,
      PoisonOr.isRefinedBy_self, implies_true] -- to do
    split <;> simp

def sdiv_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewriteBin 64 64 (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_sdiv_lower_riscv_no_flag, llvm_sdiv_lower_riscv_exact]
