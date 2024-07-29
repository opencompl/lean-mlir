import Lean
import Init.Data.BitVec.Lemmas
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.InstCombine.ForLean
import Lean.Meta
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Decide
import SSA.Experimental.Bits.Lemmas

open Lean Elab Tactic
open Lean
open Lean.Meta
open Lean.Elab
open Lean.Elab.Tactic


/--
Get a list of fvars in an automata-only expression
-/
partial def getFVars (e : Expr) : TacticM (List Expr) :=
    match_expr e with
      | HAnd.hAnd _ _ _ _ a b => do
        let a ← getFVars a
        let b ← getFVars b
        return a ++ b
      | HSub.hSub _ _ _ _ a b => do
        let a ← getFVars a
        let b ← getFVars b
        return a ++ b
      | HOr.hOr _ _ _ _ a b => do
        let a ← getFVars a
        let b ← getFVars b
        return a ++ b
      | HXor.hXor _ _ _ _ a b => do
        let a ← getFVars a
        let b ← getFVars b
        return a ++ b
      | Eq _ a b => do
        let a ← getFVars a
        let b ← getFVars b
        return a ++ b
      | HAdd.hAdd _ _ _ _ a b => do
        let a ← getFVars a
        let b ← getFVars b
        return a ++ b
      | Neg.neg _ _ a => do
        let a ← getFVars a
        return a
      | OfNat.ofNat _ _ _ => do
        return []
      | _ => match e with
        | Lean.Expr.fvar a => return [Lean.Expr.fvar a]
        | _ => throwError s!"getFVars: {e} is not a automata expression"

/--
Get a list of variables in an expression
-/
partial def getVars (e : Expr) : TacticM (List Name) :=
    match_expr e with
      | HAnd.hAnd _ _ _ _ a b => do
        let a ← getVars a
        let b ← getVars b
        return a ++ b
      | HSub.hSub _ _ _ _ a b => do
        let a ← getVars a
        let b ← getVars b
        return a ++ b
      | HOr.hOr _ _ _ _ a b => do
        let a ← getVars a
        let b ← getVars b
        return a ++ b
      | HXor.hXor _ _ _ _ a b => do
        let a ← getVars a
        let b ← getVars b
        return a ++ b
      | Eq _ a b => do
        let a ← getVars a
        let b ← getVars b
        return a ++ b
      | HAdd.hAdd _ _ _ _ a b => do
        let a ← getVars a
        let b ← getVars b
        return a ++ b
      | Neg.neg _ _ a => do
        let a ← getVars a
        return a
      | OfNat.ofNat _ _ _ => do
        return []
      | _ => match e with
        | Lean.Expr.fvar a => return [a.name]
        | _ => throwError s!"getVars:{e} is not a automata expression"

