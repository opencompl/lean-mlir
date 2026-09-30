import LeanMLIR.Dialects.LLVM.Syntax

namespace LeanMLIR.Tests

open InstCombine
open LLVM.Ty (bitvec)

/-- Assert that the elaborator respects variable ordering correctly -/
private def variable_order1 : Com LLVM ⟨[bitvec 2, bitvec 1]⟩ .pure [bitvec 1] := [llvm()| {
    ^bb0(%arg1: i1, %arg2 : i2):
      "llvm.return"(%arg1) : (i1) -> ()
  }]
/-- Assert that the elaborator respects variable ordering correctly -/
private def variable_order2 : Com LLVM ⟨[bitvec 2, bitvec 1]⟩ .pure [bitvec 2] := [llvm()| {
    ^bb0(%arg1: i1, %arg2 : i2):
      "llvm.return"(%arg2) : (i2) -> ()
  }]

/-! Result type annotations are checked against the type the operation returns
(see https://github.com/opencompl/lean-mlir/issues/170). -/

/--
error: Type mismatch in result 'v1' of 'llvm.mlir.constant': the operation returns 'i64', but the result is annotated with type 'i420'
-/
#guard_msgs in
private def mismatched_constant_result : Com LLVM ⟨[]⟩ .pure [bitvec 64] := [llvm()| {
    %v1 = "llvm.mlir.constant" () { value = -1 : i64 } : () -> (i420)
    "llvm.return" (%v1) : (i64) -> ()
  }]

/--
error: Type mismatch in result 'v3' of 'llvm.add': the operation returns 'i64', but the result is annotated with type 'i3'
-/
#guard_msgs in
private def mismatched_add_result : Com LLVM ⟨[bitvec 64]⟩ .pure [bitvec 64] := [llvm()| {
    ^bb0(%arg0: i64):
      %v3 = "llvm.add" (%arg0, %arg0) : (i64, i64) -> i3
      "llvm.return" (%v3) : (i64) -> ()
  }]

private def matching_result : Com LLVM ⟨[]⟩ .pure [bitvec 64] := [llvm()| {
    %v1 = "llvm.mlir.constant" () { value = -1 : i64 } : () -> (i64)
    "llvm.return" (%v1) : (i64) -> ()
  }]
