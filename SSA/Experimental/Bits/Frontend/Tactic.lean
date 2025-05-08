import Mathlib.Data.Fintype.Defs
import SSA.Experimental.Bits.Frontend.Defs
import SSA.Experimental.Bits.Frontend.Preprocessing
import SSA.Experimental.Bits.Frontend.Syntax

import SSA.Experimental.Bits.Fast.Reflect
-- import SSA.Experimental.Bits.AutoStructs.FormulaToAuto

initialize Lean.registerTraceClass `Bits.Frontend

namespace Tactic
open Lean Meta Elab Tactic

inductive CircuitBackend
/-- NFA-based implementation. -/
| automata
/-- Pure lean implementation, verified. -/
| circuit_lean
/-- bv_decide based backend. Currently unverified. -/
| circuit_cadical (maxIter : Nat := 4)
/-- Dry run, do not execute and close proof with `sorry` -/
| dryrun
deriving Repr, DecidableEq

/-- Tactic options for bv_automata_circuit -/
structure Config where
  /--
  The upper bound on the size of circuits in the FSM, beyond which the tactic will bail out on an error.
  This is useful to prevent the tactic from taking oodles of time cruncing on goals that
  build large state spaces, which can happen in the presence of tactics.
  -/
  circuitSizeThreshold : Nat := 200

  /--
  The upper bound on the state space of the FSM, beyond which the tactic will bail out on an error.
  See also `Config.circuitSizeThreshold`.
  -/
  stateSpaceSizeThreshold : Nat := 200
  /--
  Whether the tactic should used a specialized solver for fixed-width constraints.
  -/
  fastFixedWidth : Bool := false
  /--
  Whether the tactic should use the (currently unverified) bv_decide based backend for solving constraints.
  -/
  backend : CircuitBackend := .circuit_lean

/-- Default user configuration -/
def Config.default : Config := {}

/-- The free variables in the term that is reflected. -/
structure ReflectMap where
  /-- Map expressions to their index in the eventual `Reflect.Map`. -/
  exprs : Std.HashMap Expr Nat


instance : EmptyCollection ReflectMap where
  emptyCollection := { exprs := ∅ }

abbrev ReflectedExpr := Expr

/--
Insert expression 'e' into the reflection map. This returns the map,
as well as the denoted term.
-/
def ReflectMap.findOrInsertBVExpr (m : ReflectMap) (e : Expr) : _root_.Term × ReflectMap :=
  let (ix, m) := match m.exprs.get? e with
    | some ix =>  (ix, m)
    | none =>
      let ix := m.exprs.size
      (ix, { m with exprs := m.exprs.insert e ix })
  -- let e :=  mkApp (mkConst ``Term.var) (mkNatLit ix)
  (Term.var ix, m)

/--
Insert expression 'e' into the reflection map. This returns the map,
as well as the denoted term.
-/
def ReflectMap.findOrInsertBoolExpr (m : ReflectMap) (e : Expr) : BTerm × ReflectMap :=
  let (ix, m) := match m.exprs.get? e with
    | some ix =>  (ix, m)
    | none =>
      let ix := m.exprs.size
      (ix, { m with exprs := m.exprs.insert e ix })
  (BTerm.var ix, m)


#check Reflect.Map.empty

#check Reflect.Map.append

/--
Convert the meta-level "list of expressions" into an object level list
repeatedly calling `Reflect.Map.empty` and `Reflect.Map.append`.
-/
let mkExprOfArrayExpr (ty : Expr) (xs : List Expr) : MetaM ReflectedExpr := do
  let mut out := mkApp (mkConst ``Reflect.Map.empty) ty
  for x in xs do
    out := mkAppN (mkConst ``Reflect.Map.append) #[ty, x, out]
  return out


/--
Convert the meta-level `ReflectMap` into an object level `Reflect.Map` by
repeatedly calling `Reflect.Map.empty` and `Reflect.Map.set`.
-/
def ReflectMap.toExpr (xs : ReflectMap) (w : Expr) : MetaM ReflectedExpr := do
  let exprs := xs.exprs.toArray.qsort (fun ei ej => ei.2 < ej.2)
  mkExprOfArrayExpr (mkApp (mkConst ``BitVec) w) exprs

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
  bvToIxMap : ReflectMap
  e : α

instance [ToMessageData α] : ToMessageData (ReflectResult α) where
  toMessageData result := m!"{result.e} {result.bvToIxMap}"



/--
info: ∀ {w : Nat} (a b : BitVec w),
  @Eq (BitVec w) (@HAdd.hAdd (BitVec w) (BitVec w) (BitVec w) (@instHAdd (BitVec w) (@BitVec.instAdd w)) a b)
    (BitVec.ofNat w (@OfNat.ofNat Nat (nat_lit 0) (instOfNatNat (nat_lit 0)))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a b: BitVec w), a + b = 0#w

/--
info: ∀ {w : Nat} (a : BitVec w),
  @Eq (BitVec w) (@Neg.neg (BitVec w) (@BitVec.instNeg w) a)
    (BitVec.ofNat w (@OfNat.ofNat Nat (nat_lit 0) (instOfNatNat (nat_lit 0)))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w), - a = 0#w

/--
info: ∀ {w : Nat} (a : BitVec w) (n : Nat),
  @Eq (BitVec w) (@HShiftLeft.hShiftLeft (BitVec w) Nat (BitVec w) (@BitVec.instHShiftLeftNat w) a n)
    (BitVec.ofNat w (@OfNat.ofNat Nat (nat_lit 0) (instOfNatNat (nat_lit 0)))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w) (n : Nat), a <<< n = 0#w


/--
info: ∀ {w : Nat} (a : BitVec w),
  @LT.lt (BitVec w) (@instLTBitVec w) a
    (BitVec.ofNat w (@OfNat.ofNat Nat (nat_lit 0) (instOfNatNat (nat_lit 0)))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w),  a  < 0#w

/--
info: ∀ {w : Nat} (a : BitVec w),
  @LE.le (BitVec w) (@instLEBitVec w) a
    (BitVec.ofNat w (@OfNat.ofNat Nat (nat_lit 0) (instOfNatNat (nat_lit 0)))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w),  a  ≤ 0#w

/--
info: ∀ {w : Nat} (a : BitVec w),
  @Eq Bool (@BitVec.slt w a (BitVec.ofNat w (@OfNat.ofNat Nat (nat_lit 0) (instOfNatNat (nat_lit 0))))) true : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w),  a.slt 0#w


def reflectAtomUnchecked (map : ReflectMap) (_w : Expr) (e : Expr) : MetaM (ReflectResult _root_.Term) := do
  let (e, map) := map.findOrInsertBVExpr e
  return { bvToIxMap := map, e := e }

abbrev foo : Bool := (true : Bool) ^^ (true : Bool)


mutual

partial def reflectBoolUnchecked (map : ReflectMap)  (e : Expr) : MetaM (ReflectResult BTerm) := do
  match_expr e with
  | BitVec.msb w x =>
    let ⟨map, x⟩ ← reflectBVUnchecked map w x
    return { bvToIxMap := map, e := BTerm.msb x }
  | Bool.true =>
      return { bvToIxMap := map, e := BTerm.tru }
  | Bool.false =>
      return { bvToIxMap := map, e := BTerm.fals }
  | Bool.xor a b =>
      let ⟨map, l⟩ ← reflectBoolUnchecked map a
      let ⟨map, r⟩ ← reflectBoolUnchecked map b
      return { bvToIxMap := map, e := BTerm.xor l r }
  | _ =>
    let (e, map) := map.findOrInsertBoolExpr e
    return { bvToIxMap := map, e := e }

/--
Return a new expression that this is **defeq** to, along with the expression of the environment that this needs.
Crucially, when this succeeds, this will be in terms of `term`.
and furthermore, it will reflect all terms as variables.

Precondition: we assume that this is called on bitvectors.
-/
partial def reflectBVUnchecked (map : ReflectMap) (w : Expr) (e : Expr) : MetaM (ReflectResult _root_.Term) := do
  if let some (v, _bvTy) ← getOfNatValue? e ``BitVec then
    return { bvToIxMap := map, e := Term.ofNat v }
  -- TODO: bitvector contants.
  match_expr e with
  | BitVec.ofInt _wExpr iExpr =>
    let i ← getIntValue? iExpr
    match i with
    | _ =>
      let (e, map) := map.findOrInsertBVExpr e
      return { bvToIxMap := map, e := e }
  | BitVec.ofNat _wExpr nExpr =>
    let n ← getNatValue? nExpr
    match n with
    | .some 0 =>
      return {bvToIxMap := map, e := Term.zero }
    | .some 1 =>
      let _ := (mkConst ``Term.one)
      return {bvToIxMap := map, e := Term.one }
    | .some n =>
      return { bvToIxMap := map, e := Term.ofNat n }
    | none =>
      logWarning "expected concrete BitVec.ofNat, found symbol '{n}', creating free variable"
      reflectAtomUnchecked map w e

  | HAnd.hAnd _bv _bv _bv _inst a b =>
      let a ← reflectBVUnchecked map w a
      let b ← reflectBVUnchecked a.bvToIxMap w b
      let out := Term.and a.e b.e
      return { b with e := out }
  | HOr.hOr _bv _bv _bv _inst a b =>
      let a ← reflectBVUnchecked map w a
      let b ← reflectBVUnchecked a.bvToIxMap w b
      let out := Term.or a.e b.e
      return { b with e := out }
  | HXor.hXor _bv _bv _bv _inst a b =>
      let a ← reflectBVUnchecked map w a
      let b ← reflectBVUnchecked a.bvToIxMap w b
      let out := Term.xor a.e b.e
      return { b with e := out }
  | Complement.complement _bv _inst a =>
      let a ← reflectBVUnchecked map w a
      let out := Term.not a.e
      return { a with e := out }
  | HAdd.hAdd _bv _bv _bv _inst a b =>
      let a ← reflectBVUnchecked map w a
      let b ← reflectBVUnchecked a.bvToIxMap w b
      let out := Term.add a.e b.e
      return { b with e := out }
  | HShiftLeft.hShiftLeft _bv _nat _bv _inst a n =>
      let a ← reflectBVUnchecked map w a
      let some n ← getNatValue? n
        | throwError m!"expected shiftLeft by natural number, found symbolic shift amount '{n}' at '{indentD e}'"
      return { a with e := Term.shiftL a.e n }

  | HSub.hSub _bv _bv _bv _inst a b =>
      let a ← reflectBVUnchecked map w a
      let b ← reflectBVUnchecked a.bvToIxMap w b
      let out := Term.sub a.e b.e
      return { b with e := out }
  | Neg.neg _bv _inst a =>
      let a ← reflectBVUnchecked map w a
      let out := Term.neg a.e
      return { a with e := out }
  -- incr
  -- decr
  | _ =>
    let (e, map) := map.findOrInsertBVExpr e
    return { bvToIxMap := map, e := e }

end

set_option pp.explicit true in
/--
info: ∀ {w : Nat} (a b : BitVec w), Or (@Eq (BitVec w) a b) (And (@Ne (BitVec w) a b) (@Eq (BitVec w) a b)) : Prop
-/
#guard_msgs in
#check ∀ {w : Nat} (a b : BitVec w), a = b ∨ (a ≠ b) ∧ a = b

partial def reflectBoolPredicateAux (map : ReflectMap) (e : Expr) : MetaM (ReflectResult Predicate) := do
  match_expr e with
  | Eq α ea eb => do
     let_expr Bool := α
       | throwError m!"expected to be called on boolean equality, but called on '{e}'"
     let ⟨map, a⟩ ← reflectBoolUnchecked map ea
     let ⟨map, b⟩ ← reflectBoolUnchecked map eb
     logInfo m!"reflecting {e} : ({repr a} ~ {ea}) = ({repr b} ~ {eb})"
     return { bvToIxMap := map, e := Predicate.boolBinary .eq a b }
  | _ => throwError m!"expected boolean predicate, found '{e}'"

/-- Return a new expression that this is defeq to, along with the expression of the environment that this needs, under which it will be defeq. -/
partial def reflectPredicateAux (bvToIxMap : ReflectMap) (e : Expr) (wExpected : Expr) : MetaM (ReflectResult Predicate) := do
  match_expr e with
  | Eq α a b =>
    match_expr α with
    | Nat =>
       -- support width equality constraints
      -- TODO: canonicalize 'a = w' into 'w = a'.
      if wExpected != a then
        throwError m!"Only Nat expressions allowed are '{wExpected} ≠ <concrete value>'. Found {indentD e}."
      let some natVal ← Lean.Meta.getNatValue? b
        | throwError m!"Expected '{wExpected} ≠ <concrete width>', found symbolic width {indentD b}."
      let out := Predicate.width .eq natVal
      return { bvToIxMap := bvToIxMap, e := out }

    | BitVec w =>
      let a ←  reflectBVUnchecked bvToIxMap w a
      let b ← reflectBVUnchecked a.bvToIxMap w b
      return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .eq a.e b.e }
    | Bool =>
      -- Sadly, recall that slt, sle are of type 'BitVec w → BitVec w → Bool',
      -- so we get goal states of them form 'a <ₛb = true'.
      -- So we need to match on 'Eq _ true' where '_' is 'slt'.
      -- This makes me unhappy too, but c'est la vie.
      -- TODO: this can be fixed now, since we have a boolean fragment.
      match_expr b with
      | true =>
        match_expr a with
        | BitVec.slt w a b =>
          let a ← reflectBVUnchecked bvToIxMap w a
          let b ← reflectBVUnchecked a.bvToIxMap w b
          return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .slt a.e b.e }
        | BitVec.sle w a b =>
          let a ← reflectBVUnchecked bvToIxMap w a
          let b ← reflectBVUnchecked a.bvToIxMap w b
          return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .sle a.e b.e }
        | BitVec.ult w a b =>
          let a ← reflectBVUnchecked bvToIxMap w a
          let b ← reflectBVUnchecked a.bvToIxMap w b
          return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .ult a.e b.e }
        | BitVec.ule w a b =>
          let a ← reflectBVUnchecked bvToIxMap w a
          let b ← reflectBVUnchecked a.bvToIxMap w b
          return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .ule a.e b.e }
        | _ =>
          reflectBoolPredicateAux bvToIxMap e
      | _ =>
          reflectBoolPredicateAux bvToIxMap e
    | _ =>
      throwError m!"unknown equality kind, expected 'bv = bv' or 'bv.slt bv = true' or 'bv.sle bv = true' or 'bool = bool'. Found {indentD e}"
  | Ne α a b =>
    /- Support width constraints with α = Nat -/
    match_expr α with
    | Nat => do
      -- TODO: canonicalize 'a ≠ w' into 'w ≠ a'.
      if wExpected != a then
        throwError m!"Only Nat expressions allowed are '{wExpected} ≠ <concrete value>'. Found {indentD e}."
      let some natVal ← Lean.Meta.getNatValue? b
        | throwError m!"Expected '{wExpected} ≠ <concrete width>', found symbolic width {indentD b}."
      let out := Predicate.width .neq natVal
      return { bvToIxMap := bvToIxMap, e := out }
    | BitVec w =>
      let a ← reflectBVUnchecked bvToIxMap w a
      let b ← reflectBVUnchecked a.bvToIxMap w b
      return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .neq a.e b.e }
    | _ =>
      throwError m!"Expected typeclass to be 'BitVec w' / 'Nat', found '{indentD α}' in {e} when matching against 'Ne'"
  | LT.lt α _inst a b =>
    let_expr BitVec w := α | throwError m!"Expected typeclass to be BitVec w, found '{indentD α}' in {indentD e} when matching against 'LT.lt'"
    let a ← reflectBVUnchecked bvToIxMap w a
    let b ← reflectBVUnchecked a.bvToIxMap w b
    return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .ult a.e b.e }
  | LE.le α _inst a b =>
    let_expr BitVec w := α | throwError m!"Expected typeclass to be BitVec w, found '{indentD α}' in {indentD e} when matching against 'LE.le'"
    let a ← reflectBVUnchecked bvToIxMap w a
    let b ← reflectBVUnchecked a.bvToIxMap w b
    return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .ule a.e b.e }
  | Or p q =>
    let p ← reflectPredicateAux bvToIxMap p wExpected
    let q ← reflectPredicateAux p.bvToIxMap q wExpected
    let out := Predicate.lor p.e q.e
    return { q with e := out }
  | And p q =>
    let p ← reflectPredicateAux bvToIxMap p wExpected
    let q ← reflectPredicateAux p.bvToIxMap q wExpected
    let out := Predicate.land p.e q.e
    return { q with e := out }
  | _ =>
     throwError m!"expected predicate over bitvectors (no quantification), found:  {indentD e}"

/-- Name of the tactic -/
def tacName : String := "bv_automata_gen"

abbrev WidthToExprMap := Std.HashMap Expr Expr

/--
Find all bitwidths implicated in the given expression.
Maps each length (the key) to an expression of that length.

Find all bitwidths implicated in the given expression,
by visiting subexpressions with visitExpr:
    O(size of expr × inferType)
-/
def findExprBitwidths (target : Expr) : MetaM WidthToExprMap := do
  let (_, out) ← StateT.run (go target) ∅
  return out
  where
    go (target : Expr) : StateT WidthToExprMap MetaM Unit := do
      -- Creates fvars when going inside binders.
      forEachExpr target fun e => do
        match_expr ← inferType e with
        | BitVec n =>
          -- TODO(@bollu): do we decide to normalize `n`? upto what?
          modify (fun arr => arr.insert n.cleanupAnnotations e)
        | _ => return ()

/-- Return if expression 'e' is a bitvector of bitwidth 'w' -/
private def Expr.isBitVecOfWidth (e : Expr) (w : Expr) : MetaM Bool := do
  match_expr ← inferType e with
  | BitVec w' => return w == w'
  | _ => return false


/-- Revert all bitwidths of a given bitwidth and then run the continuation 'k'.
This allows
-/
def revertBVsOfWidth (g : MVarId) (w : Expr) : MetaM MVarId := g.withContext do
  let mut reverts : Array FVarId := #[]
  for d in ← getLCtx do
    if ← Expr.isBitVecOfWidth d.type w then
      reverts := reverts.push d.fvarId
  /- revert all the bitvectors of the given width in one fell swoop. -/
  let (_fvars, g) ← g.revert reverts
  return g

/-- generalize our mapping to get a single fvar -/
def generalizeMap (g : MVarId) (e : Expr) : MetaM (FVarId × MVarId) :=  do
  let (fvars, g) ← g.generalize #[{ expr := e : GeneralizeArg}]
  --eNow target no longer depends on the particular bitvectors
  if h : fvars.size = 1 then
    return (fvars[0], g)
  throwError"expected a single free variable from generalizing map {e}, found multiple..."

/--
Revert all hypotheses that have to do with bitvectors, so that we can use them.

For now, we choose to revert all propositional hypotheses.
The issue is as follows: Since our reflection fragment only deals with
goals in negation normal form, the naive algorithm would run an NNF pass
and then try to reflect the hyp before reverting it. This is expensive and annoying to implement.

Ideally, we would have a pass that quickly walks an expression to cheaply
ee if it's in the BV fragment, and revert it if it is.
For now, we use a sound overapproximation and revert everything.
-/
def revertBvHyps (g : MVarId) : MetaM MVarId := do
  let (_, g) ← g.revert (← g.getNondepPropHyps)
  return g

namespace BvDecide
open Std Sat AIG in

def cadicalTimeoutSec : Nat := 1000


/--
An axiom that tracks that a theorem is true because of our currently unverified
'decideIfZerosM' decision procedure.
-/
axiom decideIfZerosMAx {p : Prop} : p

end BvDecide


/--
Reflect an expression of the form:
  ∀ ⟦(w : Nat)⟧ (← focus)
  ∀ (b₁ b₂ ... bₙ : BitVec w),
  <proposition about bitvectors>.

Reflection code adapted from `elabNaticeDecideCoreUnsafe`,
which explains how to create the correct auxiliary definition of the form
`decideProprerty = true`, such that our goal state after using `ofReduceBool` becomes
⊢ ofReduceBool decideProperty = true

which is then indeed `rfl` equal to `true`.
-/
def reflectUniversalWidthBVs (g : MVarId) (cfg : Config) : TermElabM (List MVarId) := do
  let ws ← findExprBitwidths (← g.getType)
  let ws := ws.toArray
  if hgt: ws.size > 1 then
    let (w1, wExample1) := ws[0]
    let (w2, wExample2) := ws[1]
    let mExample := m!"{w1} → {wExample1}; {w2} → {wExample2}"
    throwError m!"found multiple bitvector widths in the target: {indentD mExample}"
  else
    -- we have exactly one width
    let w := if h : ws.size = 0 then mkNatLit 0 else (ws[0]).fst

    -- We can now revert hypotheses that are of this bitwidth.
    let g ← revertBvHyps g

    -- Next, after reverting, we have a goal which we want to reflect.
    -- we convert this goal to NNF
    let .some g ← NNF.runNNFSimpSet g
      | trace[Bits.Frontend] m!"Converting to negation normal form automatically closed goal."
        return[]
    trace[Bits.Frontend] m!"goal after NNF: {indentD g}"

    let .some g ← Simplifications.runPreprocessing g
      | trace[Bits.Frontend] m!"Preprocessing automatically closed goal."
        return[]
    trace[Bits.Frontend] m!"goal after preprocessing: {indentD g}"

    -- finally, we perform reflection.
    let result ← reflectPredicateAux ∅ (← g.getType) w
    result.bvToIxMap.throwWarningIfUninterpretedExprs

    trace[Bits.Frontend] m!"predicate (repr): {indentD (repr result.e)}"

    let bvToIxMapVal ← result.bvToIxMap.toExpr w

    let target := (mkAppN (mkConst ``Predicate.denote) #[result.e.quote, w, bvToIxMapVal])
    let g ← g.replaceTargetDefEq target
    trace[Bits.Frontend] m!"goal after reflection: {indentD g}"


    match cfg.backend with
    | .dryrun =>
        g.assign (← mkSorry (← g.getType) (synthetic := false))
        trace[Bits.Frontend] "Closing goal with 'sorry' for dry-run"
        return []
    | .automata =>
      throwError "ERROR: Disabled automata tactic when developing zext/sext extensions."
      -- let (mapFv, g) ← generalizeMap g bvToIxMapVal;
      -- let (_, g) ← g.revert #[mapFv]
      -- -- Apply Predicate.denote_of_eval_eq.
      -- let wVal? ← Meta.getNatValue? w
      -- let g ←
      --   -- TODO FIXME
      --   if false then
      --     pure g
      --   else
      --     -- Generic width problem.
      --     if !w.isFVar then
      --       let msg := m!"Width '{w}' is not a free variable (i.e. width is not universally quantified)."
      --       let msg := msg ++ Format.line ++ m!"The tactic will perform width-generic reasoning."
      --       let msg := msg ++ Format.line ++ m!"To perform width-specific reasoning, rewrite goal with a width constraint, e.g. ∀ (w : Nat) (hw : w = {w}), ..."
      --       logWarning  msg

      --     let [g] ← g.apply <| (mkConst ``Formula.denote_of_isUniversal)
      --       | throwError m!"Failed to apply `Predicate.denote_of_eval_eq` on goal '{indentD g}'"
      --     pure g
      -- let [g] ← g.apply <| (mkConst ``of_decide_eq_true)
      --   | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
      -- let [g] ← g.apply <| (mkConst ``Lean.ofReduceBool)
      --   | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
      -- return [g]
    | .circuit_cadical maxIter =>
      let fsm := predicateEvalEqFSM result.e |>.toFSM
      trace[Bits.Frontend] f!"{fsm.format}'"
      let isTrueForall ← fsm.decideIfZerosMCadical maxIter
      if isTrueForall
      then do
        let gs ← g.apply (mkConst ``Reflect.BvDecide.decideIfZerosMAx [])
        if gs.isEmpty
        then return gs
        else
          throwError m!"Expected application of 'decideIfZerosMAx' to close goal, but failed. {indentD g}"
      else
        throwError m!"failed to prove goal, since decideIfZerosM established that theorem is not true."
        return [g]
    | .circuit_lean =>
      let fsm := predicateEvalEqFSM result.e |>.toFSM
      trace[Bits.Frontend] f!"{fsm.format}'"
      if fsm.circuitSize > cfg.circuitSizeThreshold && cfg.circuitSizeThreshold != 0 then
        throwError m!"Not running on goal: since circuit size ('{fsm.circuitSize}') is larger than threshold ('circuitSizeThreshold:{cfg.circuitSizeThreshold}')"
      if fsm.stateSpaceSize > cfg.stateSpaceSizeThreshold && cfg.stateSpaceSizeThreshold != 0 then
        throwError m!"Not running on goal: since state space size size ('{fsm.stateSpaceSize}') is larger than threshold ('stateSpaceSizeThreshold:{cfg.stateSpaceSizeThreshold}')"

      let (mapFv, g) ← generalizeMap g bvToIxMapVal;
      let (_, g) ← g.revert #[mapFv]
      -- Apply Predicate.denote_of_eval_eq.
      let wVal? ← Meta.getNatValue? w
      let g ←
        -- Fixed width problem
        if h : wVal?.isSome ∧ cfg.fastFixedWidth then
          trace[Bits.Frontend] m!"using special fixed-width procedure for fixed bitwidth '{w}'."
          let wVal := wVal?.get h.left
          let [g] ← g.apply <| (mkConst ``Predicate.denote_of_eval_eq_fixedWidth)
            | throwError m!"Failed to apply `Predicate.denote_of_eval_eq_fixedWidth` on goal '{indentD g}'"
          pure g
        else
          -- Generic width problem.
          -- If the generic width problem has as 'complex' width, then warn the user that they're
          -- trying to solve a fragment that's better expressed differently.
          if !w.isFVar then
            let msg := m!"Width '{w}' is not a free variable (i.e. width is not universally quantified)."
            let msg := msg ++ Format.line ++ m!"The tactic will perform width-generic reasoning."
            let msg := msg ++ Format.line ++ m!"To perform width-specific reasoning, rewrite goal with a width constraint, e.g. ∀ (w : Nat) (hw : w = {w}), ..."
            logWarning  msg

          let [g] ← g.apply <| (mkConst ``Predicate.denote_of_eval_eq)
            | throwError m!"Failed to apply `Predicate.denote_of_eval_eq` on goal '{indentD g}'"
          pure g
      let [g] ← g.apply <| (mkConst ``of_decide_eq_true)
        | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
      let [g] ← g.apply <| (mkConst ``Lean.ofReduceBool)
        | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
      return [g]

/-- Allow elaboration of `bv_automata_gen's config` arguments to tactics. -/
declare_config_elab elabBvAutomataCircuitConfig Config

