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
/-
def eg1 :=
  [llvm(64)| {
^bb0(%X : _, %Y : _):
      %v1 = llvm.and %X, %Y
      %v2 = llvm.or %X, %Y
      %v3 = llvm.add %v1, %v2
      llvm.return %v3
  }].denote
-/


def eg22 :=
  [RV64_com| {
    ^entry (%X: !i64, %Y: !i64):
    %v1 = "RV64.add" (%X, %Y) : (!i64, !i64) -> (!i64)
    "return" (%v1) : (!i64, !i64) -> ()
  }].denote



def eg21_b :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
      %v1 = llvm.add %Y, %X : i64
      llvm.return %v1 : i64
  }]

#check eg21_b --(Γv : ((Ctxt.snoc [] toRISCV.Ty.bv).snoc toRISCV.Ty.bv).Valuation)
def lh_llvm : (HVector TyDenote.toType [InstCombine.Ty.bitvec 64,InstCombine.Ty.bitvec 64]) :=
          HVector.cons (some (BitVec.ofNat 64 20)) <| HVector.cons (some (BitVec.ofNat 64 2)) .nil
-- creating an HVector but specifying the types bc Lean can't just infer it
#check lh -- dependetly typed HVector

def test_add_llvm : Option (BitVec 64) := eg21_b.denote (Ctxt.Valuation.ofHVector lh_llvm)
#eval test_add_llvm


theorem add_llvm_eq_bc :
  eg21_b.denote (Ctxt.Valuation.ofHVector lh_llvm) = some x →
    x = (BitVec.add (BitVec.ofNat 64 20) (BitVec.ofNat 64 2))
  := by
  unfold eg21_b lh_llvm
  simp_alive_meta
  simp_peephole [InstCombine.Op.denote,HVector.get,HVector.get, LLVM.add]
  simp [HVector.cons_get_zero]
  simp_alive_undef
  intro h
  injection h with h₁
  rw [← h₁]
  bv_decide

def lh_riscv : HVector TyDenote.toType [toRISCV.Ty.bv,toRISCV.Ty.bv ] :=
  HVector.cons ((BitVec.ofNat 64 20)) <| HVector.cons ( (BitVec.ofNat 64 2)) .nil -- hvector from which we will create the valuation
def test_add_riscv : BitVec 64 := eg22 (Ctxt.Valuation.ofHVector lh_riscv)
#eval test_add_riscv

-- managed the proof the bit vec domain
theorem add_riscv_eq_bv :
  eg22 (Ctxt.Valuation.ofHVector lh_riscv) = BitVec.add (BitVec.ofNat 64 20) (BitVec.ofNat 64 2)
  := by
  unfold eg22 lh_riscv
  simp_peephole
  unfold RV64.RTYPE_pure64_RISCV_ADD
  simp [HVector.cons_get_zero]

-- first steps
-- example where I still modell both contexts explictily
theorem translation_add :
    eg21_b.denote (Ctxt.Valuation.ofHVector lh_llvm) = some x →
      x = eg22 (Ctxt.Valuation.ofHVector lh_riscv) := by
    rw [add_riscv_eq_bv]
    apply add_llvm_eq_bc

-- diffrent step where I attempt to have only one proof
theorem translation_add_combined :
    eg21_b.denote (Ctxt.Valuation.ofHVector lh_llvm) = some x →
      x = eg22 (Ctxt.Valuation.ofHVector lh_riscv) := by
    unfold eg22 lh_riscv eg21_b lh_llvm
    simp_alive_meta
    simp_peephole [InstCombine.Op.denote,HVector.get,HVector.get, LLVM.add]
    unfold RV64.RTYPE_pure64_RISCV_ADD
    simp [HVector.cons_get_zero]
    simp_alive_undef
    intro h
    injection h with h₁
    rw [← h₁]
    bv_decide

-- attempt 3 where I try to have a universal context
--def contextMap
--def contextRefine :
  def ADD_LLVM_BIG_CONTEXT :=
    [llvm(64)| {
^bb0(%X : i64, %Y : i64, %Z : i64, %W : i64 ):
      %v1 = llvm.add %Y, %X : i64
      llvm.return %v1 : i64
  }]
