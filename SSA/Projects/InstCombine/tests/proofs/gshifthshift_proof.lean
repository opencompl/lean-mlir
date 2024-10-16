
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshifthshift_proof
theorem shl_shl_thm (x : BitVec 32) : x <<< 34 = 0#32 := sorry

theorem lshr_lshr_thm (x : BitVec 232) : x >>> 232 = 0#232 := sorry

theorem ashr_shl_constants_thm (x : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some ((4294967263#32).sshiftRight x.toNat)) fun a => some (a <<< 3)) ⊑
    Option.bind (if 32#32 ≤ x then none else some ((4294967263#32).sshiftRight x.toNat)) fun a =>
      if (a <<< 3).sshiftRight 3 = a then none else some (a <<< 3) := sorry

theorem shl_lshr_demand1_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (40#8 <<< x.toNat)) fun a => some (a >>> 3 ||| 224#8)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (5#8 <<< x.toNat)) fun a => some (a ||| 224#8) := sorry

theorem shl_lshr_demand6_thm (x : BitVec 16) :
  (Option.bind (if 16#16 ≤ x then none else some (32912#16 <<< x.toNat)) fun a => some (a >>> 4 &&& 4094#16)) ⊑
    Option.bind (if 16#16 ≤ x then none else some (2057#16 <<< x.toNat)) fun a => some (a &&& 4094#16) := sorry

theorem lshr_shl_demand1_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (28#8 >>> x.toNat)) fun a => some (a <<< 3 ||| 7#8)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (224#8 >>> x.toNat)) fun a => some (a ||| 7#8) := sorry

theorem lshr_shl_demand3_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (28#8 >>> x.toNat)) fun a => some (a <<< 3 ||| 3#8)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (28#8 >>> x.toNat)) fun a =>
      (if a <<< 3 >>> 3 = a then none else some (a <<< 3)).bind fun a => some (a ||| 3#8) := sorry

