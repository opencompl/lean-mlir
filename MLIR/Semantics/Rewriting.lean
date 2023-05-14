/-
## Rewriting of MLIR programs
This file implements a rewriting system for MLIR, following the ideas of PDL.
-/

import MLIR.AST
import MLIR.Semantics.Matching
import MLIR.Semantics.Semantics
import MLIR.Semantics.Refinement
import MLIR.Semantics.Dominance
open MLIR.AST


/-
### replace an operation with multiple operations
The operation to replace is identified by the name of its only result.

TODO: Remove this restriction, and have a way to identify uniquely operations.
-/


section replaceOpIn
variable (nameMatch: SSAVal) (new_ops: List (Op δ))

def replaceOpIn: OpRegion δ k → OpRegion δ k
| .op name res args regions attrs =>
    OpRegion.op name res args (replaceOpIn regions) attrs
| .region name args ops => .region name args (replaceOpIn ops)
| .regionsnil => .regionsnil
| .regionscons r rs => .regionscons (replaceOpIn r) (replaceOpIn rs)
| .opsnil => .opsnil
| .opscons o os => .opscons (replaceOpIn o) (replaceOpIn os)
end replaceOpIn

/-
A peephole rewrite for operations.
-/
structure PeepholeRewriteOp (δ: Dialect α σ ε) [S: Semantics δ] where
  findRoot: MTerm δ
  findSubtree: List (MTerm δ)
  replaceSubtree: List (MTerm δ)
  wellformed:
    ∀ (toplevelProg: Op δ)
      (_prog: Ops δ)
      (foundProg: Ops δ)
      (replacedProg: Ops δ)
      (matchctx: VarCtx δ)
      (domctx: DomContext δ)
      (MATCH: matchMProgInOp toplevelProg (findSubtree ++ [findRoot]) [] = .some (_prog.toList, matchctx))
      (FIND: MTerm.concretizeProg (findSubtree ++ [findRoot]) matchctx = .some foundProg.toList)
      (SUBST: MTerm.concretizeProg replaceSubtree matchctx = .some replacedProg.toList)
      (DOMFIND: (foundProg.obeysSSA domctx).isSome = true)
      , (replacedProg.obeysSSA domctx).isSome = true

  correct:
    ∀ (toplevelProg: Op δ)
      (foundProg: Ops δ)
      (replacedProg: Ops δ)
      (matchctx: VarCtx δ)
      (domctx: DomContext δ)
      (MATCH: matchMProgInOp toplevelProg (findSubtree ++ [findRoot]) [] = .some (_prog, matchctx))
      (FIND: MTerm.concretizeProg (findSubtree ++ [findRoot]) matchctx = .some foundProg.toList)
      (SUBST: MTerm.concretizeProg replaceSubtree matchctx = .some replacedProg.toList)
      ,  (replacedProg.denoteTop (Δ := δ) (S := S)).refines (foundProg.denoteTop (Δ := δ) (S := S)).run
