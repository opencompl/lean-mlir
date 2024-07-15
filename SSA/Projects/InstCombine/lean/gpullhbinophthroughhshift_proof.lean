import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem and_signbit_shl_thm (x : _root_.BitVec 32) : (x &&& 4294901760#32) <<< 8 = x <<< 8 &&& 4278190080#32 := sorry

theorem and_nosignbit_shl_thm (x : _root_.BitVec 32) : (x &&& 2147418112#32) <<< 8 = x <<< 8 &&& 4278190080#32 := sorry

theorem or_signbit_shl_thm (x : _root_.BitVec 32) : (x ||| 4294901760#32) <<< 8 = x <<< 8 ||| 4278190080#32 := sorry

theorem or_nosignbit_shl_thm (x : _root_.BitVec 32) : (x ||| 2147418112#32) <<< 8 = x <<< 8 ||| 4278190080#32 := sorry

theorem xor_signbit_shl_thm (x : _root_.BitVec 32) : (x ^^^ 4294901760#32) <<< 8 = x <<< 8 ^^^ 4278190080#32 := sorry

theorem xor_nosignbit_shl_thm (x : _root_.BitVec 32) : (x ^^^ 2147418112#32) <<< 8 = x <<< 8 ^^^ 4278190080#32 := sorry

theorem add_signbit_shl_thm (x : _root_.BitVec 32) : (x + 4294901760#32) <<< 8 = x <<< 8 + 4278190080#32 := sorry

theorem add_nosignbit_shl_thm (x : _root_.BitVec 32) : (x + 2147418112#32) <<< 8 = x <<< 8 + 4278190080#32 := sorry

theorem and_signbit_lshr_thm (x : _root_.BitVec 32) : (x &&& 4294901760#32) >>> 8 = x >>> 8 &&& 16776960#32 := sorry

theorem and_nosignbit_lshr_thm (x : _root_.BitVec 32) : (x &&& 2147418112#32) >>> 8 = x >>> 8 &&& 8388352#32 := sorry

theorem or_signbit_lshr_thm (x : _root_.BitVec 32) : (x ||| 4294901760#32) >>> 8 = x >>> 8 ||| 16776960#32 := sorry

theorem or_nosignbit_lshr_thm (x : _root_.BitVec 32) : (x ||| 2147418112#32) >>> 8 = x >>> 8 ||| 8388352#32 := sorry

theorem xor_signbit_lshr_thm (x : _root_.BitVec 32) : (x ^^^ 4294901760#32) >>> 8 = x >>> 8 ^^^ 16776960#32 := sorry

theorem xor_nosignbit_lshr_thm (x : _root_.BitVec 32) : (x ^^^ 2147418112#32) >>> 8 = x >>> 8 ^^^ 8388352#32 := sorry

theorem and_signbit_ashr_thm (x : _root_.BitVec 32) :
  (x &&& 4294901760#32).sshiftRight 8 = x.sshiftRight 8 &&& 4294967040#32 := sorry

theorem and_nosignbit_ashr_thm (x : _root_.BitVec 32) : (x &&& 2147418112#32).sshiftRight 8 = x >>> 8 &&& 8388352#32 := sorry

theorem or_signbit_ashr_thm (x : _root_.BitVec 32) : (x ||| 4294901760#32).sshiftRight 8 = x >>> 8 ||| 4294967040#32 := sorry

theorem or_nosignbit_ashr_thm (x : _root_.BitVec 32) :
  (x ||| 2147418112#32).sshiftRight 8 = x.sshiftRight 8 ||| 8388352#32 := sorry

theorem xor_signbit_ashr_thm (x : _root_.BitVec 32) :
  (x ^^^ 4294901760#32).sshiftRight 8 = x.sshiftRight 8 ^^^ 4294967040#32 := sorry

theorem xor_nosignbit_ashr_thm (x : _root_.BitVec 32) :
  (x ^^^ 2147418112#32).sshiftRight 8 = x.sshiftRight 8 ^^^ 8388352#32 := sorry

