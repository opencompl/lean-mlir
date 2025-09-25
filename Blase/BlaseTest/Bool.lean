import Blase
open BitVec

theorem bool1 (x : Bool) : x = x := by bv_multi_width

theorem bool2 (x y : Bool) (h : x = true ) : x = true := by
  bv_multi_width +verbose?
