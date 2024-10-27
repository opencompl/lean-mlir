
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2012h08h28hudiv_ashl_proof
theorem udiv400_thm (x : BitVec 32) : x >>> 2 / 100#32 = x / 400#32 := by bv_compare'

theorem sdiv400_yes_thm (x : BitVec 32) : (x >>> 2).sdiv 100#32 = x / 400#32 := by bv_compare'

theorem udiv_i80_thm (x : BitVec 80) : x >>> 2 / 100#80 = x / 400#80 := by bv_compare'

