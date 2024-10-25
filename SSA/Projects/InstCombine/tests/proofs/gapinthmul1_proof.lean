
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthmul1_proof
theorem test1_thm (x : BitVec 17) : x * 1024#17 = x <<< 10 := by bv_compare'

