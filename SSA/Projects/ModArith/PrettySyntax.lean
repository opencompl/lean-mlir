/-
Released under Apache 2.0 license as described in the file LICENSE.

This file defines a "pretty syntax" for the `ModArith` dialect, analogous to
`FullyHomomorphicEncryption/PrettySyntax.lean`.

It provides macros to parse lines of the form:
  %v = mod_arith.constant 12 : !Zp
  %w = mod_arith.add %x, %y : !Zp
etc., into the uniform EDSL used by the MLIR translation in Lean.

Authors: Jaeho Choi <zerozerozero0216@gmail.com>
-/
import SSA.Core.MLIRSyntax.PrettyEDSL
import SSA.Projects.ModArith.Syntax

namespace MLIR.EDSL.Pretty
open Lean

/--
We declare `mod_arith.constant`, `mod_arith.add`, `mod_arith.sub`, etc.
as uniform ops. This means we can write lines like:

  %x = mod_arith.add %a, %b : (!Zp, !Zp) -> !Zp

and the `PrettyEDSL` machinery will parse them automatically.
-/
syntax "mod_arith.constant" : MLIR.Pretty.uniform_op
syntax "mod_arith.add" : MLIR.Pretty.uniform_op
syntax "mod_arith.sub" : MLIR.Pretty.uniform_op
syntax "mod_arith.mul" : MLIR.Pretty.uniform_op
syntax "return" : MLIR.Pretty.uniform_op

/--
We handle two forms:

  1) `%v = mod_arith.constant 42 : !Zp`
     which gets parsed as an integer attribute with value 42

  2) `%v = mod_arith.constant -10 : !Zp`
     for negative numbers

For each, we produce a uniform op in the underlying IR:

  `%v = "mod_arith.constant" () {value = 42} : () -> (!Zp)`
-/
syntax mlir_op_operand " = " "mod_arith.constant" "$" noWs "{" term "}" " : " mlir_type : mlir_op
syntax mlir_op_operand " = " "mod_arith.constant" neg_num " : " mlir_type : mlir_op

macro_rules
  -- Case (2): negative integer literal
  | `(mlir_op| $v:mlir_op_operand = mod_arith.constant $x:neg_num : $t) =>
    `(mlir_op| $v:mlir_op_operand = "mod_arith.constant" () {value = $x:neg_num} : () -> ($t))

  -- Case (1): arbitrary integer expression in braces
  | `(mlir_op| $v:mlir_op_operand = mod_arith.constant ${ $x:term } : $t) => do
      let ctor := mkIdent ``MLIR.AST.AttrValue.int
      let x ← `($ctor $x [mlir_type| i64])
      `(mlir_op| $v:mlir_op_operand = "mod_arith.constant" () {value = $$($x)} : () -> ($t))

section Test
variable {q : Nat} [h : Fact (q > 1)]
/--
A small test snippet. If you do:

  #check test_one_lhs

It shows how Lean parses:

  %e1 = mod_arith.constant 12 : !R
  %e2 = mod_arith.constant -5 : !R
  %add = mod_arith.add %e1, %e2 : !R
  return %add : !R
-/
private def test_lhs := [mod_arith q, h | {
  ^bb0(%a : !R):
    %e1 = mod_arith.constant 12 : !R
    %e2 = mod_arith.constant -5 : !R
    %add = mod_arith.add %e1, %e2 : !R
    return %a : !R
}]

/--
info: '_private.SSA.Projects.ModArith.PrettySyntax.0.MLIR.EDSL.Pretty.test_lhs' depends on axioms: [propext, Quot.sound]
-/
#guard_msgs in #print axioms test_lhs

end Test

end Pretty

end EDSL

end MLIR
