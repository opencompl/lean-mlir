/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.SLLVM.Dialect.Semantics.EffectM
import SSA.Projects.SLLVM.Tactic.SimpSet

/-- `x.canBe y` returns true when `x` can be refined into a bitvector value `y`.
That is, when `x` is poison or `x` is equal to `value y`. -/
@[simp_sllvm]
def LLVM.IntW.canBe (x : LLVM.IntW w) (y : BitVec w) : Bool :=
  x = .poison ∨ x = .value y

namespace LeanMLIR.SLLVM

/-- An LLVM pointer, or `poison` -/
def Ptr : Type := PoisonOr Pointer

/-! ### div / rem -/

@[simp_sllvm]
def udiv (x y : LLVM.IntW w) (flag : LLVM.ExactFlag) : EffectM (LLVM.IntW w) := do
  if y.canBe 0#w then
    .ub
  else
    pure <| LLVM.udiv x y flag

@[simp_sllvm]
def sdiv (x y : LLVM.IntW w) (flag : LLVM.ExactFlag) : EffectM (LLVM.IntW w) := do
  if y.canBe 0#w then
    .ub
  else
    pure <| LLVM.sdiv x y flag

@[simp_sllvm]
def urem (x y : LLVM.IntW w) : EffectM (LLVM.IntW w) := do
  if y.canBe 0#w then
    .ub
  else
    pure <| LLVM.urem x y

@[simp_sllvm]
def srem (x y : LLVM.IntW w) : EffectM (LLVM.IntW w) := do
  if y.canBe 0#w then
    .ub
  else
    pure <| LLVM.srem x y

/-! ### pointer arithmetic -/

def ptradd (p : SLLVM.Ptr) (x : LLVM.IntW 64) : SLLVM.Ptr := do
  let p ← p
  let x ← x
  return { p with offset := p.offset + x}

/-!
**SIMPLIFICATION**
We deliberately don't support int-to-ptr nor ptr-to-int casts
-/
