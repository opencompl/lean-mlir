
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthmul2_proof
theorem test1_thm (x : BitVec 177) : x * 45671926166590716193865151022383844364247891968#177 = x <<< 155 := by bv_compare'

