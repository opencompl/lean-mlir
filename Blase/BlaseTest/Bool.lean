import Blase
open BitVec

theorem bool1 (x : Bool) : x = x := by bv_multi_width

theorem bool2 (x y : Bool) (h : x = y) : y = x := by
  bv_multi_width

theorem bool3 (x y : Bool) : BitVec.ofBool x = BitVec.ofBool y ↔ x = y := by
  bv_multi_width
