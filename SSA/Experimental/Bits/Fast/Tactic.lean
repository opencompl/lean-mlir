import Lean.Meta.Tactic.Simp.BuiltinSimprocs
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Decide
import SSA.Experimental.Bits.Lemmas
import Qq.Macro

open Lean Elab Tactic
open Lean Meta
open scoped Qq

/-!
# BitVec Automata Tactic
There are two ways of expressing BitVec expressions. One is:


```
(x &&& y) || y + 0
```

the other way is:

```
Term.add (Term.or (Term.and (Term.var 0) (Term.var 1)) (Term.var 1)) Term.zero
```

The goal of this tactic is to convert expressions of the first kind into the second kind, because
we have a decision procedure that decides equality on expressions of the second kind.
-/



section EvalLemmas
variable {x y : _root_.Term} {vars : Nat → BitStream}
def sub_eval :
    (Term.sub x y).eval vars = x.eval vars - y.eval vars := by
  simp only [Term.eval]

def add_eval :
    (Term.add x y).eval vars = x.eval vars + y.eval vars := by
  simp only [Term.eval]

def neg_eval :
    (Term.neg x).eval vars = - x.eval vars := by
  simp only [Term.eval]

def not_eval :
    (Term.not x).eval vars = ~~~ x.eval vars := by
  simp only [Term.eval]

def and_eval :
    (Term.and x y).eval vars = x.eval vars &&& y.eval vars := by
  simp only [Term.eval]

def xor_eval :
    (Term.xor x y).eval vars = x.eval vars ^^^ y.eval vars := by
  simp only [Term.eval]

def or_eval :
    (Term.or x y).eval vars = x.eval vars ||| y.eval vars := by
  simp only [Term.eval]
end EvalLemmas

def quoteFVar  (x : FVarId)  : Q(Nat) := mkNatLit (hash x).val

/--
Simplify BitStream.ofBitVec x where x is an FVar.

It reduces
BitStream.ofBitVec x ====> (Term.var n).eval vars
where n is the index of variable x

It should reduce
BitStream.ofBitVec 0 ====> (Term.zero).eval vars
BitStream.ofBitVec 1 ====> (Term.one).eval vars
but this doesn't work for some reason
-/
simproc reduce_bitvec (BitStream.ofBitVec _) := fun e => do
  let context  ← getLCtx
  let contextLength := context.getFVarIds.size - 1
  let lastFVar  ← context.getAt? contextLength
  let typeOfMapIndexToFVar : Q(Nat → BitStream) := .fvar lastFVar.fvarId
  match e.appArg! with
    | .fvar x => do
      let p : Q(Nat) := quoteFVar x
      return .done { expr := q(Term.eval (Term.var $p) $typeOfMapIndexToFVar)}
    |  x => do
      match_expr x with
        | BitVec.ofNat _ _  => do
          --- If x is not a nat literal, the compiler will panic. Oh well.
          -- let _ := x.natLit!
          --- warning: number literals are not implemented yet.
          return .done { expr := q(Term.eval (Term.zero) $typeOfMapIndexToFVar) }
        | _ => throwError s!"reduce_bitvec: Expression {x} is not a nat literal"

/--
Introduce vars which maps variable ids to the variable values.

let vars (n : Nat) : BitStream := BitStream.ofBitVec (if n = 0 then v0 else if n = 1 then v1 else if n = 2 then v2 ......)

Term.var 0 -- represent the 0th variable
Term.var 1 -- represent the 1st variable
-/
def introduceMapIndexToFVar : TacticM Unit := do withMainContext <| do
  let context : LocalContext ← getLCtx
  let fVars : List FVarId := context.getFVarIds.data.drop 1
  let goal : MVarId ← getMainGoal
  let last : FVarId := fVars.get! 0
  let hypType: Q(Type) := q(Nat → BitStream)
  let lastBVar : Q(Nat) := .bvar 0
  let target : Expr ← getMainTarget
  match_expr target  with
    | BitStream.EqualUpTo a _ _  => do
      let length : Nat ← a.nat?
      let hypValue : Q(BitVec $length)  := fVars.foldl (fun accumulator currentFVar =>
        let quotedCurrentFVar : Q(BitVec $length) := .fvar currentFVar
        let fVarId : Q(Nat) := quoteFVar currentFVar
        q(ite ($lastBVar = $fVarId) $quotedCurrentFVar $accumulator)) (.fvar last)
      let hyp : Q(Nat → BitStream) := q(fun _ => BitStream.ofBitVec $hypValue)
      let newGoal : MVarId ← goal.define `vars hypType hyp
      replaceMainGoal [newGoal]
    | _ => throwError "Goal is not of the expected form"

elab "introduceMapIndexToFVar" : tactic => introduceMapIndexToFVar

/--
Create bv_automata tactic which solves equalities on bitvectors.
-/
macro "bv_automata" : tactic =>
  `(tactic| (
  apply BitStream.eq_of_ofBitVec_eq
  simp only [
    BitStream.ofBitVec_sub,
    BitStream.ofBitVec_or,
    BitStream.ofBitVec_xor,
    BitStream.ofBitVec_and,
    BitStream.ofBitVec_add,
    BitStream.ofBitVec_neg
  ]
  introduceMapIndexToFVar
  intro mapIndexToFVar
  -- This simp is non-terminal. I'm not going to do anything about this.
  simp [
    ← sub_eval,
    ← add_eval,
    ← neg_eval,
    ← and_eval,
    ← xor_eval,
    ← or_eval,
    ← not_eval,
    reduce_bitvec
  ]
  intros _ _
  repeat (apply congrFun)
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
