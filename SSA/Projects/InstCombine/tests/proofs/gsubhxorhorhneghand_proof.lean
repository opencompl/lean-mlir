
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubhxorhorhneghand_proof
theorem sub_to_and_thm (x x_1 : BitVec 32) : (x_1 ^^^ x) - (x_1 ||| x) = -(x_1 &&& x) := by bv_compare'

theorem sub_to_and_or_commuted_thm (x x_1 : BitVec 32) : (x_1 ^^^ x) - (x ||| x_1) = -(x_1 &&& x) := by bv_compare'

theorem sub_to_and_and_commuted_thm (x x_1 : BitVec 32) : (x_1 ^^^ x) - (x ||| x_1) = -(x_1 &&& x) := by bv_compare'

