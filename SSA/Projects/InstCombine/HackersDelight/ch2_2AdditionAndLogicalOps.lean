import SSA.Projects.InstCombine.TacticAuto

/- 2–2 Addition Combined with Logical Operations -/

namespace HackersDelight

namespace Ch2Basics

namespace AdditionCombinedWithLogicalOperations

set_option bv.ac_nf false

variable {x y z : BitVec 64}

theorem neg_eq_not_add_one :
    -x = ~~~ x + 1 := by
  /-
  Bitwuzla proved the goal after 0.000000ms
  LeanSAT proved the goal after 2.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 0.000000ms, LRAT processing 0.000000ms
  -/
  all_goals sorry

theorem neg_eq_neg_not_one :
    -x = ~~~ (x - 1) := by
  /-
  Bitwuzla proved the goal after 78.000000ms
  LeanSAT proved the goal after 102.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 76.931125ms, LRAT processing 12.654000ms
  -/
  all_goals sorry

theorem not_eq_neg_sub_one :
    ~~~ x = - x - 1:= by
  /-
  Bitwuzla proved the goal after 80.000000ms
  LeanSAT proved the goal after 100.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 67.521667ms, LRAT processing 21.116416ms
  -/
  all_goals sorry

theorem neg_not_eq_add_one :
    - ~~~ x = x + 1 := by
  /-
  Bitwuzla proved the goal after 0.000000ms
  LeanSAT proved the goal after 3.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 0.000000ms, LRAT processing 0.000000ms
  -/
  all_goals sorry

theorem not_neg_eq_sub_one :
    ~~~ (-x) = x - 1 := by
  /-
  Bitwuzla proved the goal after 71.000000ms
  LeanSAT proved the goal after 88.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 68.747583ms, LRAT processing 0.000000ms
  -/
  all_goals sorry

theorem add_eq_sub_not_sub_one :
    x + y = x - ~~~ y - 1 := by
  /-
  Bitwuzla proved the goal after 77.000000ms
  LeanSAT proved the goal after 397.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 278.967584ms, LRAT processing 103.312625ms
  -/
  all_goals sorry

theorem add_eq_xor_add_mul_and :
    x + y = (x ^^^ y) + 2 * (x &&& y) := by
  /-
  Bitwuzla proved the goal after 69.000000ms
  LeanSAT proved the goal after 562.000000ms: rewriting 0.000000ms, bitblasting 39.375666ms, SAT solving 332.286084ms, LRAT processing 139.911542ms
  -/
  all_goals sorry

theorem add_eq_or_add_and :
    x + y = (x ||| y) + (x &&& y) := by
  /-
  Bitwuzla proved the goal after 69.000000ms
  LeanSAT proved the goal after 78.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 60.266000ms, LRAT processing 0.000000ms
  -/
  all_goals sorry

theorem add_eq_mul_or_neg_xor :
    x + y = 2 * (x ||| y) - (x ^^^ y) := by
  /-
  Bitwuzla proved the goal after 71.000000ms
  LeanSAT proved the goal after 657.000000ms: rewriting 0.000000ms, bitblasting 43.160292ms, SAT solving 384.178584ms, LRAT processing 174.218375ms
  -/
  all_goals sorry

theorem sub_eq_add_not_add_one :
    x - y = x + ~~~ y + 1 := by
  /-
  Bitwuzla proved the goal after 128.000000ms
  LeanSAT proved the goal after 472.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 332.866042ms, LRAT processing 121.096209ms
  -/
  all_goals sorry

theorem sub_eq_xor_sub_mul_not_and :
    x - y = (x ^^^ y) - 2 * (~~~ x &&& y) := by
  /-
  Bitwuzla proved the goal after 455.000000ms
  LeanSAT proved the goal after 1155.000000ms: rewriting 0.000000ms, bitblasting 40.963625ms, SAT solving 772.373000ms, LRAT processing 281.464250ms
  -/
  all_goals sorry

theorem sub_eq_and_not_sub_not_and :
    x - y = (x &&& ~~~ y) - (~~~ x &&& y) := by
  /-
  Bitwuzla proved the goal after 186.000000ms
  LeanSAT proved the goal after 350.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 226.543250ms, LRAT processing 103.837833ms
  -/
  all_goals sorry

theorem sub_eq_mul_and_not_sub_xor :
    x - y = 2 * (x &&& ~~~ y) - (x ^^^ y) := by
  /-
  Bitwuzla proved the goal after 292.000000ms
  LeanSAT proved the goal after 1066.000000ms: rewriting 0.000000ms, bitblasting 43.908333ms, SAT solving 712.796292ms, LRAT processing 246.808250ms
  -/
  all_goals sorry

theorem xor_eq_or_sub_and :
    x ^^^ y = (x ||| y) - (x &&& y) := by
  /-
  Bitwuzla proved the goal after 73.000000ms
  LeanSAT proved the goal after 83.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 63.391291ms, LRAT processing 0.000000ms
  -/
  all_goals sorry

theorem and_not_eq_or_sub:
    x &&& ~~~ y = (x ||| y) - y := by
  /-
  Bitwuzla proved the goal after 73.000000ms
  LeanSAT proved the goal after 92.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 67.368708ms, LRAT processing 11.745792ms
  -/
  all_goals sorry

theorem and_not_eq_sub_add :
    x &&& ~~~ y = x - (x &&& y) := by
  /-
  Bitwuzla proved the goal after 74.000000ms
  LeanSAT proved the goal after 93.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 64.167792ms, LRAT processing 16.168542ms
  -/
  all_goals sorry

theorem not_sub_eq_sub_sub_one :
    ~~~ (x - y) = y - x - 1 := by
  /-
  Bitwuzla proved the goal after 450.000000ms
  LeanSAT proved the goal after 843.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 602.927334ms, LRAT processing 222.062625ms
  -/
  all_goals sorry

theorem not_sub_eq_not_add :
    ~~~ (x - y) = ~~~x + y := by
  /-
  Bitwuzla proved the goal after 128.000000ms
  LeanSAT proved the goal after 254.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 176.880667ms, LRAT processing 63.317750ms
  -/
  all_goals sorry

theorem not_xor_eq_and_sub_or_sub_one :
    ~~~ (x ^^^ y) = (x &&& y) - (x ||| y) - 1 := by
  /-
  Bitwuzla proved the goal after 75.000000ms
  LeanSAT proved the goal after 255.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 170.216083ms, LRAT processing 68.071459ms
  -/
  all_goals sorry

theorem not_xor_eq_and_add_not_or :
    ~~~ (x ^^^ y) = (x &&& y) + ~~~ (x ||| y) := by
  /-
  Bitwuzla proved the goal after 70.000000ms
  LeanSAT proved the goal after 77.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 64.834375ms, LRAT processing 0.000000ms
  -/
  all_goals sorry

theorem or_eq_and_not_add :
    x ||| y = (x &&& ~~~ y) + y := by
  /-
  Bitwuzla proved the goal after 70.000000ms
  LeanSAT proved the goal after 86.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 64.732083ms, LRAT processing 11.730167ms
  -/
  all_goals sorry

theorem and_eq_not_or_sub_not :
    x &&& y = (~~~ x ||| y) - ~~~ x := by
  /-
  Bitwuzla proved the goal after 74.000000ms
  LeanSAT proved the goal after 85.000000ms: rewriting 0.000000ms, bitblasting 0.000000ms, SAT solving 62.816041ms, LRAT processing 0.000000ms
  -/
  all_goals sorry

end AdditionCombinedWithLogicalOperations

end Ch2Basics

end HackersDelight
