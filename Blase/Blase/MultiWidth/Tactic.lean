import Mathlib.Data.Fintype.Defs
import Blase.MultiWidth.Defs
import Blase.MultiWidth.GoodFSM
import Blase.MultiWidth.Preprocessing
import Blase.KInduction.KInduction
import Blase.AutoStructs.FormulaToAuto
import Blase.ReflectMap
import Blase.Fast.Aiger

initialize Lean.registerTraceClass `Bits.MultiWidth

namespace MultiWidth
namespace Tactic
open Lean Meta Elab Tactic

/-- Whether widths should be abstracted. -/
inductive WidthAbstractionKind
/-- widths should be abstracted for `≥ the cutoff -/
| generalizeGeq (cutoff : Nat)
/-- widths should always be abstracted. -/
| always
/-- widths should never be abstracted. -/
| never
deriving DecidableEq, Repr

/-- Tactic options for bv_automata_circuit -/
structure Config where
  check? : Bool := true
  -- number of k-induction iterations.
  niter : Nat := 30
  /-- start verified at this  K-induction iteration. -/
  startVerifyAtIter : Nat := 0
  /-- debug printing verbosity. -/
  verbose?: Bool := false
  /-- By default, widths larger than 1 (ie. non boolean) are always abstracted. -/
  widthAbstraction : WidthAbstractionKind := .generalizeGeq 2
  /-- Make the final reflection proof as a 'sorry' for debugging. -/
  debugFillFinalReflectionProofWithSorry : Bool := false
  /-- Debug print the SMT-LIB version -/
  debugPrintSmtLib : Bool := false
  /-- Dump the FSM to an Aiger file. -/
  debugDumpAiger: Option String := none
deriving DecidableEq, Repr

/-- Default user configuration -/
def Config.default : Config := {}

structure Context extends Config where

abbrev SolverM := ReaderT Context TermElabM

def SolverM.run (m : SolverM α) (ctx : Context) : TermElabM α :=
  ReaderT.run m ctx

def check? : SolverM Bool := do
  return (← read).check?

/-- Log a new information message using the given message data. The position is provided by `getRef`. -/
def debugLog (msgData : MessageData) : SolverM Unit := do
  if (← read).verbose? then
    log msgData MessageSeverity.information
  else
    return ()

/-- Check the type of e if check? is true. -/
def debugCheck (e : Expr) : SolverM Unit := do
    if ← check?
    then
      check e
    else return ()


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
  match toOrder.val2ix.get? e with
    | some ix =>
      (ix, toOrder)
    | none =>
      let ix := toOrder.val2ix.size
      (ix, { toOrder with val2ix := toOrder.val2ix.insert e ix, ix2val := toOrder.ix2val.push e })

def TotalOrder.getIx? (ix : Nat) {α : Type} [Hashable α] [BEq α] (toOrder : TotalOrder α) : Option α :=
    toOrder.ix2val[ix]?

def TotalOrder.getIxD {α : Type} [Hashable α] [BEq α]  (ix : Nat) (d : α) (toOrder : TotalOrder α) : α :=
  toOrder.ix2val.getD ix d

def TotalOrder.toArrayAsc {α : Type} [Hashable α] [BEq α] (toOrder : TotalOrder α) : Array α :=
  toOrder.ix2val


structure CollectState where
    wToIx : TotalOrder Expr := ∅
    bvToIx : TotalOrder (Expr × MultiWidth.Nondep.WidthExpr) := ∅
    boolToIx : TotalOrder Expr := ∅
    pToIx : TotalOrder Expr := ∅
    nToIx : TotalOrder Expr := ∅
    iToIx : TotalOrder Expr := ∅

@[simp]
def CollectState.wcard (state : CollectState) : Nat :=
  state.wToIx.size

def CollectState.tcard (state : CollectState) : Nat :=
  state.bvToIx.size

def CollectState.bcard (state : CollectState) : Nat :=
  state.boolToIx.size

def CollectState.ncard (state : CollectState) : Nat :=
  state.nToIx.size

def CollectState.icard (state : CollectState) : Nat :=
  state.iToIx.size

def CollectState.pcard (state : CollectState) : Nat :=
  state.pToIx.size


def collectWidthAtom (state : CollectState) (e : Expr) :
    SolverM (MultiWidth.Nondep.WidthExpr × CollectState) := do
    if ← check? then
      if !(← isDefEq (← inferType e) (mkConst ``Nat)) then
        throwError m!"expected width to be a Nat, found: {indentD e}"
    -- If we do not want width abstraction, then try to interpret width as constant.
    if let .some n ← getNatValue? e then
      match (← read).widthAbstraction with
      | .never =>
        return (MultiWidth.Nondep.WidthExpr.const n, state)
      | .generalizeGeq cutoff =>
        if n < cutoff then
          return (MultiWidth.Nondep.WidthExpr.const n, state)
        else
          mkAtom
      | .always => mkAtom
    else
      mkAtom
    where
      mkAtom := do
        let (wix, wToIx) := state.wToIx.findOrInsertVal e
        -- TODO: implement 'w + K'.
        return (.var wix, { state with wToIx := wToIx })

partial def collectWidthExpr (state : CollectState) (e : Expr) :
    SolverM (MultiWidth.Nondep.WidthExpr × CollectState) := do
  if let some v ← getNatValue? e then
    return (.const v, state)
  else
    match_expr e with
    | Nat.succ n =>
      let (we, state) ← collectWidthExpr state n
      return (.addK we 1, state)
    | min nat _inst x y =>
      match_expr nat with
      | Nat =>
        let (wx, state) ← collectWidthExpr state x
        let (wy, state) ← collectWidthExpr state y
        return (.min wx wy, state)
      | _ => mkAtom
    | max nat _inst x y =>
      match_expr nat with
      | Nat =>
        let (wx, state) ← collectWidthExpr state x
        let (wy, state) ← collectWidthExpr state y
        return (.max wx wy, state)
      | _ => mkAtom
    | HAdd.hAdd _nat0 _nat1 _nat2 _inst a b =>
      match_expr _nat0 with
      | Nat =>
        match_expr _nat1 with
        | Nat =>
          match_expr _nat2 with
          | Nat => do
            if let some a ← getNatValue? a then
              let (wb, state) ← collectWidthExpr state b
              return (.kadd a wb, state)
            else
              let (wa, state) ← collectWidthExpr state a
              if let some b ← getNatValue? b then
                return (.addK wa b, state)
              else
                mkAtom
          | _ => mkAtom
        | _ => mkAtom
      | _ => mkAtom
    | _ => mkAtom
    where
      mkAtom := do
        let (we, state) ← collectWidthAtom state e
        return (we, state)

/-- info: Fin.mk {n : ℕ} (val : ℕ) (isLt : val < n) : Fin n -/
#guard_msgs in #check Fin.mk

