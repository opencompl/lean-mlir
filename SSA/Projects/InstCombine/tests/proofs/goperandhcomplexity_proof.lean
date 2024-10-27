
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section goperandhcomplexity_proof
theorem neg_thm (x : BitVec 8) : -x ^^^ x / 42#8 = x / 42#8 ^^^ -x := sorry

theorem not_thm (x : BitVec 8) : (255#8 ^^^ x) * (x / 42#8) = x / 42#8 * (x ^^^ 255#8) := sorry

