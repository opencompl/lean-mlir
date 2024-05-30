import SSA.Core.MLIRSyntax.GenericParser
import SSA.Projects.InstCombine.Tactic
open Lean

declare_syntax_cat InstCombine.un_op_name
declare_syntax_cat InstCombine.bin_op_name

syntax "llvm.return" : InstCombine.un_op_name
syntax "llvm.not" : InstCombine.un_op_name

syntax "llvm.add" : InstCombine.bin_op_name
syntax "llvm.mul" : InstCombine.bin_op_name


syntax (mlir_op_operand " = ")? InstCombine.un_op_name mlir_op_operand " : " mlir_type : mlir_op
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

macro resName:mlir_op_operand " = " name:InstCombine.bin_op_name
    x:mlir_op_operand ", " y:mlir_op_operand " : " t:mlir_type : mlir_op  => do
  let name ← match name.raw with
    | .node _ _ ⟨.atom _ name :: _⟩ => pure name
    | _ => Macro.throwErrorAt name s!"Expected an atom, found: {name}" --TODO: better error message
  let opName := Syntax.mkStrLit name
  `(mlir_op| $resName:mlir_op_operand = $opName ($x, $y) : ($t, $t) -> ($t) )

set_option hygiene false in
macro res:mlir_op_operand " = " "llvm.mlir.constant" x:num " : " t:mlir_type : mlir_op =>
  `(mlir_op| $res:mlir_op_operand = "llvm.mlir.constant"() {value = $x:num : $t} : () -> ($t) )


def pretty_test :=
  [alive_icom ()|{
  ^bb0(%arg0: i32):
    %0 = llvm.mlir.constant 8 : i32
    %1 = llvm.add %0, %arg0 : i32
    %2 = llvm.mul %1, %arg0 : i32
    %3 = llvm.not %2 : i32
    llvm.return %3 : i32
  }]