private def mkFinLit (n : Nat) (i : Nat) : SolverM Expr := do
  let en := mkNatLit n
  let ei := mkNatLit i
  let out := mkAppN (.const ``Fin.mk []) #[en, ei, ← mkDecideProof (← mkLt ei en)]
  debugCheck out
  return out


/-- info: MultiWidth.WidthExpr.var {wcard : ℕ} (v : Fin wcard) : WidthExpr wcard -/
#guard_msgs in #check MultiWidth.WidthExpr.var

/-- info: MultiWidth.WidthExpr.min {wcard : ℕ} (v w : WidthExpr wcard) : WidthExpr wcard -/
#guard_msgs in #check MultiWidth.WidthExpr.min

/-- info: MultiWidth.WidthExpr.max {wcard : ℕ} (v w : WidthExpr wcard) : WidthExpr wcard -/
#guard_msgs in #check MultiWidth.WidthExpr.max

/-- info: MultiWidth.WidthExpr.addK {wcard : ℕ} (v : WidthExpr wcard) (k : ℕ) : WidthExpr wcard -/
#guard_msgs in #check MultiWidth.WidthExpr.addK

/- This needs to be checked carefully for equivalence. -/
def mkWidthExpr (wcard : Nat) (ve : MultiWidth.Nondep.WidthExpr) :
    SolverM Expr := do
  match ve with
  | .const w =>
    let out := mkAppN (mkConst ``MultiWidth.WidthExpr.const)
      #[mkNatLit wcard, mkNatLit w]
    debugCheck out
    return out
  | .var v =>
    let out := mkAppN (mkConst ``MultiWidth.WidthExpr.var)
      #[mkNatLit wcard, ← mkFinLit wcard v]
    debugCheck out
    return out
  | .min v w =>
    let out := mkAppN (mkConst ``MultiWidth.WidthExpr.min)
      #[mkNatLit wcard, ← mkWidthExpr wcard v, ← mkWidthExpr wcard w]
    debugCheck out
    return out
  | .max v w =>
      let out := mkAppN (mkConst ``MultiWidth.WidthExpr.max)
        #[mkNatLit wcard, ← mkWidthExpr wcard v, ← mkWidthExpr wcard w]
      debugCheck out
      return out
  | .addK v k =>
    let out := mkAppN (mkConst ``MultiWidth.WidthExpr.addK)
      #[mkNatLit wcard, ← mkWidthExpr wcard v, mkNatLit k]
    debugCheck out
    return out
  | .kadd k v =>
    let out := mkAppN (mkConst ``MultiWidth.WidthExpr.kadd)
      #[mkNatLit wcard, mkNatLit k, ← mkWidthExpr wcard v]
    debugCheck out
    return out

/-- info: MultiWidth.Term.Ctx.empty (wcard : ℕ) : Term.Ctx wcard 0 -/
#guard_msgs in #check MultiWidth.Term.Ctx.empty

/-# Reflection for BV environments, terms, and predicates. -/

/-- info: MultiWidth.Term.Ctx.empty (wcard : ℕ) : Term.Ctx wcard 0 -/
#guard_msgs in #check MultiWidth.Term.Ctx.empty

/-- Build `Term.Ctx.empty`. -/
def mkTermCtxEmptyExpr (reader : CollectState) : SolverM Expr := do
  let mkEmptyCtx := mkAppN (mkConst ``MultiWidth.Term.Ctx.empty) #[mkNatLit reader.wcard]
  debugCheck mkEmptyCtx
  return mkEmptyCtx

/--
info: MultiWidth.Term.Ctx.cons {wcard tcard : ℕ} (ctx : Term.Ctx wcard tcard) (w : WidthExpr wcard) :
  Term.Ctx wcard (tcard + 1)
-/
#guard_msgs in #check MultiWidth.Term.Ctx.cons

def mkTermCtxConsExpr (reader : CollectState) (tctx : Expr) (w : MultiWidth.Nondep.WidthExpr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.Term.Ctx.cons) #[ tctx, ← mkWidthExpr reader.wcard w ]
  debugCheck out
  return out


/-- Make the expression for the 'tctx' from the 'CollectState'. -/
def CollectState.mkTctxExpr (reader : CollectState) : SolverM Expr := do
  let mut ctx ← mkTermCtxEmptyExpr reader
  -- NOTE: this indexes backwards, as usual, we need to use De Bruijn levels vs indexes
  for (_bv, wexpr) in reader.bvToIx.toArrayAsc.reverse do
    ctx ← mkTermCtxConsExpr reader ctx wexpr
  debugCheck ctx
  return ctx

/--
info: MultiWidth.Term.Ctx.Env.empty {wcard : ℕ} (wenv : WidthExpr.Env wcard) (ctx : Term.Ctx wcard 0) : ctx.Env wenv
-/
#guard_msgs in #check MultiWidth.Term.Ctx.Env.empty

def mkTermEnvEmpty (reader : CollectState) (wenv : Expr) : SolverM Expr := do
  let emptyCtx ← mkTermCtxEmptyExpr reader
  let out := mkAppN (mkConst ``MultiWidth.Term.Ctx.Env.empty) #[mkNatLit reader.wcard, wenv, emptyCtx]
  debugCheck out
  return out

/--
info: MultiWidth.WidthExpr.toNat {wcard : ℕ} (e : WidthExpr wcard) (env : WidthExpr.Env wcard) : ℕ
-/
#guard_msgs in #check MultiWidth.WidthExpr.toNat

/--
info: MultiWidth.Term.Ctx.Env.cons {tcard wcard : ℕ} {wenv : Fin wcard → ℕ} {tctx : Term.Ctx wcard tcard}
  (tenv : tctx.Env wenv) (wexpr : WidthExpr wcard) {w : ℕ} (bv : BitVec w) (hw : w = wexpr.toNat wenv) :
  (tctx.cons wexpr).Env wenv
-/
#guard_msgs in #check MultiWidth.Term.Ctx.Env.cons

def mkTermEnvCons (reader : CollectState)
    (wenv : Expr) (tenv : Expr) (w : MultiWidth.Nondep.WidthExpr) (bv : Expr) : SolverM Expr := do
  let wexpr ← mkWidthExpr reader.wcard w
  let out ← mkAppM (``MultiWidth.Term.Ctx.Env.cons)
    #[ tenv,
      wexpr,
      bv,
      ← mkEqRefl (← mkAppM ``MultiWidth.WidthExpr.toNat #[wexpr, wenv])
      ]
  debugCheck out
  return out

/-- Build an expression `tenv` for the `Term.Ctx.Env`. -/
def CollectState.mkTenvExpr (reader : CollectState) (wenv : Expr) (_tctx : Expr) : SolverM Expr := do
  let mut out ← mkTermEnvEmpty reader (wenv := wenv)
  debugCheck out
  for ((bv, wexpr)) in reader.bvToIx.toArrayAsc.reverse do
    out ← mkTermEnvCons (reader := reader) (wenv := wenv) (tenv := out) (w := wexpr) (bv := bv)
    debugCheck out
  debugCheck out
  return out


