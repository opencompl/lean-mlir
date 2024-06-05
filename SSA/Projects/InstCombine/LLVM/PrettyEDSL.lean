import SSA.Core.MLIRSyntax.GenericParser
import SSA.Projects.InstCombine.Tactic
open Lean

namespace MLIR.EDSL

declare_syntax_cat InstCombine.un_op_name
declare_syntax_cat InstCombine.bin_op_name
declare_syntax_cat InstCombine.cmp_op_name

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

syntax "llvm.icmp.eq"  : InstCombine.cmp_op_name
syntax "llvm.icmp.ne"  : InstCombine.cmp_op_name
syntax "llvm.icmp.slt" : InstCombine.cmp_op_name
syntax "llvm.icmp.sle" : InstCombine.cmp_op_name
syntax "llvm.icmp.sgt" : InstCombine.cmp_op_name
syntax "llvm.icmp.sge" : InstCombine.cmp_op_name
syntax "llvm.icmp.ult" : InstCombine.cmp_op_name
syntax "llvm.icmp.ule" : InstCombine.cmp_op_name
syntax "llvm.icmp.ugt" : InstCombine.cmp_op_name
syntax "llvm.icmp.uge" : InstCombine.cmp_op_name

/-- /-- Given syntax of category `un_op_name`, `bin_op_name`, or `cmp_op_name`,
extract the name of the operation and return it as a string literal syntax. -/
def extractOpName : Syntax → Option (TSyntax `str)
  | .node _ _ ⟨.atom _ name :: _⟩ => some <| Syntax.mkStrLit name
  | _ => none

syntax (mlir_op_operand " = ")? InstCombine.un_op_name mlir_op_operand (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $[$resName =]? $name:InstCombine.un_op_name $x $[: $t]? ) => do
    let some opName := extractOpName name.raw
      | Macro.throwUnsupported
    let t ← t.getDM `(mlir_type| _)
    let retTy : TSyntaxArray `mlir_type := match resName with
      | some _ => #[t]
      | none => #[]
    `([mlir_op| $[$resName =]? $opName ($x) : ($t) -> ($retTy:mlir_type,*) ])

syntax mlir_op_operand " = " InstCombine.bin_op_name mlir_op_operand ", " mlir_op_operand
        (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $resName:mlir_op_operand = $name:InstCombine.bin_op_name $x, $y $[: $t]?) => do
    let some opName := extractOpName name.raw
      | Macro.throwUnsupported
    let t ← t.getDM `(mlir_type| _)
    `(mlir_op| $resName:mlir_op_operand = $opName ($x, $y) : ($t, $t) -> ($t) )

syntax mlir_op_operand " = " InstCombine.cmp_op_name mlir_op_operand ", " mlir_op_operand
        (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $resName:mlir_op_operand = $name:InstCombine.cmp_op_name $x, $y $[: $t]?) => do
    let some opName := extractOpName name.raw
      | Macro.throwUnsupported
    let t ← t.getDM `(mlir_type| _)
    `(mlir_op| $resName:mlir_op_operand = $opName ($x, $y) : ($t, $t) -> (i1) )

syntax mlir_op_operand " = " "llvm.mlir.constant" neg_num (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant $x $[: $t]?) => do
    let t ← t.getDM `(mlir_type| _)
    `(mlir_op| $res:mlir_op_operand = "llvm.mlir.constant"() {value = $x:neg_num : $t} : () -> ($t) )

syntax mlir_op_operand " = " "llvm.select" mlir_op_operand ", " mlir_op_operand ", " mlir_op_operand
    (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = llvm.select $c, $x, $y $[: $t]?) => do
    let t ← t.getDM `(mlir_type| _)
    `(mlir_op| $res:mlir_op_operand = "llvm.select" ($c, $x, $y) : (i1, $t, $t) -> ($t))

section Test

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

private def prettier_test_generic (w : Nat) :=
  [alive_icom (w)|{
  ^bb0(%arg0: _):
    %0 = llvm.mlir.constant 8
    %1 = llvm.add %0, %arg0
    %2 = llvm.mul %1, %arg0
    %3 = llvm.not %2
    llvm.return %3
  }]

private def neg_constant (w : Nat) :=
  [alive_icom (w)| {
    %0 = llvm.mlir.constant -1
    llvm.return %0
  }]

private def pretty_select (w : Nat) :=
  [alive_icom (w)| {
    ^bb0(%arg0: i1, %arg1 : _):
      %0 = llvm.select %arg0, %arg1, %arg1
      llvm.return %0
  }]

example : pretty_test         = prettier_test_generic 32 := rfl
example : pretty_test_generic = prettier_test_generic    := rfl

end Test
