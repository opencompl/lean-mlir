/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.ForMathlib
import SSA.Core.ErasedContext
import Batteries.Data.BitVec
import Lean

open MLIR AST
open Std (BitVec)
open Ctxt (Var DerivedCtxt)
open InstCombine (MOp)
open Lean

namespace AliveHandwritten
set_option pp.proofs false
set_option pp.proofs.withType false


theorem xor_allOnes_eq_not (x: _root_.BitVec w) :
  x ^^^ (BitVec.allOnes w) = ~~~ x:= by
  ext i
  simp

-- example proof of pure bitvector reasoning.
-- This is closed automatically by proof automation.
example (w : Nat) :
  [llvm ( w )| {
  ^bb0(%X : _, %C1 : _, %C2 : _):
    %v1 = llvm.xor %X, %C1
    %v2 = llvm.and %v1, %C2
    llvm.return %v2
  }] ⊑ [llvm ( w )| {
  ^bb0(%X : _, %C1 : _, %C2 : _):
  %v1 = llvm.and %X, %C2
  %v2 = llvm.xor %X, %C1
  %v3 = llvm.and %C1, %C2
  %v4 = llvm.xor %v1, %v3
  llvm.return %v4
  }] := by simp_alive_peephole; alive_auto

-- example proof of add plus xor.
-- This is an easy alive statement.
example (w : Nat) :
  [llvm ( w )| {
  ^bb0(%X : _, %Y : _):
    %cones = llvm.mlir.constant -1
    %v1 = llvm.xor %X, %cones
    %v2 = llvm.add %v1, %Y
    llvm.return %v2
  }] ⊑ [llvm ( w )| {
  ^bb0(%X : _, %Y : _):
  %c1 = llvm.mlir.constant 1
  %v1 = llvm.sub %Y, %c1
  %v2 = llvm.sub %v1, %X
  llvm.return %v2
  }] := by
    simp_alive_peephole
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    rw [BitVec.negOne_eq_allOnes, xor_allOnes_eq_not, ← BitVec.allOnes_sub_eq_not];
    rename_i a b
    ring

-- Example proof of shift + mul, this is one of the hardest alive examples.
-- (alive_simplifyMulDivRem290)
example :
    [llvm (w)| {
  ^bb0(%X : _, %Y : _):
    %c1 = llvm.mlir.constant 1
    %poty = llvm.shl %c1, %Y
    %r = llvm.mul %poty, %X
    llvm.return %r
  }] ⊑  [llvm (w)| {
  ^bb0(%X : _, %Y : _):
    %r = llvm.shl %X, %Y
    llvm.return %r
  }] := by
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  intros A B
  rcases A with rfl | A  <;> (try (simp [Option.bind, Bind.bind]; done)) <;>
  rcases B with rfl | B  <;> (try (simp [Option.bind, Bind.bind]; done)) <;>
  by_cases h : w ≤ BitVec.toNat B <;> simp [h]
  apply BitVec.eq_of_toNat_eq
  simp [bv_toNat]
  ring_nf

-- Example proof of xor + sub, this is automatically closed by automation.
example :
    [llvm (w)| {
  ^bb0(%X : _, %Y : _):
    %v1 = llvm.sub %X, %X
    %r = llvm.xor %v1, %Y
    llvm.return %r
  }] ⊑  [llvm (w)| {
  ^bb0(%X : _, %Y : _):
    llvm.return %Y
  }] := by
    simp_alive_peephole
    alive_auto
