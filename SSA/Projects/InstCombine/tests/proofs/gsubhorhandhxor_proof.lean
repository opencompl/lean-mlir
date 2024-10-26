
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubhorhandhxor_proof
theorem sub_to_xor_thm (x x_1 : BitVec 32) : (x_1 ||| x) - (x_1 &&& x) = x_1 ^^^ x := sorry

theorem sub_to_xor_or_commuted_thm (x x_1 : BitVec 32) : (x_1 ||| x) - (x &&& x_1) = x ^^^ x_1 := sorry

theorem sub_to_xor_and_commuted_thm (x x_1 : BitVec 32) : (x_1 ||| x) - (x &&& x_1) = x ^^^ x_1 := sorry

