
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gandhnarrow_proof
theorem zext_add_thm (x : BitVec 8) :
  setWidth 16 x + 44#16 &&& setWidth 16 x = setWidth 16 (x + 44#8) &&& setWidth 16 x := sorry

theorem zext_sub_thm (x : BitVec 8) :
  65531#16 - setWidth 16 x &&& setWidth 16 x = setWidth 16 (251#8 - x) &&& setWidth 16 x := sorry

theorem zext_mul_thm (x : BitVec 8) :
  setWidth 16 x * 3#16 &&& setWidth 16 x = setWidth 16 (x * 3#8) &&& setWidth 16 x := sorry

theorem zext_lshr_thm (x : BitVec 8) :
  setWidth 16 x >>> 4 &&& setWidth 16 x = setWidth 16 (x >>> 4) &&& setWidth 16 x := sorry

theorem zext_ashr_thm (x : BitVec 8) :
  (setWidth 16 x).sshiftRight 2 &&& setWidth 16 x = setWidth 16 (x >>> 2) &&& setWidth 16 x := sorry

theorem zext_shl_thm (x : BitVec 8) :
  setWidth 16 x <<< 3 &&& setWidth 16 x = setWidth 16 (x <<< 3) &&& setWidth 16 x := sorry

