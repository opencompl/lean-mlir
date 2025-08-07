import SSA.Projects.InstCombine.TacticAuto

/- 2-1 De Morgan’s Laws Extended -/

set_option Elab.async false
set_option warn.sorry false

namespace HackersDelight

namespace Ch2Basics

namespace DeMorgansLawsExtended

variable {x y z : BitVec WIDTH}

theorem not_and_eq_not_or_not :
    ~~~ (x &&& y) = ~~~ x ||| ~~~ y := by
  all_goals sorry

theorem not_or_eq_not_and_not :
    ~~~ (x ||| y) = ~~~ x &&& ~~~ y := by
  all_goals sorry

theorem not_add_one_eq_not_sub_one :
    ~~~ (x + 1) = ~~~ x - 1 := by
  all_goals sorry

theorem not_sub_one_eq_not_add_one :
    ~~~ (x - 1) = ~~~ x + 1 := by
  all_goals sorry

theorem not_neg_eq_sub_one :
    ~~~ (- x) = x - 1 := by
  all_goals sorry

theorem not_xor_eq_not_xor :
    ~~~ (x ^^^ y) = ~~~ x ^^^ y := by
  all_goals sorry

theorem q_not_xor :
    ~~~ (x ^^^ y) = ~~~ x ^^^ y := by
  all_goals sorry

theorem not_add_eq_not_sub :
    ~~~ (x + y) = ~~~ x - y := by
  all_goals sorry

theorem not_sub_eq_not_add :
    ~~~ (x - y) = ~~~ x + y := by
  all_goals sorry

end DeMorgansLawsExtended

end Ch2Basics

end HackersDelight