syntax (name := bvAutomataGen) "bv_automata_gen" (Lean.Parser.Tactic.config)? : tactic
@[tactic bvAutomataGen]
def evalBvAutomataCircuit : Tactic := fun
| `(tactic| bv_automata_gen $[$cfg]?) => do
  let cfg ← elabBvAutomataCircuitConfig (mkOptionalNode cfg)
  let g ← getMainGoal
  g.withContext do
    let gs ← reflectUniversalWidthBVs g cfg
    replaceMainGoal gs
    match gs  with
    | [] => return ()
    | [g] => do
      trace[Bits.Frontend] m!"goal being decided via boolean reflection: {indentD g}"
      evalDecideCore `bv_automata_circuit (cfg := { native := true : Parser.Tactic.DecideConfig })
    | _gs => throwError m!"expected single goal after reflecting, found multiple goals. quitting"
| _ => throwUnsupportedSyntax

/-
/-- A tactic that succeeds if we have multiple widths. -/
syntax (name := bvAutomataFragmentWidthLegal) "bv_automata_fragment_width_legal" : tactic
@[tactic bvAutomataFragmentWidthLegal]
def evalBvAutomataFragmentIllegalWidth : Tactic := fun
| `(tactic| bv_automata_fragment_width_legal) => do
  let g ← getMainGoal
  g.withContext do
    let ws ← findExprBitwidths (← g.getType)
    let ws := ws.toArray
    if h0: ws.size = 0 then throwError m!"found no bitvector in the target: {indentD (← g.getType)}"
    else if hgt: ws.size > 1 then
      let (w1, wExample1) := ws[0]
      let (w2, wExample2) := ws[1]
      let mExample := m!"{w1} → {wExample1}; {w2} → {wExample2}"
      throwError m!"found multiple bitvector widths in the target: {indentD mExample}"
    else
      return ()
| _ => throwUnsupportedSyntax

/-- A tactic that succeeds if we have no uninterpreted function symbols. -/
syntax (name := bvAutomataFragmentNoUninterpreted) "bv_automata_fragment_no_uninterpreted" : tactic
@[tactic bvAutomataFragmentNoUninterpreted]
def evalBvAutomataFragmentNoUninterpreted : Tactic := fun
| `(tactic| bv_automata_fragment_no_uninterpreted) => do
  let g ← getMainGoal
  g.withContext do
    let ws ← findExprBitwidths (← g.getType)
    let ws := ws.toArray
    if h0: ws.size = 0 then
      throwError m!"found no bitvector in the target: {indentD (← g.getType)}"
    else if hgt: ws.size > 1 then
      let (w1, wExample1) := ws[0]
      let (w2, wExample2) := ws[1]
      let mExample := m!"{w1} → {wExample1}; {w2} → {wExample2}"
      throwError m!"found multiple bitvector widths in the target: {indentD mExample}"
    else
      let (w, wExample) := ws[0]
      let g ← revertBvHyps g
      -- Next, after reverting, we have a goal which we want to reflect.
      -- we convert this goal to NNF
      let .some g ← NNF.runNNFSimpSet g
        | trace[Bits.Frontend] m!"Converting to negation normal form automatically closed goal."
          return ()
      trace[Bits.Frontend] m!"goal after NNF: {indentD g}"
      let .some g ← Simplifications.runPreprocessing g
        | trace[Bits.Frontend] m!"Preprocessing automatically closed goal."
          return ()
      trace[Bits.Frontend] m!"goal after preprocessing: {indentD g}"
      -- finally, we perform reflection.
      let result ← reflectPredicateAux ∅ (← g.getType) w
      -- Order the expressions so we get stable error messages.
      let exprs := result.bvToIxMap.exprs.toArray.qsort (fun ei ej => ei.1.lt ej.1)
      let mut out? : Option MessageData := .none
      let header := m!"Tactic has not understood the following expressions, and will treat them as symbolic:"
      for (e, _) in exprs do
        if e.isFVar then continue
        let eshow := indentD m!"- '{e}'"
        out? := match out? with
          | .none => header ++ Format.line ++ eshow
          | .some out => .some (out ++ eshow)
      match out? with
      | .none => pure ()
      | .some out => throwError out
