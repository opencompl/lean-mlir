import SSA.Core.DSL.MLIRSyntax.AST

namespace MLIR.AST

inductive TransformError (Ty : Type)
  | nameAlreadyDeclared (var : String)
  | undeclaredName (var : String)
  | indexOutOfBounds (name : String) (index len : Nat)
  | typeError (expected got : Ty)
  | widthError {φ} (expected got : Width φ)
  | unsupportedUnaryOp
  | unsupportedBinaryOp (error : String)
  | unsupportedOp (error : String)
  | unsupportedType
  | generic (error : String)

namespace TransformError

instance [Repr Ty] : Repr (TransformError Ty) where
  reprPrec err _ := match err with
    | nameAlreadyDeclared var => f!"Already declared {var}, shadowing is not allowed"
    | undeclaredName name => f!"Undeclared name '{name}'"
    | indexOutOfBounds name index len =>
        f!"Index of '{name}' out of bounds of the given context (index was {index}, but context has length {len})"
    | typeError expected got => f!"Type mismatch: expected '{repr expected}', but 'name' has type '{repr got}'"
    | widthError expected got => f!"Type mismatch: {expected} ≠ {got}"
    | unsupportedUnaryOp => f!"Unsuported unary operation"
    | unsupportedBinaryOp err => f!"Unsuported binary operation 's!{err}'"
    | unsupportedOp err => f!"Unsuported operation 's!{err}'"
    | unsupportedType => f!"Unsuported type"
    | generic err => err

end TransformError

end MLIR.AST