/-- Build an expression `penv` for the `Predicate.Env`. -/
def CollectState.mkEnvExpr
    (empty : SolverM Expr)
    (cons : (env : Expr) → (x : Expr) → SolverM Expr)
    (xs : Array Expr) : SolverM Expr := do
  let mut out ← empty
  for x in xs do
    out ← cons out x
    debugCheck out
  debugCheck out
  return out


/-- info: MultiWidth.Predicate.Env.empty : Predicate.Env 0 -/
#guard_msgs in #check MultiWidth.Predicate.Env.empty

def mkPredicateEnvEmpty  : SolverM Expr := do
  let out := mkAppN (mkConst ``MultiWidth.Predicate.Env.empty) #[]
  debugCheck out
  return out

/--
info: MultiWidth.Predicate.Env.cons {pcard : ℕ} (env : Predicate.Env pcard) (p : Prop) : Predicate.Env (pcard + 1)
-/
#guard_msgs in #check MultiWidth.Predicate.Env.cons

def mkPredicateEnvCons (penv : Expr) (p : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.Predicate.Env.cons)
    #[penv, p]
  debugCheck out
  return out

/-- Build an expression `penv` for the `Predicate.Env`. -/
def CollectState.mkPenvExpr (reader : CollectState) : SolverM Expr := do
  CollectState.mkEnvExpr
    (mkPredicateEnvEmpty)
    (mkPredicateEnvCons) (reader.pToIx.toArrayAsc.reverse)

/-- info: MultiWidth.WidthExpr.Env.empty : WidthExpr.Env 0 -/
#guard_msgs in #check MultiWidth.WidthExpr.Env.empty

def mkWidthEnvEmpty : SolverM Expr := do
  let out := (mkConst ``MultiWidth.WidthExpr.Env.empty)
  debugCheck out
  return out

/--
info: MultiWidth.WidthExpr.Env.cons {wcard : ℕ} (env : WidthExpr.Env wcard) (w : ℕ) : WidthExpr.Env (wcard + 1)
-/
#guard_msgs in #check MultiWidth.WidthExpr.Env.cons

def mkWidthEnvCons (wenv : Expr) (w : Expr) : SolverM Expr := do
  let out ← mkAppM ``MultiWidth.WidthExpr.Env.cons #[wenv, w]
  debugCheck out
  return out

def CollectState.mkWenvExpr (reader : CollectState) : SolverM Expr := do
  CollectState.mkEnvExpr
    (mkWidthEnvEmpty)
    (mkWidthEnvCons) (reader.wToIx.ix2val.reverse)


/-- info: MultiWidth.Term.BoolEnv.empty : Term.BoolEnv 0 -/
#guard_msgs in #check MultiWidth.Term.BoolEnv.empty

def mkBoolEnvEmpty : SolverM Expr := do
  let out := mkAppN (mkConst ``MultiWidth.Term.BoolEnv.empty) #[]
  debugCheck out
  return out

/--
info: MultiWidth.Term.BoolEnv.cons {bcard : ℕ} (env : Term.BoolEnv bcard) (b : Bool) : Term.BoolEnv (bcard + 1)
-/
#guard_msgs in #check MultiWidth.Term.BoolEnv.cons

def mkBoolEnvCons (benv : Expr) (b : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.Term.BoolEnv.cons) #[benv, b]
  debugCheck out
  return out

def CollectState.mkBenvExpr (reader : CollectState) : SolverM Expr := do
  CollectState.mkEnvExpr
    (mkBoolEnvEmpty)
    (mkBoolEnvCons) (reader.boolToIx.toArrayAsc.reverse)

def CollectState.mkNatEnvEmpty : SolverM Expr := do
  let out := mkAppN (mkConst ``MultiWidth.Term.NatEnv.empty) #[]
  debugCheck out
  return out

def CollectState.mkNatEnvCons (nenv : Expr) (n : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.Term.NatEnv.cons) #[nenv, n]
  debugCheck out
  return out

def CollectState.mkNenvExpr (reader : CollectState) : SolverM Expr := do
  CollectState.mkEnvExpr
    (mkNatEnvEmpty)
    (mkNatEnvCons) (reader.nToIx.toArrayAsc.reverse)

def CollectState.mkIntEnvEmpty : SolverM Expr := do
  let out := mkAppN (mkConst ``MultiWidth.Term.IntEnv.empty) #[]
  debugCheck out
  return out

def CollectState.mkIntEnvCons (ienv : Expr) (i : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.Term.IntEnv.cons) #[ienv, i]
  debugCheck out
  return out

def CollectState.mkIenvExpr (reader : CollectState) : SolverM Expr := do
  CollectState.mkEnvExpr
    (mkIntEnvEmpty)
    (mkIntEnvCons) (reader.iToIx.toArrayAsc.reverse)

/-- Visit a raw BV expr, and collect information about it. -/
def collectBoolAtom (state : CollectState)
  (e : Expr) : SolverM (MultiWidth.Nondep.Term × CollectState) := do
  let t ← inferType e
  let_expr Bool := t
    | throwError m!"expected type Bool, found: {indentD t} (expression: {indentD e})"
  let (ix, boolToIx) := state.boolToIx.findOrInsertVal (e)
  return (.boolVar ix, { state with boolToIx })

def getBoolValue? (e : Expr) : Option Bool :=
  match_expr e with
  | Bool.true => some true
  | Bool.false => some false
  | _ => none

def collectBoolTerm (state : CollectState)
  (e : Expr) : SolverM (MultiWidth.Nondep.Term × CollectState) := do
  let t ← inferType e
  let_expr Bool := t
    | throwError m!"expected type 'Bool', found: {indentD t} (expression: {indentD e})"
  -- | make a boolean atom.
  if let some b := getBoolValue? e then
    return (.boolConst b, state)
  else
    mkAtom
  where
    mkAtom := do
    let (t, state) ← collectBoolAtom state e
    return (t, state)


/-- Visit a raw BV expr, and collect information about it. -/
def collectBVAtom (state : CollectState)
  (e : Expr) : SolverM (MultiWidth.Nondep.Term × CollectState) := do
  let t ← inferType e
  let_expr BitVec w := t
    | throwError m!"expected type 'BitVec w', found: {indentD t} (expression: {indentD e})"
  let (wexpr, state) ← collectWidthExpr state w
  let (bvix, bvToIx) := state.bvToIx.findOrInsertVal (e, wexpr)
  return (.var bvix wexpr, { state with bvToIx })

