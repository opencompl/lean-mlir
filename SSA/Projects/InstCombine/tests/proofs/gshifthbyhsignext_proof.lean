
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshifthbyhsignext_proof
theorem t0_shl_thm (x : BitVec 8) (x_1 : BitVec 32) :
  (if 32#32 ≤ signExtend 32 x then none else some (x_1 <<< (signExtend 32 x).toNat)) ⊑
    if 32#32 ≤ setWidth 32 x then none else some (x_1 <<< (x.toNat % 4294967296)) := by bv_compare'

theorem t1_lshr_thm (x : BitVec 8) (x_1 : BitVec 32) :
  (if 32#32 ≤ signExtend 32 x then none else some (x_1 >>> (signExtend 32 x).toNat)) ⊑
    if 32#32 ≤ setWidth 32 x then none else some (x_1 >>> (x.toNat % 4294967296)) := by bv_compare'

theorem t2_ashr_thm (x : BitVec 8) (x_1 : BitVec 32) :
  (if 32#32 ≤ signExtend 32 x then none else some (x_1.sshiftRight (signExtend 32 x).toNat)) ⊑
    if 32#32 ≤ setWidth 32 x then none else some (x_1.sshiftRight (x.toNat % 4294967296)) := by bv_compare'

