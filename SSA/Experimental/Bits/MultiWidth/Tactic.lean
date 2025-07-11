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
  vals : Std.HashMap α Nat 

instance [Hashable α] [BEq α] : EmptyCollection (TotalOrder α) where
  emptyCollection := { vals := ∅ }

def TotalOrder.findOrInsert {α : Type} [Hashable α] [BEq α] (toOrder : TotalOrder α) (e : α) : Nat × TotalOrder α := 
  let (ix, vals) := match toOrder.vals.get? e with
    | some ix => (ix, toOrder.vals)
    | none =>
      let ix := toOrder.vals.size
      (ix, toOrder.vals.insert e ix)
  (ix, { toOrder with vals := vals })

def TotalOrder.toArray {α : Type} [Hashable α] [BEq α] (toOrder : TotalOrder α) : Array (α × Nat) := 
  toOrder.vals.toArray.qsort (fun a b => a.2 < b.2)

def TotalOrder.toArray_ {α : Type} [Hashable α] [BEq α] (toOrder : TotalOrder α) : Array α := 
  toOrder.toArray.map Prod.fst


/-- Get the value of an array at a given index `i`,
where the index `i` is a `Fin n` -/
private def arrayGetFin (a : Array α) (n : Nat) (hn : n = a.size) (i : Fin n) : α :=
  a[i] 

def arrayExprToExpr (a : Array Expr) (ty : Expr) : MetaM Expr := do
    let mut out := mkAppN (mkConst ``Array.empty []) #[ty]
    for e in a do
      out ← mkAppM ``Array.push #[out, e]
    return out

/-- build an expr for 'xs' as `fun (x : Fin n) => arrayGetFin xs n (by rfl) x`  -/
def exprArrayToFinEnv (xs : Array Expr) (n : Expr) : MetaM Expr := sorry

structure CollectState where
    wToIx : TotalOrder Expr
    bvToIx : TotalOrder Expr
    bvToWidth : Std.HashMap Expr Expr -- map from BitVec to width


/- TODO: type a 'ReflectMap' with some kind of ``Name to make it clear what's happening. -/ 
structure ReflectedWidth  where
  wToIx : ReflectMap
  w : MultiWidth.Nondep.WidthExpr

def collectWidthAtom (wToIx : TotalOrder Expr) (e : Expr) (check? : Bool := false) : 
    MetaM (TotalOrder Expr) := do
    if check? then
      if !(← isDefEq (← inferType e) (mkConst ``Nat)) then
        throwError m!"expected width to be a Nat, found: {indentD e}"
    let (_, wToIx) := wToIx.findOrInsert e
    return wToIx

def reflectBVAtom (reader : CollectState) (wMapExpr : Expr) (bvMapExpr : Expr) 
  (e : Expr) : MetaM Expr := do sorry

structure ReflectedTerm where
  wToIx : ReflectMap
  bvToIx : ReflectMap
  w : MultiWidth.Nondep.WidthExpr
  term : MultiWidth.Nondep.Term


def collectBVAtom (state : CollectState) 
  (e : Expr) : MetaM (CollectState) := do
  let t ← inferType e
  let_expr BitVec w := t
    | throwError m!"expected type 'BitVec w', found: {indentD t} (expression: {indentD e})"
  let wToIx ← collectWidthAtom state.wToIx w
  let (_, bvToIx) := state.bvToIx.findOrInsert e
  let bvToWidth := state.bvtoWidth.insert e w
  return { wToIx := wToIx, bvToIx := bvToIx, bvToWidth := bvToWidth }

def reflectBVAtom (reader : CollectState) (e : Expr) : MetaM Expr := do sorry


/--
Return a new expression that this is **defeq** to, along with the expression of the environment that this needs.
Crucially, when this succeeds, this will be in terms of `term`.
and furthermore, it will reflect all terms as variables.

Precondition: we assume that this is called on bitvectors.
-/
partial def reflectTermUnchecked (state : CollectState) (e : Expr) : 
     MetaM (CollectState) := do
  match_expr e with
  | _ =>
    let state ← collectBVAtom state e
    return state


set_option pp.explicit true in
/--
info: ∀ {w : Nat} (a b : BitVec w), Or (@Eq (BitVec w) a b) (And (@Ne (BitVec w) a b) (@Eq (BitVec w) a b)) : Prop
-/
#guard_msgs in
#check ∀ {w : Nat} (a b : BitVec w), a = b ∨ (a ≠ b) ∧ a = b

