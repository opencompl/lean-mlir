/-
This file contains some basic lemmas for the `ModArith` dialect in HEIR,
analogous to the `Statements.lean` file from the `Poly` dialect.

Authors: Jaeho Choi<zerozerozero0216@gmail.com>
-/
import SSA.Projects.ModArith.Basic
import Batteries.Data.List.Lemmas
import Mathlib.Algebra.Ring.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.ZMod.QuotientRing

namespace ModArith

theorem add_comm (a b : R q) : a + b = b + a := by
  ring
theorem mul_comm (a b : R q) : a * b = b * a := by
  ring

theorem add_zero (a : ZMod q) : a + 0 = a := by
  ring
theorem zero_add (a : ZMod q) : 0 + a = a := by
  ring

theorem mul_zero (a : ZMod q) : a * 0 = 0 := by
  ring
theorem zero_mul (a : ZMod q) : 0 * a = 0 := by
  ring

theorem mul_one (a : ZMod q) : a * 1 = a := by
  ring
theorem one_mul (a : ZMod q) : 1 * a = a := by
  ring

theorem sub_zero (a : ZMod q) : a - 0 = a := by
  ring

theorem sub_self (a : ZMod q) : a - a = 0 := by
  ring

end ModArith
