/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.ComWrappers
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
def alive_DivRemOfSelect_srca :=
  [alive_icom ()| {
  ^bb0():
    %c0 = "llvm.mlir.constant" () { value = 0 : i16 } :() -> (i16)
    "llvm.return" (%c0) : (i16) -> ()
  }]

open ComWrappers

def aliveDivRemOfSelect_comWrapper :
    Com InstCombine.LLVM [] .pure (InstCombine.Ty.bitvec 16) :=
  .lete (const 16 0  ) <|
  .ret ⟨0, by simp [Ctxt.snoc]⟩

#check alive_DivRemOfSelect_srca
#check aliveDivRemOfSelect_comWrapper

set_option pp.proofs true in
lemma src_eq_comwrapper :
  alive_DivRemOfSelect_srca
  =
  aliveDivRemOfSelect_comWrapper := by
  unfold alive_DivRemOfSelect_srca
  unfold aliveDivRemOfSelect_comWrapper
  simp only [Com.changeDialect_ret]
  simp only [Com.changeDialect_lete]
  dsimp []
  dsimp! only [Expr.changeDialect]


  simp only [
    (HVector.changeDialect_nil), InstcombineTransformDialect.MOp.instantiateCom]

  dsimp only [DialectMorphism.mapOp_mk, DialectMorphism.mapTy_mk,
    InstcombineTransformDialect.MOp.instantiateCom,
    InstcombineTransformDialect.instantiateMOp,
    InstcombineTransformDialect.instantiateMTy,
    HVector.changeDialect_nil, HVector.map']
  unfold ComWrappers.const
  simp_alive_meta
  rfl

def alive_DivRemOfSelect_src (w : Nat) :=
  [alive_icom (w)| {
  ^bb0():
    %c0 = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
    "llvm.return" (%c0) : (_) -> ()
  }]

def alive_DivRemOfSelect_tgt (w : Nat) :=
  [alive_icom (w)| {
  ^bb0():
    %c0 = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
    "llvm.return" (%c0) : (_) -> ()
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
  (@Ctxt.Valuation.snoc InstCombine.LLVM.Ty InstCombine.instTyDenoteTy
  (@List.nil InstCombine.Ty : List InstCombine.Ty)
  (InstCombine.Ty.bitvec w)
  Γv
  (@LLVM.const? w 0)) =
  (@Ctxt.Valuation.snoc InstCombine.LLVM.Ty InstCombine.instTyDenoteTy
  (@List.nil InstCombine.Ty : List InstCombine.Ty)
  (InstCombine.Ty.bitvec w)
  Γv
  (@LLVM.const? w 0)) := rfl

set_option pp.proofs true in
theorem alive_DivRemOfSelect (w : Nat) :
    alive_DivRemOfSelect_src w ⊑ alive_DivRemOfSelect_tgt w := by

  unfold alive_DivRemOfSelect_src alive_DivRemOfSelect_tgt
  simp only [Com.changeDialect_ret, Com.changeDialect_lete, Expr.changeDialect,
    (HVector.changeDialect_nil), InstcombineTransformDialect.MOp.instantiateCom]
  dsimp! []
  dsimp only [DialectMorphism.mapOp_mk, DialectMorphism.mapTy_mk,
    InstcombineTransformDialect.MOp.instantiateCom,
    InstcombineTransformDialect.instantiateMOp,
    InstcombineTransformDialect.instantiateMTy,
    HVector.changeDialect_nil, HVector.map']
  dsimp! []
  simp_alive_meta
  dsimp! only [InstCombine.MTy.bitvec]
  unfold InstcombineTransformDialect.instantiateMTy
  dsimp only [Ctxt.map_cons, ConcreteOrMVar.instantiate_mvar_zero'', Ctxt.get?, Var.zero_eq_last,
    List.map_cons, List.map_nil]
  dsimp (config := {failIfUnchanged := false }) only [ConcreteOrMVar.instantiate]
  unfold InstcombineTransformDialect.instantiateMOp
  unfold InstcombineTransformDialect.instantiateMTy
  simp!
  dsimp! []
  simp_alive_ssa


  simp (config := {failIfUnchanged := false}) only [
        Com.denote, Expr.denote,
        Ctxt.Valuation.snoc_last, Ctxt.map,
        DialectDenote.denote,
        /- Effect massaging -/
        EffectKind.liftEffect_rfl,
        InstCombine.Op.denote                      | ConcreteOrMVar.concrete w => w

      -- `simp` might close trivial goals, so we use `only_goal` to ensure we only run
      -- more tactics when we still have goals to solve, to avoid 'no goals to be solved' errors.
      only_goal
        simp (config := {failIfUnchanged := false}) only [Ctxt.Var.toSnoc, Ctxt.Var.last]
        repeat (generalize_or_fail at $Γv)
        try clear $Γv
      )
  simp_peephole [InstCombine.Op.denote] at Γv
  simp_alive_ssa
  simp (config := {failIfUnchanged := false}) only [
        Int.ofNat_eq_coe, Nat.cast_zero, DerivedCtxt.snoc, DerivedCtxt.ofCtxt,
        DerivedCtxt.ofCtxt_empty, Valuation.snoc_last,
        Com.denote, Expr.denote, Var.zero_eq_last, Var.succ_eq_toSnoc,
        Ctxt.empty, Ctxt.empty_eq, Ctxt.snoc, Ctxt.Valuation.nil, Ctxt.Valuation.snoc_last, Ctxt.map,
        Ctxt.Valuation.snoc_eval, Ctxt.ofList, Ctxt.Valuation.snoc_toSnoc,
        HVector.map, HVector.getN, HVector.get, HVector.toSingle, HVector.toPair, HVector.toTuple,
        DialectDenote.denote, Expr.op_mk, Expr.args_mk,
        DialectMorphism.mapOp, DialectMorphism.mapTy, List.map, Ctxt.snoc, List.map,
        Function.comp, Valuation.ofPair, Valuation.ofHVector, Function.uncurry,
        List.length_singleton, Fin.zero_eta, List.map_eq_map, List.map_cons, List.map_nil,
        bind_assoc, pairBind,
        /- `castPureToEff` -/
        Com.letPure, Expr.denote_castPureToEff,
        /- Unfold denotation -/
        Com.denote_lete, Com.denote_ret, Expr.denote_unfold, HVector.denote,
        /- Effect massaging -/
        EffectKind.toMonad_pure, EffectKind.toMonad_impure,
        EffectKind.liftEffect_rfl,
        Id.pure_eq, Id.bind_eq, id_eq,
        (HVector.denote_cons), (HVector.denote_nil), InstCombine.Op.denote, *]
  simp (config := {failIfUnchanged := false}) only [
            InstCombine.Op.denote, HVector.getN, HVector.get
          ]






  simp_peephole
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