partial def collectTerm (state : CollectState) (e : Expr) :
     SolverM (MultiWidth.Nondep.Term × CollectState) := do
  match_expr e with
  | BitVec.ofBool bExpr =>
      let (b, state) ← collectBoolTerm state bExpr
      return (.bvOfBool b, state)
  | BitVec.ofNat wExpr nExpr =>
    let (w, state) ← collectWidthExpr state wExpr
    if let some n ← getNatValue? nExpr then
      return (.ofNat w n, state)
    else
      mkAtom
  | HAdd.hAdd _bv _bv _bv _inst a b =>
    match_expr _bv with
    | BitVec w =>
      let (w, state) ← collectWidthExpr state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.add w ta tb, state)
    | _ => mkAtom
  | BitVec.zeroExtend _w v x =>
      let (v, state) ← collectWidthExpr state v
      let (x, state) ← collectTerm state x
      return (.zext x v, state)
  | BitVec.setWidth _w v x =>
      let (v, state) ← collectWidthExpr state v
      let (x, state) ← collectTerm state x
      return (.setWidth x v, state)
  | BitVec.signExtend _w v x =>
      let (v, state) ← collectWidthExpr state v
      let (x, state) ← collectTerm state x
      return (.sext x v, state)
  | HXor.hXor _bv _bv _bv _inst a b =>
    match_expr _bv with
    | BitVec w =>
      let (w, state) ← collectWidthExpr state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.bxor w ta tb, state)
    | _ => mkAtom
  | HAnd.hAnd _bv _bv _bv _inst a b =>
    match_expr _bv with
    | BitVec w =>
      let (w, state) ← collectWidthExpr state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.band w ta tb, state)
    | _ => mkAtom
  | HOr.hOr _bv _bv _bv _inst a b =>
    match_expr _bv with
    | BitVec w =>
      let (w, state) ← collectWidthExpr state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.bor w ta tb, state)
    | _ => mkAtom
  | Complement.complement bv _inst a =>
    match_expr bv with
    | BitVec w =>
      let (w, state) ← collectWidthExpr state w
      let (ta, state) ← collectTerm state a
      return (.bnot w ta, state)
    | _ => mkAtom
  | HShiftLeft.hShiftLeft _bv _nat _bv _inst a n =>
    match_expr _bv with
    | BitVec w =>
      match_expr _nat with
      | Nat =>
        let (w, state) ← collectWidthExpr state w
        let (ta, state) ← collectTerm state a
        if let some nn ← getNatValue? n then
          return (.shiftl w ta nn, state)
        else
          mkAtom
      | _ => mkAtom
    | _ => mkAtom
  | _ => mkAtom
  where
    mkAtom := do
      let (t, state) ← collectBVAtom state e
      return (t, state)

/--
info: MultiWidth.Term.var {wcard tcard bcard ncard icard pcard : Nat} {tctx : Term.Ctx wcard tcard} (v : Fin tcard) :
  @Term wcard tcard bcard ncard icard pcard tctx (@TermKind.bv wcard (tctx v))
-/
#guard_msgs in set_option pp.explicit true in #check MultiWidth.Term.var

/--
info: MultiWidth.Term.ofNat {wcard tcard bcard ncard icard pcard : Nat} {tctx : Term.Ctx wcard tcard} (w : WidthExpr wcard)
  (n : Nat) : @Term wcard tcard bcard ncard icard pcard tctx (@TermKind.bv wcard w)
-/
#guard_msgs in set_option pp.explicit true in #check MultiWidth.Term.ofNat

/--
info: MultiWidth.Term.bvOfBool {wcard tcard bcard ncard icard pcard : Nat} {tctx : Term.Ctx wcard tcard}
  (b : @Term wcard tcard bcard ncard icard pcard tctx (@TermKind.bool wcard)) :
  @Term wcard tcard bcard ncard icard pcard tctx
    (@TermKind.bv wcard (@WidthExpr.const wcard (@OfNat.ofNat Nat (nat_lit 1) (instOfNatNat (nat_lit 1)))))
-/
#guard_msgs in set_option pp.explicit true in #check MultiWidth.Term.bvOfBool

/-- Convert a raw expression into a `Term`.
This needs to be checked carefully for equivalence. -/
def mkTermExpr (wcard tcard bcard ncard icard pcard : Nat) (tctx : Expr)
    (t : MultiWidth.Nondep.Term) : SolverM Expr := do
  match t with
  | .bvOfBool b =>
    let bExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Term.bvOfBool [])
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx, bExpr]
    debugCheck out
    return out
  | .ofNat w n =>
    let wExpr ← mkWidthExpr wcard w
    let out := mkAppN (mkConst ``MultiWidth.Term.ofNat [])
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx, wExpr, mkNatLit n]
    debugCheck out
    return out
  | .var v _wexpr =>
    let out := mkAppN (mkConst ``MultiWidth.Term.var [])
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx, ← mkFinLit tcard v]
    debugCheck out
    return out
  | .add _w a b =>
     let out ← mkAppM ``MultiWidth.Term.add
        #[← mkTermExpr wcard tcard bcard ncard icard pcard tctx a,
        ← mkTermExpr wcard tcard bcard ncard icard pcard tctx b]
     debugCheck out
     return out
  | .zext a v =>
    let vExpr ← mkWidthExpr wcard v
    let out ← mkAppM ``MultiWidth.Term.zext
      #[← mkTermExpr wcard tcard bcard ncard icard pcard tctx a, vExpr]
    debugCheck out
    return out
  | .setWidth a v =>
    let vExpr ← mkWidthExpr wcard v
    let out ← mkAppM ``MultiWidth.Term.setWidth
      #[← mkTermExpr wcard tcard bcard ncard icard pcard tctx a, vExpr]
    debugCheck out
    return out
  | .sext a v =>
    let vExpr ← mkWidthExpr wcard v
    let out ← mkAppM ``MultiWidth.Term.sext
      #[← mkTermExpr wcard tcard bcard ncard icard pcard tctx a, vExpr]
    debugCheck out
    return out
  | .band w a b =>
      let wExpr ← mkWidthExpr wcard w
      let aExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx a
      let bExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx b
      let out := mkAppN (mkConst ``MultiWidth.Term.band)
        #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx,
          wExpr, aExpr, bExpr]
      debugCheck out
      return out
  | .bor w a b =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx a
    let bExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Term.bor)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx,
        wExpr, aExpr, bExpr]
    debugCheck out
    return out
  | .bxor w a b =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx a
    let bExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Term.bxor)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx,
        wExpr, aExpr, bExpr]
    debugCheck out
    return out
  | .bnot w a =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx a
    let out := mkAppN (mkConst ``MultiWidth.Term.bnot)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx,
        wExpr, aExpr]
    debugCheck out
    return out
  | .boolVar v =>
    let out := mkAppN (mkConst ``MultiWidth.Term.boolVar [])
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx,
        ← mkFinLit bcard v]
    debugCheck out
    return out
  | .boolConst b =>
    let out := mkAppN (mkConst ``MultiWidth.Term.boolConst [])
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx,
        mkBoolLit b]
    debugCheck out
    return out
  | .shiftl w a n =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx a
    let nExpr := mkNatLit n
    let out := mkAppN (mkConst ``MultiWidth.Term.shiftl)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx,
        wExpr, aExpr, nExpr]
    debugCheck out
    return out
  | _ => throwError m!"mkTermExpr: unsupported term: {repr t}"

