import LeanMLIR.Dialects.LLVM

namespace LeanMLIR.Tests

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
  rfl

example : pretty_test_generic = prettier_test_generic    := rfl

/-! ## antiquotations test -/

/-
TODO: Constant value antiquotations don't work with the new elaborator.
            To properly support these test-cases, we should include constant values
            into the existing deeply-embedded metavariable instantiation

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

-/

end Tests
