import LeanMLIR.MLIRSyntax.PrettyEDSL

import LeanMLIR.Dialects.LLVM.Syntax.Pretty.Overflow
import LeanMLIR.Dialects.LLVM.Syntax.Pretty.Exact
import LeanMLIR.Dialects.LLVM.Syntax.Pretty.NonNeg
import LeanMLIR.Dialects.LLVM.Syntax.Pretty.Disjoint

open Lean

namespace MLIR.EDSL
open Pretty

syntax "llvm.return"  : MLIR.Pretty.uniform_op
syntax "llvm.copy"    : MLIR.Pretty.uniform_op
syntax "llvm.neg"     : MLIR.Pretty.uniform_op
syntax "llvm.not"     : MLIR.Pretty.uniform_op
syntax "llvm.or"      : MLIR.Pretty.uniform_op
syntax "llvm.and"     : MLIR.Pretty.uniform_op
syntax "llvm.srem"    : MLIR.Pretty.uniform_op
syntax "llvm.urem"    : MLIR.Pretty.uniform_op
syntax "llvm.xor"     : MLIR.Pretty.uniform_op

syntax "llvm.add"     : MLIR.Pretty.overflow_op
syntax "llvm.shl"     : MLIR.Pretty.overflow_op
syntax "llvm.mul"     : MLIR.Pretty.overflow_op
syntax "llvm.sub"     : MLIR.Pretty.overflow_op

syntax "llvm.udiv"    : MLIR.Pretty.exact_op
syntax "llvm.sdiv"    : MLIR.Pretty.exact_op
syntax "llvm.lshr"    : MLIR.Pretty.exact_op
syntax "llvm.ashr"    : MLIR.Pretty.exact_op

syntax "llvm.or"      : MLIR.Pretty.disjoint_op

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

declare_syntax_cat InstCombine.int_cast_op
syntax "llvm.trunc" : MLIR.Pretty.overflow_int_cast_op
syntax "llvm.zext" : MLIR.Pretty.nneg_op
syntax "llvm.sext" : InstCombine.int_cast_op

syntax mlir_op_operand " = " InstCombine.int_cast_op mlir_op_operand " : " mlir_type " to " mlir_type : mlir_op
macro_rules
  | `(mlir_op| $resName:mlir_op_operand = $name:InstCombine.int_cast_op $x : $t to $t') => do
    let some opName := extractOpName name.raw
      | Macro.throwUnsupported
    `(mlir_op| $resName:mlir_op_operand = $opName ($x) : ($t) -> $t')

open MLIR.AST
syntax mlir_op_operand " = " "llvm.mlir.constant" "("   neg_num (" : " mlir_type)? ")"
  (" : " mlir_type)? : mlir_op
syntax mlir_op_operand " = " "llvm.mlir.constant" "("  ("$" noWs "{" term "}") ")"
  (" : " mlir_type)?   : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant( $x $[: $inner_type]?)
      $[: $outer_type]? ) => do
      /- We deviate slightly from LLVM by allowing syntax such as `llvm.mlir.constant (10) : i62`.
          Strictly speaking, the spec mandates that the *inner* type annotation may only be left out
          if the type is `i64` or `f64`.
          Since the type in this case is unambiguous, there is no harm in allowing this for other
          widths as well.
        If no annotation is given at all, then the width is assumed to be `_`,
        a symbolic/metavariable width
      -/
      let outer_type ← outer_type.getDM `(mlir_type| _)
      let inner_type := inner_type.getD outer_type
      `(mlir_op| $res:mlir_op_operand = "llvm.mlir.constant"()
          {value = $x:neg_num : $inner_type} : () -> ($outer_type) )
  | `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant( ${ $x:term }) $[: $t]?) => do
      let t ← t.getDM `(mlir_type| _)
      let x ← `(MLIR.AST.AttrValue.int $x [mlir_type| $t])
      `(mlir_op| $res:mlir_op_operand = "llvm.mlir.constant"() {value = $$($x) } : () -> ($t) )

syntax mlir_op_operand " = " "llvm.mlir.constant" "(true)" (" : " mlir_type)? : mlir_op
syntax mlir_op_operand " = " "llvm.mlir.constant" "(false)" (" : " mlir_type)? : mlir_op
syntax mlir_op_operand " = " "llvm.mlir.constant" neg_num (" : " mlir_type)? : mlir_op
syntax mlir_op_operand " = " "llvm.mlir.constant" ("$" noWs "{" term "}")
  (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant (true) $[: $t]?) =>
      `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant (1 : i1) : i1)
  | `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant (false) $[: $t]?) =>
      `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant (0 : i1) : i1)
  | `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant $x $[: $t]?) =>
      `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant($x $[: $t]?) $[: $t]?)
  | `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant ${ $x:term } $[: $t]?) =>
      `(mlir_op| $res:mlir_op_operand = llvm.mlir.constant($$($x) $[: $t]?) $[: $t]?)


syntax mlir_op_operand " = " "llvm.icmp" str mlir_op_operand ", " mlir_op_operand (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = llvm.icmp $p $x, $y $[: $t]?) => do
    let t ← t.getDM `(mlir_type| _)
    match p.getString with
      | "eq" => `(mlir_op| $res:mlir_op_operand = "llvm.icmp.eq" ($x, $y) : ($t, $t) -> (i1))
      | "ne" => `(mlir_op| $res:mlir_op_operand = "llvm.icmp.ne" ($x, $y) : ($t, $t) -> (i1))
      | "slt" => `(mlir_op| $res:mlir_op_operand = "llvm.icmp.slt" ($x, $y) : ($t, $t) -> (i1))
      | "sle" => `(mlir_op| $res:mlir_op_operand = "llvm.icmp.sle" ($x, $y) : ($t, $t) -> (i1))
      | "sgt" => `(mlir_op| $res:mlir_op_operand = "llvm.icmp.sgt" ($x, $y) : ($t, $t) -> (i1))
      | "sge" => `(mlir_op| $res:mlir_op_operand = "llvm.icmp.sge" ($x, $y) : ($t, $t) -> (i1))
      | "ult" => `(mlir_op| $res:mlir_op_operand = "llvm.icmp.ult" ($x, $y) : ($t, $t) -> (i1))
      | "ule" => `(mlir_op| $res:mlir_op_operand = "llvm.icmp.ule" ($x, $y) : ($t, $t) -> (i1))
      | "ugt" => `(mlir_op| $res:mlir_op_operand = "llvm.icmp.ugt" ($x, $y) : ($t, $t) -> (i1))
      | "uge" => `(mlir_op| $res:mlir_op_operand = "llvm.icmp.uge" ($x, $y) : ($t, $t) -> (i1))
      | _ => Macro.throwErrorAt p s!"unexpected predicate {p.getString}"

syntax mlir_op_operand " = " "llvm.select" mlir_op_operand ", " mlir_op_operand ", " mlir_op_operand
    (" : " mlir_type)? : mlir_op
macro_rules
  | `(mlir_op| $res:mlir_op_operand = llvm.select $c, $x, $y $[: $t]?) => do
    let t ← t.getDM `(mlir_type| _)
    `(mlir_op| $res:mlir_op_operand = "llvm.select" ($c, $x, $y) : (i1, $t, $t) -> ($t))

end EDSL

end MLIR
