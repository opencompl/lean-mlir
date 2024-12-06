/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Lean.Meta.Tactic.Simp.BuiltinSimprocs
import Lean.Meta.KExprMap
import SSA.Experimental.Bits.AutoStructs.Basic
import SSA.Experimental.Bits.AutoStructs.Defs
import SSA.Experimental.Bits.AutoStructs.FormulaToAuto
import Qq.Macro


namespace AutoStructs

section EvalLemmas
variable {x y : Term} {w} {vars : Nat → BitVec w}

lemma eval_sub :
    (x.sub y).evalNat vars = x.evalNat vars - y.evalNat vars := by
  simp only [Term.evalNat]

lemma eval_add :
    (x.add y).evalNat vars = x.evalNat vars + y.evalNat vars := by
  simp only [Term.evalNat]

lemma eval_neg :
    (x.neg).evalNat vars = - x.evalNat vars := by
  simp only [Term.evalNat]

lemma eval_not :
    (x.not).evalNat vars = ~~~ x.evalNat vars := by
  simp only [Term.evalNat]

lemma eval_and :
    (x.and y).evalNat vars = x.evalNat vars &&& y.evalNat vars := by
  simp only [Term.evalNat]

lemma eval_xor :
    (x.xor y).evalNat vars = x.evalNat vars ^^^ y.evalNat vars := by
  simp only [Term.evalNat]

lemma eval_or :
    (x.or y).evalNat vars = x.evalNat vars ||| y.evalNat vars := by
  simp only [Term.evalNat]
end EvalLemmas

section SatLemmas
variable {x y : Formula} {w} {vars : Nat → BitVec w}

open Formula

lemma sat_and :
    (binop .and x y).sat' vars ↔ x.sat' vars ∧ y.sat' vars := by
  simp only [Formula.sat', evalBinop']

lemma sat_or :
    (binop .or x y).sat' vars ↔ x.sat' vars ∨ y.sat' vars := by
  simp only [Formula.sat', evalBinop']

lemma sat_impl :
    (binop .impl x y).sat' vars ↔ (x.sat' vars → y.sat' vars) := by
  simp only [Formula.sat', evalBinop']

lemma sat_iff :
    (binop .equiv x y).sat' vars ↔ (x.sat' vars ↔ y.sat' vars) := by
  simp only [Formula.sat', evalBinop']

lemma sat_neg :
    (unop .neg x).sat' vars ↔ (¬ x.sat' vars) := by
  simp only [Formula.sat', evalBinop']