def lh_llvm_big : (HVector TyDenote.toType [InstCombine.Ty.bitvec 64,InstCombine.Ty.bitvec 64,InstCombine.Ty.bitvec 64,InstCombine.Ty.bitvec 64 ]) :=
          HVector.cons (some (BitVec.ofNat 64 20)) <| HVector.cons (some (BitVec.ofNat 64 2)) <| HVector.cons (some (BitVec.ofNat 64 20)) <| HVector.cons (some (BitVec.ofNat 64 2)) .nil

theorem larger_context :
  ADD_LLVM_BIG_CONTEXT.denote (Ctxt.Valuation.ofHVector lh_llvm_big) = some x →
    x = eg22 (Ctxt.Valuation.ofHVector lh_riscv)
  := by
  unfold ADD_LLVM_BIG_CONTEXT eg22 lh_llvm_big lh_riscv
  simp_alive_meta
  simp_peephole [InstCombine.Op.denote,HVector.get,HVector.get, LLVM.add]
  simp [HVector.cons_get_zero]
  simp_alive_undef
  unfold RV64.RTYPE_pure64_RISCV_ADD
  intro h
  injection h with h₁
  rw [← h₁]
  bv_decide


 theorem testLLVMOnly1 :
  eg21_a ⊑  eg21_b := by
  unfold eg21_a eg21_b
  simp_alive_meta
  intros Γv
  simp_peephole [InstCombine.Op.denote] at Γv
  simp (config := {failIfUnchanged := false}) only [
            InstCombine.Op.denote, HVector.getN, HVector.get,
            beq_self_eq_true, Option.isSome_some, HVector.cons_get_zero
          ]
  simp (config := {failIfUnchanged := false }) only [Nat.cast_ofNat,
          Nat.cast_one, Int.reduceNegSucc, Int.reduceNeg]
  simp_alive_undef
  simp_alive_case_bash'
  . intro x1 x2
    bv_decide


#check TyDenote.toType
--def Γv : HVector (BitVec 64) 2 := HVector.cons x1 (HVector.cons x2 HVector.nil)
/-

((InstcombineTransformDialect.MOp.instantiateCom ⟨[sorry], ⋯⟩).mapTy <$>
      (Ctxt.snoc [] (InstCombine.MTy.bitvec 64)).snoc (InstCombine.MTy.bitvec 64)).Valuation

-/
def lh : HVector TyDenote.toType [InstCombine.Ty.bitvec 64,InstCombine.Ty.bitvec 64]
  :=  HVector.cons (some (BitVec.ofNat 64 0)) <| HVector.cons (some (BitVec.ofNat 64 2)) .nil





theorem testLLVMOnly_explicitContext :
  let Γv := (Ctxt.Valuation.ofHVector lh)
  eg21_a.denote Γv  =  eg21_b.denote Γv := by
  unfold eg21_a eg21_b
  sorry
  --intro Γv
  --simp_alive_meta
  --simp_peephole [InstCombine.Op.denote]
  --simp [InstCombine.Op.denote,HVector.getN,HVector.get]
  --simp_alive_undef
  --simp_alive_case_bash'
  --. intro x1 x2
    --apply congrArg some
    --bv_decide


theorem testLLVMOnly :
  eg21.denote Γv  =  eg21_b.denote  Γv := by
  unfold eg21 eg21_b
  simp_alive_meta
  simp_peephole [InstCombine.Op.denote] at Γv
  simp [InstCombine.Op.denote,HVector.getN,HVector.get]
  simp_alive_undef
  simp_alive_case_bash'
  . intro x1 x2
    apply congrArg some
    bv_decide

  --simp_alive_meta
  /-


((InstcombineTransformDialect.MOp.instantiateCom ⟨[sorry], ⋯⟩).mapTy <$>
      (Ctxt.snoc [] (InstCombine.MTy.bitvec 64)).snoc (InstCombine.MTy.bitvec 64)).Valuation








  ((InstcombineTransformDialect.MOp.instantiateCom ⟨[sorry], ⋯⟩).mapTy <$>
    (Ctxt.snoc [] (InstCombine.MTy.bitvec 64)).snoc (InstCombine.MTy.bitvec 64)).Valuation

