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


/-- Tactic options for bv_automata_circuit -/
structure Config where
  check? : Bool := true
  -- number of k-induction iterations.
  niter : Nat := 10
  verbose?: Bool := false
  /-- Make the final reflection proof as a 'sorry' for debugging. -/
  debugFillFinalReflectionProofWithSorry : Bool := false

/-- Default user configuration -/
def Config.default : Config := {}

structure Context extends Config where

abbrev SolverM := ReaderT Context TermElabM

def SolverM.run (m : SolverM α) (ctx : Context) : TermElabM α :=
  ReaderT.run m ctx

def check?  : SolverM Bool := do
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
    bvToIx : TotalOrder Expr := ∅
    bvIxToWidthExpr : Std.HashMap Nat MultiWidth.Nondep.WidthExpr := ∅ -- map from BitVec to width

@[simp]
def CollectState.wcard (state : CollectState) : Nat :=
  state.wToIx.size

def CollectState.tcard (state : CollectState) : Nat :=
  state.bvToIx.size

def collectWidthAtom (state : CollectState) (e : Expr) :
    SolverM (MultiWidth.Nondep.WidthExpr × CollectState) := do
    if ← check? then
      if !(← isDefEq (← inferType e) (mkConst ``Nat)) then
        throwError m!"expected width to be a Nat, found: {indentD e}"
    let (wix, wToIx) := state.wToIx.findOrInsertVal e
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
    return out
  | .max v w =>
      let out := mkAppN (mkConst ``MultiWidth.WidthExpr.max)
        #[mkNatLit wcard, ← mkWidthExpr wcard v, ← mkWidthExpr wcard w]
      return out
  | .addK v k =>
    let out := mkAppN (mkConst ``MultiWidth.WidthExpr.addK)
      #[mkNatLit wcard, ← mkWidthExpr wcard v, mkNatLit k]
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
  for i in [0:reader.tcard] do
    let some wexpr := reader.bvIxToWidthExpr.get? i
      | throwError "unable to find width for BitVec at index {i}"
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
  for (bv, ix) in reader.bvToIx.toArrayAsc.zipIdx do
    let some wexpr := reader.bvIxToWidthExpr.get? ix
      | throwError "unable to find width for '{bv}' at index {ix}"
    out ← mkTermEnvCons (reader := reader) (wenv := wenv) (tenv := out) (w := wexpr) (bv := bv)
    debugCheck out
  debugCheck out
  return out

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
  let mut out ← mkWidthEnvEmpty
  -- | needs to be reversed, because variable '0' is at the end of the array.
  for w in reader.wToIx.toArrayAsc.reverse do
    out ← mkWidthEnvCons out w
  debugCheck out
  return out

/-- Visit a raw BV expr, and collect information about it. -/
def collectBVAtom (state : CollectState)
  (e : Expr) : SolverM (MultiWidth.Nondep.Term × CollectState) := do
  let t ← inferType e
  let_expr BitVec w := t
    | throwError m!"expected type 'BitVec w', found: {indentD t} (expression: {indentD e})"
  let (wexpr, state) ← collectWidthAtom state w
  let (bvix, bvToIx) := state.bvToIx.findOrInsertVal e
  let bvIxToWidthExpr := state.bvIxToWidthExpr.insert bvix wexpr
  return (.var bvix wexpr, { state with bvToIx, bvIxToWidthExpr })

partial def collectTerm (state : CollectState) (e : Expr) :
     SolverM (MultiWidth.Nondep.Term × CollectState) := do
  match_expr e with
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
  | HNot.hnot _bv _inst a =>
    match_expr _bv with
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
info: MultiWidth.Term.var {wcard tcard : ℕ} {tctx : Term.Ctx wcard tcard} (v : Fin tcard) : Term tctx (tctx v)
-/
#guard_msgs in #check MultiWidth.Term.var

