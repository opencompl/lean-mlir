import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import Mathlib.Data.List.AList
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import SSA.Projects.MLIRSyntax.AST -- TODO post-merge: bring into Core
import SSA.Projects.MLIRSyntax.EDSL -- TODO post-merge: bring into Core


open MLIR AST
open Std (BitVec)
open Ctxt (Var)

-- set_option pp.proofs false
-- set_option pp.proofs.withType false


/-
Name: SimplifyDivRemOfSelect

%sel = select %c, %Y, 0
%r = udiv %X, %sel
  =>
%r = udiv %X, %Y

-/

/-
def alive_simplifyDivRemOfSelect (w : Nat) :
[mlir_icom( w )| {
^bb0(%c : i1, %X : _, %Y : _):
  %v0  = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
  %sel = "llvm.select" (%c,%Y,%v0) : (i1, _, _) -> (_)
  %r   = "llvm.udiv" (%X,%sel) : (_, _) -> (_)
  "llvm.return" (%r) : (_) -> ()
}] ⊑ [mlir_icom ( w )| {
^bb0(%c : i1, %X : _, %Y : _):
  %r = "llvm.udiv" (%X,%Y) : (_, _) -> (_)
  "llvm.return" (%r) : (_) -> ()
}] := by
  simp_alive_peephole
  -- goal: ⊢ BitVec.udiv? x1✝ (BitVec.select x2✝ x0✝ (BitVec.ofInt w 0)) ⊑ BitVec.udiv? x1✝ x0✝
  sorry
-/

/-
Name: MulDivRem:805
%r = sdiv 1, %X
  =>
%inc = add %X, 1
%c = icmp ult %inc, 3
%r = select %c, %X, 0

Proof:
======
  Values of LHS:
    - 1/x where x >= 2: 0
    - 1/1 = 1
    - 1/0 = UB
    - 1/ -1 = -1
    - 1/x where x <= -2: 0
  Values of RHS:
    RHS: (x + 2) <_u 3 ? x : 0
    - x >= 2: (x + 1) <_u 3 ? x : 0
              =  false ? x : 0 = false
    - x = 1: (1 + 1) <_u 3 ? x : 0
              = 2 <_u 3 ? x : 0
              = true ? x : 0
              = x = 1
    - x = 0: (0 + 1) <_u 3 ? x : 0
              = 1 <_u 3 ? 0 : 0
              = true ? 0 : 0
              = 0
    - x = -1: (-1 + 1) <_u 3 ? x : 0
              = 0 <_u 3 ? x : 0
              = true ? x : 0
              = x = -1
    - x <= -2 : (-2 + 1) <_u 3 ? x : 0
              = -1 <_u 3 ? x : 0
              = INT_MAX < 3 ? x : 0
              = false ? x : 0
              = 0
 Thus, LHS and RHS agree on values.
-/
def alive_simplifyMulDivRem805 (w : Nat) :
    [alive_icom ( w )| {
    ^bb0(%X : _):
      %v1  = "llvm.mlir.constant" () { value = 1 : _ } :() -> (_)
      %r   = "llvm.sdiv" (%v1,%X) : (_, _) -> (_)
      "llvm.return" (%r) : (_) -> ()
    }] ⊑ [alive_icom ( w )| {
    ^bb0(%X : _):
      %v1  = "llvm.mlir.constant" () { value = 1 : _ } :() -> (_)
      %inc = "llvm.add" (%v1,%X) : (_, _) -> (_)
      %v3  = "llvm.mlir.constant" () { value = 3 : _ } :() -> (_)
      %c   = "llvm.icmp.ult" (%inc, %v3) : (_, _) -> (i1)
      %v0  = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
      %r = "llvm.select" (%c, %X, %v0) : (i1, _, _) -> (_)
      "llvm.return" (%r) : (_) -> ()
    }] := by
  simp_alive_peephole
  sorry

/-
Name: MulDivRem:290

%Op0 = shl 1, %Y
%r = mul %Op0, %Op1
  =>
%r = shl %Op1, %Y

Proof
======
  1. Without taking UB into account
    ⟦LHS₁⟧: (1 << Y) . Op1 = (1 . 2^Y) X = 2^Y . Op1
    ⟦RHS₁⟧: Op1 << Y = Op1 . 2^Y
    equal by ring.

  2. With UB into account
    ⟦LHS₂⟧: (1 << Y) . Op1 = Y >= n ? UB : ⟦LHS₁⟧
    ⟦RHS₂⟧: Op1 << Y = Y >= n ? UB : ⟦RHS₁⟧
    but ⟦LHS₁⟧ = ⟦ RHS₁⟧ and thus we are done.

