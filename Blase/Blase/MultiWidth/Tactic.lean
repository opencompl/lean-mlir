import Mathlib.Data.Fintype.Defs
import Blase.MultiWidth.Defs
import Blase.MultiWidth.GoodFSM
import Blase.MultiWidth.Preprocessing
import Blase.KInduction.KInduction
import Blase.AutoStructs.FormulaToAuto
import Blase.ReflectMap

initialize Lean.registerTraceClass `Bits.MultiWidth

namespace MultiWidth
namespace Tactic
open Lean Meta Elab Tactic

/-- Whether widths should be abstracted. -/
inductive WidthAbstractionKind
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
  /-- debug printing verbosity. -/
  verbose?: Bool := false
  /-- By default, widths are always abstracted. -/
  widthAbstraction : WidthAbstractionKind := .always
  /-- Make the final reflection proof as a 'sorry' for debugging. -/
  debugFillFinalReflectionProofWithSorry : Bool := false
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

@[simp]
def CollectState.wcard (state : CollectState) : Nat :=
  state.wToIx.size

def CollectState.tcard (state : CollectState) : Nat :=
  state.bvToIx.size

def CollectState.bcard (state : CollectState) : Nat :=
  state.boolToIx.size

def CollectState.pcard (state : CollectState) : Nat :=
  state.pToIx.size


def collectWidthAtom (state : CollectState) (e : Expr) :
    SolverM (MultiWidth.Nondep.WidthExpr × CollectState) := do
    if ← check? then
      if !(← isDefEq (← inferType e) (mkConst ``Nat)) then
        throwError m!"expected width to be a Nat, found: {indentD e}"
    -- If we do not want width abstraction, then try to interpret width as constant.
    if (← read).widthAbstraction ≠ .always then
      if let .some n ← getNatValue? e then
        return (MultiWidth.Nondep.WidthExpr.const n, state)
    let (wix, wToIx) := state.wToIx.findOrInsertVal e
    -- TODO: implement 'w + K'.
    return (.var wix, { state with wToIx := wToIx })

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
  let (wexpr, state) ← collectWidthAtom state w
  let (bvix, bvToIx) := state.bvToIx.findOrInsertVal (e, wexpr)
  return (.var bvix wexpr, { state with bvToIx })

partial def collectTerm (state : CollectState) (e : Expr) :
     SolverM (MultiWidth.Nondep.Term × CollectState) := do
  match_expr e with
  | BitVec.ofNat wExpr nExpr =>
    let (w, state) ← collectWidthAtom state wExpr
    if let some n ← getNatValue? nExpr then
      return (.ofNat w n, state)
    else
      mkAtom
  | HAdd.hAdd _bv _bv _bv _inst a b =>
    match_expr _bv with
    | BitVec w =>
      let (w, state) ← collectWidthAtom state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.add w ta tb, state)
    | _ => mkAtom
  | BitVec.zeroExtend _w v x =>
      let (v, state) ← collectWidthAtom state v
      let (x, state) ← collectTerm state x
      return (.zext x v, state)
  | BitVec.signExtend _w v x =>
      let (v, state) ← collectWidthAtom state v
      let (x, state) ← collectTerm state x
      return (.sext x v, state)
  | HXor.hXor _bv _bv _bv _inst a b =>
    match_expr _bv with
    | BitVec w =>
      let (w, state) ← collectWidthAtom state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.bxor w ta tb, state)
    | _ => mkAtom
  | HAnd.hAnd _bv _bv _bv _inst a b =>
    match_expr _bv with
    | BitVec w =>
      let (w, state) ← collectWidthAtom state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.band w ta tb, state)
    | _ => mkAtom
  | HOr.hOr _bv _bv _bv _inst a b =>
    match_expr _bv with
    | BitVec w =>
      let (w, state) ← collectWidthAtom state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.bor w ta tb, state)
    | _ => mkAtom
  | Complement.complement bv _inst a =>
    match_expr bv with
    | BitVec w =>
      let (w, state) ← collectWidthAtom state w
      let (ta, state) ← collectTerm state a
      return (.bnot w ta, state)
    | _ => mkAtom
  | _ => mkAtom
  where
    mkAtom := do
      let (t, state) ← collectBVAtom state e
      return (t, state)

/--
info: MultiWidth.Term.var {wcard tcard bcard : Nat} {tctx : Term.Ctx wcard tcard} (v : Fin tcard) :
  @Term wcard tcard bcard tctx (@TermKind.bv wcard (tctx v))
-/
#guard_msgs in set_option pp.explicit true in #check MultiWidth.Term.var

/--
info: MultiWidth.Term.ofNat {wcard tcard bcard : Nat} {tctx : Term.Ctx wcard tcard} (w : WidthExpr wcard) (n : Nat) :
  @Term wcard tcard bcard tctx (@TermKind.bv wcard w)
-/
#guard_msgs in set_option pp.explicit true in #check MultiWidth.Term.ofNat

/-- Convert a raw expression into a `Term`.
This needs to be checked carefully for equivalence. -/
def mkTermExpr (wcard tcard bcard : Nat) (tctx : Expr)
    (t : MultiWidth.Nondep.Term) : SolverM Expr := do
  match t with
  | .ofNat w n =>
    let wExpr ← mkWidthExpr wcard w
    let out := mkAppN (mkConst ``MultiWidth.Term.ofNat [])
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx, wExpr, mkNatLit n]
    debugCheck out
    return out
  | .var v _wexpr =>
    let out := mkAppN (mkConst ``MultiWidth.Term.var [])
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx, ← mkFinLit tcard v]
    debugCheck out
    return out
  | .add _w a b =>
     let out ← mkAppM ``MultiWidth.Term.add
        #[← mkTermExpr wcard tcard bcard tctx a,
        ← mkTermExpr wcard tcard bcard tctx b]
     debugCheck out
     return out
  | .zext a v =>
    let vExpr ← mkWidthExpr wcard v
    let out ← mkAppM ``MultiWidth.Term.zext
      #[← mkTermExpr wcard tcard bcard tctx a, vExpr]
    debugCheck out
    return out
  | .sext a v =>
    let vExpr ← mkWidthExpr wcard v
    let out ← mkAppM ``MultiWidth.Term.sext
      #[← mkTermExpr wcard tcard bcard tctx a, vExpr]
    debugCheck out
    return out
  | .band w a b =>
      let wExpr ← mkWidthExpr wcard w
      let aExpr ← mkTermExpr wcard tcard bcard tctx a
      let bExpr ← mkTermExpr wcard tcard bcard tctx b
      let out := mkAppN (mkConst ``MultiWidth.Term.band)
        #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx,
          wExpr, aExpr, bExpr]
      debugCheck out
      return out
  | .bor w a b =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard bcard tctx a
    let bExpr ← mkTermExpr wcard tcard bcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Term.bor)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx,
        wExpr, aExpr, bExpr]
    debugCheck out
    return out
  | .bxor w a b =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard bcard tctx a
    let bExpr ← mkTermExpr wcard tcard bcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Term.bxor)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx,
        wExpr, aExpr, bExpr]
    debugCheck out
    return out
  | .bnot w a =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard bcard tctx a
    let out := mkAppN (mkConst ``MultiWidth.Term.bnot)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx,
        wExpr, aExpr]
    debugCheck out
    return out
  | .boolVar v =>
    let out := mkAppN (mkConst ``MultiWidth.Term.boolVar [])
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx,
        ← mkFinLit bcard v]
    debugCheck out
    return out
  | .boolConst b =>
    let out := mkAppN (mkConst ``MultiWidth.Term.boolConst [])
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx,
        mkBoolLit b]
    debugCheck out
    return out

set_option pp.explicit true in
/--
info: ∀ {w : Nat} (a b : BitVec w), Or (@Eq (BitVec w) a b) (And (@Ne (BitVec w) a b) (@Eq (BitVec w) a b)) : Prop
-/
#guard_msgs in
#check ∀ {w : Nat} (a b : BitVec w), a = b ∨ (a ≠ b) ∧ a = b


/-- Visit a raw BV expr, and collect information about it. -/
def collectPredicateAtom (state : CollectState)
  (e : Expr) : SolverM (MultiWidth.Nondep.Predicate × CollectState) := do
  let t ← inferType e
  if !t.isProp then
    throwError m!"expected type 'Prop', found: {t} (expression: {indentD e})"
  let (pix, pToIx) := state.pToIx.findOrInsertVal e
  return (.var pix, { state with pToIx })

/-- Return a new expression that this is defeq to, along with the expression of the environment that this needs, under which it will be defeq. -/
partial def collectBVPredicateAux (state : CollectState) (e : Expr) :
    SolverM (MultiWidth.Nondep.Predicate × CollectState) := do
  match_expr e with
  | LE.le α _inst v w =>
    match_expr α with
    | Nat =>
      let (v, state) ← collectWidthAtom state v
      let (w, state) ← collectWidthAtom state w
      return (.binWidthRel .le v w, state)
    | _ =>
      throwError m!"expected (· ≤ ·) for natural numbers, found:  {indentD e}"
  | Eq α a b =>
    match_expr α with
    | Nat =>
      let (a, state) ← collectWidthAtom state a
      let (b, state) ← collectWidthAtom state b
      return (.binWidthRel .eq a b, state)
    | BitVec w =>
      let (w, state) ← collectWidthAtom state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.binRel .eq w ta tb, state)
    | Bool =>
      let (a, state) ← collectBoolTerm state a
      let (b, state) ← collectBoolTerm state b
      return (.boolBinRel .eq a b, state)
    | _ => mkAtom
  | Ne α a b =>
    match_expr α with
    | BitVec w =>
      let (w, state) ← collectWidthAtom state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.binRel .ne w ta tb, state)
    | Bool =>
      let (a, state) ← collectBoolTerm state a
      let (b, state) ← collectBoolTerm state b
      return (.boolBinRel .ne a b, state)
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
info: MultiWidth.Predicate.binRel {wcard tcard bcard : Nat} {tctx : Term.Ctx wcard tcard} {pcard : Nat}
  (k : BinaryRelationKind) (w : WidthExpr wcard) (a b : @Term wcard tcard bcard tctx (@TermKind.bv wcard w)) :
  Predicate wcard tcard bcard tctx pcard
-/
#guard_msgs in set_option pp.explicit true in #check MultiWidth.Predicate.binRel

/--
info: MultiWidth.Predicate.or {wcard tcard bcard : ℕ} {tctx : Term.Ctx wcard tcard} {pcard : ℕ}
  (p1 p2 : Predicate wcard tcard bcard tctx pcard) : Predicate wcard tcard bcard tctx pcard
-/
#guard_msgs in #check MultiWidth.Predicate.or


/--
info: MultiWidth.Predicate.var {pcard wcard tcard bcard : ℕ} {tctx : Term.Ctx wcard tcard} (v : Fin pcard) :
  Predicate wcard tcard bcard tctx pcard
-/
#guard_msgs in #check MultiWidth.Predicate.var


/--
info: MultiWidth.Predicate.binWidthRel {wcard tcard bcard : ℕ} {tctx : Term.Ctx wcard tcard} {pcard : ℕ}
  (k : WidthBinaryRelationKind) (wa wb : WidthExpr wcard) : Predicate wcard tcard bcard tctx pcard
-/
#guard_msgs in #check MultiWidth.Predicate.binWidthRel


/--
info: MultiWidth.Predicate.boolBinRel {wcard tcard bcard : ℕ} {tctx : Term.Ctx wcard tcard} {pcard : ℕ}
  (k : BoolBinaryRelationKind) (a b : Term bcard tctx TermKind.bool) : Predicate wcard tcard bcard tctx pcard
-/
#guard_msgs in #check MultiWidth.Predicate.boolBinRel


def Expr.mkPredicateExpr (wcard tcard bcard pcard : Nat) (tctx : Expr)
    (p : MultiWidth.Nondep.Predicate) : SolverM Expr := do
  match p with
  | .binRel k w a b =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard bcard tctx a
    let bExpr ← mkTermExpr wcard tcard bcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Predicate.binRel)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard,
        tctx, mkNatLit pcard,
        toExpr k,
        wExpr, aExpr, bExpr]
    debugCheck out
    return out
  | .binWidthRel k v w =>
    let vExpr ← mkWidthExpr wcard v
    let wExpr ← mkWidthExpr wcard w
    let out := mkAppN (mkConst ``MultiWidth.Predicate.binWidthRel)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard,
        tctx, mkNatLit pcard,
        Lean.toExpr k, vExpr, wExpr]
    debugCheck out
    return out
  | .or p q =>
    let pExpr ← mkPredicateExpr wcard tcard bcard pcard tctx p
    let qExpr ← mkPredicateExpr wcard tcard bcard pcard tctx q
    let out := mkAppN (mkConst ``MultiWidth.Predicate.or)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx, mkNatLit pcard, pExpr, qExpr]
    debugCheck out
    return out
  | .and p q =>
    let pExpr ← mkPredicateExpr wcard tcard bcard pcard tctx p
    let qExpr ← mkPredicateExpr wcard tcard bcard pcard tctx q
    let out := mkAppN (mkConst ``MultiWidth.Predicate.and)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx, mkNatLit pcard, pExpr, qExpr]
    debugCheck out
    return out
  | .boolBinRel k a b =>
    let aExpr ← mkTermExpr wcard tcard bcard tctx a
    let bExpr ← mkTermExpr wcard tcard bcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Predicate.boolBinRel)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx, mkNatLit pcard,
        Lean.toExpr k, aExpr, bExpr]
    debugCheck out
    return out
  | .var v =>
    let out := mkAppN (mkConst ``MultiWidth.Predicate.var)
      #[mkNatLit wcard, mkNatLit tcard, mkNatLit bcard, tctx, mkNatLit pcard, ← mkFinLit pcard v]
    debugCheck out
    return out

/--
info: MultiWidth.Predicate.toProp {wcard tcard bcard pcard : ℕ} {wenv : WidthExpr.Env wcard} {tctx : Term.Ctx wcard tcard}
  (benv : Term.BoolEnv bcard) (tenv : tctx.Env wenv) (penv : Predicate.Env pcard)
  (p : Predicate wcard tcard bcard tctx pcard) : Prop
-/
#guard_msgs in #check MultiWidth.Predicate.toProp

def Expr.mkPredicateToPropExpr (pExpr : Expr)
  (_wcard _tcard _bcard _pcard : Nat) (_wenv : Expr) (_tctx : Expr) (tenv : Expr) (penv : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.Predicate.toProp) #[tenv, penv, pExpr]
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

def CollectState.logSuspiciousFvars (state : CollectState) : SolverM Unit := do
  for (e, _w) in state.bvToIx.toArrayAsc do
    if !e.isFVar then
      logWarning m!"abstracted non-variable bitvector: {indentD <| "→ '" ++ toMessageData e ++ "'"}"
  for e in state.wToIx.toArrayAsc do
    if !e.isFVar then
      logWarning m!"abstracted non-variable width: {indentD <| "→ '" ++ toMessageData e ++ "'"}"
  for e in state.pToIx.toArrayAsc do
    if !e.isFVar then
      logWarning m!"abstracted prop: {indentD <| "→ '" ++ toMessageData e ++ "'"}"
  for e in state.boolToIx.toArrayAsc do
    if !e.isFVar then
      logWarning m!"abstracted boolean: {indentD <| "→ '" ++ toMessageData e ++ "'"}"

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
info: MultiWidth.mkPredicateFSMDep {wcard tcard bcard pcard : ℕ} {tctx : Term.Ctx wcard tcard}
  (p : Predicate wcard tcard bcard tctx pcard) : PredicateFSM wcard tcard bcard pcard (Nondep.Predicate.ofDep p)
-/
#guard_msgs in #check MultiWidth.mkPredicateFSMDep
def Expr.mkPredicateFSMDep (_wcard _tcard _bcard _pcard : Nat) (_tctx : Expr) (p : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.mkPredicateFSMDep) #[p]
  debugCheck out
  return out

/--
info: MultiWidth.mkPredicateFSMNondep (wcard tcard bcard pcard : ℕ) (p : Nondep.Predicate) :
  PredicateFSM wcard tcard bcard pcard p
-/
#guard_msgs in #check MultiWidth.mkPredicateFSMNondep
def Expr.mkPredicateFSMNondep (wcard tcard bcard pcard : Nat) (pNondep : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.mkPredicateFSMNondep) #[toExpr wcard, toExpr tcard, toExpr bcard, toExpr pcard, pNondep]
  debugCheck out
  return out

def Expr.mkPredicateFSMtoFSM (p : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.PredicateFSM.toFsm) #[p]
  debugCheck out
  return out

/--
info: MultiWidth.Predicate.toProp_of_KInductionCircuits' {wcard tcard bcard pcard : ℕ} (P : Prop)
  (tctx : Term.Ctx wcard tcard) (p : Predicate wcard tcard bcard tctx pcard) (pNondep : Nondep.Predicate)
  (_hpNondep : pNondep = Nondep.Predicate.ofDep p) (fsm : PredicateFSM wcard tcard bcard pcard pNondep)
  (_hfsm : fsm = mkPredicateFSMNondep wcard tcard bcard pcard pNondep) (n : ℕ)
  (circs : ReflectVerif.BvDecide.KInductionCircuits fsm.toFsm n) (hCircs : circs.IsLawful)
  (sCert : BVDecide.Frontend.LratCert) (hs : circs.mkSafetyCircuit.verifyCircuit sCert = true)
  (indCert : BVDecide.Frontend.LratCert) (hind : circs.mkIndHypCycleBreaking.verifyCircuit indCert = true)
  (wenv : WidthExpr.Env wcard) (tenv : tctx.Env wenv) (benv : Term.BoolEnv bcard) (penv : Predicate.Env pcard)
  (hp : Predicate.toProp benv tenv penv p = P) : P
-/
#guard_msgs in #check MultiWidth.Predicate.toProp_of_KInductionCircuits'

/--
Revert all prop-valued hyps.
-/
def revertPropHyps (g : MVarId) : SolverM MVarId := do
  let (_, g) ← g.revert (← g.getNondepPropHyps)
  return g

open Lean Meta Elab Tactic in
def solve (g : MVarId) : SolverM Unit := do
  let g ← revertPropHyps g
  let .some g ← g.withContext (Normalize.runPreprocessing g)
    | do
        debugLog m!"Preprocessing automatically closed goal."
  g.withContext do
    debugLog m!"goal after preprocessing: {indentD g}"

  g.withContext do
    let collect : CollectState := {}
    let pRawExpr ← g.getType
    let (p, collect) ← collectBVPredicateAux collect pRawExpr
    debugLog m!"collected predicate: '{repr p}'"
    let tctx ← collect.mkTctxExpr
    let wenv ← collect.mkWenvExpr
    let tenv ← collect.mkTenvExpr (wenv := wenv) (_tctx := tctx)
    let benv ← collect.mkBenvExpr
    let penv ← collect.mkPenvExpr
    let pExpr ← Expr.mkPredicateExpr collect.wcard collect.tcard collect.bcard collect.pcard tctx p
    let pNondepExpr := Lean.ToExpr.toExpr p
    let fsm := MultiWidth.mkPredicateFSMNondep collect.wcard collect.tcard collect.bcard collect.pcard p
    debugLog m!"fsm from MultiWidth.mkPredicateFSMNondep {collect.wcard} {collect.tcard} {repr p}."
    debugLog m!"fsm circuit size: {fsm.toFsm.circuitSize}"
    let (stats, _log) ← FSM.decideIfZerosVerified fsm.toFsm (maxIter := (← read).niter)
    match stats with
    | .safetyFailure i =>
      collect.logSuspiciousFvars
      throwError m!"safety failure at iteration {i} for predicate {repr p}"
    | .exhaustedIterations _ =>
      collect.logSuspiciousFvars
      throwError m!"exhausted iterations for predicate {repr p}"
    | .provenByKIndCycleBreaking niters safetyCert indCert =>
      if (← read).verbose? then
        collect.logSuspiciousFvars
      debugLog m!"proven by KInduction with {niters} iterations"
      let prf ← g.withContext <| do
        -- let predFsmExpr ← Expr.mkPredicateFSMDep collect.wcard collect.tcard tctx pExpr
        let predNondepFsmExpr ← Expr.mkPredicateFSMNondep collect.wcard collect.tcard collect.bcard collect.pcard pNondepExpr
        -- let fsmExpr ← Expr.mkPredicateFSMtoFSM predFsmExpr
        let fsmExpr ← Expr.mkPredicateFSMtoFSM predNondepFsmExpr
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
        let pEqVal ← mkEqRefl pRawExpr  -- mkEqReflNativeDecideProof `pReflectEq (mkConst `Prop) pToProp pRawExpr
        debugCheck pEqVal
        let prf ← mkAppM ``MultiWidth.Predicate.toProp_of_KInductionCircuits'
          #[pRawExpr,
            tctx,
            pExpr,
            pNondepExpr,
            ← mkEqRefl pNondepExpr,
            predNondepFsmExpr,
            ← mkEqRefl predNondepFsmExpr,
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
            penv,
            pEqVal]
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
  SolverM.run (ctx := ctx) do
    forallTelescope (← g.getType) fun xs gTy => do
      let goalMVar ← mkFreshExprMVar gTy
      solve goalMVar.mvarId!
      g.assign (← mkLambdaFVars xs goalMVar)

declare_config_elab elabBvMultiWidthConfig Config

syntax (name := bvMultiWidth) "bv_multi_width" Lean.Parser.Tactic.optConfig : tactic
@[tactic bvMultiWidth]
def evalBvMultiWidth : Tactic := fun
| `(tactic| bv_multi_width $cfg) => do
  let cfg ← elabBvMultiWidthConfig cfg
  let g ← getMainGoal
  g.withContext do
    solveEntrypoint g cfg
| _ => throwUnsupportedSyntax

/-
A tactic to generalize the width of BitVectors
-/

structure State where
  /-- Maps fixed width to a new MVar for the generic width. -/
  mapping : DiscrTree Expr
  invMapping : Std.HashMap Expr Expr
  deriving Inhabited

abbrev GenM := StateT State TermElabM 

def State.get? (e : Expr) : GenM (Option Expr) := do
  let s ← get
  match ← s.mapping.getMatch e with
  | #[x] => return x
  | #[] => return none
  | _ => unreachable!

def State.setMapping (e x : Expr) : GenM Unit := do
  let s ← get
  let m ← s.mapping.insert e x
  set {s with mapping := m}

/-- Get the generic width BV MVar corresponding to an existing BV width. -/
def State.add? (e : Expr) : GenM Expr := do
  match ← get? e with
  | some x => pure x
  | none =>
    if e.isFVar || e.isBVar then pure e else
    let x ← mkFreshExprMVar (some (.const ``Nat [])) (userName := `w)
    setMapping e x
    modify fun s => { s with invMapping := s.invMapping.insert x e }
    pure x

/--
This table determines which arguments of important functions are bitwidths and
should be generalized and which ones are normal parameters which should be
recursively visited.
-/
def genTable : Std.HashMap Name (Array Bool) := Id.run do
  let mut table := .emptyWithCapacity 16
  table := table.insert ``BitVec #[true]
  table := table.insert ``BitVec.zeroExtend #[true, true, false]
  table := table.insert ``BitVec.signExtend #[true, true, false]
  table := table.insert ``BitVec.instAdd #[true]
  table := table.insert ``BitVec.instSub #[true]
  table := table.insert ``BitVec.instMul #[true]
  table := table.insert ``BitVec.instDiv #[true]
  table

partial def visit (t : Expr) : GenM Expr := do
  let t ← instantiateMVars t
  match t with
  | .app _ _ =>
    let f := t.getAppFn
    let args := t.getAppArgs
    let table := 
      if let some (f, _) := f.const? then
        genTable[f]?
      else
        none
    let bv? (n : Nat) :=
      match table with
      | .some xs => xs.getD n false
      | .none => false
    args.zipIdx.foldlM (init := f) fun res (arg, i) => do
      let arg ← if bv? i then State.add? arg else visit arg
      pure <| .app res arg
  | .forallE n e₁ e₂ info =>
    pure <| .forallE n (← visit e₁) (← visit e₂) info
  | e => 
    pure e

def doBvGeneralize (g : MVarId) : GenM (Expr × MVarId) := do
  let lctx ← getLCtx
  let mut allFVars := #[]
  for h in lctx do
    if not h.isImplementationDetail then
      allFVars := allFVars.push h.fvarId
  let (_, g) ← g.revert allFVars
  let e ← visit (← g.getType)
  let mut newVars := #[]
  for x in (←get).mapping.elements do
    newVars := newVars.push x

  let e ← mkForallFVars newVars e (binderInfoForMVars := .default)
  let e ← instantiateMVars e
  pure (e, g)

/--
This tactic tries to generalize the bitvector widths, and only the bitvector
widths. See `genTable` if the tactic fails to generalize the right parameters
of a function over bitvectors.
-/
syntax (name := bvGeneralize) "bv_generalize" Lean.Parser.Tactic.optConfig : tactic
@[tactic bvGeneralize]
def evalBvGeneralize : Tactic := fun
| `(tactic| bv_generalize) => do
  let g₀ ← getMainGoal
  g₀.withContext do
    let ((e, g), s) ← (doBvGeneralize g₀).run default
    g.withContext do
      let g' ← mkFreshExprMVar (some e)
      let mut newVals := #[]
      for x in s.mapping.elements do
        newVals := newVals.push (s.invMapping[x]!)
      g.assign <| mkAppN g' newVals 
      replaceMainGoal [g'.mvarId!]
| _ => throwUnsupportedSyntax

theorem test_bv_generalize_simple (x y : BitVec 32) (zs : List (BitVec 44)) : 
    x = x := by
  bv_generalize
  bv_multi_width

theorem test_bv_generalize (x y : BitVec 32) (zs : List (BitVec 44)) (z : BitVec 10) (h : 52 + 10 = 42) (heq : x = y) : 
    x.zeroExtend 10 = y.zeroExtend 10 + 0 := by
  bv_generalize
  bv_multi_width

end Tactic
end MultiWidth
