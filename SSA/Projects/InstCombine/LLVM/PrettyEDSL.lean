import SSA.Core.MLIRSyntax.PrettyEDSL
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.LLVM.PrettyEDSLOverflow
import SSA.Projects.InstCombine.LLVM.PrettyEDSLExact
import SSA.Projects.InstCombine.LLVM.PrettyEDSLNonNeg
import SSA.Projects.InstCombine.LLVM.PrettyEDSLDisjoint
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

section Test

private def pretty_test :=
  [llvm()|{
  ^bb0(%arg0: i32):
    %0 = llvm.mlir.constant 8 : i32
    %1 = llvm.add %0, %arg0 : i32
    %2 = llvm.mul %1, %arg0 : i32
    %3 = llvm.not %2 : i32
    llvm.return %3 : i32
  }]

private def pretty_test_generic (w : Nat) :=
  [llvm(w)|{
  ^bb0(%arg0: _):
    %0 = llvm.mlir.constant 8 : _
    %1 = llvm.add %0, %arg0 : _
    %2 = llvm.mul %1, %arg0 : _
    %3 = llvm.not %2 : _
    llvm.return %3 : _
  }]

private def prettier_test_generic (w : Nat) :=
  [llvm(w)|{
  ^bb0(%arg0: _):
    %0 = llvm.mlir.constant(8)
    %1 = llvm.add %0, %arg0
    %2 = llvm.mul %1, %arg0
    %3 = llvm.not %2
    llvm.return %3
  }]

private def neg_constant (w : Nat) :=
  [llvm(w)| {
    %0 = llvm.mlir.constant(-1)
    llvm.return %0
  }]

private def pretty_select (w : Nat) :=
  [llvm(w)| {
    ^bb0(%arg0: i1, %arg1 : _):
      %0 = llvm.select %arg0, %arg1, %arg1
      llvm.return %0
  }]

private def pretty_bool :=
  [llvm()| {
    ^bb0():
      %0 = llvm.mlir.constant (1 : i1) : i1
      %1 = llvm.mlir.constant (0 : i1) : i1
      %2 = llvm.mlir.constant (true)
      %3 = llvm.mlir.constant (false)
      %4 = llvm.mlir.constant (true) : i1
      %5 = llvm.mlir.constant (false) : i1
      %10 = llvm.add %0, %1 : i1
      %11 = llvm.add %2, %3 : i1
      %12 = llvm.add %4, %5 : i1
      llvm.return %2 : i1
  }]

private def pretty_test_overflow :=
  [llvm()|{
  ^bb0(%arg0: i32):
    %0 = llvm.mlir.constant 8 : i32
    %1 = llvm.add %0, %arg0 overflow<nsw> : i32
    %2 = llvm.mul %1, %arg0 : i32
    %3 = llvm.not %2 : i32
    llvm.return %3 : i32
  }]

private def pretty_test_trunc :=
  [llvm()|{
  ^bb0(%arg0: i64):
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    llvm.return %1 : i64
  }]

private def pretty_test_icmp :=
  [llvm()|{
  ^bb0(%arg0: i1):
    %1 = llvm.icmp "eq" %arg0, %arg0 : i1
    llvm.return %1 : i1
  }]

private def pretty_test_zext :=
  [llvm()|{
  ^bb0(%arg0: i32):
    %1 = llvm.zext nneg %arg0 : i32 to i64
    llvm.return %1 : i64
  }]

private def pretty_test_disjoint :=
  [llvm()|{
  ^bb0(%arg0: i32, %arg1: i32):
    %1 = llvm.or disjoint %arg0, %arg1 : i32
    llvm.return %1 : i32
  }]

private def pretty_test_exact :=
  [llvm()|{
  ^bb0(%arg0: i64):
    %0 = llvm.udiv exact %arg0, %arg0 : i64
    %1 = llvm.sdiv exact %arg0, %arg0 : i64
    %2 = llvm.lshr exact %arg0, %arg0 : i64
    %3 = llvm.ashr exact %arg0, %arg0 : i64
    llvm.return %0 : i64
  }]

example : pretty_test = prettier_test_generic 32 := by
  unfold pretty_test prettier_test_generic
  simp_alive_meta
  rfl

example : pretty_test_generic = prettier_test_generic    := rfl

/-! ## antiquotations test -/

private def antiquot_test (x) := -- antiquotated constant value in generic syntax
  [llvm| {
    %0 = "llvm.mlir.constant"() { value = $(.int (x : Nat) (.i _ 42)) } : () -> (i42)
    llvm.return %0 : i42
  }]
private def antiquot_test_pretty (x : Nat) := -- antiquotated constant value in pretty syntax
  [llvm| {
    %0 = llvm.mlir.constant(${x}) : i42
    llvm.return %0 : i42
  }]
example : antiquot_test = antiquot_test_pretty := rfl

end Test

end EDSL

end MLIR
