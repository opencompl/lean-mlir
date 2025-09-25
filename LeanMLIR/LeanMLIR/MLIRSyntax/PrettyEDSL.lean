import LeanMLIR.MLIRSyntax.GenericParser
/-!
# Pretty MLIR Syntax

This file buils some common functionality that dialects can use to define pretty syntax.
Note that since pretty syntax is just defined as Lean macros, none of this is *required*.
-/

namespace MLIR.EDSL.Pretty
open Lean

/-! The category of uniform operation (names).
Syntax of this category is expected to be just a single atom, which is seen as the name of a
MLIR operation where all inputs and outputs have the same type -/
declare_syntax_cat MLIR.Pretty.uniform_op

/-- Given syntax which consists of just a node with a single atom (as expected by `uniform_op`),
extract the name of the operation and return it as a string literal syntax. -/
def extractOpName : Syntax → Option (TSyntax `str)
  | .node _ _ ⟨.atom _ name :: _⟩ => some <| Syntax.mkStrLit name
  | _ => none

/-!
If we register `foo.bar` as a uniform op, then syntax like the following will be parsed
```lean
$x = foo.bar $y, $z : $t
```
The uniformity means only a single mlir type has to be specified, this is expanded to:
```lean
$x = "foo.bar"($y, $z) : ($t, $t) -> $t
```
Where the number of repeated `t`s is determined by the number of arguments given.

It's also possible to leave out the `: $t` type annotation entirely, in which case `t` will be
assumed to be `_`, the "hole" type.
-/
syntax (mlir_op_operand " = ")? MLIR.Pretty.uniform_op mlir_op_operand,*
  (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $[$resName =]? $name:MLIR.Pretty.uniform_op $xs,* $[: $t]? ) => do
    let some opName := extractOpName name.raw | Macro.throwUnsupported
    let t ← t.getDM `(mlir_type| _)
    let argTys : TSyntaxArray `mlir_type := xs.getElems.map (fun _ => t)
    let retTy : TSyntaxArray `mlir_type := match resName with
      | some _ => #[t]
      | none => #[]
    `([mlir_op| $[$resName =]? $opName ($xs,*) : ($argTys,*) -> ($retTy:mlir_type,*) ])

end MLIR.EDSL.Pretty
