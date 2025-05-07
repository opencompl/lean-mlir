import SSA.Core.MLIRSyntax.PrettyEDSL
import SSA.Projects.RISCV64.Base
import SSA.Projects.RISCV64.Syntax
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.ForLean
/-!
This file defines a pretty printing/syntax for the `RISCV64` dialect.
This allows the dialect to be written in MLIR-style syntax as well as
assembly-like style.

[RV64_com| {
  ^bb0(%r1 : !i64, %r2 : !i64 ):
  %1 =  const (0) : !i64
  %2 =  sub %r1,  %1 : !i64
        ret %2 : !i64

We use the functionalities defined in `SSA.Core.MLIRSyntax.PrettyEDSL`.
For operands with immediates or shift amounts encoded as part of the opcode,
we define additional rules.
 -/

open MLIR.AST
open Lean

syntax "add" : MLIR.Pretty.uniform_op
syntax "sub" : MLIR.Pretty.uniform_op
syntax "and" : MLIR.Pretty.uniform_op
syntax "or" : MLIR.Pretty.uniform_op
syntax "xor" : MLIR.Pretty.uniform_op
syntax "sll" : MLIR.Pretty.uniform_op
syntax "sra" : MLIR.Pretty.uniform_op
syntax "mul" : MLIR.Pretty.uniform_op
syntax "div" : MLIR.Pretty.uniform_op
syntax "divu" : MLIR.Pretty.uniform_op
syntax "remu" : MLIR.Pretty.uniform_op
syntax "rem" : MLIR.Pretty.uniform_op
syntax "li" : MLIR.Pretty.uniform_op
syntax "ret" : MLIR.Pretty.uniform_op
syntax "sext.b" : MLIR.Pretty.uniform_op
syntax "sext.h" : MLIR.Pretty.uniform_op
syntax "zext.h" : MLIR.Pretty.uniform_op
syntax "ror" : MLIR.Pretty.uniform_op
syntax "rol" : MLIR.Pretty.uniform_op
syntax "addw" : MLIR.Pretty.uniform_op
syntax "subw" : MLIR.Pretty.uniform_op
syntax "sllw" : MLIR.Pretty.uniform_op
syntax "srlw" : MLIR.Pretty.uniform_op
syntax "sraw" : MLIR.Pretty.uniform_op
syntax "srl" : MLIR.Pretty.uniform_op
syntax "slt" : MLIR.Pretty.uniform_op
syntax "sltu" : MLIR.Pretty.uniform_op
syntax "czero.eqz" : MLIR.Pretty.uniform_op
syntax "czero.nez" : MLIR.Pretty.uniform_op
syntax "bclr" : MLIR.Pretty.uniform_op
syntax "bext" : MLIR.Pretty.uniform_op
syntax "binv" : MLIR.Pretty.uniform_op
syntax "bset" : MLIR.Pretty.uniform_op
syntax "rolw" : MLIR.Pretty.uniform_op
syntax "rorw" : MLIR.Pretty.uniform_op
syntax "mulu" : MLIR.Pretty.uniform_op
syntax "mulh" : MLIR.Pretty.uniform_op
syntax "mulhu" : MLIR.Pretty.uniform_op
syntax "mulhsu" : MLIR.Pretty.uniform_op
syntax "mulw" : MLIR.Pretty.uniform_op
syntax "divw" : MLIR.Pretty.uniform_op
syntax "divwu" : MLIR.Pretty.uniform_op
syntax "remw" : MLIR.Pretty.uniform_op
syntax "remwu" : MLIR.Pretty.uniform_op
syntax "add.uw" : MLIR.Pretty.uniform_op
syntax "sh1add.uw" : MLIR.Pretty.uniform_op
syntax "sh2add.uw" : MLIR.Pretty.uniform_op
syntax "sh3add.uw" : MLIR.Pretty.uniform_op
syntax "sh1add" : MLIR.Pretty.uniform_op
syntax "sh2add" :  MLIR.Pretty.uniform_op
syntax "sh3add" :  MLIR.Pretty.uniform_op

private def test_simple := [RV64_com| {
  ^bb0(%e1 : !i64, %e2 : !i64 ):
  %1 =  add %e1, %e2 : !i64
        ret %1 : !i64
}]
private def test_simple2 := [RV64_com| {
  ^bb0(%e1 : !i64, %e2 : !i64 ):
  %1 =  add %e1, %e2 : !i64
  %2 =  sub %1, %1 : !i64
        ret %2  : !i64
}]
#check test_simple

/-
Bellow we implement the case, where an operation has `one` attirbute value.
e.g constant or single register operations.
WIP: extend pretty print for negative numerals/immediates. Somehow always threw an error, but is wip.
-/

syntax mlir_op_operand " = " "const" "(" num (" : " mlir_type )? ")"
  (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = const ($x)
      $[: $outer_type]? ) => do
      let outer_type ← outer_type.getDM `(mlir_type| _)
      `(mlir_op| $res:mlir_op_operand = "const"()
          {val = $x:num :  $outer_type} : ( $outer_type) -> ( $outer_type) )

syntax mlir_op_operand " = " "li" "(" num (" : " mlir_type)? ")" (" : " mlir_type)?
  : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = li ($x)
     $[: $outer_type]?  ) => do
      let outer_type ← outer_type.getDM `(mlir_type| _ )
      `(mlir_op| $res:mlir_op_operand = "li"()
          {imm = $x:num : $outer_type } : ($outer_type) -> ($outer_type))

declare_syntax_cat MLIR.One.Attr.One.Arg.Imm.op
syntax "bclri" : MLIR.One.Attr.One.Arg.Imm.op
syntax "bexti" : MLIR.One.Attr.One.Arg.Imm.op
syntax "bseti" : MLIR.One.Attr.One.Arg.Imm.op
syntax "binvi" : MLIR.One.Attr.One.Arg.Imm.op
syntax "addiw" : MLIR.One.Attr.One.Arg.Imm.op
syntax "lui" : MLIR.One.Attr.One.Arg.Imm.op
syntax "auipc": MLIR.One.Attr.One.Arg.Imm.op
syntax "addi" : MLIR.One.Attr.One.Arg.Imm.op
syntax "slti" : MLIR.One.Attr.One.Arg.Imm.op
syntax "sltiu" : MLIR.One.Attr.One.Arg.Imm.op
syntax "andi": MLIR.One.Attr.One.Arg.Imm.op
syntax "ori" : MLIR.One.Attr.One.Arg.Imm.op
syntax "xori" : MLIR.One.Attr.One.Arg.Imm.op

syntax mlir_op_operand  " = " MLIR.One.Attr.One.Arg.Imm.op mlir_op_operand "," num (":" mlir_type)? : mlir_op
macro_rules
| `(mlir_op| $res:mlir_op_operand = $op1:MLIR.One.Attr.One.Arg.Imm.op $reg1 , $x : $t)  => do
    let some opName := MLIR.EDSL.Pretty.extractOpName op1.raw
      | Macro.throwUnsupported
    `(mlir_op| $res:mlir_op_operand = $opName ($reg1) {imm = $x:num : $t }  : ($t) -> ($t) )

declare_syntax_cat MLIR.One.Attr.One.Arg.Shamt.op
syntax "slli" : MLIR.One.Attr.One.Arg.Shamt.op
syntax "srai" : MLIR.One.Attr.One.Arg.Shamt.op
syntax "slliw" : MLIR.One.Attr.One.Arg.Shamt.op
syntax "srliw" : MLIR.One.Attr.One.Arg.Shamt.op
syntax "sraiw" : MLIR.One.Attr.One.Arg.Shamt.op
syntax "srli" : MLIR.One.Attr.One.Arg.Shamt.op

syntax mlir_op_operand  " = " MLIR.One.Attr.One.Arg.Shamt.op mlir_op_operand "," num (":" mlir_type)? : mlir_op
macro_rules
| `(mlir_op| $res:mlir_op_operand = $op1:MLIR.One.Attr.One.Arg.Shamt.op $reg1 , $x  : $t )  => do
    let some opName := MLIR.EDSL.Pretty.extractOpName op1.raw
      | Macro.throwUnsupported
    `(mlir_op| $res:mlir_op_operand = $opName ($reg1) {shamt= $x:num : $t}  : ($t) -> ($t) )


/-! # Testing -/
private def test_andi := [RV64_com| {
  ^bb0(%e1 : !i64, %e2 : !i64 ):
  %1 =  andi %e1, 42 : !i64
        ret %1 : !i64
}]

private def test_slli := [RV64_com| {
  ^bb0(%e1 : !i64, %e2 : !i64 ):
  %1 =  slli %e1, 42 : !i64
        ret %1 : !i64
}]

private def test_li := [RV64_com| {
  ^bb0(%e1 : !i64):
  %1 =  li (42) : !i64
  %2 =  li (42) : !i64
  ret %1 : !i64
}]

private def big_test := [RV64_com| {
  ^bb0(%r1 : !i64, %r2 : !i64 ):
  %1 = andi %r1, 42 : !i64
  %2 = sub %r1,  %1 : !i64
  %3 = andi %2, 10 : !i64
  %4 = div %r2, %r1 : !i64
  %5 = add %4, %1 : !i64
  %7 = li (2) : !i64
  %6 = ror %5, %7 : !i64
  ret %6 : !i64
}]
#eval big_test
