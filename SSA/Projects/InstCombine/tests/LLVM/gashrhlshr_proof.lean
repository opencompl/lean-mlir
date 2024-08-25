import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem ashr_known_pos_exact_thm (x x_1 : _root_.BitVec 8) :
  (if 8 ≤ x.toNat then none else some ((x_1 &&& 127#8).sshiftRight x.toNat)) ⊑
    if 8 ≤ x.toNat then none else some ((x_1 &&& 127#8) >>> x) := by
  sorry

