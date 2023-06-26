import SSA.Core.WellTypedFramework
/-
an EDSL that elaborates expressions with nesting
allowed into SSA.

Authors: Siddharth Bhat
-/
namespace EDSL2
open Lean Elab Macro

declare_syntax_cat dsl_op2
scoped syntax "[dsl_op2|" dsl_op2 "]" : term
syntax dsl_var2 := "%v" num
declare_syntax_cat dsl_expr2
declare_syntax_cat dsl_region2
declare_syntax_cat dsl_stmt2

/-
This is a fancier syntax, which allows expressions in the
intermediate nodes. This is elaborated into SSA, with temporary
variable names.
-/
syntax dsl_var2 : dsl_expr2
scoped syntax "()" : dsl_expr2
scoped syntax "(" dsl_expr2 ")" : dsl_expr2
scoped syntax "(" dsl_expr2 "," dsl_expr2 ")" : dsl_expr2
scoped syntax "(" dsl_expr2 "," dsl_expr2 "," dsl_expr2 ")" : dsl_expr2
scoped syntax "op:" dsl_op2 ws dsl_expr2 (ws dsl_region2)? : dsl_expr2
syntax dsl_assign2 := dsl_var2 ":= " dsl_expr2
scoped syntax sepBy(dsl_assign2, ";") : dsl_stmt2

syntax dsl_bb2 := (dsl_stmt2)? "return " dsl_expr2

scoped syntax "{" dsl_var2 "=>" dsl_bb2 "}" : dsl_region2
-- scoped syntax "$(" term ")" : dsl_region2
-- scoped syntax "$(" term ")" : dsl_expr2

inductive ElabVar
| User (n : ℕ)
| Synthetic (n : ℕ)
deriving DecidableEq, Inhabited

def ElabVar.toString : ElabVar → String
| .User n => s!"%v{n}"
| .Synthetic n => s!"%vsynth{n}"

instance : ToString ElabVar where toString := ElabVar.toString

def ElabVar.toNat : ElabVar → Nat
| .User n => n
| .Synthetic n => n

def ElabVar.quoteAsNat (var : ElabVar) : TSyntax `term := 
  Lean.quote var.toNat



structure SSAElabContext where
  vars : Array ElabVar -- list of variables, in order of occurrence

abbrev SSAElabM (α : Type) := StateT SSAElabContext MacroM α

def SSAElabContext.addVar (var : ElabVar) : SSAElabM Unit := do
  modify fun ctx => { ctx with vars := ctx.vars.push var }

/- generate a fresh variable for temporary use. -/
def SSAElabContext.addFreshSyntheticVar : SSAElabM ElabVar := do
  -- This is a hack. We assign fresh variables an index > 99999.
  -- Ideally, we should have two different scopes, one for
  -- user defined variables, and one for synthetic variables.
  let synthv := ElabVar.Synthetic <| 9999 + (← get).vars.size
  SSAElabContext.addVar synthv
  return synthv

-- given an array [x, y, z], the index of 'z' is '0' (though its index is '2' in the array),
-- since we cound from the back.
def SSAElabContext.getIndex? (var : ElabVar) : SSAElabM (Option Nat) := do
  match (← get).vars.findIdx? (fun v => v == var) with
  | .some ixFromFront => return ((← get).vars.size - 1) - ixFromFront
  | .none => return none


/-- extract out the index (nat) of the dsl_var -/
def dslVarToElabVar : TSyntax ``dsl_var2 → MacroM (ElabVar)
| `(dsl_var2| %v $ix) => return ElabVar.User ix.getNat
| stx => Macro.throwErrorAt stx s!"expected variable %v<n>, found {stx}"

/-- convert a de-bruijn into a intrinsically well typed context variable -/
def idxToContextVar : Nat → MacroM (TSyntax `term)
| 0 => `(SSA.Context.Var.last)
| n+1 => do `(SSA.Context.Var.prev $(← idxToContextVar n))

def ElabVar.quoteAsContextVar (var : ElabVar) : SSAElabM (TSyntax `term) := do
  if let .some idx := (← SSAElabContext.getIndex? var) then
    idxToContextVar idx
  else
    Macro.throwError s!"unknown variable asked to quote as contextvar {var}"

