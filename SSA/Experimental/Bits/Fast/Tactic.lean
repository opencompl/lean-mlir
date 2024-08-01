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
(x &&& y) ||| y + 0
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

def termNat (n : Nat) : _root_.Term :=
  match n with
  | 0 => Term.zero
  | x + 1 => Term.incr (termNat x)

def incrBit (w n : Nat) :  BitStream.ofBitVec (BitVec.ofNat w n.succ) = (BitStream.ofBitVec (BitVec.ofNat w n)).incr := by
  sorry

def termNatCorrect (f : Nat → BitStream) (w n : Nat) :  BitStream.ofBitVec (BitVec.ofNat w n) = (termNat n).eval f := by
  induction n
  ext i
  simp only [Term.eval ,termNat, BitStream.zero_eq, Bool.ite_eq_false_distrib, BitVec.getLsb_zero, BitVec.msb_zero, ite_self]
  rename_i n ff
  simp only [Term.eval ,termNat, ← ff]
  exact incrBit w n


def quoteThm (qMapIndexToFVar : Q(Nat → BitStream)) (w : Q(Nat)) (nat: Nat) : Q(@Eq (BitStream) (BitStream.ofBitVec (@BitVec.ofNat $w $nat)) (@Term.eval (termNat $(nat)) $qMapIndexToFVar)) := q(termNatCorrect $qMapIndexToFVar $w $nat)

/--
Simplify BitStream.ofBitVec x where x is an FVar.

It reduces
BitStream.ofBitVec x ====> (Term.var n).eval vars
where n is the index of variable x

It should reduce
BitStream.ofBitVec 0 ====> (Term.zero).eval vars
BitStream.ofBitVec 1 ====> (Term.one).eval vars
but for some reason slows down for larger and larger numbers. I don't know why, just don't
try any numbers bigger than 2
-/
simproc reduce_bitvec (BitStream.ofBitVec _) := fun e => do
  let context  ← getLCtx
  let contextLength := context.getFVarIds.size - 1
  let lastFVar  ← context.getAt? contextLength
  let qMapIndexToFVar : Q(Nat → BitStream) := .fvar lastFVar.fvarId
  match e.appArg! with
    | .fvar x => do
      let p : Q(Nat) := quoteFVar x
      return .done { expr := q(Term.eval (Term.var $p) $qMapIndexToFVar)}
    |  x =>
      match_expr x with
        | BitVec.ofNat a b  =>
          let nat := b.nat?
          let length : Q(Nat) := a
          match nat with
            | .none => throwError m!"{b} is not a nat literal"
            | .some nat =>
              return .done {
                expr := q(Term.eval (termNat $nat) $qMapIndexToFVar)
                proof? := .some (quoteThm qMapIndexToFVar length nat)
                }
        | _ => throwError m!"reduce_bitvec: Expression {x} is not a nat literal"

/-!
# Helper function to construct Exprs
-/


/--
Helper function to construct an equality expression
-/
def eqE (left : Q(Nat)) (right : Q(Nat)) : Q(Prop) :=
  q($left = $right)

/--
Helper function to construct an if then else expression
-/
def iteE (length : Q(Nat)) (left : Q(Nat)) (right : Q(Nat)) (ifTrue : Expr) (ifFalse : Expr) : Expr :=
  ((((((Expr.const `ite [Level.zero.succ]).app (.app (.const ``BitVec []) length)).app
                (eqE left right)).app
            (((Expr.const `instDecidableEqNat []).app left).app right)).app
        ifTrue).app
    ifFalse)

/--
Helper function to construct a function expression
-/
def funE (length : Q(Nat)) (body : Q(BitStream)) : Q(Nat → BitStream):=
  (Expr.lam `n (Expr.const `Nat [])
    (((Expr.const `BitStream.ofBitVec []).app
          length).app
      body)
    BinderInfo.default)

/--
Introduce vars which maps variable ids to the variable values.

let vars (n : Nat) : BitStream := BitStream.ofBitVec (if n = 0 then v0 else if n = 1 then v1 else if n = 2 then v2 ......)

Term.var 0 -- represent the 0th variable
Term.var 1 -- represent the 1st variable
-/
def introduceMapIndexToFVar : TacticM Unit := do withMainContext <| do
  let context : LocalContext ← getLCtx
  let fVars : List FVarId :=  (PersistentArray.toList context.decls).filterMap (fun d => match d with
    | .none => .none
    | .some (.cdecl _ f _ type _ _) =>  match (type : Q(Type)) with
      | .app (.const ``BitVec []) _ => .some f
      | _ => .none
    | .some (.ldecl _ _ _ _ _ _ _) => .none
    )
  let goal : MVarId ← getMainGoal
  let last : FVarId := fVars.get! 0
  let mapIndexToFVarType: Q(Type) := q(Nat → BitStream)
  let lastBVar : Q(Nat) := .bvar 0
  let target : Expr ← getMainTarget
  match_expr target  with
    | BitStream.EqualUpTo a _ _  => do
      let length : Expr := a
      let hypValue : Expr  := fVars.foldl (fun (accumulator : Expr) (currentFVar : FVarId) =>
        let quotedCurrentFVar : Expr := .fvar currentFVar
        let fVarId : Expr := quoteFVar currentFVar
        iteE length lastBVar fVarId quotedCurrentFVar accumulator
        ) (.fvar last)
      let mapIndexToFVar : Expr := funE length hypValue
      let newGoal : MVarId ← goal.define `vars mapIndexToFVarType mapIndexToFVar
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
    BitStream.ofBitVec_not,
    BitStream.ofBitVec_add,
    BitStream.ofBitVec_neg
  ]
  introduceMapIndexToFVar
  intro mapIndexToFVar
  simp only [
    ← sub_eval,
    ← add_eval,
    ← neg_eval,
    ← and_eval,
    ← xor_eval,
    ← or_eval,
    ← not_eval,
    reduce_bitvec,
    Nat.reduceAdd,
    BitVec.ofNat_eq_ofNat
  ]
  intros _ _
  repeat (apply congrFun)
  native_decide
  ))


/-!
# Test Cases

-/
def test0 {w : Nat} (x y : BitVec (w + 1)) : x + 0 = x := by
  bv_automata

def test1 {w : Nat} (x y : BitVec (w + 1)) : (x ||| y) - (x ^^^ y) = x &&& y := by
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

def test26 {w : Nat} (x y : BitVec (w + 1)) : 1 + x + 0 = 1  + x := by
  bv_automata

def test27 (x y : BitVec 5) : 2 + x  = 1  + x + 1 := by
  bv_automata

def test28 {w : Nat} (x y : BitVec (w + 1)) : x &&& x &&& x &&& x &&& x &&& x = x := by
  bv_automata


-- This test is commented out because it takes over a minute to run
-- def broken_test (x y : BitVec 5) : 2 + x  + 2 =  x + 4 := by
--   bv_automata
