
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section ghoisthnegationhouthofhbiashcalculationhwithhconstant_proof
theorem t0_thm (x : BitVec 8) : (x &&& 42#8) - x = -(x &&& 213#8) := by bv_compare'

theorem n5_thm (x : BitVec 8) : x - (x &&& 42#8) = x &&& 213#8 := by bv_compare'

