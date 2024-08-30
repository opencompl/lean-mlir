import SSA.Projects.InstCombine.ForMathlib
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.TacticAuto

namespace HackersDelight

namespace Ch2Basics

variable {x y : BitVec w}

def UnsignedMultiplicationOverflows? (x y : BitVec w) : Prop := x.toNat * y.toNat > 2 ^ w

theorem mul_div_neq_imp_unsigned_mul_overflow (h : y.toNat ≠ 0) :
    (x * y) / z ≠ x → UnsignedMultiplicationOverflows? x y := by
  sorry

end Ch2Basics

end HackersDelight
