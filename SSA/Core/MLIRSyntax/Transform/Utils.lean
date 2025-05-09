import SSA.Core.MLIRSyntax.AST
import SSA.Core.MLIRSyntax.Transform.TransformError

/-!
This file defines a set of helper functions on `AST` objects that
are usefull to implementors of `Transform` typeclasses
-/

namespace MLIR.AST

namespace Op
variable {φ} (op : Op φ)


/--
`op.getAttr attr` returns the value of an attribute, if present,
or throw an error otherwise. -/
def getAttr (attr : String) : Except (TransformError Ty) (AttrValue φ) := do
  let some val := op.getAttr? attr
    | .error <| .generic s!"Missing attribute `{attr}`"
  return val

/--
`op.getBoolAttr attr` returns the value of a Boolean attribute.

Throws an error if the attribute is not present, or if the value of the attribute
has the wrong type.
-/
def getBoolAttr (attr : String) : Except (TransformError Ty) Bool := do
  let .bool b ← op.getAttr attr
    | .error <| .generic s!"Expected attribute `{attr}` to be of type Bool, but found:\n\
        \t{attr}"
  return b

/--
`op.getIntAttr attr` returns the value of an integer attribute.

Throws an error if the attribute is not present, or if the value of the attribute
has the wrong type.
-/
def getIntAttr (attr : String) : Except (TransformError Ty) (Int × MLIRType φ) := do
  let .int val ty ← op.getAttr attr
    | .error <| .generic s!"Expected attribute `{attr}` to be of type Int, but found:\n\
        \t{attr}"
  return (val, ty)

end Op