set_option pp.explicit true in
/--
info: ∀ {w : Nat} (a b : BitVec w), Or (@Eq (BitVec w) a b) (And (@Ne (BitVec w) a b) (@Eq (BitVec w) a b)) : Prop
-/
#guard_msgs in
#check ∀ {w : Nat} (a b : BitVec w), a = b ∨ (a ≠ b) ∧ a = b


/-- Visit a raw BV expr, and collect information about it. -/
def collectPredicateAtom (state : CollectState)
  (e : Expr) : SolverM (MultiWidth.Nondep.Term × CollectState) := do
  let t ← inferType e
  if !t.isProp then
    throwError m!"expected type 'Prop', found: {t} (expression: {indentD e})"
  let (pix, pToIx) := state.pToIx.findOrInsertVal e
  return (.pvar pix, { state with pToIx })

/-
Certain predicates like `ult, slt` etc return booleans, and are thus
encoded as `a.slt b = true` instead of a prop level `a.slt b`.
To fix this, we have a special case in the reflection that looks for this pattern,
and then reflects it into the appropriate prop.
-/
def collectBVBooleanEqPredicateAux (state : CollectState) (a b : Expr) :
  Option (SolverM (MultiWidth.Nondep.Term × CollectState)) :=
  let_expr true := b | none
  let out? := match_expr a with
    | BitVec.slt w x y => some (w, MultiWidth.BinaryRelationKind.slt, x, y)
    | BitVec.sle w x y => some (w, MultiWidth.BinaryRelationKind.sle, x, y)
    | BitVec.ult w x y => some (w, MultiWidth.BinaryRelationKind.ult, x, y)
    | BitVec.ule w x y => some (w, MultiWidth.BinaryRelationKind.ule, x, y)
    | _ => none
  -- NOTE: Lean bug prevents us from writing this with do-notation,
  -- so we suffer as haskellers once did.
  out? >>= fun ((w, kind, x, y)) => some do
    let (w, state) ← collectWidthExpr state w
    let (tx, state) ← collectTerm state x
    let (ty, state) ← collectTerm state y
    pure (.binRel kind w tx ty, state)

/-- Return a new expression that this is defeq to, along with the expression of the environment that this needs, under which it will be defeq. -/
partial def collectBVPredicateAux (state : CollectState) (e : Expr) :
    SolverM (MultiWidth.Nondep.Term × CollectState) := do
  match_expr e with
  | LE.le α _inst v w =>
    match_expr α with
    | Nat =>
      let (v, state) ← collectWidthExpr state v
      let (w, state) ← collectWidthExpr state w
      return (.binWidthRel .le v w, state)
    | _ =>
      debugLog m!"expected (· ≤ ·) for natural numbers, found:  {indentD e}, so abstracting over expression."
      mkAtom
  | Eq α a b =>
    match_expr α with
    | Nat =>
      let (a, state) ← collectWidthExpr state a
      let (b, state) ← collectWidthExpr state b
      return (.binWidthRel .eq a b, state)
    | BitVec w =>
      let (w, state) ← collectWidthExpr state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.binRel .eq w ta tb, state)
    | Bool =>
      -- | TODO: Refactor to use our spanky new bool sort!
      if let .some mkBoolPredicate := collectBVBooleanEqPredicateAux state a b then
        mkBoolPredicate
      else
        let (a, state) ← collectBoolTerm state a
        let (b, state) ← collectBoolTerm state b
        return (.boolBinRel .eq a b, state)
    | _ => mkAtom
  | Ne α a b =>
    match_expr α with
    | BitVec w =>
      let (w, state) ← collectWidthExpr state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.binRel .ne w ta tb, state)
    | _ => collectPredicateAtom state e
  | Or p q =>
    let (ta, state) ← collectBVPredicateAux state p
    let (tb, state) ← collectBVPredicateAux state q
    return (.or ta tb, state)
  | And p q =>
    let (ta, state) ← collectBVPredicateAux state p
    let (tb, state) ← collectBVPredicateAux state q
    return (.and ta tb, state)
  | _ =>
    mkAtom
  where
    mkAtom := do
      let (t, state) ← collectPredicateAtom state e
      return (t, state)

/--
info: MultiWidth.Term.binRel {wcard tcard bcard ncard icard pcard : Nat} {tctx : Term.Ctx wcard tcard}
  (k : BinaryRelationKind) (w : WidthExpr wcard)
  (a b : @Term wcard tcard bcard ncard icard pcard tctx (@TermKind.bv wcard w)) :
  @Term wcard tcard bcard ncard icard pcard tctx (@TermKind.prop wcard)
-/
#guard_msgs in set_option pp.explicit true in #check MultiWidth.Term.binRel

/--
info: MultiWidth.Term.or {wcard tcard bcard ncard icard pcard : ℕ} {tctx : Term.Ctx wcard tcard}
  (p1 p2 : Term bcard ncard icard pcard tctx TermKind.prop) : Term bcard ncard icard pcard tctx TermKind.prop
-/
#guard_msgs in #check MultiWidth.Term.or


/--
info: MultiWidth.Term.var {wcard tcard bcard ncard icard pcard : ℕ} {tctx : Term.Ctx wcard tcard} (v : Fin tcard) :
  Term bcard ncard icard pcard tctx (TermKind.bv (tctx v))
-/
#guard_msgs in #check MultiWidth.Term.var


/--
info: MultiWidth.Term.binWidthRel {wcard tcard bcard ncard icard pcard : ℕ} {tctx : Term.Ctx wcard tcard}
  (k : WidthBinaryRelationKind) (wa wb : WidthExpr wcard) : Term bcard ncard icard pcard tctx TermKind.prop
-/
#guard_msgs in #check MultiWidth.Term.binWidthRel


/--
info: MultiWidth.Term.boolBinRel {wcard tcard bcard ncard icard pcard : ℕ} {tctx : Term.Ctx wcard tcard}
  (k : BoolBinaryRelationKind) (a b : Term bcard ncard icard pcard tctx TermKind.bool) :
  Term bcard ncard icard pcard tctx TermKind.prop
-/
#guard_msgs in #check MultiWidth.Term.boolBinRel


