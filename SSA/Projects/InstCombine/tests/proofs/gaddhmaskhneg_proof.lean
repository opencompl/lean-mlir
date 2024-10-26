
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gaddhmaskhneg_proof
theorem dec_mask_neg_i32_thm (x : BitVec 32) : (-x &&& x) + 4294967295#32 = x + 4294967295#32 &&& (x ^^^ 4294967295#32) := sorry

theorem dec_mask_commute_neg_i32_thm (x : BitVec 32) :
  (Option.bind (if x = 0#32 ∨ 42#32 = intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x)) fun a =>
      Option.bind (if x = 0#32 ∨ 42#32 = intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x)) fun a_1 =>
        some ((a &&& -a_1) + 4294967295#32)) ⊑
    Option.bind (if x = 0#32 ∨ 42#32 = intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x)) fun a =>
      (if a.msb = (4294967295#32).msb ∧ ¬(a + 4294967295#32).msb = a.msb then none else some (a + 4294967295#32)).bind
        fun a =>
        Option.bind (if x = 0#32 ∨ 42#32 = intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x)) fun x =>
          some (a &&& (x ^^^ 4294967295#32)) := sorry

theorem dec_commute_mask_neg_i32_thm (x : BitVec 32) : 4294967295#32 + (-x &&& x) = x + 4294967295#32 &&& (x ^^^ 4294967295#32) := sorry