| _  => throwUnsupportedSyntax

/-- A tactic that succeeds if we have successfully reflected the goal state. -/
syntax (name := bvAutomataFragmentCheckReflected) "bv_automata_fragment_reflect" : tactic
@[tactic bvAutomataFragmentCheckReflected]
def evalBvAutomataFragmentCheckReflected : Tactic := fun
| `(tactic| bv_automata_fragment_reflect) => do
  let g ← getMainGoal
  g.withContext do
    let ws ← findExprBitwidths (← g.getType)
    let ws := ws.toArray
    -- if h0: ws.size = 0 then throwError m!"found no bitvector in the target: {indentD (← g.getType)}"
    if hgt: ws.size > 1 then
      let (w1, wExample1) := ws[0]
      let (w2, wExample2) := ws[1]
      let mExample := m!"{w1} → {wExample1}; {w2} → {wExample2}"
      throwError m!"found multiple bitvector widths in the target: {indentD mExample}"
    else
      -- Pick the width, and set the width to be dummy 0 if no widths are in play.
      let w := if h0 : ws.size = 0 then mkNatLit 0 else ws[0].fst

      -- We can now revert hypotheses that are of this bitwidth.
      let g ← revertBvHyps g

      -- Next, after reverting, we have a goal which we want to reflect.
      -- we convert this goal to NNF
      let .some g ← NNF.runNNFSimpSet g
        | trace[Bits.Frontend] m!"Converting to negation normal form automatically closed goal."
          return ()
      trace[Bits.Frontend] m!"goal after NNF: {indentD g}"

      let .some g ← Simplifications.runPreprocessing g
        | trace[Bits.Frontend] m!"Preprocessing automatically closed goal."
          return ()
      trace[Bits.Frontend] m!"goal after preprocessing: {indentD g}"
      -- finally, we perform reflection.
      let result ← reflectPredicateAux ∅ (← g.getType) w
      let bvToIxMapVal ← result.bvToIxMap.toExpr w

      let target := (mkAppN (mkConst ``Predicate.denote) #[result.e.quote, w, bvToIxMapVal])
      let g ← g.replaceTargetDefEq target
      trace[Bits.Frontend] m!"goal after reflection: {indentD g}"
      return ()
| _  => throwUnsupportedSyntax
-/

end Tactic
