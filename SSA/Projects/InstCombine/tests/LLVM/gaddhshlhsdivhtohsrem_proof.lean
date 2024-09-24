
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gaddhshlhsdivhtohsrem_proof
theorem addhshlhsdivhscalar0_thm (x : BitVec 8) : x.sdiv 252#8 <<< 2 + x = x - x.sdiv 4#8 * 4#8 := sorry

theorem addhshlhsdivhscalar1_thm (x : BitVec 8) : x.sdiv 192#8 <<< 6 + x = x - x.sdiv 64#8 * 64#8 := sorry

theorem addhshlhsdivhscalar2_thm (x : BitVec 32) :
  x.sdiv 3221225472#32 <<< 30 + x = x - x.sdiv 1073741824#32 * 1073741824#32 := sorry

theorem addhshlhsdivhnegative1_thm (x : BitVec 32) :
  (Option.bind (if x = intMin 32 then none else some (x.sdiv 4294967295#32)) fun a => some (a <<< 1 + x)) ⊑
    some (-x) := sorry

