/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.MLIRSyntax.AST

namespace MLIR.AST

inductive TransformError
  | nameAlreadyDeclared (var : String)
  | undeclaredName (var : String)
  | indexOutOfBounds (name : String) (index len : Nat)
  | typeError (expected got : String)
  | widthError {φ} (expected got : Width φ)
  | unsupportedUnaryOp
  | unsupportedBinaryOp (error : String)
  | unsupportedOp (error : String)
  | unsupportedType
  | generic (error : String)

namespace TransformError

instance : Repr (TransformError) where
  reprPrec err _ := match err with
    | nameAlreadyDeclared var => f!"Already declared {var}, shadowing is not allowed"
    | undeclaredName name => f!"Undeclared name '{name}'"
    | indexOutOfBounds name index len =>
        f!"Index of '{name}' out of bounds of the given context " ++
        f!"(index was {index}, but context has length {len})"
    | typeError expected got =>
        f!"Type mismatch: expected '{repr expected}', but 'name' has type '{repr got}'"
    | widthError expected got => f!"Type mismatch: {expected} ≠ {got}"
    | unsupportedUnaryOp => f!"Unsupported unary operation"
    | unsupportedBinaryOp err => f!"Unsupported binary operation 's!{err}'"
    | unsupportedOp err => f!"Unsupported operation 's!{err}'"
    | unsupportedType => f!"Unsupported type"
    | generic err => err

end TransformError

end MLIR.AST
