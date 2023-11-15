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

end MLIR
