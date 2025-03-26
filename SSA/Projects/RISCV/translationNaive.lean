import SSA.Projects.RISCV.RV64
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.ForLean
import Lean
import Mathlib.Tactic.Ring
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Experimental.Bits.Fast.Reflect
import SSA.Experimental.Bits.Fast.MBA
import SSA.Experimental.Bits.FastCopy.Reflect
import SSA.Experimental.Bits.AutoStructs.Tactic
import SSA.Experimental.Bits.AutoStructs.ForLean
import Std.Tactic.BVDecide
import SSA.Core.Tactic.TacBench
import Leanwuzla

-- problems bc of registers
-- proof of bitwise instruction wise translation via bit vec domain -> but with concrete input
-- idea write a libary that translate each llvm instruction one to one into riscv instruction
-- then lowert whole riscv into bit vec

def ADD_RV64 :=
  [RV64_com| {
    ^entry (%X: !i64, %Y: !i64):
    %v1 = "RV64.add" (%X, %Y) : (!i64, !i64) -> (!i64)
    "return" (%v1) : (!i64, !i64) -> ()
  }].denote

def ADD_LLVM :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.add %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

  def ADD_LLVM_BIG_CONTEXT :=
    [llvm(64)| {
^bb0(%X : i64, %Y : i64, %Z : i64, %W : i64):
      %v1 = llvm.add %Y, %X : i64
      llvm.return %v1 : i64
  }]

def lh_llvm : (HVector TyDenote.toType [InstCombine.Ty.bitvec 64,InstCombine.Ty.bitvec 64]) :=
          HVector.cons (some (BitVec.ofNat 64 20)) <| HVector.cons (some (BitVec.ofNat 64 2)) .nil

def lh_riscv : HVector TyDenote.toType [toRISCV.Ty.bv,toRISCV.Ty.bv ] :=
  HVector.cons ((BitVec.ofNat 64 20)) <| HVector.cons ( (BitVec.ofNat 64 2)) .nil -- hvector from which we will create the valuation

theorem translation_add_combined :
    ADD_LLVM (Ctxt.Valuation.ofHVector lh_llvm) = some x →
      x = ADD_RV64 (Ctxt.Valuation.ofHVector lh_riscv) := by
    unfold ADD_RV64 lh_riscv ADD_LLVM lh_llvm
    simp_alive_meta
    simp_peephole [InstCombine.Op.denote,HVector.get,HVector.get, LLVM.add]
    unfold RV64.RTYPE_pure64_RISCV_ADD
    simp [HVector.cons_get_zero]
    simp_alive_undef
    intro h
    injection h with h₁
    rw [← h₁]
    bv_decide

def return_val_add : BitVec 64 := ADD_RV64 (Ctxt.Valuation.ofHVector lh_riscv)
#eval return_val_add

def OR_RV64 :=
  [RV64_com| {
    ^entry (%X: !i64, %Y: !i64):
    %v1 = "RV64.add" (%X, %Y) : (!i64, !i64) -> (!i64)
    "return" (%v1) : (!i64, !i64) -> ()
  }].denote

-- disjoint and normal or
def OR_LLVM :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.or %Y, %X : i64 -- handle disjoint flag
      llvm.return %v1 : i64
  }].denote

def XOR_LLVM :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.xor %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

def shl_LLVM :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.shl %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

def shl_LLVM_flags :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.add %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

--true and false flags
def lshr_LLVM_ :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.lshr %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

--true and false flags
def ashr_LLVM_ :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.ashr %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

def urem_LLVM_ :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.urem %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

def srem_LLVM_ :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.srem %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

def ADD_LLVM_flags :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.add %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

def MUL_LLVM :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.mul %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

def MUL_LLVM_flags :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.add %Y, %X : i64
      llvm.return %v1 : i64
  }].denote


def SUB_LLVM_ :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.sub %Y, %X : i64
      llvm.return %v1 : i64
  }].denote


def SUB_LLVM_flags :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.add %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

-- true and false case
def SDIV_LLVM_:=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.sdiv %Y, %X : i64
      llvm.return %v1 : i64
  }].denote

-- true and false case
def UDIV_LLVM_:=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.udiv %Y, %X : i64
      llvm.return %v1 : i64
  }].denote


/-
  | neg
  | not
  | copy
  | trunc (w' : Width φ) (noWrapFlags : NoWrapFlags := {nsw := false, nuw := false} )
  | zext  (w' : Width φ) (nneg : NonNegFlag := {nneg := false} )
  | sext  (w' : Width φ)



    | .and                => "and"
    | .or   ⟨false⟩        => "or"
    | .or   ⟨true⟩         => "or disjoint"
    | .xor                => "xor"
    | .shl  ⟨false, false⟩ => "shl"
    | .shl  ⟨nsw, nuw⟩     => toString f!"shl {nsw} {nuw}"
    | .lshr ⟨false⟩        => "lshr"
    | .lshr ⟨true⟩         => "lshr exact"
    | .ashr ⟨false⟩        => "ashr"
    | .ashr ⟨true⟩         => "ashr exact"
    | .urem               => "urem"
    | .srem               => "srem"
    | .add  ⟨false, false⟩ => "add"
    | .add  ⟨nsw, nuw⟩     => toString f!"add {nsw} {nuw}"
    | .mul  ⟨false, false⟩ => "mul"
    | .mul  ⟨nsw, nuw⟩     => toString f!"mul {nsw} {nuw}"
    | .sub  ⟨false, false⟩ => "sub"
    | .sub  ⟨nsw, nuw⟩     => toString f!"sub {nsw} {nuw}"
    | .sdiv ⟨false⟩        => "sdiv"
    | .sdiv ⟨true⟩         => "sdiv exact"
    | .udiv ⟨false⟩        => "udiv"
    | .udiv ⟨true⟩         => "udiv exact"

-/
