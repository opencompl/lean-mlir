
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gassochcasthassoc_proof
theorem XorZextXor_thm (x : BitVec 3) : setWidth 5 x ^^^ 3#5 ^^^ 12#5 = setWidth 5 x ^^^ 15#5 := sorry

theorem OrZextOr_thm (x : BitVec 3) : setWidth 5 x ||| 3#5 ||| 8#5 = setWidth 5 x ||| 11#5 := sorry

theorem AndZextAnd_thm (x : BitVec 3) : setWidth 5 x &&& 3#5 &&& 14#5 = setWidth 5 x &&& 2#5 := sorry

theorem zext_nneg_thm (x : BitVec 16) : setWidth 24 x &&& 32767#24 &&& 8388607#24 = setWidth 24 x &&& 32767#24 := sorry