/--
Convert a Nat to syntax
-/
def NatToSyntax (n : Nat) : (TSyntax `term) :=
 match n with
  | 0 => mkIdent `Term.zero
  | Nat.succ x => Syntax.mkApp (mkIdent `Term.incr) #[NatToSyntax x]

/--
Reflect the expression `e` into a Syntax of the terms in the `Term` datatype
-/
partial def reflectS (e : _root_.Term) (names : List Name) : TacticM (TSyntax `term) := do
  match e with
    | Term.and a b => do
      let a ← reflectS a names
      let b ← reflectS b names
      return Syntax.mkApp (mkIdent `Term.and) #[a,b]
    | Term.sub a b => do
      let a ← reflectS a names
      let b ← reflectS b names
      return Syntax.mkApp (mkIdent `Term.sub) #[a,b]
    | Term.or a b => do
      let a ← reflectS a names
      let b ← reflectS b names
      return Syntax.mkApp (mkIdent `Term.or) #[a,b]
    | Term.xor a b => do
      let a ← reflectS a names
      let b ← reflectS b names
      return Syntax.mkApp (mkIdent `Term.xor) #[a,b]
    | Term.add a b => do
        let a ← reflectS a names
        let b ← reflectS b names
        return Syntax.mkApp (mkIdent `Term.add) #[a,b]
    | Term.neg a => do
        let a ← reflectS a names
        return Syntax.mkApp (mkIdent `Term.neg) #[a]
    | Term.incr a => do
        let a ← reflectS a names
        return Syntax.mkApp (mkIdent `Term.incr) #[a]
    | Term.zero => do
      return mkIdent `Term.zero
    | Term.var a  => do
      return Syntax.mkApp (mkIdent `Term.var) #[Lean.quote a]
    | _ => throwError "reflectS: unimplemented case"

/--
Reflect the expression `e` into a Syntax version of itself
-/
partial def reflectS2 (e : _root_.Term) (names : List Name) : TacticM (TSyntax `term) := do
  match e with
    | Term.and a b => do
      let a ← reflectS2 a names
      let b ← reflectS2 b names
      return Syntax.mkApp (mkIdent `HAnd.hAnd) #[a,b]
    | Term.sub  a b => do
      let a ← reflectS2 a names
      let b ← reflectS2 b names
      return Syntax.mkApp (mkIdent `HSub.hSub) #[a,b]
    | Term.or a b => do
      let a ← reflectS2 a names
      let b ← reflectS2 b names
      return Syntax.mkApp (mkIdent `HOr.hOr) #[a,b]
    | Term.xor a b => do
      let a ← reflectS2 a names
      let b ← reflectS2 b names
      return Syntax.mkApp (mkIdent `HXor.hXor) #[a,b]
    | Term.add a b => do
        let a ← reflectS2 a names
        let b ← reflectS2 b names
        return Syntax.mkApp (mkIdent `HAdd.hAdd) #[a,b]
    | Term.neg a => do
        let a ← reflectS2 a names
        return Syntax.mkApp (mkIdent `Neg.neg) #[a]
    | Term.incr a => do
        let a ← reflectS2 a names
        return Syntax.mkApp (mkIdent `BitStream.incr) #[a]
    | Term.zero => do
      return mkIdent `BitStream.zero
    | Term.var a  => do
      `(vars $(Lean.quote a))
    | _ => throwError "reflectS2: unimplemented case"

/--
Conver a list of expression to an expression
-/
def listExpr (t : Expr) (exprs : List Lean.Expr) : Lean.Expr :=
  let exprType := t
  let nilExpr := mkApp (.const ``List.nil [Lean.Level.zero]) exprType
  let consExpr := mkApp (mkConst ``List.cons [Lean.Level.zero]) exprType
  exprs.foldr (fun e acc => mkApp2 consExpr e acc) nilExpr


def natToTerm (n : Nat) : _root_.Term :=
  match n with
    | 0 => Term.zero
    | Nat.succ x => Term.incr (natToTerm x)

partial def parseTerm (e : Expr) (names : List Name) : TacticM (_root_.Term) := do
  match_expr e with
    | HAnd.hAnd _ _ _ _ a b => do
      let a ← parseTerm a names
      let b ← parseTerm b names
      return Term.and a b
    | HSub.hSub _ _ _ _ a b => do
      let a ← parseTerm a names
      let b ← parseTerm b names
      return Term.sub a b
    | HOr.hOr _ _ _ _ a b => do
      let a ← parseTerm a names
      let b ← parseTerm b names
      return Term.or a b
    | HXor.hXor _ _ _ _ a b => do
      let a ← parseTerm a names
      let b ← parseTerm b names
      return Term.xor a b
    | HAdd.hAdd _ _ _ _ a b => do
        let a ← parseTerm a names
        let b ← parseTerm b names
        return Term.add a b
    | Neg.neg _ _ a => do
        let a ← parseTerm a names
        return Term.neg a
    | OfNat.ofNat _ b _ => do
      match b with
        | Lean.Expr.lit nv => do
          match nv with
            | Lean.Literal.natVal n => do
              return natToTerm n
            | _ => throwError s!"Not a literal natval expression at {repr nv}"
        | _ => throwError s!"Not a Literal expression at {repr b}"
    | _ => match e with
      | Lean.Expr.fvar a => return Term.var (names.indexOf (a.name))
      | _ => throwError s!"reflectS: {e} is not a automata expression"
/--
Tactic to solve goals of the form $lhs = $rhs, where $lhs and $rhs contain only
constant-memory operations on bitvectors
-/
def bvAutomata : TacticM Unit := do withMainContext <| do
  let goal ← getMainTarget
  let name := (← getLCtx).foldl (· ++ toString ·.userName) ""
  match_expr goal with
    | Eq type lhs rhs =>
        match_expr type with
        | BitVec n =>
          let vars ← getVars goal
          let fvars ← getFVars goal
          let parsedLeft ← parseTerm lhs vars
          let parsedRight ← parseTerm rhs vars
          let ql ← reflectS parsedLeft vars
          let qr ← reflectS parsedRight vars
          let l2 ← reflectS2 parsedLeft vars
          let r2 ← reflectS2 parsedRight vars
          evalTactic (← `(tactic|
          (
          apply BitStream.eq_of_ofBitVec_eq
          repeat (
            first
            | simp only [BitStream.ofBitVec_sub]
            | simp only [BitStream.ofBitVec_or]
            | simp only [BitStream.ofBitVec_xor]
            | simp only [BitStream.ofBitVec_and]
            | simp only [BitStream.ofBitVec_add]
            | simp only [BitStream.ofBitVec_neg]
          )
          )
          ))
          let goal ← getMainGoal
          let hypType: Lean.Expr := Lean.Expr.forallE
            ( .str .anonymous "some function")
            (Lean.Expr.const `Nat [])
            (Lean.Expr.const `BitStream [])
            (Lean.BinderInfo.default)
          let someType : Expr := (.app (.const `BitVec []) n)
          let efvars : Expr := (listExpr (.app (.const `BitVec []) n) fvars)
          match fvars with
            | [] => throwError "no free variables in the expression"
            | var :: _fun_match =>
              let hypValue : Expr := (Expr.lam `b
                (.const `Nat [])
                (.app (.app (.const `BitStream.ofBitVec []) n) (.app (.app (.app (.app (.const ``List.getD [Lean.Level.zero]) someType) efvars) (.bvar 0)) var))
                  ) BinderInfo.default
              let (newGoal) ← goal.define `vars hypType hypValue
              -- Clear the original goal and replace it with the new goal
              replaceMainGoal [newGoal]
              evalTactic (← `(tactic|(
              intro vars
              )))
              evalTactic (← `(tactic|(
              have decided : ($ql).eval = ($qr).eval := by
                native_decide
              )))
              logInfo (← `(tactic|(
              have decided : ($ql).eval = ($qr).eval := by
                native_decide
              )))
              evalTactic (← `(tactic|(
              have lhs : ($ql).eval vars = ($l2) := by
                simp only [vars, List.getD, Option.getD,List.get?]
                repeat (
                  simp only [Term.eval]
                )
                simp [ite]
                try rfl
              )))
              evalTactic (← `(tactic|(
              have rhs : ($qr).eval vars = ($r2) := by
                simp only [vars, List.getD, Option.getD,List.get?]
                repeat (
                  simp only [Term.eval]
                )
                simp [ite]
                try rfl
              )))
              evalTactic (← `(tactic|(
              simp only [vars, List.getD, Option.getD,List.get? ] at rhs
              simp only [vars, List.getD, Option.getD,List.get? ] at lhs
              try rw [← rhs]
              try rw [← lhs]
              try rw [decided]
              intros _ _
              try rfl
              )))
          logInfo s!"{name}: bv automata tactic succeeded"
          return ()
        | _ => do
          throwError m!"{name}: Equality not on the type of BitVectors. It is instead on another type {type}"
    | _ => do
      throwError m!"{name}: Equality expected, found {goal}"

/--
Tactic to solve goals of the form $lhs = $rhs, where $lhs and $rhs contain only
constant-memory operations on bitvectors
-/
elab "bv_automata" : tactic => bvAutomata

def test1 (x y : BitVec 2) : (x ||| y) - (x ^^^ y) = x &&& y := by
  bv_automata

def test5 (x y : BitVec 2) : (x + -y) = (x - y):= by
  bv_automata

def test7 (x y : BitVec 2) : (x + y) = (y + x):= by
  bv_automata

def test8 (x y z : BitVec 2) : (x + (y + z)) = (x + y + z):= by
  bv_automata
