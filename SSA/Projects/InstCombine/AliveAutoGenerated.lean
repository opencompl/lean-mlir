import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.Tactic
open MLIR AST

abbrev ICom.Refinement (src tgt : Com (φ:=0) Γ t) (h : Goedel.toType t = Option α := by rfl) : Prop :=
  ∀ Γv, Bitvec.Refinement (h ▸ src.denote Γv) (h ▸ tgt.denote Γv)

infixr:90 " ⊑ "  => ICom.Refinement


-- Name:AddSub:1043
-- precondition: true
/-
  %Y = and %Z, C1
  %X = xor %Y, C1
  %LHS = add %X, 1
  %r = add %LHS, %RHS

=>
  %or = or %Z, ~C1
  %Y = and %Z, C1
  %X = xor %Y, C1
  %LHS = add %X, 1
  %r = sub %RHS, %or

-/
def AddSub_1043_src (w : Nat) :=
[mlir_icom (w)| {
^bb0(%C1 : _, %Z : _, %RHS : _):
  %v1 = "llvm.and" (%Z,%C1) : (_, _) -> (_)
  %v2 = "llvm.xor" (%v1,%C1) : (_, _) -> (_)
  %v3 = "llvm.mlir.constant" () { value = 1 : _ } :() -> (_)
  %v4 = "llvm.add" (%v2,%v3) : (_, _) -> (_)
  %v5 = "llvm.add" (%v4,%RHS) : (_, _) -> (_)
  "llvm.return" (%v5) : (_) -> ()
}]

def AddSub_1043_tgt (w : Nat):=
[mlir_icom (w)| {
^bb0(%C1 : _, %Z : _, %RHS : _):
  %v1 = "llvm.not" (%C1) : (_) -> (_)
  %v2 = "llvm.or" (%Z,%v1) : (_, _) -> (_)
  %v3 = "llvm.and" (%Z,%C1) : (_, _) -> (_)
  %v4 = "llvm.xor" (%v3,%C1) : (_, _) -> (_)
  %v5 = "llvm.mlir.constant" () { value = 1 : _ } :() -> (_)
  %v6 = "llvm.add" (%v4,%v5) : (_, _) -> (_)
  %v7 = "llvm.sub" (%RHS,%v2) : (_, _) -> (_)
  "llvm.return" (%v7) : (_) -> ()
}]

open Ctxt (Var) in
theorem AddSub_1043_refinement (w : Nat) : AddSub_1043_src w ⊑ AddSub_1043_tgt w := by
  unfold AddSub_1043_src AddSub_1043_tgt
  intro (Γv : ([.bitvec w, .bitvec w, .bitvec w] : List InstCombine.Ty) |> Ctxt.Valuation)
  simp [ICom.denote, IExpr.denote, HVector.denote, Var.zero_eq_last, Var.succ_eq_toSnoc,
        Ctxt.snoc, Ctxt.Valuation.snoc_last, Ctxt.ofList, Ctxt.Valuation.snoc_toSnoc,
        HVector.map, OpDenote.denote, IExpr.op_mk, IExpr.args_mk, ICom.Refinement,
        Bind.bind]
  simp_alive
  rfl