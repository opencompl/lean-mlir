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
    ^bb0 (%r1 : !i64, %r2 : !i64 ):
    %1 = const (0) : !i64
    %2 = sub %r1, %1 : !i64
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
syntax "max" : MLIR.Pretty.uniform_op
syntax "min" : MLIR.Pretty.uniform_op
syntax "minu" : MLIR.Pretty.uniform_op
syntax "maxu" : MLIR.Pretty.uniform_op

private def test_simple := [RV64_com| {
  ^bb0(%e1 : !i64, %e2 : !i64 ):
  %1 = add %e1, %e2 : !i64
       ret %1 : !i64
}]
private def test_simple2 := [RV64_com| {
  ^bb0(%e1 : !i64, %e2 : !i64 ):
  %1 = add %e1, %e2 : !i64
  %2 = sub %1, %1 : !i64
       ret %2  : !i64
}]

/-
Bellow we implement the case, where an operation has
one attribute value.
e.g constant or single register operations.
WIP: extend pretty print for negative
numerals/immediates. Somehow they always
throw an error, but is wip.
-/

syntax mlir_op_operand " = " "const" "(" num (" : " mlir_type )? ")"
  (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = const ($x)
      $[: $outer_type]? ) => do
      let outer_type ← outer_type.getDM `(mlir_type| _)
      `(mlir_op| $res:mlir_op_operand = "const"()
          {val = $x:num : $outer_type} : ($outer_type) -> ($outer_type) )

syntax mlir_op_operand " = " "li" "(" num (" : " mlir_type)? ")" (" : " mlir_type)?
  : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = li ($x)
     $[: $outer_type]?  ) => do
      let outer_type ← outer_type.getDM `(mlir_type| _ )
      `(mlir_op| $res:mlir_op_operand = "li"()
          {imm = $x:num : $outer_type } : ($outer_type) -> ($outer_type))

declare_syntax_cat MLIR.Pretty.RV.opWithImmediate
syntax "bclri" : MLIR.Pretty.RV.opWithImmediate
syntax "bexti" : MLIR.Pretty.RV.opWithImmediate
syntax "bseti" : MLIR.Pretty.RV.opWithImmediate
syntax "binvi" : MLIR.Pretty.RV.opWithImmediate
syntax "addiw" : MLIR.Pretty.RV.opWithImmediate
syntax "lui" : MLIR.Pretty.RV.opWithImmediate
syntax "auipc": MLIR.Pretty.RV.opWithImmediate
syntax "addi" : MLIR.Pretty.RV.opWithImmediate
syntax "slti" : MLIR.Pretty.RV.opWithImmediate
syntax "sltiu" : MLIR.Pretty.RV.opWithImmediate
syntax "andi": MLIR.Pretty.RV.opWithImmediate
syntax "ori" : MLIR.Pretty.RV.opWithImmediate
syntax "xori" : MLIR.Pretty.RV.opWithImmediate

syntax mlir_op_operand  " = " MLIR.Pretty.RV.opWithImmediate mlir_op_operand "," num (":" mlir_type)? : mlir_op
macro_rules
| `(mlir_op| $res:mlir_op_operand = $op1:MLIR.Pretty.RV.opWithImmediate $reg1 , $x : $t)  => do
    let some opName := MLIR.EDSL.Pretty.extractOpName op1.raw
      | Macro.throwUnsupported
    `(mlir_op| $res:mlir_op_operand = $opName ($reg1) {imm = $x:num : $t} : ($t) -> ($t) )

declare_syntax_cat MLIR.Pretty.RV.opWithShamt
syntax "slli" : MLIR.Pretty.RV.opWithShamt
syntax "srai" : MLIR.Pretty.RV.opWithShamt
syntax "slliw" : MLIR.Pretty.RV.opWithShamt
syntax "srliw" : MLIR.Pretty.RV.opWithShamt
syntax "sraiw" : MLIR.Pretty.RV.opWithShamt
syntax "srli" : MLIR.Pretty.RV.opWithShamt

syntax mlir_op_operand " = " MLIR.Pretty.RV.opWithShamt mlir_op_operand "," num (":" mlir_type)? : mlir_op
macro_rules
| `(mlir_op| $res:mlir_op_operand = $op1:MLIR.Pretty.RV.opWithShamt $reg1 , $x  : $t )  => do
    let some opName := MLIR.EDSL.Pretty.extractOpName op1.raw
      | Macro.throwUnsupported
    `(mlir_op| $res:mlir_op_operand = $opName ($reg1) {shamt = $x:num : $t}  : ($t) -> ($t) )

/-! # Testing -/
private def test_andi := [RV64_com| {
  ^bb0(%e1 : !i64, %e2 : !i64 ):
  %1 = andi %e1, 42 : !i64
       ret %1 : !i64
}]

private def test_slli := [RV64_com| {
 ^bb0(%e1 : !i64, %e2 : !i64 ):
 %1 = slli %e1, 42 : !i64
 ret %1 : !i64
}]

private def test_li := [RV64_com| {
 ^bb0(%e1 : !i64):
 %1 = li (42) : !i64
 %2 = li (42) : !i64
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
