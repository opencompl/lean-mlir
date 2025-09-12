import Lean
open Lean Meta Elab


/-- The free variables in the term that is reflected. -/
structure ReflectMap where
  /-- Map expressions to their index in the eventual `Reflect.Map`. -/
  exprs : Std.HashMap Expr Nat

/-- The size of the reflect map map. -/
def ReflectMap.size (m : ReflectMap) : Nat :=
    m.exprs.size


/-- Convert the 'ReflectMap' into an array of expressions, sorted by their index. -/
def ReflectMap.toArray (m : ReflectMap) : Array Expr := Id.run do
  let vals := m.exprs.toArray
  let vals := vals.qsort (fun a b => a.2 < b.2)
  return vals.map Prod.fst


instance : EmptyCollection ReflectMap where
  emptyCollection := { exprs := ∅ }
/--
Insert expression 'e' into the reflection map. This returns the map,
as well as the denoted term.
-/
def ReflectMap.findOrInsertExpr (m : ReflectMap) (e : Expr) : Nat × ReflectMap :=
  let (ix, m) := match m.exprs.get? e with
    | some ix =>  (ix, m)
    | none =>
      let ix := m.exprs.size
      (ix, { m with exprs := m.exprs.insert e ix })
  (ix, m)


instance : ToMessageData ReflectMap where
  toMessageData exprs := Id.run do
    -- sort in order of index.
    let es := exprs.exprs.toArray.qsort (fun a b => a.2 < b.2)
    let mut lines := es.map (fun (e, i) => m!"{i}→{e}")
    return m!"[" ++ m!" ".joinSep lines.toList ++ m!"]"

/--
If we have variables in the `ReflectMap` that are not FVars,
then we will throw a warning informing the user that this will be treated as a symbolic variable.
-/
def ReflectMap.throwWarningIfUninterpretedExprs (xs : ReflectMap) : MetaM Unit := do
  let mut out? : Option MessageData := none
  let header := m!"Tactic has not understood the following expressions, and will treat them as symbolic:"
  -- Order the expressions so we get stable error messages.
  let exprs := xs.exprs.toArray.qsort (fun ei ej => ei.1.lt ej.1)

  for (e, _) in exprs do
    if e.isFVar then continue
    let eshow := indentD m!"- '{e}'"
    out? := match out? with
      | .none => header ++ Format.line ++ eshow
      | .some out => .some (out ++ eshow)
  let .some out := out? | return ()
  logWarning out

/--
Result of reflection, where we have a collection of bitvector variables,
along with the bitwidth and the final term.
-/
structure ReflectResult (α : Type) where
  /-- Map of 'free variables' in the bitvector expression,
  which are indexed as Term.var. This array is used to build the environment for decide.
  -/
  exprToIx : ReflectMap
  e : α

instance [ToMessageData α] : ToMessageData (ReflectResult α) where
  toMessageData result := m!"{result.e} {result.exprToIx}"
