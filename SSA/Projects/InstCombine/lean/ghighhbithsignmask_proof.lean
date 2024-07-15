import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem t0_thm (x : _root_.BitVec 64) : x >>> 63 * 18446744073709551615#64 = x.sshiftRight 63 := sorry

theorem t0_exact_thm (x : _root_.BitVec 64) : x >>> 63 * 18446744073709551615#64 = x.sshiftRight 63 := sorry

theorem t2_thm (x : _root_.BitVec 64) : x.sshiftRight 63 * 18446744073709551615#64 = x >>> 63 := sorry

theorem t3_exact_thm (x : _root_.BitVec 64) : x.sshiftRight 63 * 18446744073709551615#64 = x >>> 63 := sorry

