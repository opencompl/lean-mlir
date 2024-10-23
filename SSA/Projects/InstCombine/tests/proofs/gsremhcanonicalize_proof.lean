
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsremhcanonicalize_proof
theorem test_srem_canonicalize_op0_thm (x x_1 : BitVec 32) :
  ((if (-signExtend 33 x_1).msb = (-signExtend 33 x_1).getMsbD 1 then some (-x_1) else none).bind fun a =>
      Option.map (fun div => a - div * x)
        (if x = 0#32 ∨ a = intMin 32 ∧ x = 4294967295#32 then none else some (a.sdiv x))) ⊑
    (Option.map (fun div => x_1 - div * x)
          (if x = 0#32 ∨ x_1 = intMin 32 ∧ x = 4294967295#32 then none else some (x_1.sdiv x))).bind
      fun a => if (-signExtend 33 a).msb = (-signExtend 33 a).getMsbD 1 then some (-a) else none := sorry

