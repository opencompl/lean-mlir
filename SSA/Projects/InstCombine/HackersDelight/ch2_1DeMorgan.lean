import SSA.Projects.InstCombine.TacticAuto

/- 2-1 De Morgan’s Laws Extended -/

namespace HackersDelight

namespace Ch2Basics

namespace DeMorgansLawsExtended

variable {x y z : BitVec 64}

theorem not_and_eq_not_or_not :
    ~~~ (x &&& y) = ~~~ x ||| ~~~ y := by
  bv_bench

theorem not_or_eq_not_and_not :
    ~~~ (x ||| y) = ~~~ x &&& ~~~ y := by
  bv_bench

theorem not_add_one_eq_not_sub_one :
    ~~~ (x + 1) = ~~~ x - 1 := by
  bv_bench

theorem not_sub_one_eq_not_add_one :
    ~~~ (x - 1) = ~~~ x + 1 := by
  bv_bench

theorem not_neg_eq_sub_one :
    ~~~ (- x) = x - 1 := by
  bv_bench

theorem not_xor_eq_not_xor :
    ~~~ (x ^^^ y) = ~~~ x ^^^ y := by
  bv_bench

theorem q_not_xor :
    ~~~ (x ^^^ y) = ~~~ x ^^^ y := by
  bv_bench

theorem not_add_eq_not_sub :
    ~~~ (x + y) = ~~~ x - y := by
  bv_bench

theorem not_sub_eq_not_add :
    ~~~ (x - y) = ~~~ x + y := by
  bv_bench

end DeMorgansLawsExtended

end Ch2Basics

end HackersDelight
