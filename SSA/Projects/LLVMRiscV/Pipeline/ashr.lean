import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV


/- # ASHR, not exact -/
def ashr_llvm_no_flag := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.ashr %x, %amount : i64
    llvm.return %1 : i64
  }]

/- # ASHR,  exact -/
def ashr_llvm_exact_flag := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.ashr exact %x, %amount : i64
    llvm.return %1 : i64
  }]

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
  correct := by
    unfold ashr_llvm_no_flag ashr_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_case_bash
    intro x x'
    simp_alive_ops
    split
    case value.value.isTrue ht =>
      simp
    case value.value.isFalse hf =>
      simp only [BitVec.sshiftRight_eq', Nat.sub_zero, Nat.reduceAdd, PoisonOr.toOption_getSome,
        BitVec.setWidth_eq, BitVec.extractLsb_toNat, Nat.shiftRight_zero, tsub_zero, Nat.reducePow,
        BitVec.signExtend_eq, PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
      simp only [Nat.cast_ofNat, BitVec.ofNat_eq_ofNat, ge_iff_le, BitVec.not_le] at hf
      rw [Nat.mod_eq_of_lt (a:= x'.toNat) (b:= 64)]
      bv_omega

def llvm_ashr_lower_riscv_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := ashr_llvm_exact_flag
  rhs := ashr_riscv
  correct := by
    unfold ashr_llvm_exact_flag ashr_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp only [BitVec.ushiftRight_eq', BitVec.shiftLeft_eq', BitVec.shiftLeft_ushiftRight,
      BitVec.reduceAllOnes, ne_eq, true_and, LLVM.ashr?, Nat.cast_ofNat, BitVec.ofNat_eq_ofNat,
      ge_iff_le, BitVec.sshiftRight_eq', ite_not, Nat.sub_zero, Nat.reduceAdd, BitVec.setWidth_eq,
      BitVec.extractLsb_toNat, Nat.shiftRight_zero, tsub_zero, Nat.reducePow, BitVec.signExtend_eq]
    simp_alive_case_bash
    intro x x'
    simp_alive_split
    simp only [PoisonOr.toOption_getSome]
    rw [Nat.mod_eq_of_lt (a:= x'.toNat) (b:= 64)]
    bv_omega

def ashr_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_ashr_lower_riscv_no_flag,llvm_ashr_lower_riscv_flag]
