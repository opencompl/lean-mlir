import Blase
open BitVec
set_option warn.sorry false

theorem setWidth_eq_zext (x : BitVec v) : x.zeroExtend w = x.setWidth w := by
  bv_multi_width

theorem shiftl1 {v : Nat} (x : BitVec v) :
    x <<< 5 = x <<< 3 <<< 2 := by
  bv_multi_width

/-- Check that by default, we understand width 1 bitvectors (ie, not specialized to width w). -/
theorem width1_understood (x y : BitVec 1) : x + y = x ^^^ y := by
  bv_multi_width


/-- error: MUSTCEX: Found exact counter-example for 'x <<< 5 = x <<< 3 <<< 3' -/
#guard_msgs in theorem shiftl2 {v : Nat} (x : BitVec v) :
    x <<< 5 = x <<< 3 <<< 3 := by
  bv_multi_width

/--
trace: v : ℕ
x : BitVec v
⊢ x + (x <<< 1 + (x <<< 2 + (x <<< 3 + x <<< 4))) = x <<< 2
-/
#guard_msgs in theorem mul2shift {v : Nat} (x : BitVec v) :
    x * 31 = x * 4 := by
  simp [bv_multi_width_normalize]
  trace_state
  sorry

