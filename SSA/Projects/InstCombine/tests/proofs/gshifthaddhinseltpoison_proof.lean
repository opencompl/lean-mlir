
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshifthaddhinseltpoison_proof
theorem ashr_C1_add_A_C2_i32_thm (x : BitVec 32) :
  (if 32#32 ≤ (x &&& 65535#32) + 5#32 then none
    else some ((6#32).sshiftRight (((x.toNat &&& 65535) + 5) % 4294967296))) ⊑
    some 0#32 := sorry

theorem lshr_C1_add_A_C2_i32_thm (x : BitVec 32) :
  (if 32#32 ≤ (x &&& 65535#32) + 5#32 then none else some (6#32 <<< (((x.toNat &&& 65535) + 5) % 4294967296))) ⊑
    if 32#32 ≤ x &&& 65535#32 then none else some (192#32 <<< (x.toNat &&& 65535)) := sorry

