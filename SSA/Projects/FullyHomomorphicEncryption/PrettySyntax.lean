import SSA.Core.MLIRSyntax.PrettyEDSL
import SSA.Projects.FullyHomomorphicEncryption.Syntax

import Mathlib.Init.Data.Nat.Lemmas

namespace MLIR.EDSL.Pretty
open Lean

syntax "poly.add" : MLIR.Pretty.uniform_op
syntax "return" : MLIR.Pretty.uniform_op

syntax mlir_op_operand " = " "arith.const" "$" noWs "{" term "}" " : " mlir_type : mlir_op
syntax mlir_op_operand " = " "arith.const" neg_num " : " mlir_type : mlir_op
macro_rules
  | `(mlir_op| $v:mlir_op_operand = arith.const $x:neg_num : $t) =>
      `(mlir_op| $v:mlir_op_operand = "arith.const" () {value = $x:neg_num } : () -> ($t))
  | `(mlir_op| $v:mlir_op_operand = arith.const ${ $x:term } : $t) => do
      let ctor := mkIdent ``MLIR.AST.AttrValue.int
      let x ← `($ctor $x [mlir_type| i64])
      --                         ^^^^^^^^^^^^^^^^ Is this right? It seems we just ignore the
      --                                          type annotation
      `(mlir_op| $v:mlir_op_operand = "arith.const" () {value = $$($x) } : () -> ($t))

syntax mlir_op_operand " = " "poly.monomial" mlir_op_operand,*
  " : " "("mlir_type,*")" " -> " mlir_type : mlir_op
macro_rules
  | `(mlir_op| $v:mlir_op_operand = poly.monomial $xs,* : ($ts,*) -> $t) =>
      `(mlir_op| $v:mlir_op_operand = "poly.monomial" ($xs,*) : ($ts,*) -> $t)


section Test
variable {q n} [h : Fact (q > 1)]

private def fhe_test_one_lhs := [fhe_com q, n, h | {
  ^bb0(%a : ! R):
  --        ^^^ TODO: should `: R` also work here?
    %one_int = arith.const 1 : i16
    %zero_idx = arith.const 0 : index
    %two_to_the_n = arith.const ${2 ^ n} : index
    %x2n = poly.monomial %one_int, %two_to_the_n : (i16, index) -> ! R
    %one_r = poly.monomial %one_int, %zero_idx : (i16, index) -> ! R
    %p = poly.add %x2n, %one_r : ! R
    --                           ^^^ TODO: have `: R` also just work
    %v1 = poly.add %a, %p : ! R
    return %v1 : ! R
  }]

private def fhe_test_one_rhs := [fhe_com q, n, h | {
  ^bb0(%a : !R):
    return %a : !R
  }]

end Test
