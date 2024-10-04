import Lean.Meta.Tactic.Simp.BuiltinSimprocs
import Lean.Meta

open Lean Elab Tactic
open Lean Meta

/- Copy-pasted from Lean/Elab/Tactic/ElabTerm.lean -/

private def preprocessPropToDecide (expectedType : Expr) : TermElabM Expr := do
  let mut expectedType ← instantiateMVars expectedType
  if expectedType.hasFVar then
    expectedType ← zetaReduce expectedType
  if expectedType.hasFVar || expectedType.hasMVar then
    throwError "expected type must not contain free or meta variables{indentExpr expectedType}"
  return expectedType

private def mkNativeAuxDecl (baseName : Name) (type value : Expr) : TermElabM Name := do
  let auxName ← Term.mkAuxName baseName
  let decl := Declaration.defnDecl {
    name := auxName, levelParams := [], type, value
    hints := .abbrev
    safety := .safe
  }
  addDecl decl
  compileDecl decl
  pure auxName

elab "safe_native_decide" : tactic =>
  Lean.Elab.Tactic.closeMainGoalUsing `safeNativeDecide fun expectedType => do
    let expectedType ← preprocessPropToDecide expectedType
    let d ← mkDecide expectedType
    let auxDeclName ← mkNativeAuxDecl `_nativeDecide (Lean.mkConst `Bool) d
    -- new lines
    unless ← reduceBoolNative auxDeclName do
      throwError "The statement is false"
    let rflPrf ← mkEqRefl (toExpr true)
    let s := d.appArg! -- get instance from `d`
    return mkApp3 (Lean.mkConst ``of_decide_eq_true) expectedType s <| mkApp3 (Lean.mkConst ``Lean.ofReduceBool) (Lean.mkConst auxDeclName) (toExpr true) rflPrf