def Expr.mkPredicateExpr (wcard tcard bcard ncard icard pcard : Nat) (tctx : Expr)
  (p : MultiWidth.Nondep.Term) : SolverM Expr := do
  match p with
  | .binRel k w a b =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx a
    let bExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Term.binRel)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard,
        tctx,
        toExpr k,
        wExpr, aExpr, bExpr]
    debugCheck out
    return out
  | .binWidthRel k v w =>
    let vExpr ← mkWidthExpr wcard v
    let wExpr ← mkWidthExpr wcard w
    let out := mkAppN (mkConst ``MultiWidth.Term.binWidthRel)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard,
        tctx,
        Lean.toExpr k, vExpr, wExpr]
    debugCheck out
    return out
  | .or p q =>
    let pExpr ← mkPredicateExpr wcard tcard bcard ncard icard pcard tctx p
    let qExpr ← mkPredicateExpr wcard tcard bcard ncard icard pcard tctx q
    let out := mkAppN (mkConst ``MultiWidth.Term.or)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx, pExpr, qExpr]
    debugCheck out
    return out
  | .and p q =>
    let pExpr ← mkPredicateExpr wcard tcard bcard ncard icard pcard tctx p
    let qExpr ← mkPredicateExpr wcard tcard bcard ncard icard pcard tctx q
    let out := mkAppN (mkConst ``MultiWidth.Term.and)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx, pExpr, qExpr]
    debugCheck out
    return out
  | .boolBinRel k a b =>
    let aExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx a
    let bExpr ← mkTermExpr wcard tcard bcard ncard icard pcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Term.boolBinRel)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx,
        Lean.toExpr k, aExpr, bExpr]
    debugCheck out
    return out
  | .pvar v =>
    let out := mkAppN (mkConst ``MultiWidth.Term.pvar)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, mkNatLit ncard, mkNatLit icard, mkNatLit pcard, tctx, ← mkFinLit pcard v]
    debugCheck out
    return out
  | _ => throwError m!"unsupported predicate term: {indentD <| repr p}"
/-- error: Unknown identifier `MultiWidth.Predicate.toProp` -/
#guard_msgs in #check MultiWidth.Predicate.toProp

def Expr.mkPredicateToPropExpr (pExpr : Expr)
  (_wcard _tcard _bcard _pcard : Nat) (_wenv : Expr) (_tctx : Expr) (tenv : Expr) (penv : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.Term) #[tenv, penv, pExpr]
  debugCheck out
  return out

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
def mkEqReflBoolNativeDecideProof (name : Name) (lhsExpr : Expr) (rhs : Bool) (debugSorry? : Bool := false) : SolverM Expr := do
    -- hoist a₁ into a top-level definition of 'Lean.ofReduceBool' to succeed.
  let name := name ++ `lhs
  let auxDeclName ← Term.mkAuxName name
  let decl := Declaration.defnDecl {
    name := auxDeclName
    levelParams := []
    type := mkConst ``Bool
    value := lhsExpr
    hints := .abbrev
    safety := .safe
  }
  addAndCompile decl
  -- debugLog m!"declared {lhsExpr} as {auxDeclName}"
  debugLog m!"declared {auxDeclName} equality native decide proof."
  let lhsDef : Expr := mkConst auxDeclName
  let rflProof ← mkEqRefl (toExpr rhs)
  -- let rflProof := mkApp2 (mkConst ``Eq.refl [Level.ofNat 1]) (mkConst ``Bool []) (toExpr rhs)
  let rflTy := mkApp3 (mkConst ``Eq [Level.ofNat 1]) (mkConst ``Bool []) lhsExpr (toExpr rhs)
  let sorryProof ← mkSorry (type := rflTy) (synthetic := true)
  let proof := mkApp3 (mkConst ``Lean.ofReduceBool []) lhsDef (toExpr rhs) rflProof
  return if debugSorry? then sorryProof else proof

def mkEqReflNativeDecideProof (name : Name) (tyExpr : Expr)
    (lhsSmallExpr : Expr) (rhsLargeExpr : Expr)
    (debugSorry? : Bool := false) : SolverM Expr := do
    -- hoist a₁ into a top-level definition of 'Lean.ofReduceBool' to succeed.
  let name := name ++ `eqProof
  let auxDeclName ← Term.mkAuxName name
  let rflTy := mkApp3 (mkConst ``Eq [Level.ofNat 1]) tyExpr lhsSmallExpr rhsLargeExpr
  let rflProof ← mkEqRefl rhsLargeExpr
  let sorryProof ← mkSorry (type := rflTy) (synthetic := true)
  let proof := if debugSorry? then sorryProof else rflProof
  let decl := Declaration.defnDecl {
    name := auxDeclName
    levelParams := []
    type := rflTy
    value := proof
    hints := .abbrev
    safety := .safe
  }
  addAndCompile decl
  return (mkConst auxDeclName)

def mkDecideTy : SolverM Expr := do
  let ty ← mkEq (mkNatLit 1) (mkNatLit 1)
  debugCheck ty
  return ty

def CollectState.logSuspiciousFvars (state : CollectState) : SolverM (Array Expr) := do
  let mut exprs := #[]
  for (e, _w) in state.bvToIx.toArrayAsc do
    if !e.isFVar then
      logWarning m!"abstracted non-variable bitvector: {indentD <| "→ '" ++ toMessageData e ++ "'"}"
      exprs := exprs.push e
  for e in state.wToIx.toArrayAsc do
    if !e.isFVar then
      logWarning m!"abstracted non-variable width: {indentD <| "→ '" ++ toMessageData e ++ "'"}"
      exprs := exprs.push e
  for e in state.pToIx.toArrayAsc do
    if !e.isFVar then
      logWarning m!"abstracted prop: {indentD <| "→ '" ++ toMessageData e ++ "'"}"
      exprs := exprs.push e
  for e in state.boolToIx.toArrayAsc do
    if !e.isFVar then
      logWarning m!"abstracted boolean: {indentD <| "→ '" ++ toMessageData e ++ "'"}"
      exprs := exprs.push e
  return exprs

/--
info: Circuit.verifyCircuit {α : Type} [DecidableEq α] [Fintype α] [Hashable α] (c : Circuit α) (cert : String) : Bool
-/
#guard_msgs in #check Circuit.verifyCircuit
def Expr.mkVerifyCircuit (c cert : Expr) : SolverM Expr := do
  let out ← mkAppM ``Circuit.verifyCircuit #[c, cert]
  debugCheck out
  return out

/--
info: ReflectVerif.BvDecide.KInductionCircuits.mkN {arity : Type} [DecidableEq arity] [Fintype arity] [Hashable arity]
  (fsm : FSM arity) (n : ℕ) : ReflectVerif.BvDecide.KInductionCircuits fsm n
-/
#guard_msgs in #check ReflectVerif.BvDecide.KInductionCircuits.mkN
def Expr.KInductionCircuits.mkN (fsm : Expr) (n : Expr) : SolverM Expr := do
  let out ← mkAppM ``ReflectVerif.BvDecide.KInductionCircuits.mkN #[fsm, n]
  debugCheck out
  return out

