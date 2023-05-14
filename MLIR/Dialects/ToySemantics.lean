import MLIR.Dialects.ToyModel
import MLIR.Dialects.BuiltinModel
import MLIR.Semantics.Fitree
import MLIR.Semantics.Verifier
import MLIR.Semantics.SSAEnv
import MLIR.Semantics.UB
import MLIR.Semantics.TensorElem
import MLIR.Util.Metagen
import MLIR.Util.Reduce

import MLIR.AST
import MLIR.EDSL

import Lean

open MLIR.AST


/- To be automatically generated -/

inductive ToyOp: Type → Type :=
  | Constant:
      (cst_D: DimList) → (cst_τ: MLIRTy) → (cst: TensorLiteral cst_D cst_τ) →
      ToyOp (RankedTensor cst_D cst_τ)
  | Transpose:
      (τ: MLIRTy) → (n m: Nat) →
      RankedTensor [Dimension.Known n, Dimension.Known m] τ →
      ToyOp (RankedTensor [Dimension.Known m, Dimension.Known n] τ)
  | Reshape:
      (τ: MLIRTy) → (D D': DimList) → (H: D.known) → (H': D'.known) →
      (Hprod: D'.prod = D.prod) →
      RankedTensor D τ →
      ToyOp (RankedTensor D' τ)

/- To be automatically generated (hopefully; basically this is the
   verification stuff) -/

def toy_semantics_op (op: Op builtin):
    Fitree (UBE +' SSAEnvE builtin +' ToyOp) Unit :=
  match op with
  | Op.mk "toy.constant" [(res, builtin.tensor D₁ τ₁)] [] .regionsnil attrs =>
      match AttrDict.find attrs "value" with
      | some (builtin.dense_tensor_attr elem D₂ τ₂) =>
          match TensorLiteral.ofTensorElem elem D₁ τ₁ with
          | none =>
              raiseUB s!"{op}"
          | some t_lit => do
              let t ← Fitree.trigger <| ToyOp.Constant D₁ τ₁ t_lit
              SSAEnv.set? (builtin.tensor D₁ τ₁) res t
      | _ =>
          raiseUB s!"{op}"

  | Op.mk "toy.transpose" [(res, τ₂)] [(t_name, builtin.tensor D τ)] .regionsnil _ =>
      match D with
      | [Dimension.Known n, Dimension.Known m] => do
          let t ← Fitree.trigger (SSAEnvE.Get (builtin.tensor
                  [Dimension.Known n, Dimension.Known m] τ) t_name);
          let t' ← Fitree.trigger (ToyOp.Transpose τ n m t);
          SSAEnv.set? (builtin.tensor [Dimension.Known m, Dimension.Known n] τ)
            (some res) t'
      | _ =>
          raiseUB s!"{op}"

  | Op.mk "toy.reshape" [(res, builtin.tensor D' τ₂)]
        [(t_name, builtin.tensor D τ₁)] .regionsnil _ =>
      if H: τ₁ = τ₂
        ∧ DimList.known D
        ∧ DimList.known D'
        ∧ DimList.prod D' = DimList.prod D then do
        let t ← Fitree.trigger (SSAEnvE.Get (builtin.tensor D τ₁) t_name);
        let t' ← Fitree.trigger (ToyOp.Reshape τ₁ D D'
                H.2.1 H.2.2.1 H.2.2.2 t);
        let t': RankedTensor D' τ₂ := cast (by rw [H.1]) t';
        SSAEnv.set? (builtin.tensor D' τ₂) (some res) t'
      else
        raiseUB s!"{op}"

  | _ => raiseUB s!"{op}"

def toy_semantics_ops: Ops builtin →
      Fitree (UBE +' (SSAEnvE builtin) +' ToyOp) Unit
| .opsnil => Fitree.ret ()
| .opscons o os => do
      toy_semantics_op o
      toy_semantics_ops os
-- TODO: toy_semantics_bb: handle basic block arguments
@[simp]
def toy_semantics_region: Region builtin →
      Fitree (UBE +' (SSAEnvE builtin) +' ToyOp) Unit
  | Region.mk name args .opsnil =>
      Fitree.ret ()
  | Region.mk name args os =>
         (toy_semantics_ops os)

/- Manually specified: ToyOp event handler -/

def ToyOp.handle {E}: ToyOp ~> Fitree E :=
  fun _ e => match e with
  | ToyOp.Constant D τ t_lit =>
      return RankedTensor.ofTensorLiteral t_lit
  | ToyOp.Transpose α n m t =>
      return transpose t
  | ToyOp.Reshape α D D' H H' Hprod t =>
      return reshape D' H H' Hprod t

-- Interpretation in context

def interp_toy {E} (t: Fitree (ToyOp +' E) R): Fitree E R :=
  t.interp (Fitree.case ToyOp.handle (fun T => @Fitree.trigger E E T _))

@[simp]
def run_toy (t: Fitree (UBE +' SSAEnvE builtin +' ToyOp) Unit)
    (env: SSAEnv builtin): Fitree Void1 (Unit × SSAEnv builtin) :=
  Fitree.interp ToyOp.handle (interpSSA' (interpUB'! t) env)

/-
### Examples and testing
-/

-- TODO: Can we infer the builtin in there?
def transpose_stmt: Op builtin := [mlir_op|
  %t2 = "toy.transpose"(%t1): (tensor<2×4×i32>) -> (tensor<4×2×i32>)
]

def constant_stmt: Op builtin := [mlir_op|
  %t = "toy.constant"() {value=dense<[[1,2],[3,4]]>: tensor<2×2×i32>}:
    () -> (tensor<2×2×i32>)
]

def double_transpose: Region builtin := [mlir_region| {
  ^dbl:
    %t2 = "toy.transpose"(%t1): (tensor<2×4×i32>) -> (tensor<4×2×i32>)
    %t3 = "toy.transpose"(%t2): (tensor<4×2×i32>) -> (tensor<2×4×i32>)
}]

#eval Fitree.run <| run_toy (toy_semantics_op transpose_stmt) SSAEnv.empty

#eval Fitree.run <| run_toy (toy_semantics_op constant_stmt) SSAEnv.empty

/-
See 'bcb600a4500455ae9c72383031290cfc210ce13b' where this infinite looped.
theorem double_transpose_correct:
  ∀ (t1: RankedTensor [.Known 2, .Known 4] .i32),
    run_toy (toy_semantics_region double_transpose)
      (SSAEnv.One [("t1", ⟨builtin.tensor [.Known 2, .Known 4] .i32, t1⟩)])
    =
    Fitree.ret ((), SSAEnv.One [
      (SSAVal.SSAVal "t1", ⟨builtin.tensor [.Known 2, .Known 4] .i32, t1⟩),
      (SSAVal.SSAVal "t2", ⟨builtin.tensor [.Known 4, .Known 2] .i32,
                           transpose t1⟩),
      (SSAVal.SSAVal "t3", ⟨builtin.tensor [.Known 2, .Known 4] .i32, t1⟩)
    ]) := by
  intros t1
  simp [double_transpose, toy_semantics_region, toy_semantics_op]; simp_itree
  simp [interpUB'!]; simp_itree
  simp [interpSSA', Fitree.interpState, SSAEnvE.handle]; simp_itree
  simp [SSAEnv.get, SSAEnv.getT, SSAEnv.set]; simp_itree
  simp [SSAEnv.get, SSAEnv.getT, SSAEnv.set]; simp_itree
  rw [transpose_involutive]
-/