lemma sat_eq (t1 t2 : Term) :
    (atom .eq t1 t2).sat' vars ↔ (t1.evalNat vars = t2.evalNat vars) := by
  simp [Formula.sat', evalRelation]

lemma sat_slt (t1 t2 : Term) :
    (atom (.signed .lt) t1 t2).sat' vars ↔ (t1.evalNat vars <ₛ t2.evalNat vars) := by
  simp [Formula.sat', evalRelation]

lemma sat_sle (t1 t2 : Term) :
    (atom (.signed .le) t1 t2).sat' vars ↔ (t1.evalNat vars ≤ₛ t2.evalNat vars) := by
  simp [Formula.sat', evalRelation]

lemma sat_ult (t1 t2 : Term) :
    (atom (.unsigned .lt) t1 t2).sat' vars ↔ (t1.evalNat vars <ᵤ t2.evalNat vars) := by
  simp [Formula.sat', evalRelation]

lemma sat_ule (t1 t2 : Term) :
    (atom (.unsigned .le) t1 t2).sat' vars ↔ (t1.evalNat vars ≤ᵤ t2.evalNat vars) := by
  simp [Formula.sat', evalRelation]

end SatLemmas
end AutoStructs

open AutoStructs

open Lean Elab Tactic
open Lean Meta
open scoped Qq

def AutoStructs.Term.toExpr (t : Term) : Expr :=
  open Term in
  match t with
  | .var n => mkApp (mkConst ``var) (mkNatLit n)
  | .zero => mkConst ``zero
  | .one => mkConst ``one
  | .negOne => mkConst ``negOne
  | .and t1 t2 => mkApp2 (mkConst ``Term.and) t1.toExpr t2.toExpr
  | .or t1 t2 => mkApp2 (mkConst ``Term.or) t1.toExpr t2.toExpr
  | .xor t1 t2 => mkApp2 (mkConst ``Term.xor) t1.toExpr t2.toExpr
  | .add t1 t2 => mkApp2 (mkConst ``add) t1.toExpr t2.toExpr
  | .sub t1 t2 => mkApp2 (mkConst ``sub) t1.toExpr t2.toExpr
  | .not t => mkApp (mkConst ``Term.not) t.toExpr
  | .neg t => mkApp (mkConst ``neg) t.toExpr

def AutoStructs.Relation.toExpr (rel : Relation) : Expr :=
  open Relation in
  open RelationOrdering in
  match rel with
  | .eq => mkConst ``eq
  | .unsigned .lt => mkApp (mkConst ``unsigned) (mkConst ``lt)
  | .unsigned .le => mkApp (mkConst ``unsigned) (mkConst ``le)
  | .unsigned .gt => mkApp (mkConst ``unsigned) (mkConst ``gt)
  | .unsigned .ge => mkApp (mkConst ``unsigned) (mkConst ``ge)
  | .signed .lt => mkApp (mkConst ``signed) (mkConst ``lt)
  | .signed .le => mkApp (mkConst ``signed) (mkConst ``le)
  | .signed .gt => mkApp (mkConst ``signed) (mkConst ``gt)
  | .signed .ge => mkApp (mkConst ``signed) (mkConst ``ge)

def AutoStructs.Binop.toExpr (rel : Binop) : Expr :=
  open Binop in
  match rel with
  | .and => mkConst ``Binop.and
  | .or => mkConst ``Binop.or
  | .impl => mkConst ``Binop.impl
  | .equiv => mkConst ``Binop.equiv

def AutoStructs.Unop.toExpr (rel : Unop) : Expr :=
  open Unop in
  match rel with
  | .neg => mkConst ``neg

def AutoStructs.Formula.toExpr (φ : Formula) : Expr :=
  open AutoStructs in
  open Formula in
  match φ with
  | .atom rel t1 t2 => mkApp3 (mkConst ``atom) rel.toExpr t1.toExpr t2.toExpr
  | .binop op φ1 φ2 => mkApp3 (mkConst ``binop) op.toExpr φ1.toExpr φ2.toExpr
  | .unop op φ => mkApp2 (mkConst ``unop) op.toExpr φ.toExpr
  | .msbSet φ => mkApp (mkConst ``msbSet) φ.toExpr

instance : ToExpr AutoStructs.Formula where
  toExpr := AutoStructs.Formula.toExpr
  toTypeExpr := mkConst ``AutoStructs.Formula

namespace Tactic
structure State where
  varMap : KExprMap Nat := {}
  invMap : Array Expr := #[]
deriving Inhabited

abbrev M := StateRefT State MetaM

def addAsVar (e : Expr) : M AutoStructs.Term := do
  if let some v ← (←get).varMap.find? e then
      pure (.var v)
  else
    let s ← get
    let v := s.invMap.size
    let varMap := ← s.varMap.insert e v
    let invMap := s.invMap.push e
    set ({varMap, invMap } : State)
    pure (.var v)

-- TODO: make this work
def checkBVs (es : List Expr) : M Bool := do
  for e in es do
    let_expr BitVec _ := e | return false
  pure true

-- TODO: make the shortcuts better
partial def parseTerm (e : Expr) : M AutoStructs.Term := do
  match_expr e with
  | OfNat.ofNat α n _ =>
    let_expr BitVec _ ← α | addAsVar e
    match n with
    | .lit (.natVal 0) => pure AutoStructs.Term.zero
    | .lit (.natVal 1) => pure AutoStructs.Term.one
    | _ =>  logWarning m!"Unknown integer {n}"; addAsVar e -- TODO: all other integers...
  | BitVec.ofNat _w n =>
    match n.nat? with
    | some 0 => pure AutoStructs.Term.zero
    | some 1 => pure AutoStructs.Term.one
    | _ =>  logWarning m!"Unknown integer {n}"; addAsVar e -- TODO: all other integers...
  | HXor.hXor α1 α2 α3 _ e1 e2 =>
    let_expr BitVec _ ← α1 | addAsVar e
    let_expr BitVec _ ← α2 | addAsVar e
    let_expr BitVec _ ← α3 | addAsVar e
    let t1 ← parseTerm e1
    let t2 ← parseTerm e2
    pure (.xor t1 t2)
  | HOr.hOr α1 α2 α3 _ e1 e2 =>
    let_expr BitVec _ ← α1 | addAsVar e
    let_expr BitVec _ ← α2 | addAsVar e
    let_expr BitVec _ ← α3 | addAsVar e
    let t1 ← parseTerm e1
    let t2 ← parseTerm e2
    pure (.or t1 t2)
  | HAnd.hAnd α1 α2 α3 _ e1 e2 =>
    let_expr BitVec _ ← α1 | addAsVar e
    let_expr BitVec _ ← α2 | addAsVar e
    let_expr BitVec _ ← α3 | addAsVar e
    let t1 ← parseTerm e1
    let t2 ← parseTerm e2
    pure (.and t1 t2)
  | HAdd.hAdd α1 α2 α3 _ e1 e2 =>
    let_expr BitVec _ ← α1 | addAsVar e
    let_expr BitVec _ ← α2 | addAsVar e
    let_expr BitVec _ ← α3 | addAsVar e
    let t1 ← parseTerm e1
    let t2 ← parseTerm e2
    pure (.add t1 t2)
  | HSub.hSub α1 α2 α3 _ e1 e2 =>
    let_expr BitVec _ ← α1 | addAsVar e
    let_expr BitVec _ ← α2 | addAsVar e
    let_expr BitVec _ ← α3 | addAsVar e
    let t1 ← parseTerm e1
    let t2 ← parseTerm e2
    pure (.sub t1 t2)
  | Neg.neg α _ e1 =>
    let_expr BitVec _ ← α | addAsVar e
    let t1 ← parseTerm e1
    pure (.neg t1)
  | Complement.complement α _ e' =>
    let_expr BitVec _ ← α | addAsVar e
    let t ← parseTerm e'
    pure (.not t)
  | _ =>
    -- logInfo m!"term is {e} === {reprStr e}, let's treat is as a variable"
    addAsVar e

-- Note: we assume a preprocesing phase replaced boolean operations with
-- Prop operations, e.g. `(x < y && y ≤ z) = (x < z)` with `x < y ∧ y ≤ z ↔ x < z
partial def parseFormula (e : Expr) : M Formula := do
  match_expr e with
  | Eq α e1 e2 =>
    match_expr e2 with
    | true =>
      let_expr Bool ← α | failure
      parseFormula e1
    | false =>
      let_expr Bool ← α | failure
      pure $ .unop .neg (←parseFormula e1)
    | _ =>
      let_expr BitVec _ ← α | throwError m!"Equality {e} has a strange type"
      let t1 ← parseTerm e1
      let t2 ← parseTerm e2
      pure (.atom .eq t1 t2)
  | Not e =>
    let t ← parseFormula e
    pure (.unop .neg t)
  | Iff e1 e2 =>
    let t1 ← parseFormula e1
    let t2 ← parseFormula e2
    pure (.binop .equiv t1 t2)
  | BEq.beq α _ e1 e2 =>
    match_expr α with
    | BitVec _ =>
      let t1 ← parseTerm e1
      let t2 ← parseTerm e2
      pure (.atom .eq t1 t2)
    | _ => throwError m!"Unexpected Beq type {α}"
  -- | Impl => TODO
  | And e1 e2 =>
    let t1 ← parseFormula e1
    let t2 ← parseFormula e2
    pure (.binop .and t1 t2)
  | Or e1 e2 =>
    let t1 ← parseFormula e1
    let t2 ← parseFormula e2
    pure (.binop .or t1 t2)
  | BitVec.slt _ e1 e2 =>
    pure (.atom (.signed .lt) (← parseTerm e1) (← parseTerm e2))
  | BitVec.sle _ e1 e2 =>
    pure (.atom (.signed .le) (← parseTerm e1) (← parseTerm e2))
  | BitVec.ult _ e1 e2 =>
    pure (.atom (.unsigned .lt) (← parseTerm e1) (← parseTerm e2))
  | BitVec.ule _ e1 e2 =>
    pure (.atom (.unsigned .le) (← parseTerm e1) (← parseTerm e2))
  | BitVec.msb _ e =>
    pure (.msbSet (← parseTerm e))
  | _ => throwError m!"Unsupported syntax {e} === {reprStr e}"

axiom automaton_axiom (A : Prop) : A

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

def mkFinLit (m n : Nat) : MetaM Expr :=
  let r := mkRawNatLit n
  mkAppOptM ``OfNat.ofNat #[some (mkApp (mkConst ``Fin) (mkNatLit m)), some r, none]

def mkBitVecLit0 (w : Expr) : MetaM Expr :=
  mkAppOptM ``BitVec.zero #[w]


-- instance {α : Type u} [ToExpr α] [ToLevel.{u}] : ToExpr (Array α) :=
--   let type := toTypeExpr α
--   { toExpr     := fun as => mkApp2 (mkConst ``List.toArray [toLevel.{u}]) type (toExpr as.toList)
--     toTypeExpr := mkApp (mkConst ``Array [toLevel.{u}]) type }

-- let type := toTypeExpr α
-- let nil  := mkApp (mkConst ``List.nil [levelZero]) type
-- let cons := mkApp (mkConst ``List.cons [levelZero]) type
-- { toExpr     := List.toExprAux nil cons,
--   toTypeExpr := mkApp (mkConst ``List [levelZero]) type }

def listExprExpr (es : List Expr) (type : Expr) : Expr :=
  let nil  := mkApp (mkConst ``List.nil [levelZero]) type
  let cons := mkApp (mkConst ``List.cons [levelZero]) type
  es.foldl (init := nil) fun res e => mkApp2 cons e res

def arrayExprExpr (es : Array Expr) (type : Expr) : Expr :=
  mkApp2 (mkConst ``List.toArray [levelZero]) type (listExprExpr es.toList type)

def makeEnv (es : Array Expr) (w : Expr) : MetaM Expr :=
   withLocalDecl `n BinderInfo.default (.const ``Nat []) λ n => do
    let bv0 := mkApp (mkConst ``BitVec.zero) w
    let body ← es.zipWithIndex.foldlM (init := bv0) fun res (e, i) => do
      mkAppM ``ite #[←mkAppM ``Eq #[n, mkNatLit i], e, res]
    mkLambdaFVars #[n] body

private def buildEnv (es : Array Expr) : MetaM Expr := do
  let some e0 := es[0]? | throwError "The goal contains no variables"
  let type ← inferType e0
  let_expr BitVec w ← type | throwError "Variables must be of BitVector type"
  makeEnv es w

private partial def assertSame (φ : Formula) (st : State) : TacticM Unit:= do
  withMainContext do
    liftMetaTactic fun goal => do
      let goalT ← goal.getType
      let efor := toExpr φ
      let ρ ← buildEnv st.invMap
      let new ← mkAppM ``Formula.sat' #[efor, ρ]
      -- let new ← mkAppM ``Eq #[new, mkConst ``true]
      let newGoal ← mkAppM ``Iff #[new, goalT]
      let mvar ← mkFreshExprMVar (some newGoal)
      let mvar' ← mkFreshExprMVar (some new)
      goal.assign (←mkAppM ``Iff.mp #[mvar, mvar'])
      pure [mvar.mvarId!, mvar'.mvarId!]

elab "bv_automata_inner" : tactic => do
  withMainContext do
    let mvar ← getMainGoal
    let typ ← mvar.getType
    let e ← instantiateMVars typ
    let (φ, st) ← parseFormula e|>.run default
    assertSame φ st

macro "bv_automata'" : tactic =>
  `(tactic| (
     bv_automata_inner
     { simp only [
         AutoStructs.sat_and,
         AutoStructs.sat_or,
         AutoStructs.sat_impl,
         AutoStructs.sat_iff,
         AutoStructs.sat_neg,
         AutoStructs.sat_eq,
         AutoStructs.sat_slt,
         AutoStructs.sat_sle,
         AutoStructs.sat_ult,
         AutoStructs.sat_ule,
         AutoStructs.eval_sub,
         AutoStructs.eval_add,
         AutoStructs.eval_neg,
         AutoStructs.eval_and,
         AutoStructs.eval_xor,
         AutoStructs.eval_or,
         AutoStructs.eval_not]
       rfl }
     { apply decision_procedure_is_correct; native_decide } ))

end Tactic

section tests

variable (w : Nat) (x y z : BitVec w)

theorem dfadfa : (x <ₛ 0) ↔ x.msb := by bv_automata'

theorem and_ule_not_xor : x &&& y ≤ᵤ ~~~(x ^^^ y) := by bv_automata'

theorem xor_ule_or : x ^^^ y ≤ᵤ x ||| y := by bv_automata'

theorem ult_iff_not_ule : (x <ᵤ y) ↔ ¬ (y ≤ᵤ x) := by bv_automata'

theorem sub_neg_sub : (x - y) = - (y - x) := by bv_automata'

-- only for w > 0
theorem eq_iff_not_sub_or_sub :
    x = y ↔ (~~~ (x - y ||| y - x)).msb := by bv_automata'

theorem zulip_example :
  ¬(n <ᵤ ~~~k) ∨
    (((a + k - a <ᵤ a + k + 1#64 - a) ∧ (a + k - a <ᵤ a + k + 1#64 + n - a)) ∧
        a + k + 1#64 + n - (a + k + 1#64) <ᵤ a - (a + k + 1#64)) ∧
      a + k + 1#64 + n - (a + k + 1#64) <ᵤ a + k - (a + k + 1#64) := by
  bv_automata'

theorem zulip_example' :
    ¬(n <ᵤ ~~~k) ∨
    (((k <ᵤ k + 1) ∧ (k <ᵤ k + 1 + n)) ∧ n <ᵤ -k - 1) ∧ n <ᵤ -1 := by
  bv_automata'

theorem lt_iff_sub_xor_xor_and_sub_xor :
    (x <ₛ y) ↔ ((x - y) ^^^ ((x ^^^ y) &&& ((x - y) ^^^ x))).msb := by
    bv_automata'

end tests
