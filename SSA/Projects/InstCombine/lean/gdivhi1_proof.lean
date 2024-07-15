import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)

theorem srem_i1_is_zero_thm (x x_1 : _root_.BitVec 1) :
  Option.map (fun div => x_1 ^^^ div &&& x) (if x = 0#1 then none else some (x_1.sdiv x)) ⊑ some 0#1 := by
  sorry

theorem urem_i1_is_zero_thm (x x_1 : _root_.BitVec 1) :
  (if x.toNat = 0 then none else some (BitVec.ofNat 1 (x_1.toNat % x.toNat))) ⊑ some 0#1 := by
  sorry

theorem sdiv_i1_is_op0_thm (x x_1 : _root_.BitVec 1) : 
    (if x = 0#1 then none else some (x_1.sdiv x)) ⊑ some x_1 := by
  sorry