/--
info: ReflectVerif.BvDecide.KInductionCircuits.IsLawful_mkN {arity : Type} [DecidableEq arity] [Fintype arity]
  [Hashable arity] (fsm : FSM arity) (n : ℕ) : (ReflectVerif.BvDecide.KInductionCircuits.mkN fsm n).IsLawful
-/
#guard_msgs in #check ReflectVerif.BvDecide.KInductionCircuits.IsLawful_mkN
def Expr.KInductionCircuits.mkIsLawful_mkN (fsm : Expr) (n : Expr) : SolverM Expr := do
  let out ← mkAppM ``ReflectVerif.BvDecide.KInductionCircuits.IsLawful_mkN #[fsm, n]
  debugCheck out
  return out
/--
info: ReflectVerif.BvDecide.KInductionCircuits.mkSafetyCircuit {arity : Type} {fsm : FSM arity} [DecidableEq arity]
  [Fintype arity] [Hashable arity] {n : ℕ} (circs : ReflectVerif.BvDecide.KInductionCircuits fsm n) :
  Circuit (Vars fsm.α arity (n + 2))
-/
#guard_msgs in #check ReflectVerif.BvDecide.KInductionCircuits.mkSafetyCircuit
def Expr.KInductionCircuits.mkMkSafetyCircuit (circs : Expr) : SolverM Expr := do
  let out ← mkAppM ``ReflectVerif.BvDecide.KInductionCircuits.mkSafetyCircuit #[circs]
  debugCheck out
  return out

/--
info: ReflectVerif.BvDecide.KInductionCircuits.mkIndHypCycleBreaking {arity : Type} {fsm : FSM arity} [DecidableEq arity]
  [Fintype arity] [Hashable arity] {n : ℕ} (circs : ReflectVerif.BvDecide.KInductionCircuits fsm n) :
  Circuit (Vars fsm.α arity (n + 2))
-/
#guard_msgs in #check ReflectVerif.BvDecide.KInductionCircuits.mkIndHypCycleBreaking
def Expr.KInductionCircuits.mkIndHypCycleBreaking (circs : Expr) : SolverM Expr := do
  let out ← mkAppM ``ReflectVerif.BvDecide.KInductionCircuits.mkIndHypCycleBreaking #[circs]
  debugCheck out
  return out

/--
info: MultiWidth.mkPredicateFSMDep {wcard tcard bcard ncard icard pcard : ℕ} {tctx : Term.Ctx wcard tcard}
  (p : Term bcard ncard icard pcard tctx TermKind.prop) :
  TermFSM wcard tcard bcard ncard icard pcard (Nondep.Term.ofDepTerm p)
-/
#guard_msgs in #check MultiWidth.mkPredicateFSMDep
def Expr.mkPredicateFSMDep (_wcard _tcard _bcard _pcard : Nat) (_tctx : Expr) (p : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.mkPredicateFSMDep) #[p]
  debugCheck out
  return out

/--
info: MultiWidth.mkTermFsmNondep (wcard tcard bcard ncard icard pcard : ℕ) (p : Nondep.Term) :
  TermFSM wcard tcard bcard ncard icard pcard p
-/
#guard_msgs in #check mkTermFsmNondep
def Expr.mkTermFsmNondep (wcard tcard bcard ncard icard pcard : Nat) (pNondep : Expr) : SolverM Expr := do
  let out ← mkAppM (``mkTermFsmNondep) #[toExpr wcard, toExpr tcard, toExpr bcard, toExpr ncard, toExpr icard, toExpr pcard, pNondep]
  debugCheck out
  return out

/--
info: MultiWidth.Term.toBV_of_KInductionCircuits {wcard tcard bcard ncard icard pcard : ℕ} (tctx : Term.Ctx wcard tcard)
  (p : Term bcard ncard icard pcard tctx TermKind.prop) (pNondep : Nondep.Term)
  (_hpNondep : pNondep = Nondep.Term.ofDepTerm p) (fsm : TermFSM wcard tcard bcard ncard icard pcard pNondep)
  (_hfsm : fsm = mkTermFsmNondep wcard tcard bcard ncard icard pcard pNondep) (n : ℕ)
  (circs : ReflectVerif.BvDecide.KInductionCircuits fsm.toFsmZext n) (hCircs : circs.IsLawful)
  (sCert : BVDecide.Frontend.LratCert) (hs : circs.mkSafetyCircuit.verifyCircuit sCert = true)
  (indCert : BVDecide.Frontend.LratCert) (hind : circs.mkIndHypCycleBreaking.verifyCircuit indCert = true)
  (wenv : WidthExpr.Env wcard) (penv : Predicate.Env pcard) (tenv : tctx.Env wenv) (benv : Term.BoolEnv bcard)
  (nenv : Term.NatEnv ncard) (ienv : Term.IntEnv icard) : Term.toBV benv nenv ienv penv tenv p
-/
#guard_msgs in #check MultiWidth.Term.toBV_of_KInductionCircuits

/--
Revert all prop-valued hyps.
-/
def revertNonDepPropHyps (g : MVarId) : MetaM MVarId := do
  g.withContext do
    let (_, g) ← g.revert (← g.getNondepPropHyps)
    return g

