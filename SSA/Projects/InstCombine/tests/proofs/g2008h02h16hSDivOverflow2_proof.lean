
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2008h02h16hSDivOverflow2_proof
theorem i_thm (x : BitVec 8) : (x.sdiv 253#8).sdiv 253#8 = x.sdiv 9#8 := by bv_compare'

