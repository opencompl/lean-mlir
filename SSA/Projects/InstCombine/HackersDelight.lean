import Init.Data.BitVec.Basic
import Init.Data.BitVec.Lemmas
import Init.Data.BitVec.Bitblast
import Mathlib.Data.BitVec

namespace HackersDelight

namespace Ch1

theorem neg_eq_not_add_one {x : BitVec w} : - x = ~~~ x + 1 := by
  apply BitVec.neg_eq_not_add

end Ch1

end HackersDelight
