import LeanMLIR.MLIRSyntax.PrettyEDSL
import SSA.Projects.InstCombine.Tactic
open Lean

namespace MLIR.EDSL
open Pretty

/-!
# Pretty syntax for the disjoint flag

This file defines the `MLIR.Pretty.disjoint_op` syntax category which, just like `MLIR.Pretty.disjoint_op`,
is a category of MLIR operations where the arguments and return values are all of the same type.
Additionally, `disjoint_op`s may be annotated with the `disjoint` flag.
The pretty syntax for this flag is `disjoint`.
It gets translated to `<{isDisjoint}>` in the generic syntax.
-/
declare_syntax_cat MLIR.Pretty.disjoint_op

-- syntax (mlir_op_operand " = ")? MLIR.Pretty.disjoint_op mlir_op_operand,* (" : " mlir_type)? : mlir_op
-- macro_rules
--   | `(mlir_op| $[$resName =]? $name:MLIR.Pretty.disjoint_op $xs,*  $[: $t]? ) => do
--     let some opName := extractOpName name.raw | Macro.throwUnsupported
--     let t ← t.getDM `(mlir_type| _)
--     let argTys : TSyntaxArray `mlir_type := xs.getElems.map (fun _ => t)
--     let retTy : TSyntaxArray `mlir_type := match resName with
--       | some _ => #[t]
--       | none => #[]
--     `([mlir_op| $[$resName =]? $opName ($xs,*) : ($argTys,*) -> ($retTy:mlir_type,*) ])

syntax (mlir_op_operand " = ")? MLIR.Pretty.disjoint_op " disjoint " mlir_op_operand,* (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $[$resName =]? $name:MLIR.Pretty.disjoint_op disjoint $xs,*  $[: $t]? ) => do
    let some opName := extractOpName name.raw | Macro.throwUnsupported
    let t ← t.getDM `(mlir_type| _)
    let argTys : TSyntaxArray `mlir_type := xs.getElems.map (fun _ => t)
    let retTy : TSyntaxArray `mlir_type := match resName with
      | some _ => #[t]
      | none => #[]
    `([mlir_op| $[$resName =]? $opName ($xs,*) <{isDisjoint}> : ($argTys,*) -> ($retTy:mlir_type,*) ])

end MLIR.EDSL
