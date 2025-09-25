import LeanMLIR.MLIRSyntax.PrettyEDSL
import SSA.Projects.InstCombine.Tactic
open Lean

namespace MLIR.EDSL
open Pretty

/-!
# Pretty syntax for the non negative flag

This file defines the `MLIR.Pretty.nneg_op` syntax category which, just like `MLIR.Pretty.uniform_op`,
is a category of MLIR operations where the arguments and return values are all of the same type.
Additionally, `nneg_op`s may be annotated with the `nneg` flag.
The pretty syntax for this flag is `nneg`.
It gets translated to `<{nonNeg}>` in the generic syntax.
-/
declare_syntax_cat MLIR.Pretty.nneg_op

syntax (mlir_op_operand " = ")? MLIR.Pretty.nneg_op mlir_op_operand " : " mlir_type " to " mlir_type : mlir_op
macro_rules
  | `(mlir_op| $resName:mlir_op_operand = $name:MLIR.Pretty.nneg_op $x : $t to $t') => do
    let some opName := extractOpName name.raw
      | Macro.throwUnsupported
    `(mlir_op| $resName:mlir_op_operand = $opName ($x) : ($t) -> $t')

syntax (mlir_op_operand " = ")? MLIR.Pretty.nneg_op " nneg " mlir_op_operand " : " mlir_type " to " mlir_type : mlir_op
macro_rules
  | `(mlir_op| $resName:mlir_op_operand = $name:MLIR.Pretty.nneg_op nneg $x : $t to $t') => do
    let some opName := extractOpName name.raw
      | Macro.throwUnsupported
    `(mlir_op| $resName:mlir_op_operand = $opName ($x) <{nonNeg}> : ($t) -> $t')

end MLIR.EDSL
