/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.SLLVM.Dialect.UB

/-- `x.canBe y` returns true when `x` can be refined into a bitvector value `y`.
That is, when `x` is poison or `x` is equal to `value y`. -/
def LLVM.IntW.canBe (x : LLVM.IntW w) (y : BitVec w) : Bool :=
  x = .poison ∨ x = .value y

namespace LeanMLIR.SLLVM

def udiv (x y : LLVM.IntW w) (flag : LLVM.ExactFlag) : UBOr (LLVM.IntW w) := do
  if y.canBe 0#w then
    .ub
  else
    .value <| LLVM.udiv x y flag

def sdiv (x y : LLVM.IntW w) (flag : LLVM.ExactFlag) : UBOr (LLVM.IntW w) := do
  if y.canBe 0#w then
    .ub
  else
    .value <| LLVM.sdiv x y flag

def urem (x y : LLVM.IntW w) : UBOr (LLVM.IntW w) := do
  if y.canBe 0#w then
    .ub
  else
    .value <| LLVM.urem x y

def srem (x y : LLVM.IntW w) : UBOr (LLVM.IntW w) := do
  if y.canBe 0#w then
    .ub
  else
    .value <| LLVM.srem x y
