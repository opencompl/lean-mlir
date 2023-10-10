import SSA.Core.Framework
import SSA.Projects.InstCombine.LLVM.Transform

namespace MLIR

/-!
  ## Instantiation
  Finally, we show how to instantiate a family of programs to a concrete program
-/

class TransformDialectInstantiate (Op : Type) (φ : Nat) (Ty MOp MTy : outParam Type)
    [OpSignature Op Ty] [AST.TransformDialect MOp MTy φ] where
  morphism : Vector Nat φ → DialectMorphism MOp Op


set_option linter.unusedVariables false -- linter gives a false positive for `φ` in `[∀ φ, ...]`

variable (Op) (φ) {Ty} {MOp MTy} [OpSignature Op Ty]
  [AST.TransformDialect MOp MTy φ]
  [instInst : TransformDialectInstantiate Op φ Ty MOp MTy] 
  [DecidableEq MTy]

def AST.mkComInstantiate (reg : AST.Region φ) : 
    AST.ExceptM MOp (Vector Nat φ → Σ (Γ : Ctxt Ty) (ty : Ty), ICom Op Γ ty) := do
  let ⟨Γ, ty, icom⟩ ← AST.mkCom MOp reg  
  return fun vals =>
    let f := instInst.morphism vals
    ⟨Γ.map f.mapTy, f.mapTy ty, icom.map f⟩

end MLIR