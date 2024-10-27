
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gaddsubhconstanthfolding_proof
theorem add_const_add_const_thm (x : BitVec 32) : x + 8#32 + 2#32 = x + 10#32 := by bv_compare'

theorem add_const_sub_const_thm (x : BitVec 32) : x + 8#32 - 2#32 = x + 6#32 := by bv_compare'

theorem add_const_const_sub_thm (x : BitVec 32) : 2#32 - (x + 8#32) = 4294967290#32 - x := by bv_compare'

theorem add_nsw_const_const_sub_nsw_thm (x : BitVec 8) :
  ((if x.msb = false ∧ ¬(x + 1#8).msb = x.msb then none else some (x + 1#8)).bind fun a =>
      if (385#9 - signExtend 9 a).msb = (385#9 - signExtend 9 a).getMsbD 1 then some (129#8 - a) else none) ⊑
    if (384#9 - signExtend 9 x).msb = (384#9 - signExtend 9 x).getMsbD 1 then some (128#8 - x) else none := by bv_compare'

theorem add_nsw_const_const_sub_thm (x : BitVec 8) :
  ((if x.msb = false ∧ ¬(x + 1#8).msb = x.msb then none else some (x + 1#8)).bind fun y' => some (129#8 - y')) ⊑
    some (128#8 - x) := by bv_compare'

theorem add_const_const_sub_nsw_thm (x : BitVec 8) :
  (if (385#9 - signExtend 9 (x + 1#8)).msb = (385#9 - signExtend 9 (x + 1#8)).getMsbD 1 then some (129#8 - (x + 1#8))
    else none) ⊑
    some (128#8 - x) := by bv_compare'

theorem add_nsw_const_const_sub_nsw_ov_thm (x : BitVec 8) :
  ((if x.msb = (2#8).msb ∧ ¬(x + 2#8).msb = x.msb then none else some (x + 2#8)).bind fun a =>
      if (385#9 - signExtend 9 a).msb = (385#9 - signExtend 9 a).getMsbD 1 then some (129#8 - a) else none) ⊑
    some (127#8 - x) := by bv_compare'

theorem add_nuw_const_const_sub_nuw_thm (x : BitVec 8) :
  ((if x + 1#8 < x ∨ x + 1#8 < 1#8 then none else some (x + 1#8)).bind fun y' =>
      if 129#8 < y' then none else some (129#8 - y')) ⊑
    if 128#8 < x then none else some (128#8 - x) := by bv_compare'

theorem add_nuw_const_const_sub_thm (x : BitVec 8) :
  ((if x + 1#8 < x ∨ x + 1#8 < 1#8 then none else some (x + 1#8)).bind fun y' => some (129#8 - y')) ⊑
    some (128#8 - x) := by bv_compare'

theorem add_const_const_sub_nuw_thm (x : BitVec 8) :
  (if 129#8 < x + 1#8 then none else some (129#8 - (x + 1#8))) ⊑ some (128#8 - x) := by bv_compare'

theorem sub_const_add_const_thm (x : BitVec 32) : x - 8#32 + 2#32 = x + 4294967290#32 := by bv_compare'

theorem sub_const_sub_const_thm (x : BitVec 32) : x - 8#32 - 2#32 = x + 4294967286#32 := by bv_compare'

theorem sub_const_const_sub_thm (x : BitVec 32) : 2#32 - (x - 8#32) = 10#32 - x := by bv_compare'

theorem const_sub_add_const_thm (x : BitVec 32) : 8#32 - x + 2#32 = 10#32 - x := by bv_compare'

theorem const_sub_sub_const_thm (x : BitVec 32) : 8#32 - x - 2#32 = 6#32 - x := by bv_compare'

theorem const_sub_const_sub_thm (x : BitVec 32) : 2#32 - (8#32 - x) = x + 4294967290#32 := by bv_compare'

theorem addsub_combine_constants_thm (x x_1 : BitVec 7) :
  (if (x_1 + 42#7).msb = (10#7 - x).msb ∧ ¬(x_1 + 42#7 + (10#7 - x)).msb = (x_1 + 42#7).msb then none
    else some (x_1 + 42#7 + (10#7 - x))) ⊑
    some (x_1 - x + 52#7) := by bv_compare'

theorem sub_from_constant_thm (x x_1 : BitVec 5) : 10#5 - x_1 + x = x - x_1 + 10#5 := by bv_compare'

theorem sub_from_constant_commute_thm (x x_1 : BitVec 5) :
  ((if (10#6 - signExtend 6 x).msb = (10#6 - signExtend 6 x).getMsbD 1 then some (10#5 - x) else none).bind fun y' =>
      if (x_1 * x_1).msb = y'.msb ∧ ¬(x_1 * x_1 + y').msb = (x_1 * x_1).msb then none else some (x_1 * x_1 + y')) ⊑
    some (x_1 * x_1 - x + 10#5) := by bv_compare'

