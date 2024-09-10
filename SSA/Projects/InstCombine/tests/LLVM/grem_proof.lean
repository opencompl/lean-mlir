
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section grem_proof
theorem test1_thm (x : BitVec 32) : x - x.sdiv 1#32 = 0#32 := sorry

theorem test3_thm (x : BitVec 32) : BitVec.ofNat 32 (x.toNat % 8) = x &&& 7#32 := sorry

theorem test7_thm (x : BitVec 32) : x * 8#32 - (x * 8#32).sdiv 4#32 * 4#32 = 0#32 := sorry

theorem test8_thm (x : BitVec 32) : x <<< 4 - (x <<< 4).sdiv 8#32 * 8#32 = 0#32 := sorry

theorem test9_thm (x : BitVec 32) : BitVec.ofNat 32 (x.toNat * 64 % 4294967296 % 32) = 0#32 := sorry

theorem test11_thm (x : BitVec 32) : BitVec.ofNat 32 ((x.toNat &&& 4294967294) * 2 % 4294967296 % 4) = 0#32 := sorry

theorem test12_thm (x : BitVec 32) : (x &&& 4294967292#32) - (x &&& 4294967292#32).sdiv 2#32 * 2#32 = 0#32 := sorry

theorem test13_thm (x : BitVec 32) :
  Option.map (fun div => x - div * x) (if x = 0#32 ∨ x = intMin 32 ∧ x = 4294967295#32 then none else some (x.sdiv x)) ⊑
    some 0#32 := sorry

theorem test16_thm (x x_1 : BitVec 32) :
  (if ((x.toNat >>> 11 &&& 4) + 4) % 4294967296 = 0 then none
    else some (BitVec.ofNat 32 (x_1.toNat % (((x.toNat >>> 11 &&& 4) + 4) % 4294967296)))) ⊑
    some ((x >>> 11 &&& 4#32 ||| 3#32) &&& x_1) := sorry

theorem test22_thm (x : BitVec 32) :
  (x &&& 2147483647#32) - (x &&& 2147483647#32).sdiv 2147483647#32 * 2147483647#32 =
    BitVec.ofNat 32 ((x.toNat &&& 2147483647) % 2147483647) := sorry