/--
A statement builder that can be filled with a statement.
-/
structure StmtBuilder (α : Type) where
  -- continuation to fill the that can be filled with a `stmt` for the $next.
  appendk : TSyntax `term → SSAElabM (TSyntax `term) 
  val : α
deriving Inhabited


/-- Chain two statement builders -/
def StmtBuilder.prepend 
  (right : StmtBuilder β) (left : StmtBuilder α) : StmtBuilder α where 
  appendk := fun x => do left.appendk (← right.appendk x) -- really I want '>=>'
  val := left.val

/-- Append right to left -/
def StmtBuilder.append 
  (left : StmtBuilder α) (right : StmtBuilder β) : StmtBuilder β where 
  appendk := fun x => do left.appendk (← right.appendk x) -- really I want '>=>'
  val := right.val

/-- extend the inside of 'e' with 'hole'. Prefer using `StmtBuilder.append`. -/
def StmtBuilder.appendHole (e : StmtBuilder α)
  (appendk : TSyntax `term → SSAElabM (TSyntax `term)) : StmtBuilder α :=
  { e with appendk := fun x => do e.appendk (← appendk x) }

/-- extend the left of the appendk with `leftHole` -/
def StmtBuilder.prependHole (right : StmtBuilder α)
  (leftHole : TSyntax `term → SSAElabM (TSyntax `term)) : StmtBuilder α :=
  { right with appendk := fun x => do leftHole (← right.appendk x) }


/-- Set the value stored in the StmtBuilder -/
def StmtBuilder.setVal (e : StmtBuilder α) (val : β)
  : StmtBuilder β := { e with val := val }

instance [ToString α] : ToString (StmtBuilder α) where
  toString elabv := s!"<appendk> ⊢ '{elabv.val}'"

/-- Builder a `StmtBuilder` from a raw value -/
def StmtBuilder.ofVal (val : α) : StmtBuilder α where
  appendk := fun x => return x
  val := val


/-- Build an assignment to store `e`. -/
def StmtBuilder.toAssign (builder : StmtBuilder (TSyntax `term))
  : SSAElabM (StmtBuilder ElabVar) := do
  let synth : ElabVar ← SSAElabContext.addFreshSyntheticVar
  let assign : TSyntax `term → SSAElabM (TSyntax `term) := 
    fun next => `(SSA.TSSA.assign $(synth.quoteAsNat) $(builder.val) $next)
  return builder.appendHole assign |>.setVal synth

mutual
partial def elabRgn : TSyntax `dsl_region2 → SSAElabM (TSyntax `term)
| `(dsl_region2| $$($v)) => return v
| `(dsl_region2| { $vstx:dsl_var2 => $bbstx:dsl_bb2 }) => do
  let var ← dslVarToElabVar vstx
  SSAElabContext.addVar (← dslVarToElabVar vstx) -- add variable.
  let bb ← elabBB bbstx
  `(SSA.TSSA.rgn $(var.quoteAsNat) $bb)
| _ => Macro.throwUnsupported

/-- Given the rest of the statements that are to be built, build them -/
partial def elabAssign (restBuilderM : SSAElabM (StmtBuilder ElabVar)): 
  TSyntax `EDSL2.dsl_assign2 → SSAElabM (StmtBuilder ElabVar)
| `(dsl_assign2| $v:dsl_var2 := $e:dsl_expr2) => do
  let eBuilder ← elabStxExpr e -- already has expression assigned to var 'vsynth'.
  -- create a variable for 'v' and assign 'v' to 'vsynth'.
  SSAElabContext.addVar (← dslVarToElabVar v) -- add variable.
  let vNat := Lean.quote (← dslVarToElabVar v).toNat -- natural number.
  -- build a mapping from 'v' to 'e' to build assignments
  let assignBuilder := 
    eBuilder.appendHole 
      (fun rest => do
        `(SSA.TSSA.assign $(vNat) $(← eBuilder.val.quoteAsContextVar) $rest))
  return (← restBuilderM).append assignBuilder

| _ => Macro.throwUnsupported



partial def elabStmt (rest : StmtBuilder ElabVar) : TSyntax `dsl_stmt2 → 
  SSAElabM (StmtBuilder ElabVar)
  | `(dsl_stmt2| $ss:dsl_assign2;*) => go ss.getElems.toList
  | _ => Macro.throwUnsupported
where go
  | [] => return rest
  | s::ss => elabAssign (go ss) s

partial def elabBB : TSyntax `EDSL2.dsl_bb2 → SSAElabM (TSyntax `term)
| `(dsl_bb2| $[ $ss?:dsl_stmt2 ]? return $rete:dsl_expr2) => do
    let retElab : StmtBuilder ElabVar ← elabStxExpr rete
    let retElab ← match ss? with 
      | .some ss => elabStmt retElab ss
      | .none => pure retElab 
    -- fill in the appendk with the 'ret' as expected.
    let out ← retElab.appendk (← `(SSA.TSSA.ret $(← retElab.val.quoteAsContextVar)))
    return out
