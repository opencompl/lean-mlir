import Lean.Meta.Tactic.Simp.BuiltinSimprocs
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

lemma eval_sub :
    (x.sub y).eval vars = x.eval vars - y.eval vars := by
  simp only [Term.eval]

lemma eval_add :
    (x.add y).eval vars = x.eval vars + y.eval vars := by
  simp only [Term.eval]

lemma eval_neg :
    (x.neg).eval vars = - x.eval vars := by
  simp only [Term.eval]

lemma eval_not :
    (x.not).eval vars = ~~~ x.eval vars := by
  simp only [Term.eval]

lemma eval_and :
    (x.and y).eval vars = x.eval vars &&& y.eval vars := by
  simp only [Term.eval]

lemma eval_xor :
    (x.xor y).eval vars = x.eval vars ^^^ y.eval vars := by
  simp only [Term.eval]

lemma eval_or :
    (x.or y).eval vars = x.eval vars ||| y.eval vars := by
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


def quoteThm (qMapIndexToFVar : Q(Nat → BitStream)) (w : Q(Nat)) (nat: Nat) : Q(@Eq BitStream (BitStream.ofBitVec (@BitVec.ofNat $w $nat)) (@Term.eval (termNat $nat) $qMapIndexToFVar)) := q(termNatCorrect $qMapIndexToFVar $w $nat)

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
    | x =>
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

/--
Given an Expr e, return a pair e', p where e' is an expression and p is a proof that e and e' are equal on the fist w bits
-/
partial def first_rep (w : Q(Nat)) (e : Q( BitStream)) : SimpM (Σ (x : Q(BitStream)) ,  Q(@BitStream.EqualUpTo $w $e $x))  :=
  match e with
    | ~q(@HSub.hSub BitStream BitStream BitStream _ $a $b) => do
      let ⟨ anext, aproof ⟩ ← first_rep w a
      let ⟨ bnext, bproof ⟩ ← first_rep w b
      return ⟨
        q(@HSub.hSub BitStream BitStream BitStream _ $anext $bnext),
        q(@BitStream.sub_congr $w $a $anext $b $bnext $aproof $bproof)
      ⟩
    | ~q(@BitStream.ofBitVec $w ($a - $b)) =>
      return ⟨
        q((@BitStream.ofBitVec $w $a) -  (@BitStream.ofBitVec $w $b)),
        .app (.app (.app (.const ``BitStream.ofBitVec_sub []) w) a ) b
      ⟩
    | ~q(@HAdd.hAdd BitStream BitStream BitStream _ $a $b) => do
      let ⟨ anext, aproof ⟩ ← first_rep w a
      let ⟨ bnext, bproof ⟩ ← first_rep w b
      return ⟨
        q($anext + $bnext),
        .app (.app (.app (.app (.app (.app (.app (.const ``BitStream.add_congr []) w) a) anext) b) bnext) aproof) bproof
      ⟩
    | ~q(@BitStream.ofBitVec $w ($a + $b)) =>
      return ⟨
        q(@HAdd.hAdd BitStream BitStream BitStream _ (@BitStream.ofBitVec $w $a) (@BitStream.ofBitVec $w $b)),
        .app (.app (.app (.const ``BitStream.ofBitVec_add []) w) a ) b
      ⟩
    | ~q(@Neg.neg BitStream _ $a)=> do
      let ⟨ anext, aproof ⟩ ← first_rep w a
      return ⟨
        q(-$anext),
        (.app (.app (.app (.app (.const ``BitStream.neg_congr []) w) a) anext) aproof)
      ⟩
    | ~q(@BitStream.ofBitVec $w (@Neg.neg (BitVec $w) _ $a)) => do
      return ⟨
        q(@Neg.neg BitStream _ (@BitStream.ofBitVec $w $a)),
        .app (.app (.const ``BitStream.ofBitVec_neg []) w) a
      ⟩
    | ~q(@Complement.complement BitStream _ $a) => do
      let ⟨ anext, aproof ⟩ ← first_rep w a
      return ⟨
        q(~~~ $anext),
        (.app (.app (.app (.app (.const ``BitStream.not_congr []) w) a) anext) aproof)
      ⟩
    | e =>
      return ⟨
        e,
        .app (.app (.const ``BitStream.equal_up_to_refl []) w) e
      ⟩

/--
Push all ofBitVecs down to the lowest level
-/
simproc reduce_bitvec2 (BitStream.EqualUpTo (_ : Nat) _ _) := fun e => do
  match (e : Q(Prop)) with
    | .app (.app (.app (.const ``BitStream.EqualUpTo []) w) l ) r => do
      let ⟨ lterm, lproof ⟩ ← first_rep w l
      let ⟨ rterm, rproof ⟩ ← first_rep w r
      return .done {
        expr := .app (.app (.app (.const ``BitStream.EqualUpTo []) w) lterm) rterm
        proof? :=
        some (.app (.app (.app (.app (.app (.app (.app (.const ``BitStream.equal_congr_congr []) w) l) lterm) r) rterm) lproof) rproof)
      }
    | _ => throwError m!"Expression {e} is not of the expected form. Expected something of the form BitStream.EqualUpTo (w : Nat) (lhs : BitStream) (rhs : BitStream) : Prop"

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
        let fVarId : Q(Nat) := quoteFVar currentFVar
        let eqE : Q(Prop)  := q($lastBVar = $fVarId);
        ((((((Expr.const `ite [Level.zero.succ]).app (.app (.const ``BitVec []) length)).app
                        eqE).app
                    (((Expr.const ``instDecidableEqNat []).app lastBVar).app fVarId)).app
                quotedCurrentFVar).app
            accumulator)
        ) (.fvar last)
      let mapIndexToFVar : Q(Nat → BitStream):=
        (Expr.lam `n (Expr.const `Nat [])
          (((Expr.const `BitStream.ofBitVec []).app
                length).app
            hypValue)
          BinderInfo.default)
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
  repeat simp only [
    reduce_bitvec2,
    BitStream.ofBitVec_not,
    BitStream.ofBitVec_xor,
    BitStream.ofBitVec_and,
    BitStream.ofBitVec_or,
  ]
  introduceMapIndexToFVar
  intro mapIndexToFVar
  simp only [
    ← eval_sub,
    ← eval_add,
    ← eval_neg,
    ← eval_and,
    ← eval_xor,
    ← eval_or,
    ← eval_not,
    reduce_bitvec,
    Nat.reduceAdd,
    BitVec.ofNat_eq_ofNat
  ]
  intros _ _
  apply congrFun
  apply congrFun
  native_decide
  ))


/-!
# Test Cases
-/


def test0 {w : Nat} (x y : BitVec (w + 1)) : x + 0 = x := by
  bv_automata

def test_simple2 {w : Nat} (x y : BitVec (w + 1)) : x = x := by
  bv_automata

def test1 {w : Nat} (x y : BitVec (w + 1)) : (x ||| y) - (x ^^^ y) = x &&& y := by
  bv_automata

def test2 (x y : BitVec 300) : (x &&& y) + (x ||| y) = x + y := by
  bv_automata

def test3 (x y : BitVec 300) : ((x ||| y) - (x ^^^ y)) = (x &&& y) := by
  bv_automata

def test4 (x y : BitVec 2) : (x + -y) = (x - y) := by
  bv_automata

def test5 (x y z : BitVec 2) : (x + y + z) = (z + y + x) := by
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
