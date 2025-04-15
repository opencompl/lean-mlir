/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.SLLVM.Meta.Tactic
import SSA.Projects.SLLVM.Dialect.Parser

namespace StructuredLLVM

def ex := [sllvm| {
  ^entry(%x : i64):
    %y = "add"(%x, %x) : (i64, i64) -> i64
    "return"(%y) : (i64) -> ()
}]

set_option trace.LeanMLIR.Elab true
example (x) : ex.denote (.ofHVector <| x ::ₕ .nil) = LLVM.add x x := by
  simp

open Lean.Meta in
#eval do
  let ex ← whnf <| Lean.Expr.const ``ex []
  Meta.comOfExpr ex
