import SSA.Core.MLIRSyntax.PrettyEDSL
import SSA.Projects.InstCombine.Tactic
open Lean

namespace MLIR.EDSL
open Pretty


declare_syntax_cat MLIR.Pretty.overflow_flag
declare_syntax_cat MLIR.Pretty.overflow_op

syntax "nsw" : MLIR.Pretty.overflow_flag
syntax "nuw" : MLIR.Pretty.overflow_flag

syntax (mlir_op_operand " = ")? MLIR.Pretty.overflow_op mlir_op_operand,* (" overflow<" MLIR.Pretty.overflow_flag,* "> ")?
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
      | `(MLIR.Pretty.overflow_flag|nsw) =>
        `(mlir_attr_val|$(mkIdent `nsw):ident)
      | `(MLIR.Pretty.overflow_flag|nuw) =>
        `(mlir_attr_val|$(mkIdent `nuw):ident)
      | _ => Macro.throwUnsupported
    `([mlir_op| $[$resName =]? $opName ($xs,*) $[<{overflowFlags = #llvm.overflow< $ovflags,* >}>]? : ($argTys,*) -> ($retTy:mlir_type,*) ])

end MLIR.EDSL
