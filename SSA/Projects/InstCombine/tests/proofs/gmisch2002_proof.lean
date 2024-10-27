
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gmisch2002_proof
theorem cast_test_2002h08h02_thm (x : BitVec 64) : setWidth 64 (setWidth 8 x) = x &&& 255#64 := by bv_compare'

