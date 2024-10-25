
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsignmaskhofhsexthvshofhshlhofhzext_proof
theorem t0_thm (x : BitVec 16) :
  setWidth 32 x <<< 16 &&& 2147483648#32 = signExtend 32 x &&& 2147483648#32 := sorry

theorem t1_thm (x : BitVec 8) : setWidth 32 x <<< 24 &&& 2147483648#32 = signExtend 32 x &&& 2147483648#32 := sorry

theorem n2_thm (x : BitVec 16) : setWidth 32 x <<< 15 &&& 2147483648#32 = 0#32 := sorry

theorem n4_thm (x : BitVec 16) :
  some (setWidth 32 x <<< 16 &&& 3221225472#32) ⊑
    (if setWidth 32 x <<< 16 >>> 16 = setWidth 32 x then none else some (setWidth 32 x <<< 16)).bind fun x' =>
      some (x' &&& 3221225472#32) := sorry

