import SSA.Projects.RISCV64.PrettyEDSL
import LeanMLIR.Framework
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

namespace BitVec
open LLVMRiscV


@[simp_denote]
def source := [LV| {
  ^entry (%x : i32, %y : i32):
  %32 = llvm.mlir.constant (64) : i129
  %1 = llvm.sext %x : i32 to i129
  %2 = llvm.sext %y : i32 to i129
  %3 = llvm.mul %1, %2 : i129
  %4 = llvm.ashr %3, %32: i129
  %5 = llvm.trunc %4: i129 to i32
  llvm.return %5 : i32
}]

@[simp_denote]
def target := [LV| {
  ^entry (%x : i32, %y : i32):
  %castx = "builtin.unrealized_conversion_cast" (%x) : (i32) -> (!i64)
  %casty = "builtin.unrealized_conversion_cast" (%y) : (i32) -> (!i64)
  %0 = mulh %castx, %casty : !i64
  %castBack = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i32)
  llvm.return %castBack : i32
  }]

@[simp]
theorem signExtend_signExtend (x : BitVec w) (h : w ≤ v) :
  BitVec.signExtend v' (BitVec.signExtend v x) = BitVec.signExtend v' x := by
    ext k hk
    simp [getElem_signExtend]
    intros hvk
    simp [msb_signExtend]
    rcases v with _|v'
    · have : w = 0 := by omega
      subst this
      simp [of_length_zero]
    · simp only [lt_add_iff_pos_left, add_pos_iff, zero_lt_one, or_true, decide_true,
        getMsbD_eq_getLsbD (by omega), tsub_lt_self_iff, and_true, BitStream.eval_ofNatUnary,
        BitVec.msb, tsub_zero, Bool.true_and, show ¬k < w by omega, ↓reduceDIte, ite_eq_right_iff]
      intros
      congr 2
      omega


def source_target : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs:= source
  rhs:= target
  correct := by
    simp_lowering
    rw [signExtend_signExtend _ (by omega), signExtend_signExtend _ (by omega)]
    rename_i x y hxy
    bv_decide
