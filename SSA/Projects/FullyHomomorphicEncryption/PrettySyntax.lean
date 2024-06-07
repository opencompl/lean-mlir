import SSA.Core.MLIRSyntax.PrettyEDSL
import SSA.Projects.FullyHomomorphicEncryption.Syntax

namespace MLIR.EDSL.Pretty
open Lean Parser

syntax "poly.add" : MLIR.Pretty.uniform_op
syntax "return" : MLIR.Pretty.uniform_op

syntax mlir_op_operand " = " "arith.const" (atomic("$(" term ")") <|> neg_num) " : " mlir_type : mlir_op

syntax mlir_op_operand " = " "poly.monomial" mlir_op_operand,*
  " : " "("mlir_type,*")" " -> " mlir_type : mlir_op
-- macro_rules


section Test

private def fhe_test_one {q n} := [fhe_com q, n, _| {
  ^bb0(%a : R):
    %one_idx = arith.const 1 : index
    %zero_idx = arith.const 0 : index
    -- %two_to_the_n = arith.const $(2**n : Nat) : index
    %two_to_the_n = arith.const 64 : index -- using a constant value, since antiquotations are broken
    %x2n = poly.monomial %one_idx, %two_to_the_n : (index, index) -> R
    %one_r = poly.monomial %one_idx, %zero_idx : (index, index) -> R
    %p = poly.add %x2n, %one_r : R
    %v1 = poly.add %a, %p : R
    return %v1
  }]

private def fhe_test_one {q n} := [fhe_com q, n, _| {
  ^bb0(%a : R):
    return %a
  }]

end Test
