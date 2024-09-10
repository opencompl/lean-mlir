
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsdivhcanonicalize_proof
theorem test_sdiv_canonicalize_op0_thm (x x_1 : BitVec 32) :
  (if x = 0#32 ∨ -x_1 = intMin 32 ∧ x = 4294967295#32 then none else some ((-x_1).sdiv x)) ⊑
    Option.bind (if x = 0#32 ∨ x_1 = intMin 32 ∧ x = 4294967295#32 then none else some (x_1.sdiv x)) fun a =>
      some (-a) := sorry

theorem test_sdiv_canonicalize_op0_exact_thm (x x_1 : BitVec 32) :
  (if x = 0#32 ∨ -x_1 = intMin 32 ∧ x = 4294967295#32 then none else some ((-x_1).sdiv x)) ⊑
    Option.bind (if x = 0#32 ∨ x_1 = intMin 32 ∧ x = 4294967295#32 then none else some (x_1.sdiv x)) fun a =>
      some (-a) := sorry