/-- Convert a raw expression into a `Term`.
This needs to be checked carefully for equivalence. -/
def mkTermExpr (wcard tcard : Nat) (tctx : Expr)
    (t : MultiWidth.Nondep.Term) : SolverM Expr := do
  match t with
  | .ofNat w n =>
    let wExpr ← mkWidthExpr wcard w
    let out := mkAppN (mkConst ``MultiWidth.Term.ofNat [])
      #[mkNatLit wcard, mkNatLit tcard, tctx, wExpr, mkNatLit n]
    debugCheck out
    return out
  | .var v _wexpr =>
    let out := mkAppN (mkConst ``MultiWidth.Term.var [])
      #[mkNatLit wcard, mkNatLit tcard, tctx, ← mkFinLit tcard v]
    debugCheck out
    return out
  | .add _w a b =>
     let out ← mkAppM ``MultiWidth.Term.add
        #[← mkTermExpr wcard tcard tctx a,
        ← mkTermExpr wcard tcard tctx b]
     debugCheck out
     return out
  | .zext a v =>
    let vExpr ← mkWidthExpr wcard v
    let out ← mkAppM ``MultiWidth.Term.zext
      #[← mkTermExpr wcard tcard tctx a, vExpr]
    debugCheck out
    return out
  | .sext a v =>
    let vExpr ← mkWidthExpr wcard v
    let out ← mkAppM ``MultiWidth.Term.sext
      #[← mkTermExpr wcard tcard tctx a, vExpr]
    debugCheck out
    return out
  | .band w a b =>
      let wExpr ← mkWidthExpr wcard w
      let aExpr ← mkTermExpr wcard tcard tctx a
      let bExpr ← mkTermExpr wcard tcard tctx b
      let out := mkAppN (mkConst ``MultiWidth.Term.band)
        #[mkNatLit wcard, mkNatLit tcard, tctx, wExpr, aExpr, bExpr]
      debugCheck out
      return out
  | .bor w a b =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard tctx a
    let bExpr ← mkTermExpr wcard tcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Term.bor)
      #[mkNatLit wcard, mkNatLit tcard, tctx, wExpr, aExpr, bExpr]
    debugCheck out
    return out
  | .bxor w a b =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard tctx a
    let bExpr ← mkTermExpr wcard tcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Term.bxor)
      #[mkNatLit wcard, mkNatLit tcard, tctx, wExpr, aExpr, bExpr]
    debugCheck out
    return out
  | .bnot w a =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard tctx a
    let out := mkAppN (mkConst ``MultiWidth.Term.bnot)
      #[mkNatLit wcard, mkNatLit tcard, tctx, wExpr, aExpr]
    debugCheck out
    return out


set_option pp.explicit true in
/--
info: ∀ {w : Nat} (a b : BitVec w), Or (@Eq (BitVec w) a b) (And (@Ne (BitVec w) a b) (@Eq (BitVec w) a b)) : Prop
-/
#guard_msgs in
#check ∀ {w : Nat} (a b : BitVec w), a = b ∨ (a ≠ b) ∧ a = b

/-- Return a new expression that this is defeq to, along with the expression of the environment that this needs, under which it will be defeq. -/
partial def collectBVPredicateAux (state : CollectState) (e : Expr) :
    SolverM (MultiWidth.Nondep.Predicate × CollectState) := do
  match_expr e with
  | Eq α a b =>
    match_expr α with
    | BitVec w =>
      let (w, state) ← collectWidthAtom state w
      let (ta, state) ← collectTerm state a
      let (tb, state) ← collectTerm state b
      return (.binRel .eq w ta tb, state)
    | _ => throwError m!"expected bitvector equality, found: {indentD e}"
  | Or p q =>
    let (ta, state) ← collectBVPredicateAux state p
    let (tb, state) ← collectBVPredicateAux state q
    return (.or ta tb, state)
  | And p q =>
    let (ta, state) ← collectBVPredicateAux state p
    let (tb, state) ← collectBVPredicateAux state q
    return (.and ta tb, state)
  | _ =>
     throwError m!"expected predicate over bitvectors (no quantification), found:  {indentD e}"

/--
info: MultiWidth.Predicate.binRel {wcard tcard : ℕ} {ctx : Term.Ctx wcard tcard} (k : BinaryRelationKind)
  (w : WidthExpr wcard) (a b : Term ctx w) : Predicate ctx
-/
#guard_msgs in #check MultiWidth.Predicate.binRel

/--
info: MultiWidth.Predicate.or {wcard tcard : ℕ} {ctx : Term.Ctx wcard tcard} (p1 p2 : Predicate ctx) : Predicate ctx
-/
#guard_msgs in #check MultiWidth.Predicate.or

def Expr.mkPredicateExpr (wcard tcard : Nat) (tctx : Expr)
    (p : MultiWidth.Nondep.Predicate) : SolverM Expr := do
  match p with
  | .binRel .eq w a b =>
    let wExpr ← mkWidthExpr wcard w
    let aExpr ← mkTermExpr wcard tcard tctx a
    let bExpr ← mkTermExpr wcard tcard tctx b
    let out := mkAppN (mkConst ``MultiWidth.Predicate.binRel)
      #[mkNatLit wcard, mkNatLit tcard, tctx,
        mkConst ``MultiWidth.BinaryRelationKind.eq,
        wExpr,
        aExpr, bExpr]
    debugCheck out
    return out
  | .or p q =>
    let pExpr ← mkPredicateExpr wcard tcard tctx p
    let qExpr ← mkPredicateExpr wcard tcard tctx q
    let out := mkAppN (mkConst ``MultiWidth.Predicate.or)
      #[mkNatLit wcard, mkNatLit tcard, tctx, pExpr, qExpr]
    debugCheck out
    return out
  | _ => throwError m!"unhandled mkPredicateExpr {repr p}"


/--
info: MultiWidth.Predicate.toProp {wcard tcard : ℕ} {wenv : WidthExpr.Env wcard} {tctx : Term.Ctx wcard tcard}
  (tenv : tctx.Env wenv) (p : Predicate tctx) : Prop
-/
#guard_msgs in #check MultiWidth.Predicate.toProp

