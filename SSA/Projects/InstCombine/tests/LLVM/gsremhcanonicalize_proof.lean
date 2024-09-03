
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsremhcanonicalize_proof
theorem test_srem_canonicalize_op0_thm (x x_1 : BitVec 32) :
  Option.map (fun div => -x_1 - div * x)
      (if x = 0#32 ∨ -x_1 = intMin 32 ∧ x = 4294967295#32 then none else some ((-x_1).sdiv x)) ⊑
    (Option.map (fun div => x_1 - div * x)
          (if x = 0#32 ∨ x_1 = intMin 32 ∧ x = 4294967295#32 then none else some (x_1.sdiv x))).bind
      fun a => some (-a) := sorry

