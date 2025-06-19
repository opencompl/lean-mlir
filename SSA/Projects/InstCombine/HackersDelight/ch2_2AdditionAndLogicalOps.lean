import SSA.Projects.InstCombine.TacticAuto
set_option Elab.async false
/- 2–2 Addition Combined with Logical Operations -/

namespace HackersDelight

namespace Ch2Basics

namespace AdditionCombinedWithLogicalOperations

variable {x y z : BitVec 64}

theorem neg_eq_not_add_one :
    -x = ~~~ x + 1 := by
  all_goals bv_compare'

theorem neg_eq_neg_not_one :
    -x = ~~~ (x - 1) := by
  all_goals bv_compare'

theorem not_eq_neg_sub_one :
    ~~~ x = - x - 1:= by
  all_goals bv_compare'

theorem neg_not_eq_add_one :
    - ~~~ x = x + 1 := by
  all_goals bv_compare'

theorem not_neg_eq_sub_one :
    ~~~ (-x) = x - 1 := by
  all_goals bv_compare'

theorem add_eq_sub_not_sub_one :
    x + y = x - ~~~ y - 1 := by
  all_goals bv_compare'

theorem add_eq_xor_add_mul_and :
    x + y = (x ^^^ y) + 2 * (x &&& y) := by
  all_goals bv_compare'

theorem add_eq_or_add_and :
    x + y = (x ||| y) + (x &&& y) := by
  all_goals bv_compare'

theorem add_eq_mul_or_neg_xor :
    x + y = 2 * (x ||| y) - (x ^^^ y) := by
  all_goals bv_compare'

theorem sub_eq_add_not_add_one :
    x - y = x + ~~~ y + 1 := by
  all_goals bv_compare'

theorem sub_eq_xor_sub_mul_not_and :
    x - y = (x ^^^ y) - 2 * (~~~ x &&& y) := by
  all_goals bv_compare'

theorem sub_eq_and_not_sub_not_and :
    x - y = (x &&& ~~~ y) - (~~~ x &&& y) := by
  all_goals bv_compare'

theorem sub_eq_mul_and_not_sub_xor :
    x - y = 2 * (x &&& ~~~ y) - (x ^^^ y) := by
  all_goals bv_compare'

theorem xor_eq_or_sub_and :
    x ^^^ y = (x ||| y) - (x &&& y) := by
  all_goals bv_compare'

theorem and_not_eq_or_sub:
    x &&& ~~~ y = (x ||| y) - y := by
  all_goals bv_compare'

theorem and_not_eq_sub_add :
    x &&& ~~~ y = x - (x &&& y) := by
  all_goals bv_compare'

theorem not_sub_eq_sub_sub_one :
    ~~~ (x - y) = y - x - 1 := by
  all_goals bv_compare'

theorem not_sub_eq_not_add :
    ~~~ (x - y) = ~~~x + y := by
  all_goals bv_compare'

theorem not_xor_eq_and_sub_or_sub_one :
    ~~~ (x ^^^ y) = (x &&& y) - (x ||| y) - 1 := by
  all_goals bv_compare'

theorem not_xor_eq_and_add_not_or :
    ~~~ (x ^^^ y) = (x &&& y) + ~~~ (x ||| y) := by
  all_goals bv_compare'

theorem or_eq_and_not_add :
    x ||| y = (x &&& ~~~ y) + y := by
  all_goals bv_compare'

theorem and_eq_not_or_sub_not :
    x &&& y = (~~~ x ||| y) - ~~~ x := by
  all_goals bv_compare'

end AdditionCombinedWithLogicalOperations

end Ch2Basics

end HackersDelight