/-- Return a new expression that this is defeq to, along with the expression of the environment that this needs, under which it will be defeq. -/
partial def collectPredicateAux (state : CollectState) (e : Expr) : 
    MetaM (CollectState) := do
  match_expr e with
  | Eq α a b =>
    match_expr α with
    | BitVec _ =>
      let state ← reflectTermUnchecked state a
      let state ← reflectTermUnchecked state b
      return state
    | _ => throwError m!"expected bitvector equality, found: {indentD e}"
  | Or p q =>
    let state ← collectPredicateAux state p
    let state ← collectPredicateAux state q
    return state
  -- | And p q =>
  --   let p ← collectPredicateAux exprToIx p
  --   let q ← collectPredicateAux p.exprToIx q
  --   let out := Predicate.land p.e q.e
  --   return { q with e := out }
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

def getBoolLit? : Expr → Option Bool
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


/-- info: predicateEvalEqFSM (p : Predicate) : FSMPredicateSolution p -/
#guard_msgs in #check predicateEvalEqFSM
def Expr.mkPredicateEvalEqFSM (p : Expr) : Expr :=
    mkApp (.const ``predicateEvalEqFSM []) p

/--
info: FSMPredicateSolution.toFSM {p : Predicate} (self : FSMPredicateSolution p) : FSM (Fin p.arity)
-/
#guard_msgs in #check FSMPredicateSolution.toFSM
def Expr.mkToFSM (self : Expr) : MetaM Expr :=
  mkAppM ``FSMPredicateSolution.toFSM #[self]


/-- info: Subtype.val.{u} {α : Sort u} {p : α → Prop} (self : Subtype p) : α -/
#guard_msgs in #check Subtype.val
def Expr.mkSubtypeVal (e : Expr) : MetaM Expr :=
  mkAppM ``Subtype.val #[e]

/--
info: Circuit.verifyCircuit {α : Type} [DecidableEq α] [Fintype α] [Hashable α] (c : Circuit α) (cert : String) : Bool
-/
#guard_msgs in #check Circuit.verifyCircuit
def Expr.mkVerifyCircuit (c cert : Expr) : MetaM Expr :=
  mkAppM ``Circuit.verifyCircuit #[c, cert]



/--
info: ReflectVerif.BvDecide.KInductionCircuits.mkN {arity : Type} [DecidableEq arity] [Fintype arity] [Hashable arity]
  (fsm : FSM arity) (n : ℕ) : ReflectVerif.BvDecide.KInductionCircuits fsm n
-/
#guard_msgs in #check ReflectVerif.BvDecide.KInductionCircuits.mkN
def Expr.KInductionCircuits.mkN (fsm : Expr) (n : Expr) : MetaM Expr :=
  mkAppM ``ReflectVerif.BvDecide.KInductionCircuits.mkN #[fsm, n]

/--
info: ReflectVerif.BvDecide.KInductionCircuits.IsLawful_mkN {arity : Type} [DecidableEq arity] [Fintype arity]
  [Hashable arity] (fsm : FSM arity) (n : ℕ) : (ReflectVerif.BvDecide.KInductionCircuits.mkN fsm n).IsLawful
-/
#guard_msgs in #check ReflectVerif.BvDecide.KInductionCircuits.IsLawful_mkN
def Expr.KInductionCircuits.mkIsLawful_mkN (fsm : Expr) (n : Expr) : MetaM Expr :=
  mkAppM ``ReflectVerif.BvDecide.KInductionCircuits.IsLawful_mkN #[fsm, n]
/--
info: ReflectVerif.BvDecide.KInductionCircuits.mkSafetyCircuit {arity : Type} {fsm : FSM arity} [DecidableEq arity]
  [Fintype arity] [Hashable arity] {n : ℕ} (circs : ReflectVerif.BvDecide.KInductionCircuits fsm n) :
  Circuit (Vars fsm.α arity (n + 2))
-/
#guard_msgs in #check ReflectVerif.BvDecide.KInductionCircuits.mkSafetyCircuit
def Expr.KInductionCircuits.mkMkSafetyCircuit (circs : Expr) : MetaM Expr :=
  mkAppM ``ReflectVerif.BvDecide.KInductionCircuits.mkSafetyCircuit #[circs]

/--
info: ReflectVerif.BvDecide.KInductionCircuits.mkIndHypCycleBreaking {arity : Type} {fsm : FSM arity} [DecidableEq arity]
  [Fintype arity] [Hashable arity] {n : ℕ} (circs : ReflectVerif.BvDecide.KInductionCircuits fsm n) :
  Circuit (Vars fsm.α arity (n + 2))
