import SSA.Core.MLIRSyntax.GenericParser
open Lean

declare_syntax_cat InstCombine.un_op_name
declare_syntax_cat InstCombine.bin_op_name

syntax "llvm.return" : InstCombine.un_op_name
syntax "llvm.not" : InstCombine.un_op_name

syntax "llvm.add" : InstCombine.bin_op_name
syntax "llvm.mul" : InstCombine.bin_op_name


syntax (mlir_op_operand " = ")? InstCombine.un_op_name mlir_op_operand " : " mlir_type : mlir_op
syntax mlir_op_operand " = " InstCombine.bin_op_name mlir_op_operand ", " mlir_op_operand " : " mlir_type : mlir_op

macro_rules
  | `([mlir_op| $[$resName =]? $name:InstCombine.un_op_name $x : $t ]) => do
    let name ← match name.raw with
      | .node _ _ ⟨.atom _ name :: _⟩ => pure name
      | _ => Macro.throwErrorAt name s!"Expected an atom, found: {name}" --TODO: better error message
    let opName := Syntax.mkStrLit name
    let retTy : TSyntaxArray `mlir_type := match resName with
      | some _ => #[t]
      | none => #[]
    `([mlir_op| $[$resName =]? $opName ($x) : ($t) -> ($retTy:mlir_type,*) ])

macro_rules
  | `([mlir_op| $resName:mlir_op_operand = $name:InstCombine.bin_op_name $x, $y : $t ]) => do
    let name ← match name.raw with
      | .node _ _ ⟨.atom _ name :: _⟩ => pure name
      | _ => Macro.throwErrorAt name s!"Expected an atom, found: {name}" --TODO: better error message
    let opName := Syntax.mkStrLit name
    `([mlir_op| $resName:mlir_op_operand = $opName ($x, $y) : ($t, $t) -> ($t) ])

syntax mlir_op_operand " = " "llvm.mlir.constant" num " : " mlir_type : mlir_op
set_option hygiene false in
-- TODO: we need hygiene here because `value` is an identifier, which would otherwise be mangled
macro_rules
  | `([mlir_op| $res:mlir_op_operand = llvm.mlir.constant $x : $t]) =>
    `([mlir_op| $res:mlir_op_operand = "llvm.mlir.constant"() {value = $x:num : $t} : () -> ($t) ])
