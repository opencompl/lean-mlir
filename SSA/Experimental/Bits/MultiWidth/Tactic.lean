import Mathlib.Data.Fintype.Defs
import SSA.Experimental.Bits.MultiWidth.Defs

import SSA.Experimental.Bits.KInduction.KInduction
import SSA.Experimental.Bits.AutoStructs.FormulaToAuto
import SSA.Experimental.Bits.ReflectMap

initialize Lean.registerTraceClass `Bits.MultiWidth

namespace Tactic
open Lean Meta Elab Tactic


/-- Tactic options for bv_automata_circuit -/
structure Config where

/-- Default user configuration -/
def Config.default : Config := {}


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

section MkReflectMapWidth

/-#
This is the first phase of the reflection process,
which visits subterms and builds a `ReflectMap` of all expressions that are widths (i.e. `Nat` sort).

In the next phase, we will use this `ReflectMap` of widths to reflect terms and predicates.
-/


end MkReflectMapWidth


structure TotalOrder (α : Type) [Hashable α] [BEq α] where
  val2ix : Std.HashMap α Nat := ∅
  ix2val : Array α := #[]

instance [Hashable α] [BEq α] : EmptyCollection (TotalOrder α) where
  emptyCollection := {}

def TotalOrder.get? {α : Type} [Hashable α] [BEq α] (toOrder : TotalOrder α) (e : α) : Option Nat :=
  toOrder.val2ix.get? e

def TotalOrder.getD {α : Type} [Hashable α] [BEq α] (toOrder : TotalOrder α) (e : α) (d : Nat) : Nat :=
  toOrder.val2ix.getD e d

def TotalOrder.size {α : Type} [Hashable α] [BEq α] (toOrder : TotalOrder α) : Nat :=
  toOrder.val2ix.size

def TotalOrder.findOrInsertVal {α : Type} [Hashable α] [BEq α] (toOrder : TotalOrder α) (e : α) : Nat × TotalOrder α :=
  let (ix, val2ix) := match toOrder.val2ix.get? e with
    | some ix => (ix, toOrder.val2ix)
    | none =>
      let ix := toOrder.val2ix.size
      (ix, toOrder.val2ix.insert e ix)
  (ix, { toOrder with val2ix := val2ix, ix2val := toOrder.ix2val.push e })

def TotalOrder.getIx? (ix : Nat) {α : Type} [Hashable α] [BEq α] (toOrder : TotalOrder α) : Option α :=
    toOrder.ix2val[ix]?

def TotalOrder.getIxD {α : Type} [Hashable α] [BEq α]  (ix : Nat) (d : α) (toOrder : TotalOrder α) : α :=
  toOrder.ix2val.getD ix d

def TotalOrder.toArrayAsc {α : Type} [Hashable α] [BEq α] (toOrder : TotalOrder α) : Array α :=
  toOrder.ix2val


structure CollectState where
    wToIx : TotalOrder Expr := ∅
    bvToIx : TotalOrder Expr := ∅
    bvIxToWidthExpr : Std.HashMap Nat MultiWidth.Nondep.WidthExpr := ∅ -- map from BitVec to width

@[simp]
def CollectState.wcard (state : CollectState) : Nat :=
  state.wToIx.size

def CollectState.tcard (state : CollectState) : Nat :=
  state.bvToIx.size

def collectWidthAtom (state : CollectState) (e : Expr) (check? : Bool := false) :
    MetaM (MultiWidth.Nondep.WidthExpr × CollectState) := do
    if check? then
      if !(← isDefEq (← inferType e) (mkConst ``Nat)) then
        throwError m!"expected width to be a Nat, found: {indentD e}"
    let (wix, wToIx) := state.wToIx.findOrInsertVal e
    return (.ofNat wix, { state with wToIx := wToIx })

private def mkFinLit (n : Nat) (i : Nat) : Expr :=
  mkAppN (.const ``Fin.mk []) #[mkNatLit n, mkNatLit i]


/-- info: MultiWidth.WidthExpr.var {wcard : ℕ} (v : Fin wcard) : MultiWidth.WidthExpr wcard -/
#guard_msgs in #check MultiWidth.WidthExpr.var

def mkWidthExpr (wcard : Nat) (w : MultiWidth.Nondep.WidthExpr) : MetaM Expr := do
  return mkAppN (mkConst ``MultiWidth.WidthExpr.var) #[mkNatLit wcard, mkFinLit wcard w.toNat]

/-- info: MultiWidth.Term.Ctx.empty (wcard : ℕ) : MultiWidth.Term.Ctx wcard 0 -/
#guard_msgs in #check MultiWidth.Term.Ctx.empty

/--
info: MultiWidth.Term.Ctx.cons {wcard tcard : ℕ} (ctx : MultiWidth.Term.Ctx wcard tcard) (w : MultiWidth.WidthExpr wcard) :
  MultiWidth.Term.Ctx wcard (tcard + 1)
-/
#guard_msgs in #check MultiWidth.Term.Ctx.cons

/-# Reflection for BV environments, terms, and predicates. -/

/-- info: MultiWidth.Term.Ctx.empty (wcard : ℕ) : MultiWidth.Term.Ctx wcard 0 -/
#guard_msgs in #check MultiWidth.Term.Ctx.empty

/-- Build `Term.Ctx.empty`. -/
def mkTermCtxEmptyExpr (reader : CollectState) : MetaM Expr := do
  let mkEmptyCtx := mkAppN (mkConst ``MultiWidth.Term.Ctx.empty) #[mkNatLit reader.wcard]
  return mkEmptyCtx

/--
info: MultiWidth.Term.Ctx.cons {wcard tcard : ℕ} (ctx : MultiWidth.Term.Ctx wcard tcard) (w : MultiWidth.WidthExpr wcard) :
  MultiWidth.Term.Ctx wcard (tcard + 1)
-/
#guard_msgs in #check MultiWidth.Term.Ctx.cons

def mkTermCtxConsExpr (reader : CollectState) (tctx : Expr) (w : MultiWidth.Nondep.WidthExpr) : MetaM Expr := do
  return mkAppN (mkConst ``MultiWidth.Term.Ctx.cons)
    #[mkNatLit reader.wcard, mkNatLit reader.tcard,
      tctx,
      ← mkWidthExpr reader.wcard w
    ]

/-- Make the expression for the 'tctx' from the 'CollectState'. -/
def CollectState.mkTctxExpr (reader : CollectState) : MetaM Expr := do
  let mut ctx ← mkTermCtxEmptyExpr reader
  for i in [0:reader.tcard] do
    let some wexpr := reader.bvIxToWidthExpr.get? i
      | throwError "unable to find width for BitVec at index {i}"
    ctx ← mkTermCtxConsExpr reader ctx wexpr
  return ctx

/--
info: MultiWidth.Term.Ctx.Env.empty {wcard : ℕ} (wenv : Fin wcard → ℕ) (ctx : MultiWidth.Term.Ctx wcard 0) : ctx.Env wenv
-/
#guard_msgs in #check MultiWidth.Term.Ctx.Env.empty

def mkTermEnvEmpty (reader : CollectState) : MetaM Expr := do
  let emptyCtx ← mkTermCtxEmptyExpr reader
  return mkAppN (mkConst ``MultiWidth.Term.Ctx.Env.empty) #[mkNatLit reader.wcard, emptyCtx]

/--
info: MultiWidth.Term.Ctx.Env.cons {tcard wcard : ℕ} {wenv : Fin wcard → ℕ} {tctx : MultiWidth.Term.Ctx wcard tcard}
  (tenv : tctx.Env wenv) (w : MultiWidth.WidthExpr wcard) (bv : BitVec (w.toNat wenv)) : (tctx.cons w).Env wenv
-/
#guard_msgs in #check MultiWidth.Term.Ctx.Env.cons

def mkTermEnvCons (reader : CollectState) (tenv : Expr) (w : MultiWidth.Nondep.WidthExpr) (bv : Expr) : MetaM Expr := do
  return mkAppN (mkConst ``MultiWidth.Term.Ctx.Env.cons)
    #[mkNatLit reader.wcard, tenv, ← mkWidthExpr reader.wcard w, bv]

/-- Build an expression `tenv` for the `Term.Ctx.Env`. -/
def CollectState.mkTenvExpr (reader : CollectState) : MetaM Expr := do
  let mut out ← mkTermEnvEmpty reader
  for (bv, ix) in reader.bvToIx.toArrayAsc.zipIdx do
    let some wexpr := reader.bvIxToWidthExpr.get? ix
      | throwError "unable to find width for BitVec {bv} at index {ix}"
    out ← mkTermEnvCons reader out wexpr bv
  return out

/-- info: MultiWidth.WidthExpr.Env.empty : MultiWidth.WidthExpr.Env 0 -/
#guard_msgs in #check MultiWidth.WidthExpr.Env.empty

def mkWidthEnvEmpty : Expr :=
  (mkConst ``MultiWidth.WidthExpr.Env.empty)

/--
info: MultiWidth.WidthExpr.Env.cons {wcard : ℕ} (env : MultiWidth.WidthExpr.Env wcard) (w : ℕ) :
  MultiWidth.WidthExpr.Env (wcard + 1)
-/
#guard_msgs in #check MultiWidth.WidthExpr.Env.cons

def mkWidthEnvCons (wenv : Expr) (w : Expr) : MetaM Expr := do
  mkAppM ``MultiWidth.WidthExpr.Env.cons #[wenv, w]

def CollectState.mkWenvExpr (reader : CollectState) : MetaM Expr := do
  let mut out := mkWidthEnvEmpty
  for w in reader.wToIx.toArrayAsc do
    out ← mkWidthEnvCons out w
  return out

/-- Visit a raw BV expr, and collect information about it. -/
def collectBVAtom (state : CollectState)
  (e : Expr) : MetaM (MultiWidth.Nondep.Term × CollectState) := do
  let t ← inferType e
  let_expr BitVec w := t
    | throwError m!"expected type 'BitVec w', found: {indentD t} (expression: {indentD e})"
  let (wexpr, state) ← collectWidthAtom state w
  let (bvix, bvToIx) := state.bvToIx.findOrInsertVal e
  let bvIxToWidthExpr := state.bvIxToWidthExpr.insert bvix wexpr
  return (.var bvix, { state with bvToIx, bvIxToWidthExpr })

partial def collectTerm (state : CollectState) (e : Expr) :
     MetaM (MultiWidth.Nondep.Term × CollectState) := do
  match_expr e with
  | _ =>
    let (t, state) ← collectBVAtom state e -- TODO: use this?
    return (t, state)

/--
info: MultiWidth.Term.var {wcard tcard : ℕ} {tctx : MultiWidth.Term.Ctx wcard tcard} (v : Fin tcard) :
  MultiWidth.Term tctx (tctx v)
-/
#guard_msgs in #check MultiWidth.Term.var

/-- Convert a raw expression into a `Term`. -/
def mkTermExpr (wcard tcard : Nat) (tctx : Expr)
    (t : MultiWidth.Nondep.Term) : MetaM Expr := do
  match t with
  | .var v =>
    return mkAppN (mkConst ``MultiWidth.Term.var [])
      #[mkNatLit wcard, mkNatLit tcard, tctx, mkFinLit tcard v]


set_option pp.explicit true in
/--
info: ∀ {w : Nat} (a b : BitVec w), Or (@Eq (BitVec w) a b) (And (@Ne (BitVec w) a b) (@Eq (BitVec w) a b)) : Prop
-/
#guard_msgs in
#check ∀ {w : Nat} (a b : BitVec w), a = b ∨ (a ≠ b) ∧ a = b

/-- Return a new expression that this is defeq to, along with the expression of the environment that this needs, under which it will be defeq. -/
partial def collectBVPredicateAux (state : CollectState) (e : Expr) :
    MetaM (MultiWidth.Nondep.Predicate × CollectState) := do
  match_expr e with
  | Eq α a b =>
    match_expr α with
    | BitVec w =>
      let (w, state) ← collectWidthAtom state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.eq w ta tb, state)
    | _ => throwError m!"expected bitvector equality, found: {indentD e}"
  | Or p q =>
    let (ta, state) ← collectBVPredicateAux state p
    let (tb, state) ← collectBVPredicateAux state q
    return (.or ta tb, state)
  | _ =>
     throwError m!"expected predicate over bitvectors (no quantification), found:  {indentD e}"

/--
info: MultiWidth.Predicate.binRel {wcard tcard : ℕ} {ctx : MultiWidth.Term.Ctx wcard tcard} {w : MultiWidth.WidthExpr wcard}
  (k : MultiWidth.BinaryRelationKind) (a b : MultiWidth.Term ctx w) : MultiWidth.Predicate ctx
-/
#guard_msgs in #check MultiWidth.Predicate.binRel

/--
info: MultiWidth.Predicate.or {wcard tcard : ℕ} {ctx : MultiWidth.Term.Ctx wcard tcard} (p1 p2 : MultiWidth.Predicate ctx) :
  MultiWidth.Predicate ctx
-/
#guard_msgs in #check MultiWidth.Predicate.or

def mkPredicateExpr (wcard tcard : Nat) (tctx : Expr)
    (p : MultiWidth.Nondep.Predicate) : MetaM Expr := do
  match p with
  | .eq w a b =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard tctx a
    let bExpr ← mkTermExpr wcard tcard tctx b
    return mkAppN (mkConst ``MultiWidth.Predicate.binRel)
      #[mkNatLit wcard, mkNatLit tcard, tctx,
        wExpr,
        mkConst ``MultiWidth.BinaryRelationKind.eq,
        aExpr, bExpr]
  | .or p q =>
    let pExpr ← mkPredicateExpr wcard tcard tctx p
    let qExpr ← mkPredicateExpr wcard tcard tctx q
    return mkAppN (mkConst ``MultiWidth.Predicate.or)
      #[mkNatLit wcard, mkNatLit tcard, tctx, pExpr, qExpr]


/--
info: MultiWidth.Predicate.toProp {wcard tcard : ℕ} {wenv : Fin wcard → ℕ} {tctx : MultiWidth.Term.Ctx wcard tcard}
  (tenv : tctx.Env wenv) (p : MultiWidth.Predicate tctx) : Prop
-/
#guard_msgs in #check MultiWidth.Predicate.toProp

def mkPredicateToPropExpr (p : MultiWidth.Nondep.Predicate)
  (wcard tcard : Nat) (wenv : Expr) (tctx : Expr) (tenv : Expr) : MetaM Expr := do
  let pExpr ← mkPredicateExpr wcard tcard tctx p
  mkAppOptM (``MultiWidth.Predicate.toProp)
    #[(mkNatLit wcard),
      (mkNatLit tcard),
      wenv, -- wenv,
      tctx,
      tenv,
      pExpr]

/-- Name of the tactic -/
def tacName : String := "bv_multi_width"

open Std Sat AIG in

private def getBoolLit? : Expr → Option Bool
  | Expr.const ``Bool.true _  => some true
  | Expr.const ``Bool.false _ => some false
  | _                         => none

open Lean Meta Elab Tactic in
/--
Assumes that the mvar has type 'a = <true>' or 'a = <false>',
and closes this goal with 'native_decide' of a 'rfl' proof.
Assigns to the MVarId a proof.
-/
def mkEqRflNativeDecideProof (lhsExpr : Expr) (rhs : Bool) : TermElabM Expr := do
    -- hoist a₁ into a top-level definition of 'Lean.ofReduceBool' to succeed.
  let auxDeclName ← Term.mkAuxName `_mkEqRflNativeDecideProof
  let decl := Declaration.defnDecl {
    name := auxDeclName
    levelParams := []
    type := mkConst ``Bool
    value := lhsExpr
    hints := .abbrev
    safety := .safe
  }
  addAndCompile decl
  let lhsDef : Expr := mkConst auxDeclName
  let rflProof ← mkEqRefl (toExpr rhs)
  mkAppM ``Lean.ofReduceBool #[lhsDef, toExpr rhs, rflProof]


