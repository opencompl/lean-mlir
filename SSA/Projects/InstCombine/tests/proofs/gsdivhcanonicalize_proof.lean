
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsdivhcanonicalize_proof
theorem test_sdiv_canonicalize_op0_thm (x x_1 : BitVec 32) :
  ((if (-signExtend 33 x_1).msb = (-signExtend 33 x_1).getMsbD 1 then some (-x_1) else none).bind fun a =>
      if x = 0#32 ∨ a = intMin 32 ∧ x = 4294967295#32 then none else some (a.sdiv x)) ⊑
    Option.bind (if x = 0#32 ∨ x_1 = intMin 32 ∧ x = 4294967295#32 then none else some (x_1.sdiv x)) fun a =>
      if (-signExtend 33 a).msb = (-signExtend 33 a).getMsbD 1 then some (-a) else none := sorry

theorem test_sdiv_canonicalize_op0_exact_thm (x x_1 : BitVec 32) :
  ((if (-signExtend 33 x_1).msb = (-signExtend 33 x_1).getMsbD 1 then some (-x_1) else none).bind fun a =>
      if x = 0#32 ∨ a = intMin 32 ∧ x = 4294967295#32 then none else some (a.sdiv x)) ⊑
    Option.bind (if x = 0#32 ∨ x_1 = intMin 32 ∧ x = 4294967295#32 then none else some (x_1.sdiv x)) fun a =>
      if (-signExtend 33 a).msb = (-signExtend 33 a).getMsbD 1 then some (-a) else none := sorry

