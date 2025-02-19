/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Lean.Meta.Tactic.Simp.BuiltinSimprocs
import Lean.Meta.KExprMap
import SSA.Experimental.Bits.AutoStructs.Basic
import SSA.Experimental.Bits.AutoStructs.Defs
import SSA.Experimental.Bits.AutoStructs.FormulaToAuto
import SSA.Experimental.Bits.FastCopy.Reflect
import Qq.Macro

open Copy
open AutoStructs

open Lean Elab Tactic
open Lean Meta
open scoped Qq

def _root_.Copy.Term.toExpr (t : _root_.Copy.Term) : Expr := t.quote

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

def _root_.Copy.WidthPredicate.toExpr (wp : WidthPredicate) : Expr :=
  mkConst (match wp with
  | .eq => ``WidthPredicate.eq
  | .neq => ``WidthPredicate.neq
  | .le => ``WidthPredicate.le
  | .lt => ``WidthPredicate.lt
  | .ge => ``WidthPredicate.ge
  | .gt => ``WidthPredicate.gt)

def AutoStructs.Formula.toExpr (φ : Formula) : Expr :=
  open AutoStructs in
  open Formula in
  match φ with
  | .width wp n => mkApp2 (mkConst ``width) wp.toExpr (mkNatLit n)
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

def addAsVar (e : Expr) : M _root_.Copy.Term := do
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
partial def parseTerm (e : Expr) : M _root_.Copy.Term := do
  match_expr e with
  | OfNat.ofNat α n _ =>
    let_expr BitVec _ ← α | addAsVar e
    match n with
    | .lit (.natVal 0) => pure _root_.Copy.Term.zero
    | .lit (.natVal 1) => pure _root_.Copy.Term.one
    | _ =>  logWarning m!"Unknown integer {n}"; addAsVar e -- TODO: all other integers...
  | BitVec.ofNat _w n =>
    match n.nat? with
    | some 0 => pure _root_.Copy.Term.zero
    | some 1 => pure _root_.Copy.Term.one
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
      match_expr α with
      | BitVec _ =>
        let t1 ← parseTerm e1
        let t2 ← parseTerm e2
        pure (.atom .eq t1 t2)
      | _ => -- assume it's a prop...
        let t1 ← parseFormula e1
        let t2 ← parseFormula e2
        pure (.binop .equiv t1 t2)
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
      -- TODO: select the case where α is Prop
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
      let efor := toExpr φ
      let ρ ← buildEnv st.invMap
      let new ← mkAppM ``Formula.sat' #[efor, ρ]
      let goal ← goal.replaceTargetDefEq new
      pure [goal]

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
     apply decision_procedure_is_correct; native_decide))

end Tactic

section tests

variable (w : Nat) (x y z : BitVec w)

theorem dfadfa : (x <ₛ 0) ↔ x.msb := by
  bv_automata'

theorem and_ule_not_xor : x &&& y ≤ᵤ ~~~(x ^^^ y) := by bv_automata'

theorem xor_ule_or : x ^^^ y ≤ᵤ x ||| y := by bv_automata'

theorem ult_iff_not_ule : (x <ᵤ y) ↔ ¬ (y ≤ᵤ x) := by bv_automata'

theorem sub_neg_sub : (x - y) = - (y - x) := by bv_automata'

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