-/
def alive_simplifyMulDivRem290 (w : Nat) :
    [alive_icom ( w )| {
    ^bb0(%Op1 : _ , %Y : _):
      %v1  = "llvm.mlir.constant" () { value = 1 : _ } :() -> (_)
      %Op0   = "llvm.shl" (%v1, %Y) : (_, _) -> (_)
      %r = "llvm.mul"(%Op0, %Op1) : (_, _) -> (_)
      "llvm.return" (%r) : (_) -> ()
    }] ⊑ [alive_icom ( w )| {
    ^bb0(%Op1 : _, %Y : _):
      %r = "llvm.mul" (%Op1, %Y) : (_, _) -> (_)
      "llvm.return" (%r) : (_) -> ()
    }] := by
  dsimp only [Com.Refinement]
  intros Γv
  simp [InstcombineTransformDialect.MOp.instantiateCom, InstcombineTransformDialect.instantiateMOp,
    ConcreteOrMVar.instantiate, Vector.get, List.nthLe, List.length_singleton, Fin.coe_fin_one, Fin.zero_eta,
    List.get_cons_zero, Function.comp_apply, InstcombineTransformDialect.instantiateMTy, Ctxt.empty_eq, Ctxt.DerivedCtxt.snoc,
    Ctxt.DerivedCtxt.ofCtxt, List.map_eq_map, List.map, DialectMorphism.mapTy, List.get] at Γv

  generalize Γv { val := 0, property := _ } = a;

  -- generalize Γv { val := 1, property := _ } = b;
  -- simp_alive_peephole
  sorry

def alive_AddSub_1152_src   :=
[alive_icom| {
^bb0(%y : i1, %x : i1):
  %v1 = "llvm.add" (%x,%y) : (i1, i1) -> (i1)
  "llvm.return" (%v1) : (i1) -> ()
}]

def alive_AddSub_1152_tgt  :=
[alive_icom ()| {
^bb0(%y : i1, %x : i1):
  %v1 = "llvm.xor" (%x,%y) : (i1, i1) -> (i1)
  "llvm.return" (%v1) : (i1) -> ()
}]
theorem alive_AddSub_1152   : alive_AddSub_1152_src ⊑ alive_AddSub_1152_tgt := by
  unfold alive_AddSub_1152_src alive_AddSub_1152_tgt
  dsimp only [Com.Refinement]
  intros Γv
  simp [InstcombineTransformDialect.MOp.instantiateCom, InstcombineTransformDialect.instantiateMOp,
    ConcreteOrMVar.instantiate, Vector.get, List.nthLe, List.length_singleton, Fin.coe_fin_one, Fin.zero_eta,
    List.get_cons_zero, Function.comp_apply, InstcombineTransformDialect.instantiateMTy, Ctxt.empty_eq, Ctxt.DerivedCtxt.snoc,
    Ctxt.DerivedCtxt.ofCtxt, List.map_eq_map, List.map, DialectMorphism.mapTy, List.get] at Γv
  simp (config := {decide := false}) only [
        Int.ofNat_eq_coe, Nat.cast_zero, Ctxt.DerivedCtxt.snoc, Ctxt.DerivedCtxt.ofCtxt,
        Ctxt.DerivedCtxt.ofCtxt_empty, Ctxt.Valuation.snoc_last,
        Com.denote, Expr.denote, HVector.denote, Var.zero_eq_last, Var.succ_eq_toSnoc,
        Ctxt.empty, Ctxt.empty_eq, Ctxt.snoc, Ctxt.Valuation.nil, Ctxt.Valuation.snoc_last,
        Ctxt.ofList, Ctxt.Valuation.snoc_toSnoc,
        HVector.map, HVector.toPair, HVector.toTuple, OpDenote.denote, Expr.op_mk, Expr.args_mk,
        DialectMorphism.mapOp, DialectMorphism.mapTy, List.map, Ctxt.snoc, List.map]
  -- simp_peephole at Γv
  generalize Γv { val := 0, property := _ } = a;
  -- simp (config := {decide := false}) [Goedel.toType] at a;
  -- revert a
  -- clear a