-/
#guard_msgs in #check ReflectVerif.BvDecide.KInductionCircuits.mkIndHypCycleBreaking
def Expr.KInductionCircuits.mkIndHypCycleBreaking (circs : Expr) : MetaM Expr :=
  mkAppM ``ReflectVerif.BvDecide.KInductionCircuits.mkIndHypCycleBreaking #[circs]

/-- Check the type of e if check? is true. -/
def debugCheck (check? : Bool) (e : Expr)  : MetaM Unit :=
    if check?
    then check e
    else return ()

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
  if h0: ws.size = 0 then throwError m!"found no bitvector in the target: {indentD (← g.getType)}"
  else if hgt: ws.size > 1 then
    let (w1, wExample1) := ws[0]
    let (w2, wExample2) := ws[1]
    let mExample := m!"{w1} → {wExample1}; {w2} → {wExample2}"
    throwError m!"found multiple bitvector widths in the target: {indentD mExample}"
  else
    -- we have exactly one width
    let (w, wExample) := ws[0]

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
    let predicate ← collectPredicateAux ∅ (← g.getType) w
    predicate.exprToIx.throwWarningIfUninterpretedExprs

    trace[Bits.Frontend] m!"predicate (repr): {indentD (repr predicate.e)}"

    let bvToIxMapVal ← predicate.exprToIx.toExpr w

    let target := (mkAppN (mkConst ``Predicate.denote) #[predicate.e.quote, w, bvToIxMapVal])
    let g ← g.replaceTargetDefEq target
    trace[Bits.Frontend] m!"goal after reflection: {indentD g}"

    match cfg.backend with
    | .dryrun =>
        logInfo m!"Reflected predicate: {repr <| predicate.e}. Converting to FSM..."
        let fsm := predicateEvalEqFSM predicate.e |>.toFSM
        logInfo m!"built FSM."
        logInfo m!"FSM state space size: {fsm.stateSpaceSize}"
        logInfo m!"FSM transition circuit size: {fsm.circuitSize}"
        g.assign (← mkSorry (← g.getType) (synthetic := false))
        trace[Bits.Frontend] "Closing goal with 'sorry' for dry-run"
        return []
    | .automata =>
      let (mapFv, g) ← generalizeMap g bvToIxMapVal;
      let (_, g) ← g.revert #[mapFv]
      -- Apply Predicate.denote_of_eval_eq.
      let wVal? ← Meta.getNatValue? w
      let g ←
        -- TODO FIXME
        if false then
          pure g
        else
          -- Generic width problem.
          if !w.isFVar then
            let msg := m!"Width '{w}' is not a free variable (i.e. width is not universally quantified)."
            let msg := msg ++ Format.line ++ m!"The tactic will perform width-generic reasoning."
            let msg := msg ++ Format.line ++ m!"To perform width-specific reasoning, rewrite goal with a width constraint, e.g. ∀ (w : Nat) (hw : w = {w}), ..."
            logWarning  msg

          let [g] ← g.apply <| (mkConst ``Formula.denote_of_isUniversal)
            | throwError m!"Failed to apply `Predicate.denote_of_eval_eq` on goal '{indentD g}'"
          pure g
      let [g] ← g.apply <| (mkConst ``of_decide_eq_true)
        | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
      let [g] ← g.apply <| (mkConst ``Lean.ofReduceBool)
        | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
      return [g]
    | .circuit_cadical_verified maxIter checkTypes? =>
      let fsm := predicateEvalEqFSM predicate.e |>.toFSM
      -- logInfo m!"built FSM."
      -- logInfo m!"FSM state space size: {fsm.stateSpaceSize}"
      -- logInfo m!"FSM transition circuit size: {fsm.circuitSize}"
      let (cert?, _circuitStats) ← fsm.decideIfZerosVerified maxIter
      match cert? with
      | .provenByKIndCycleBreaking niter safetyCert indCert =>
        let prf ← g.withContext do
        /-
        theorem eval_eq_false_of_mkIndHypCycleBreaking_eval_eq_false_of_mkSafetyCircuit_eval_eq_false
          (circs : KInductionCircuits fsm K)
          (hCircs : circs.IsLawful)
          (hSafety : ∀ (env : _), (mkSafetyCircuit circs).eval env = false)
          (hIndHyp : ∀ (env : _), (mkIndHypCycleBreaking circs).eval env = false) :
          (∀ (envBitstream : _), fsm.eval envBitstream i = false) := by
        -/
          let fsmExpr ← Expr.mkToFSM (Expr.mkPredicateEvalEqFSM (toExpr predicate.e))
          let circsExpr ← Expr.KInductionCircuits.mkN fsmExpr (toExpr niter)
          let circsLawfulExpr ← Expr.KInductionCircuits.mkIsLawful_mkN fsmExpr (toExpr niter)
          -- | verifyCircuit (mkSafetyCircuit circs)
          let verifyCircuitMkSafetyCircuitExpr ← Expr.mkVerifyCircuit
            (← Expr.KInductionCircuits.mkMkSafetyCircuit circsExpr)
            (toExpr safetyCert)
          debugCheck checkTypes? verifyCircuitMkSafetyCircuitExpr
          let safetyCertProof ← mkEqRflNativeDecideProof verifyCircuitMkSafetyCircuitExpr true
          -- verifyCircuit ... = true
          debugCheck checkTypes? safetyCertProof

          let verifyCircuitMkIndHypCircuitExpr ← Expr.mkVerifyCircuit
              (← Expr.KInductionCircuits.mkIndHypCycleBreaking circsExpr)
              (toExpr indCert)
          debugCheck checkTypes? verifyCircuitMkIndHypCircuitExpr

          let indCertProof ← mkEqRflNativeDecideProof verifyCircuitMkIndHypCircuitExpr true
          debugCheck checkTypes? indCertProof

          let prf := mkAppN (mkConst ``ReflectVerif.BvDecide.KInductionCircuits.Predicate.denote_of_verifyCircuit_mkSafetyCircuit_of_verifyCircuit_mkIndHypCycleBreaking [])
            #[
              Lean.mkNatLit niter,
              predicate.e.quote,
              w,
              circsExpr,
              circsLawfulExpr,
              bvToIxMapVal,
              (toExpr safetyCert),
              safetyCertProof,
              (toExpr indCert),
              indCertProof]
          let prf ← instantiateMVars prf
          debugCheck checkTypes? prf
          pure prf
        let gs ← g.apply prf
        if gs.isEmpty
        then return gs
        else
          throwError m!"Expected proof cerificate to close goal, but failed. Leftover goals: {indentD g}"
      | .safetyFailure iter =>
        throwError  m!"Goal is false: found safety counter-example at iteration '{iter}'"
      | .exhaustedIterations niter =>
        throwError m!"Failed to prove goal in '{niter}' iterations: Try increasing number of iterations."
    | .circuit_lean =>
      let fsm := predicateEvalEqFSM predicate.e |>.toFSM
      -- trace[Bits.Frontend] f!"{fsm.format}'"
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
      let result ← collectPredicateAux ∅ (← g.getType) w
      -- Order the expressions so we get stable error messages.
      let exprs := result.exprToIx.exprs.toArray.qsort (fun ei ej => ei.1.lt ej.1)
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
    if h0: ws.size = 0 then throwError m!"found no bitvector in the target: {indentD (← g.getType)}"
    else if hgt: ws.size > 1 then
      let (w1, wExample1) := ws[0]
      let (w2, wExample2) := ws[1]
      let mExample := m!"{w1} → {wExample1}; {w2} → {wExample2}"
      throwError m!"found multiple bitvector widths in the target: {indentD mExample}"
    else
      -- we have exactly one width
      let (w, wExample) := ws[0]

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
      let result ← collectPredicateAux ∅ (← g.getType) w
      let bvToIxMapVal ← result.exprToIx.toExpr w

      let target := (mkAppN (mkConst ``Predicate.denote) #[result.e.quote, w, bvToIxMapVal])
      let g ← g.replaceTargetDefEq target
      trace[Bits.Frontend] m!"goal after reflection: {indentD g}"
      return ()
| _  => throwUnsupportedSyntax

end Tactic

macro "bv_automata_classic" : tactic => `(tactic| (bv_automata_gen (config := {backend := .automata})))

private lemma simple_test (x y : BitVec w) : x + y = y + x ∨ x = 0 := by
  bv_automata_classic

/--
info: '_private.SSA.Experimental.Bits.SingleWidth.Tactic.0.simple_test' depends on axioms: [hashMap_missing,
 propext,
 Classical.choice,
 Lean.ofReduceBool,
 Lean.trustCompiler,
 Quot.sound]
-/
#guard_msgs in
#print axioms simple_test