def Expr.mkPredicateToPropExpr (pExpr : Expr)
  (_wcard _tcard : Nat) (_wenv : Expr) (_tctx : Expr) (tenv : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.Predicate.toProp) #[tenv, pExpr]
    -- #[(mkNatLit wcard),
    --   (mkNatLit tcard),
    --   wenv, -- wenv,
    --   tctx,
    --   tenv,
    --   pExpr]
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

def mkEqReflNativeDecideProof (name : Name) (lhsSmallExpr : Expr) (rhsLargeExpr : Expr)
    (debugSorry? : Bool := false) : SolverM Expr := do
    -- hoist a₁ into a top-level definition of 'Lean.ofReduceBool' to succeed.
  let name := name ++ `eqProof
  let auxDeclName ← Term.mkAuxName name
  let rflTy := mkApp3 (mkConst ``Eq [Level.ofNat 1]) (mkConst ``Bool []) lhsSmallExpr rhsLargeExpr
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
  for e in state.bvToIx.toArrayAsc do
    if !e.isFVar then
      logWarning m!"abstracted non-variable bitvector: {indentD <| "→ '" ++ toMessageData e ++ "'"}"
  for e in state.wToIx.toArrayAsc do
    if !e.isFVar then
      logWarning m!"abstracted non-variable width: {indentD <| "→ '" ++ toMessageData e ++ "'"}"

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
info: MultiWidth.mkPredicateFSMDep {wcard tcard : ℕ} {tctx : Term.Ctx wcard tcard} (p : Predicate tctx) :
  PredicateFSM wcard tcard (Nondep.Predicate.ofDep p)
-/
#guard_msgs in #check MultiWidth.mkPredicateFSMDep
def Expr.mkPredicateFSMDep (_wcard _tcard : Nat) (_tctx : Expr) (p : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.mkPredicateFSMDep) #[p]
  debugCheck out
  return out

/--
info: MultiWidth.mkPredicateFSMNondep (wcard tcard : ℕ) (p : Nondep.Predicate) : PredicateFSM wcard tcard p
-/
#guard_msgs in #check MultiWidth.mkPredicateFSMNondep
def Expr.mkPredicateFSMNondep (wcard tcard : Nat) (pNondep : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.mkPredicateFSMNondep) #[toExpr wcard, toExpr tcard, pNondep]
  debugCheck out
  return out

def Expr.mkPredicateFSMtoFSM (p : Expr) : SolverM Expr := do
  let out ← mkAppM (``MultiWidth.PredicateFSM.toFsm) #[p]
  debugCheck out
  return out

open Lean Meta Elab Tactic in
def solve (g : MVarId) : SolverM (List MVarId) := do
  let .some g ← g.withContext (Normalize.runPreprocessing g)
    | do
        debugLog m!"Preprocessing automatically closed goal."
        return []
  debugLog m!"goal after preprocessing: {indentD g}"

  g.withContext do
    let collect : CollectState := {}
    let (p, collect) ← collectBVPredicateAux collect (← g.getType)
    debugLog m!"collected predicate: {repr p}"
    let tctx ← collect.mkTctxExpr
    let wenv ← collect.mkWenvExpr
    let tenv ← collect.mkTenvExpr (wenv := wenv) (_tctx := tctx)
    let pExpr ← Expr.mkPredicateExpr collect.wcard collect.tcard tctx p
    let pNondepExpr := Lean.ToExpr.toExpr p
    let pToProp ← Expr.mkPredicateToPropExpr (pExpr := pExpr)
      (_wcard := collect.wcard)
      (_tcard := collect.tcard)
      (_tctx := tctx)
      (_wenv := wenv)
      (tenv := tenv)
    let g ← g.replaceTargetDefEq pToProp
    let fsm := MultiWidth.mkPredicateFSMNondep collect.wcard collect.tcard p
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
      debugLog m!"proven by KInduction with {niters} iterations"
      let prf ← g.withContext <| do
        -- let predFsmExpr ← Expr.mkPredicateFSMDep collect.wcard collect.tcard tctx pExpr
        let predNondepFsmExpr ← Expr.mkPredicateFSMNondep collect.wcard collect.tcard pNondepExpr
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
        let prf ← mkAppM ``MultiWidth.Predicate.toProp_of_KInductionCircuits
          #[tctx,
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
            tenv]
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
      return []

def solveEntrypoint (g : MVarId) (cfg : Config) : TermElabM (List MVarId) := do
  (solve g).run { toConfig := cfg }

declare_config_elab elabBvMultiWidthConfig Config

syntax (name := bvMultiWidth) "bv_multi_width" Lean.Parser.Tactic.optConfig : tactic
@[tactic bvMultiWidth]
def evalBvMultiWidth : Tactic := fun
| `(tactic| bv_multi_width $cfg) => do
  let cfg ← elabBvMultiWidthConfig cfg
  let g ← getMainGoal
  g.withContext do
    let gs ← solveEntrypoint g cfg
    replaceMainGoal gs
    match gs with
    | [] => return ()
    | _gs => throwError m!"expected single goal after reflecting, found multiple goals. quitting"
| _ => throwUnsupportedSyntax


end Tactic
end MultiWidth