def lh54 : HVector TyDenote.toType [toRISCV.Ty.bv, toRISCV.Ty.bv ]
  := HVector.cons (BitVec.ofNat 64 8) <| HVector.cons (BitVec.ofNat 64 1) .nil

def test_ror : BitVec 64 := RISCVEg54.denote (Ctxt.Valuation.ofHVector lh54)
#eval test_ror

  -/

  --simp [Com.changeDialect_ret,
        --Com.changeDialect_var, Expr.changeDialect]
  --simp_alive_meta
  --simp_alive_peephole
  --simp_alive_undef
  --simp_alive_case_bash
  --. bv_decide



def LLVMCtxt := Ctxt InstCombine.Ty
def RISCVCtxt := Ctxt toRISCV.Ty


def CtxtRefines (Γ : LLVMCtxt) (Δ : RISCVCtxt) : Type := -- defining how to the types are mapped between the two contexts
  (Δ.Var .bv) → Γ.Var (.bitvec 64)

#print CtxtRefines

--def V₁:= (Ctxt.Valuation.ofHVector lh_llvm)
--def V₂:= (Ctxt.Valuation.ofHVector lh_riscv)






structure ValuationRefines {Γ : LLVMCtxt} {Δ : RISCVCtxt} (V₁ : Γ.Valuation) (V₂ : Δ.Valuation) where
  ctxtRefines : CtxtRefines Γ Δ -- defining how to values should be mapped, challenge; llvm type is option bc of UB
  val_refines : ∀ (v : Δ.Var .bv) (x : BitVec 64), V₁ (ctxtRefines v) = some x → V₂ v = x --if the llvm variable has a some value we have the riscv value given

theorem see_LLVM_concrete3 V₁ V₂ (h : ValuationRefines V₁ V₂) : -- have the assumptions given by Valuation Refines
    eg21_b.denote V₁ = some x → eg22 V₂ = x := by -- llvm to risc-v











#check lh_llvm
#check lh_riscv
#check CtxtRefines
#check Ctxt toRISCV.Ty


theorem see_LLVM_concrete V₁ V₂ (h : ValuationRefines V₁ V₂) :
    eg21_b.denote V₁ = some x → eg22 V₂ = x := by
  unfold eg21_b eg22
  let ⟨ctxtRef, val_ref⟩ := h
  simp_alive_meta
  simp_peephole [InstCombine.Op.denote,HVector.get,HVector.get, LLVM.add]
  unfold RV64.RTYPE_pure64_RISCV_ADD
  simp [HVector.cons_get_zero]
  simp_alive_undef

  --intro h













  --simp [V₁]





/-
theorem translation_add_combined :
    eg21_b.denote (Ctxt.Valuation.ofHVector lh_llvm) = some x →
      x = eg22 (Ctxt.Valuation.ofHVector lh_riscv) := by
    unfold eg22 lh_riscv eg21_b lh_llvm
    simp_alive_meta
    simp_peephole [InstCombine.Op.denote,HVector.get,HVector.get, LLVM.add]
    unfold RV64.RTYPE_pure64_RISCV_ADD
    simp [HVector.cons_get_zero]
    simp_alive_undef
    intro h
    injection h with h₁
    rw [← h₁]
    bv_decide
-/


theorem see_LLVM (V₁) (V₂) (h : ValuationRefines V₁ V₂) :
  eg21_b.denote V₁ = some x → eg22 V₂ = x := by
  unfold eg21_b eg22





theorem see_LLVM1 (V₁) (V₂) (h : ValuationRefines V₁ V₂) :
    ∃ x, eg21_b.denote V₁ = some x → eg22 V₂ = x := by
  unfold eg21 eg22
  sorry





  --simp only [Com.denote]
  simp_alive_meta
  simp_peephole
  --simp [DialectDenote.denote]
  let ⟨ctxtRef, val_ref⟩ := h
  let X_RV := Ctxt.Var.last [] toRISCV.Ty.bv
  let Y_RV := Ctxt.Var.last [toRISCV.Ty.bv] toRISCV.Ty.bv
  let X_LL := h.ctxtRefines X_RV
  let Y_LL := h.ctxtRefines Y_RV
  cases V₁ X_LL with --none or some
  | none  => sorry
  | some x₁ => -- resolving x first
    cases V₁ Y_LL with
      | none => sorry
      | some x₂ =>