| _ => Macro.throwUnsupported

/-- insert intermediate let bindings to produce -/
-- partial def exprToVar : TSyntax ``dsl_expr2 → SSAElabM (TSyntax `term)

-- e → (stmts, e)
partial def elabStxExpr : TSyntax `dsl_expr2 → SSAElabM (StmtBuilder ElabVar)
| `(dsl_expr2| $$($v)) => do 
  let exprElab : StmtBuilder (TSyntax `term) := StmtBuilder.ofVal v
  exprElab.toAssign
| `(dsl_expr2| ( $e:dsl_expr2 )) => elabStxExpr e
| `(dsl_expr2| ()) => do
  let exprElab : StmtBuilder (TSyntax `term) := StmtBuilder.ofVal (← `(SSA.TSSA.unit))
  exprElab.toAssign
| `(dsl_expr2| ($a, $b)) => do
    let aelab ← elabStxExpr a
    let belab ← elabStxExpr b
    let val ← `(SSA.TSSA.pair $(← aelab.val.quoteAsContextVar) $(← belab.val.quoteAsContextVar))
    let exprElab : StmtBuilder (TSyntax `term) := 
      aelab.append belab |>.setVal val
    exprElab.toAssign
| `(dsl_expr2| ($a, $b, $c)) => do
  let aelab ← elabStxExpr a
  let belab ← elabStxExpr b
  let celab ← elabStxExpr c
  let val ← `(SSA.TSSA.triple $(← aelab.val.quoteAsContextVar) $(← belab.val.quoteAsContextVar) $(← celab.val.quoteAsContextVar))
  let exprElab : StmtBuilder (TSyntax `term) := 
    aelab |>.append belab |>.append celab |>.setVal val
  exprElab.toAssign
| `(dsl_expr2| $v:dsl_var2) => do
    let var : ElabVar ← dslVarToElabVar v
    return StmtBuilder.ofVal var
| `(dsl_expr2| op: $o:dsl_op2 $arg:dsl_expr2 $[ $r?:dsl_region2 ]? ) => do
  let argelab ← elabStxExpr arg
  let rgn ← match r? with
    | none => `(SSA.TSSA.rgn0)
    | some r => elabRgn r -- TODO: can a region affect stuff outside?
  let op ← `(SSA.TSSA.op [dsl_op2| $o] $(← argelab.val.quoteAsContextVar) $rgn)
  let exprElab : StmtBuilder (TSyntax `term) := argelab.setVal op
  exprElab.toAssign
| _ => Macro.throwUnsupported
end

scoped syntax "[dsl_bb2|" dsl_bb2 "]" : term
macro_rules
| `([dsl_bb2| $bb:dsl_bb2]) => do
  let ctx : SSAElabContext := {  vars := #[] }
  let (outTerm, _outCtx) ← (elabBB bb).run ctx
  return outTerm

scoped syntax "[dsl_region2|" dsl_region2 "]" : term
macro_rules
| `([dsl_region2| $r:dsl_region2]) => do
  let ctx : SSAElabContext := {  vars := #[] }
  let (outTerm, _outCtx) ← (elabRgn r).run ctx
  return outTerm

end EDSL2

