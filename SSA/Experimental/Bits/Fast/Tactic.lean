import Lean.Meta.Tactic.Simp.BuiltinSimprocs
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Decide
import SSA.Experimental.Bits.Lemmas
import Qq.Macro
open Lean Elab Tactic
open Lean Meta
open scoped Qq

def sub_eval {x y :  _root_.Term} {vars : Nat → BitStream} :(Term.sub x y).eval vars = x.eval vars - y.eval vars := by simp only [Term.eval]
def add_eval {x y : _root_.Term} {vars : Nat → BitStream}:
    (Term.add x y).eval vars = x.eval vars + y.eval vars := by
  simp only [Term.eval]
  
def neg_eval {x : _root_.Term} {vars : Nat → BitStream}:
    (Term.neg x).eval vars = - x.eval vars := by
  simp only [Term.eval]
  
def not_eval {x : _root_.Term} {vars : Nat → BitStream}:
    (Term.not x).eval vars = ~~~ x.eval vars := by
  simp only [Term.eval]

def and_eval {x y : _root_.Term} {vars : Nat → BitStream}:
    (Term.and x y).eval vars = x.eval vars &&& y.eval vars := by
  simp only [Term.eval]
  
def xor_eval {x y : _root_.Term} {vars : Nat → BitStream}:
    (Term.xor x y).eval vars = x.eval vars ^^^ y.eval vars := by
  simp only [Term.eval]
  
def or_eval {x y : _root_.Term} {vars : Nat → BitStream}:
    (Term.or x y).eval vars = x.eval vars ||| y.eval vars := by
  simp only [Term.eval]

def quoteFVar  (x : FVarId)  : Q(Nat) := mkNatLit (hash x).val
/--
Simplify BitStream.ofBitVec x where x is an FVar.
 -/
simproc reduce_bitvec (BitStream.ofBitVec _) := fun e => do
  let y ← getLCtx
  let l := y.getFVarIds.size - 1
  let g  ← y.getAt? l
  let gv : Q(Nat → BitStream) := .fvar g.fvarId
  match e.appArg! with
    | .fvar x => do
      let p : Q(Nat) := quoteFVar x
      return .done { expr := q(Term.eval (Term.var $p) $gv)}
    |  x => do
      match x with
        | .app (.app (.const ``BitVec.ofNat []) _) _ => do
          let _ := x.natLit!
          --- warning: number literals are not implemented yet.
          return .done { expr := q(Term.eval (Term.zero) $gv) }
        | _ => throwError s!"{x} is not a nat literal"

/--
Introduce vars which maps variable ids to the variable values.
-/
def introVars : TacticM Unit := do withMainContext <| do
  let y : LocalContext ← getLCtx
  let l : List FVarId := y.getFVarIds.data.drop 1
  let goal : MVarId ← getMainGoal
  let last : FVarId := l.get! 0
  let hypType: Q(Type) := q(Nat → BitStream)
  let n : Q(Nat) := .bvar 0
  let target : Expr ← getMainTarget
  match_expr target  with
    | BitStream.EqualUpTo a _ _  => do
      let length : Nat ← a.nat?
      let hypValue : Q(BitVec $length)  := l.foldl (fun a b =>
        let b' :  Q(BitVec $length) := .fvar b;
        let bq :  Q(Nat) := quoteFVar b;
        q(ite ($n = $(bq)) $b' $a)) (.fvar last)
      let hyp : Q(Nat → BitStream) := q(fun _ => BitStream.ofBitVec $hypValue)
      let newGoal : MVarId ← goal.define `vars hypType hyp
      replaceMainGoal [newGoal]
      return ()
    | _ => throwError "Goal is not of the expected form"

elab "introVars" : tactic => introVars
/--
Create bv_automata tactic which solves equalities on bitvectors.
-/
macro "bv_automata" : tactic =>
  `(tactic| (
  apply BitStream.eq_of_ofBitVec_eq
  simp only [BitStream.ofBitVec_sub,
  BitStream.ofBitVec_or,
  BitStream.ofBitVec_xor,
  BitStream.ofBitVec_and,
  BitStream.ofBitVec_add,
  BitStream.ofBitVec_neg]
  introVars
  intro vars
  simp [reduce_bitvec]
  simp only [← sub_eval, ← add_eval, ← neg_eval, ← and_eval, ← xor_eval, ← or_eval, ← not_eval]
  intros _ _
  apply congrFun
  apply congrFun
  native_decide
  ))

def test1 (x y : BitVec 300) : (x ||| y) - (x ^^^ y) = x &&& y := by
  bv_automata

def test2 (x y : BitVec 300) : (x &&& y) + (x ||| y) = x + y := by
  bv_automata

def test3 (x y : BitVec 300) : ((x ||| y) - (x ^^^ y)) = (x &&& y) := by
  bv_automata

def test4 (x y : BitVec 2) : (x + -y) = (x - y) := by
  bv_automata

def test5 (x y : BitVec 2) : (x + y) = (y + x) := by
  bv_automata
  
def test6 (x y z : BitVec 2) : (x + (y + z)) = (x + y + z) := by
  bv_automata

def test11 (x y : BitVec 2) : (x + y) = ((x |||  y) +  (x &&&  y)) := by
  bv_automata

def test15 (x y : BitVec 2) : (x - y) = (( x &&& (~~~ y)) - ((~~~ x) &&&  y)) := by
  bv_automata

def test17 (x y : BitVec 2) : (x ^^^ y) = ((x ||| y) - (x &&& y)) := by
  bv_automata

def test18 (x y : BitVec 2) : (x &&&  (~~~ y)) = ((x ||| y) - y) := by
  bv_automata

def test19 (x y : BitVec 2) : (x &&&  (~~~ y)) = (x -  (x &&& y)) := by
  bv_automata

def test21 (x y : BitVec 2) : (~~~(x - y)) = (~~~x + y) := by
  bv_automata

def test23 (x y : BitVec 2) : (~~~(x ^^^ y)) = ((x &&& y) + ~~~(x ||| y)) := by
  bv_automata

def test24 (x y : BitVec 2) : (x ||| y) = (( x &&& (~~~y)) + y) := by
  bv_automata

def test25 (x y : BitVec 2) : (x &&& y) = (((~~~x) ||| y) - ~~~x) := by
  bv_automata
