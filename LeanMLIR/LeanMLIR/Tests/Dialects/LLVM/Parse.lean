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
