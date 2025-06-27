/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto

open MLIR AST

namespace AliveHandwritten

/-
Name: SimplifyDivRemOfSelect
precondition: true
%sel = select %c, %Y, 0
%r = udiv %X, %sel
  =>
%r = udiv %X, %Y

-/
def alive_DivRemOfSelect_src (w : Nat) :=
  [llvm(w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %c0 = llvm.mlir.constant(0) : _
    %v1 = llvm.select %c, %y, %c0
    %v2 = llvm.udiv %x,  %v1
    llvm.return %v2
  }]
def alive_DivRemOfSelect_tgt (w : Nat) :=
  [llvm(w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %v1 = llvm.udiv %x, %y
    llvm.return %v1
  }]

@[simp]
theorem BitVec.ofNat_toNat_zero :
BitVec.toNat (BitVec.ofInt w 0) = 0 := by
  simp only [BitVec.toNat, BitVec.ofInt, OfNat.ofNat]
  norm_cast

theorem alive_DivRemOfSelect (w : Nat) :
    alive_DivRemOfSelect_src w ⊑ alive_DivRemOfSelect_tgt w := by
  unfold alive_DivRemOfSelect_src alive_DivRemOfSelect_tgt
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  simp_alive_split
  alive_auto

end AliveHandwritten
