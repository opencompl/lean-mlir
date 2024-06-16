import SSA.Core.MLIRSyntax.PrettyEDSL
import SSA.Projects.InstCombine.Tactic
open Lean

namespace MLIR.EDSL
open Pretty

syntax "llvm.return"  : MLIR.Pretty.uniform_op
syntax "llvm.copy"    : MLIR.Pretty.uniform_op
syntax "llvm.neg"     : MLIR.Pretty.uniform_op
syntax "llvm.not"     : MLIR.Pretty.uniform_op

syntax "llvm.add"     : MLIR.Pretty.uniform_op
syntax "llvm.and"     : MLIR.Pretty.uniform_op
syntax "llvm.ashr"    : MLIR.Pretty.uniform_op
syntax "llvm.lshr"    : MLIR.Pretty.uniform_op
syntax "llvm.mul"     : MLIR.Pretty.uniform_op
syntax "llvm.or"      : MLIR.Pretty.uniform_op
syntax "llvm.sdiv"    : MLIR.Pretty.uniform_op
syntax "llvm.shl"     : MLIR.Pretty.uniform_op
syntax "llvm.srem"    : MLIR.Pretty.uniform_op
syntax "llvm.sub"     : MLIR.Pretty.uniform_op
syntax "llvm.udiv"    : MLIR.Pretty.uniform_op
syntax "llvm.urem"    : MLIR.Pretty.uniform_op
syntax "llvm.xor"     : MLIR.Pretty.uniform_op

declare_syntax_cat InstCombine.cmp_op_name
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

syntax mlir_op_operand " = " InstCombine.cmp_op_name mlir_op_operand ", " mlir_op_operand
        (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $resName:mlir_op_operand = $name:InstCombine.cmp_op_name $x, $y $[: $t]?) => do
    let some opName := extractOpName name.raw
      | Macro.throwUnsupported
    let t ← t.getDM `(mlir_type| _)
    `(mlir_op| $resName:mlir_op_operand = $opName ($x, $y) : ($t, $t) -> (i1) )

open MLIR.AST

syntax mlir_op_operand " = " "llvm.mlir.constant" neg_num (" : " mlir_type)? : mlir_op
syntax mlir_op_operand " = " "llvm.mlir.constant" ("$" noWs "{" term "}") (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant $x $[: $t]?) => do
      let t ← t.getDM `(mlir_type| _)
      `(mlir_op| $res:mlir_op_operand = "llvm.mlir.constant"() {value = $x:neg_num : $t} : () -> ($t) )
  | `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant ${ $x:term } $[: $t]?) => do
      let t ← t.getDM `(mlir_type| _)
      let x ← `(MLIR.AST.AttrValue.int $x [mlir_type| $t])
      `(mlir_op| $res:mlir_op_operand = "llvm.mlir.constant"() {value = $$($x) } : () -> ($t) )

syntax mlir_op_operand " = " "llvm.select" mlir_op_operand ", " mlir_op_operand ", " mlir_op_operand
    (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = llvm.select $c, $x, $y $[: $t]?) => do
    let t ← t.getDM `(mlir_type| _)
    `(mlir_op| $res:mlir_op_operand = "llvm.select" ($c, $x, $y) : (i1, $t, $t) -> ($t))

section Test

private def pretty_test :=
  [llvm ()|{
  ^bb0(%arg0: i32):
    %0 = llvm.mlir.constant 8 : i32
    %1 = llvm.add %0, %arg0 : i32
    %2 = llvm.mul %1, %arg0 : i32
    %3 = llvm.not %2 : i32
    llvm.return %3 : i32
  }]

private def pretty_test_generic (w : Nat) :=
  [llvm (w)|{
  ^bb0(%arg0: _):
    %0 = llvm.mlir.constant 8 : _
    %1 = llvm.add %0, %arg0 : _
    %2 = llvm.mul %1, %arg0 : _
    %3 = llvm.not %2 : _
    llvm.return %3 : _
  }]

private def prettier_test_generic (w : Nat) :=
  [llvm (w)|{
  ^bb0(%arg0: _):
    %0 = llvm.mlir.constant 8
    %1 = llvm.add %0, %arg0
    %2 = llvm.mul %1, %arg0
    %3 = llvm.not %2
    llvm.return %3
  }]

private def neg_constant (w : Nat) :=
  [llvm (w)| {
    %0 = llvm.mlir.constant -1
    llvm.return %0
  }]

private def pretty_select (w : Nat) :=
  [llvm (w)| {
    ^bb0(%arg0: i1, %arg1 : _):
      %0 = llvm.select %arg0, %arg1, %arg1
      llvm.return %0
  }]

-- for some reason 'rfl' does not work by 'by rfl' works
example : pretty_test = prettier_test_generic 32 := by rfl
example : pretty_test_generic = prettier_test_generic    := rfl


/-! ## antiquotations test -/

private def antiquot_test (x) := -- antiquotated constant value in generic syntax
  [llvm| {
    %0 = "llvm.mlir.constant"() { value = $(.int (x : Nat) (.i _ 42)) } : () -> (i42)
    llvm.return %0 : i42
  }]
private def antiquot_test_pretty (x : Nat) := -- antiquotated constant value in pretty syntax
  [llvm| {
    %0 = llvm.mlir.constant ${x} : i42
    llvm.return %0 : i42
  }]
example : antiquot_test = antiquot_test_pretty := rfl

end Test
