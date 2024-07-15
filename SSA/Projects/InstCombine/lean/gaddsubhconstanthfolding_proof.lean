import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem add_const_const_sub_thm (x : _root_.BitVec 32) :
  2#32 + x * 4294967295#32 + 4294967288#32 = x * 4294967295#32 + 4294967290#32 := by
  sorry

theorem add_nsw_const_const_sub_nsw_thm (x : _root_.BitVec 8) : 
    129#8 + x * 255#8 + 255#8 = x * 255#8 + 128#8 := by
  sorry

theorem add_nsw_const_const_sub_thm (x : _root_.BitVec 8) : 
    129#8 + x * 255#8 + 255#8 = x * 255#8 + 128#8 := by
  sorry

theorem add_const_const_sub_nsw_thm (x : _root_.BitVec 8) : 
    129#8 + x * 255#8 + 255#8 = x * 255#8 + 128#8 := by
  sorry

theorem add_nsw_const_const_sub_nsw_ov_thm (x : _root_.BitVec 8) : 
    129#8 + x * 255#8 + 254#8 = x * 255#8 + 127#8 := by
  sorry

theorem add_nuw_const_const_sub_nuw_thm (x : _root_.BitVec 8) : 
    129#8 + x * 255#8 + 255#8 = x * 255#8 + 128#8 := by
  sorry

theorem add_nuw_const_const_sub_thm (x : _root_.BitVec 8) : 
    129#8 + x * 255#8 + 255#8 = x * 255#8 + 128#8 := by
  sorry

theorem add_const_const_sub_nuw_thm (x : _root_.BitVec 8) : 
    129#8 + x * 255#8 + 255#8 = x * 255#8 + 128#8 := by
  sorry

theorem sub_const_const_sub_thm (x : _root_.BitVec 32) : 
    2#32 + x * 4294967295#32 + 8#32 = x * 4294967295#32 + 10#32 := by
  sorry

theorem const_sub_add_const_thm (x : _root_.BitVec 32) : 
    8#32 + x * 4294967295#32 + 2#32 = x * 4294967295#32 + 10#32 := by
  sorry

theorem const_sub_sub_const_thm (x : _root_.BitVec 32) :
  8#32 + x * 4294967295#32 + 4294967294#32 = x * 4294967295#32 + 6#32 := by
  sorry

