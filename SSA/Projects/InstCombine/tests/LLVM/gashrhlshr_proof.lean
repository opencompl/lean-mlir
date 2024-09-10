
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gashrhlshr_proof
theorem ashr_known_pos_exact_thm (x x_1 : BitVec 8) :
  (if 8 ≤ x.toNat then none else some ((x_1 &&& 127#8).sshiftRight x.toNat)) ⊑
    if 8 ≤ x.toNat then none else some ((x_1 &&& 127#8) >>> x.toNat) := sorry

theorem lshr_mul_times_3_div_2_thm (x : BitVec 32) : (x * 3#32) >>> 1 = x >>> 1 + x := sorry

theorem lshr_mul_times_3_div_2_exact_thm (x : BitVec 32) : (x * 3#32) >>> 1 = x >>> 1 + x := sorry

theorem lshr_mul_times_3_div_2_exact_2_thm (x : BitVec 32) : (x * 3#32) >>> 1 = x >>> 1 + x := sorry

theorem lshr_mul_times_5_div_4_thm (x : BitVec 32) : (x * 5#32) >>> 2 = x >>> 2 + x := sorry

theorem lshr_mul_times_5_div_4_exact_thm (x : BitVec 32) : (x * 5#32) >>> 2 = x >>> 2 + x := sorry

theorem lshr_mul_times_5_div_4_exact_2_thm (x : BitVec 32) : (x * 5#32) >>> 2 = x >>> 2 + x := sorry

theorem ashr_mul_times_3_div_2_thm (x : BitVec 32) : (x * 3#32).sshiftRight 1 = x.sshiftRight 1 + x := sorry

theorem ashr_mul_times_3_div_2_exact_thm (x : BitVec 32) : (x * 3#32).sshiftRight 1 = x.sshiftRight 1 + x := sorry

theorem ashr_mul_times_3_div_2_exact_2_thm (x : BitVec 32) : (x * 3#32).sshiftRight 1 = x.sshiftRight 1 + x := sorry

theorem ashr_mul_times_5_div_4_thm (x : BitVec 32) : (x * 5#32).sshiftRight 2 = x.sshiftRight 2 + x := sorry

theorem ashr_mul_times_5_div_4_exact_thm (x : BitVec 32) : (x * 5#32).sshiftRight 2 = x.sshiftRight 2 + x := sorry

theorem ashr_mul_times_5_div_4_exact_2_thm (x : BitVec 32) : (x * 5#32).sshiftRight 2 = x.sshiftRight 2 + x := sorry