/-- Check the type of e if check? is true. -/
def debugCheck (check? : Bool) (e : Expr)  : MetaM Unit :=
    if check?
    then check e
    else return ()

open Lean Meta Elab Tactic in
def solve (g : MVarId) (_cfg : Config) : TermElabM (List MVarId) := do
  let collect : CollectState := {}
  let (p, collect) ← collectBVPredicateAux collect (← g.getType)
  let tctx ← collect.mkTctxExpr
  let wenv ← collect.mkWenvExpr
  let tenv ← collect.mkTenvExpr
  let gs ← withLocalDeclD `wenv wenv <| fun wenv => do
    withLocalDeclD `tenv tenv <| fun tenv => do
      let out ← mkPredicateToPropExpr (p := p)
        (wcard := collect.wcard)
        (tcard := collect.tcard)
        (tctx := tctx)
        (wenv := wenv)
        (tenv := tenv)
      trace[Bits.Frontend] m!"goal before reflection: {indentD g}"
      let g ← g.replaceTargetDefEq out
      return [g]
  return gs


  -- -- finally, we perform reflection.
  -- -- let predicate ← collectBVPredicateAux ∅ (← g.getType) w
  -- -- predicate.exprToIx.throwWarningIfUninterpretedExprs
  -- -- trace[Bits.Frontend] m!"predicate (repr): {indentD (repr predicate.e)}"
  -- -- let bvToIxMapVal ← predicate.exprToIx.toExpr w
  -- -- let target := (mkAppN (mkConst ``Predicate.denote) #[predicate.e.quote, w, bvToIxMapVal])
  -- -- let g ← g.replaceTargetDefEq target
  -- trace[Bits.Frontend] m!"goal after reflection: {indentD g}"
  -- let prf ← mkSorry (Expr.mvar g) (synthetic := false)
  -- if ! (← isDefEq (Expr.mvar g) prf) then
  --   throwError m!"expected goal to be defeq to the proof, but it is not: {indentD g} != {indentD prf}"
  --   return []
  -- else
  --   return []

declare_config_elab elabBvMultiWidthConfig Config

syntax (name := bvMultiWidth) "bv_multi_width" (Lean.Parser.Tactic.config)? : tactic
@[tactic bvMultiWidth]
def evalBvMultiWidth : Tactic := fun
| `(tactic| bv_multi_width $[$cfg]?) => do
  let cfg ← elabBvMultiWidthConfig (mkOptionalNode cfg)
  let g ← getMainGoal
  g.withContext do
    let gs ← solve g cfg
    replaceMainGoal gs
    match gs with
    | [] => return ()
    | [g] => do
      -- trace[Bits.Frontend] m!"goal being decided via boolean reflection: {indentD g}"
      -- evalDecideCore `bv_multi_width (cfg := { native := true : Parser.Tactic.DecideConfig })
      return
    | _gs => throwError m!"expected single goal after reflecting, found multiple goals. quitting"
| _ => throwUnsupportedSyntax


end Tactic