open Lean Meta Elab Tactic in
def solve (gorig : MVarId) : SolverM Unit := do
  -- debugLog m!"Original goal: {indentD g}"
  -- let g ← revertNonDepPropHyps g
  -- debugLog m!"Goal after reverting: {indentD g}"
  match ← gorig.withContext (Normalize.runPreprocessing gorig) with
  | none => debugLog m!"Preprocessing automatically closed goal."
  | some g => g.withContext do
    debugLog m!"goal after preprocessing: {indentD g}"
    let collect : CollectState := {}
    let pRawExpr ← inferType (.mvar g)
    debugLog m!"collecting raw expr '{pRawExpr}'."
    let (p, collect) ← collectBVPredicateAux collect pRawExpr
    debugLog m!"collected predicate: '{repr p}' for raw expr."
    let tctx ← collect.mkTctxExpr
    let wenv ← collect.mkWenvExpr
    let tenv ← collect.mkTenvExpr (wenv := wenv) (_tctx := tctx)
    let benv ← collect.mkBenvExpr
    let nenv ← collect.mkNenvExpr
    let ienv ← collect.mkIenvExpr
    let penv ← collect.mkPenvExpr
    if (← read).debugPrintSmtLib then
      throwError (p.toSmtLib |>.toSexpr |> format)
    let pExpr ← Expr.mkPredicateExpr collect.wcard collect.tcard collect.bcard collect.ncard collect.icard collect.pcard tctx p
    let pNondepExpr := Lean.ToExpr.toExpr p
    let termFsmNondep := mkTermFsmNondep collect.wcard collect.tcard collect.bcard collect.ncard collect.icard collect.pcard p
    debugLog m!"fsm from MultiWidth.mkTermFsmNondep {collect.wcard} {collect.tcard} {repr p}."
    debugLog m!"fsm circuit size: {termFsmNondep.toFsmZext.circuitSize}"
    if ! (← isDefEq pRawExpr (← mkAppM ``Term.toBV #[benv, nenv, ienv, penv, tenv, pExpr])) then
      throwError m!"internal error: collected predicate expression does not match original predicate. Collected: {indentD pExpr}, original: {indentD pRawExpr}"
    let (stats, _log) ← FSM.decideIfZerosVerified termFsmNondep.toFsmZext (maxIter := (← read).niter) (startVerifyAtIter := (← read).startVerifyAtIter)
    if let some filename := (← read).debugDumpAiger then
      let fn := System.mkFilePath [filename]
      let handle ← IO.FS.Handle.mk fn IO.FS.Mode.write
      let stream := IO.FS.Stream.ofHandle handle
      termFsmNondep.toFsmZext.toAiger.toAagFile stream

    let (stats, _log) ← FSM.decideIfZerosVerified termFsmNondep.toFsmZext (maxIter := (← read).niter) (startVerifyAtIter := (← read).startVerifyAtIter)
    match stats with
    | .safetyFailure i =>
      let suspiciousVars ← collect.logSuspiciousFvars
      -- | Found precise counter-example to claimed predicate.
      if suspiciousVars.isEmpty then
          throwError m!"CEX: Found exact counter-example at iteration {i} for predicate '{pRawExpr}'"
        else
          throwError m!"MAYCEX: Found possible counter-example at iteration {i} for predicate '{pRawExpr}'"
    | .exhaustedIterations _ =>
      let _ ← collect.logSuspiciousFvars
      throwError m!"PROOFNOTFOUND: exhausted iterations for predicate '{pRawExpr}'"
    | .provenByKIndCycleBreaking niters safetyCert indCert =>
      if (← read).verbose? then
        let _ ← collect.logSuspiciousFvars
      debugLog m!"PROVE: proven {pRawExpr}"
      let prf ← g.withContext <| do
        let termNondepFsmExpr ← Expr.mkTermFsmNondep collect.wcard collect.tcard collect.bcard collect.ncard collect.icard collect.pcard pNondepExpr
        debugCheck termNondepFsmExpr
        -- let fsmExpr := termNondepFsmExpr
        -- | TODO: refactor into fn.
        let fsmExpr ← mkAppM (``MultiWidth.TermFSM.toFsmZext) #[termNondepFsmExpr]
        -- debugCheck fsmExpr
        let circsExpr ← Expr.KInductionCircuits.mkN fsmExpr (toExpr niters)
        let circsLawfulExpr ← Expr.KInductionCircuits.mkIsLawful_mkN fsmExpr (toExpr niters)
        debugLog "making safety certs..."
        -- | verifyCircuit (mkSafetyCircuit circs)
        let verifyCircuitMkSafetyCircuitExpr ← Expr.mkVerifyCircuit
          (← Expr.KInductionCircuits.mkMkSafetyCircuit circsExpr)
          (toExpr safetyCert)
        -- debugLog m!"made safety cert expr: {verifyCircuitMkSafetyCircuitExpr}"
        debugLog "making safety cert = true proof..."
        let safetyCertProof ←
          mkEqReflBoolNativeDecideProof `safetyCert verifyCircuitMkSafetyCircuitExpr true
        -- debugLog m!"made safety cert proof: {safetyCertProof}"
        let verifyCircuitMkIndHypCircuitExpr ← Expr.mkVerifyCircuit
            (← Expr.KInductionCircuits.mkIndHypCycleBreaking circsExpr)
            (toExpr indCert)
        -- debugLog m!"made verifyCircuit expr: {verifyCircuitMkIndHypCircuitExpr}"
        let indCertProof ←
          mkEqReflBoolNativeDecideProof `indCert verifyCircuitMkIndHypCircuitExpr true
        debugLog m!"made induction cert = true proof..."
        let prf ← mkAppM ``MultiWidth.Term.toBV_of_KInductionCircuits'
          #[pRawExpr, -- P : Prop
            tctx,
            pExpr, -- p
            pNondepExpr, -- pNondep
            ← mkEqRefl pNondepExpr, -- pNondep = .ofDepTerm p
            termNondepFsmExpr, -- TermFSM ...
            ← mkEqRefl termNondepFsmExpr,
            toExpr niters,
            circsExpr,
            circsLawfulExpr,
            toExpr safetyCert,
            safetyCertProof,
            toExpr indCert,
            indCertProof,
            wenv,
            tenv,
            benv,
            nenv,
            ienv,
            penv,
            ← mkEqRefl pRawExpr]
        debugCheck prf
        let prf ←
          if (← read).debugFillFinalReflectionProofWithSorry then
            mkSorry (synthetic := true) (← g.getType)
          else
            instantiateMVars prf
        pure prf
      let gs ← g.apply prf
      if gs.isEmpty then
        debugLog m!"unified goal with proof."
      else
        let mut msg := m!"Expected proof cerificate to close goal, but failed. Leftover goals:"
        for g in gs do
          msg := msg ++ m!"{indentD g}"
        throwError msg

def solveEntrypoint (g : MVarId) (cfg : Config) : TermElabM Unit :=
  let ctx := { toConfig := cfg}
  SolverM.run (ctx := ctx) (solve g)

declare_config_elab elabBvMultiWidthConfig Config

syntax (name := bvMultiWidth) "bv_multi_width" Lean.Parser.Tactic.optConfig : tactic
@[tactic bvMultiWidth]
def evalBvMultiWidth : Tactic := fun
| `(tactic| bv_multi_width $cfg) => do
  liftMetaTactic1 fun g => do
    let (_fvars, g) ← g.intros
    let g ← revertNonDepPropHyps g
    pure g
  Normalize.generalizeOfBoolTac
  Normalize.substNatEqualitiesTac
  if let [] ← getUnsolvedGoals then
    -- all goals closed by generalization
    return
  Normalize.substBvEqualitiesTac
  if let [] ← getUnsolvedGoals then
    -- all goals closed by generalization
    return
  liftMetaTactic1 Normalize.runPreprocessing
  if let [] ← getUnsolvedGoals then
    -- all goals closed by generalization
    return
  liftMetaTactic1 fun g => do
    let (_fvars, g) ← g.intros
    let g ← revertNonDepPropHyps g
    pure g
  do
    let cfg ← elabBvMultiWidthConfig cfg
    let g ← getMainGoal
    g.withContext do
      solveEntrypoint g cfg
| _ => throwUnsupportedSyntax


macro "bv_multi_width_print_smt_lib" : tactic =>
  `(tactic| bv_multi_width (config := { debugPrintSmtLib := true }))


end Tactic
end MultiWidth
