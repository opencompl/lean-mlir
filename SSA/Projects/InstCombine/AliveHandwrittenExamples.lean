/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.ForStd
import SSA.Core.ErasedContext

open MLIR AST
open Std (BitVec)
open Ctxt (Var DerivedCtxt)
open InstCombine (MOp)

namespace AliveHandwritten
set_option pp.proofs false
set_option pp.proofs.withType false


/-
Name: SimplifyDivRemOfSelect
precondition: true
%sel = select %c, %Y, 0
%r = udiv %X, %sel
  =>
%r = udiv %X, %Y

-/
def alive_DivRemOfSelect_src (w : Nat) :=
  [alive_icom (w)| {
  ^bb0():
    %c0 = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
    %c1 = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
    "llvm.return" (%c0) : (_) -> ()
  }]

def alive_DivRemOfSelect_tgt (w : Nat) :=
  [alive_icom (w)| {
  ^bb0():
    %c0 = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
    %c1 = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
    "llvm.return" (%c1) : (_) -> ()
  }]

@[simp]
theorem BitVec.ofNat_toNat_zero :
BitVec.toNat (BitVec.ofInt w 0) = 0 := by
  simp only [BitVec.toNat, BitVec.ofInt, BitVec.toFin, BitVec.ofNat, OfNat.ofNat]
  norm_cast

#check Ctxt.Valuation.snoc_last


#check (@Ctxt.Valuation InstCombine.LLVM.Ty _ [])


def test {w : ℕ}
  (Γv : @Ctxt.Valuation InstCombine.LLVM.Ty InstCombine.instTyDenoteTy []) :
  @Ctxt.Valuation.snoc InstCombine.LLVM.Ty InstCombine.instTyDenoteTy
  (@List.nil InstCombine.Ty : List InstCombine.Ty)
  (InstCombine.Ty.bitvec w)
  Γv
  (@LLVM.const? w 0) =
  @Ctxt.Valuation.snoc InstCombine.LLVM.Ty InstCombine.instTyDenoteTy
  (@List.nil InstCombine.Ty : List InstCombine.Ty)
  (InstCombine.Ty.bitvec w)
  Γv
  (@LLVM.const? w 0) := rfl

--set_option pp.proofs true in
theorem alive_DivRemOfSelect (w : Nat) :
    alive_DivRemOfSelect_src w ⊑ alive_DivRemOfSelect_tgt w := by
  unfold alive_DivRemOfSelect_src alive_DivRemOfSelect_tgt
  dsimp [Com.changeDialect_ret_pure]
  simp only [Com.changeDialect_ret, Com.changeDialect_lete, Expr.changeDialect,
    (HVector.changeDialect_nil), InstcombineTransformDialect.MOp.instantiateCom]
  dsimp only [DialectMorphism.mapOp_mk, DialectMorphism.mapTy_mk,
    InstcombineTransformDialect.MOp.instantiateCom,
    InstcombineTransformDialect.instantiateMOp,
    InstcombineTransformDialect.instantiateMTy,
    HVector.changeDialect_nil, HVector.map']
  simp_alive_meta
  dsimp! only [InstCombine.MTy.bitvec]
  unfold InstcombineTransformDialect.instantiateMTy
  dsimp only [Ctxt.map_cons, ConcreteOrMVar.instantiate_mvar_zero'', Ctxt.get?, Var.zero_eq_last,
    List.map_cons, List.map_nil]
  dsimp (config := {failIfUnchanged := false }) only [ConcreteOrMVar.instantiate]
  simp_alive_ssa
  simp only [zero_add]
  simp only [Var.succ_eq_toSnoc]
  simp only [Var.zero_eq_last]
  simp only [Ctxt.get?]
  simp only [Valuation.snoc_last]



  simp?



  simp only [Var.succ_eq_toSnoc]

  rw [Valuation.snoc_n]















  simp_peephole






























  simp_alive_undef
  simp [simp_llvm]
  intro y c x
  cases c
  -- | select condition is itself `none`, nothing more to be done. propagate the `none`.
  case none => cases x <;> cases y <;> simp
  case some cond =>
     obtain ⟨vcond, hcond⟩ := cond
     obtain (h | h) : vcond = 1 ∨ vcond = 0 := by
       norm_num at hcond
       rcases vcond with zero | vcond <;> simp;
       rcases vcond with zero | vcond <;> simp;
       linarith
     . subst h
       simp
     . subst h; simp

end AliveHandwritten
