import SSA.Core.MLIRSyntax.GenericParser
import SSA.Projects.InstCombine.Tactic
open Lean

declare_syntax_cat InstCombine.un_op_name
declare_syntax_cat InstCombine.bin_op_name

syntax "llvm.return"  : InstCombine.un_op_name
syntax "llvm.copy"    : InstCombine.un_op_name
syntax "llvm.neg"     : InstCombine.un_op_name
syntax "llvm.not"     : InstCombine.un_op_name

syntax "llvm.add"     : InstCombine.bin_op_name
syntax "llvm.and"     : InstCombine.bin_op_name
syntax "llvm.ashr"    : InstCombine.bin_op_name
syntax "llvm.lshr"    : InstCombine.bin_op_name
syntax "llvm.mul"     : InstCombine.bin_op_name
syntax "llvm.or"      : InstCombine.bin_op_name
syntax "llvm.sdiv"    : InstCombine.bin_op_name
syntax "llvm.shl"     : InstCombine.bin_op_name
syntax "llvm.srem"    : InstCombine.bin_op_name
syntax "llvm.sub"     : InstCombine.bin_op_name
syntax "llvm.udiv"    : InstCombine.bin_op_name
syntax "llvm.urem"    : InstCombine.bin_op_name
syntax "llvm.xor"     : InstCombine.bin_op_name

-- TODO: does `icmp` need its own case?
-- TODO: does `select` need its own case?


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

macro res:mlir_op_operand " = " "llvm.mlir.constant" x:num " : " t:mlir_type : mlir_op =>
  `(mlir_op| $res:mlir_op_operand = "llvm.mlir.constant"() {value = $x:num : $t} : () -> ($t) )



private def pretty_test :=
  [alive_icom ()|{
  ^bb0(%arg0: i32):
    %0 = llvm.mlir.constant 8 : i32
    %1 = llvm.add %0, %arg0 : i32
    %2 = llvm.mul %1, %arg0 : i32
    %3 = llvm.not %2 : i32
    llvm.return %3 : i32
  }]

private def pretty_test_generic (w : Nat) :=
  [alive_icom (w)|{
  ^bb0(%arg0: _):
    %0 = llvm.mlir.constant 8 : _
    %1 = llvm.add %0, %arg0 : _
    %2 = llvm.mul %1, %arg0 : _
    %3 = llvm.not %2 : _
    llvm.return %3 : _
  }]
