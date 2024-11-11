import SSA.Core.MLIRSyntax.PrettyEDSL
import SSA.Projects.InstCombine.Tactic
open Lean

namespace MLIR.EDSL
open Pretty

/-!
# Pretty syntax for overflow flags

This file defines the `MLIR.Pretty.overflow_op` syntax category which, just like `MLIR.Pretty.uniform_op`,
is a category of MLIR operations where the arguments and return values are all of the same type.
Additionally, `overflow_op`s may be annotated with overflow flags, which are `nsw` and `nuw`.
The pretty syntax for these flags is `overflow<flags>`.
It gets translated to `<{overflowFlags = #llvm.overflow< flags >}>` in the generic syntax.
-/
declare_syntax_cat MLIR.Pretty.overflow_op
declare_syntax_cat MLIR.Pretty.overflow_int_cast_op

syntax overflow_flag := "nsw" <|> "nuw"

syntax (mlir_op_operand " = ")? MLIR.Pretty.overflow_op mlir_op_operand,* (" overflow<" overflow_flag,* "> ")?
  (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $[$resName =]? $name:MLIR.Pretty.overflow_op $xs,* $[overflow< $[$f],* >]? $[: $t]? ) => do
    let some opName := extractOpName name.raw | Macro.throwUnsupported
    let t ← t.getDM `(mlir_type| _)
    let argTys : TSyntaxArray `mlir_type := xs.getElems.map (fun _ => t)
    let retTy : TSyntaxArray `mlir_type := match resName with
      | some _ => #[t]
      | none => #[]
    let ovflags ← f.mapM fun f => f.mapM fun
      | `(overflow_flag|nsw) =>
        `(mlir_attr_val|$(mkIdent `nsw):ident)
      | `(overflow_flag|nuw) =>
        `(mlir_attr_val|$(mkIdent `nuw):ident)
      | _ => Macro.throwUnsupported
    `([mlir_op| $[$resName =]? $opName ($xs,*) $[<{overflowFlags = #llvm.overflow< $ovflags,* >}>]? : ($argTys,*) -> ($retTy:mlir_type,*) ])

syntax mlir_op_operand " = " MLIR.Pretty.overflow_int_cast_op mlir_op_operand (" overflow<" overflow_flag,* "> ")? " : " mlir_type " to " mlir_type : mlir_op
macro_rules
  | `(mlir_op| $resName:mlir_op_operand = $name:MLIR.Pretty.overflow_int_cast_op $x $[overflow< $[$f],* >]? : $t to $t' ) => do
    let some opName := extractOpName name.raw | Macro.throwUnsupported
    let ovflags ← f.mapM fun f => f.mapM fun
      | `(overflow_flag|nsw) =>
        `(mlir_attr_val|$(mkIdent `nsw):ident)
      | `(overflow_flag|nuw) =>
        `(mlir_attr_val|$(mkIdent `nuw):ident)
      | _ => Macro.throwUnsupported
    `([mlir_op| $resName:mlir_op_operand = $opName ($x) $[<{overflowFlags = #llvm.overflow< $ovflags,* >}>]? : ($t) -> $t' ])

end MLIR.EDSL
