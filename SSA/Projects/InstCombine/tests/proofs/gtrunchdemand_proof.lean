
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gtrunchdemand_proof
theorem trunc_lshr_thm (x : BitVec 8) : setWidth 6 (x >>> 2) &&& 14#6 = setWidth 6 x >>> 2 &&& 14#6 := sorry

theorem trunc_lshr_exact_mask_thm (x : BitVec 8) : setWidth 6 (x >>> 2) &&& 15#6 = setWidth 6 x >>> 2 := sorry

theorem or_trunc_lshr_thm (x : BitVec 8) : setWidth 6 (x >>> 1) ||| 32#6 = setWidth 6 x >>> 1 ||| 32#6 := sorry

theorem or_trunc_lshr_more_thm (x : BitVec 8) : setWidth 6 (x >>> 4) ||| 60#6 = setWidth 6 x >>> 4 ||| 60#6 := sorry

