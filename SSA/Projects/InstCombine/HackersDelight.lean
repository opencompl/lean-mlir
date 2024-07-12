import Init.Data.BitVec.Basic
import Init.Data.BitVec.Lemmas
import Init.Data.BitVec.Bitblast
import Mathlib.Data.BitVec

namespace HackersDelight
end HackersDelight

#check BitVec.neg_eq_not_add

theorem neg_eq_not_add_one {x : BitVec w} : - x = ~~~ x + 1 := by
  apply BitVec.neg_eq_not_add

#check BitVec.neg
