
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthxor1_proof
theorem test1_thm (x x_1 : BitVec 47) :
  x_1 &&& 70368744177664#47 ^^^ x &&& 70368744177661#47 = x_1 &&& 70368744177664#47 ||| x &&& 70368744177661#47 := sorry

theorem test4_thm (x : BitVec 37) : x ^^^ (137438953471#37 ^^^ x) = 137438953471#37 := sorry

theorem test5_thm (x : BitVec 7) : (x ||| 23#7) ^^^ 23#7 = x &&& 104#7 := sorry

theorem test6_thm (x : BitVec 7) : x ^^^ 23#7 ^^^ 23#7 = x := sorry

theorem test7_thm (x : BitVec 47) :
  (x ||| 70368744177663#47) ^^^ 703687463#47 = x &&& 70368744177664#47 ||| 70368040490200#47 := sorry

