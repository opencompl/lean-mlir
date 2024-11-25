import Lean.Meta.Tactic.Simp.BuiltinSimprocs
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Decide
import SSA.Experimental.Bits.Fast.Lemmas
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

theorem termNat_correct (f : Nat → BitStream) (w n : Nat) : BitStream.EqualUpTo w (BitStream.ofBitVec (BitVec.ofNat w n)) ((termNat n).eval f) := by
  induction' n with n ih
  · intros _ _
    simp only [Term.eval, termNat, BitStream.zero_eq, Bool.ite_eq_false_distrib, BitVec.getLsbD_zero, BitVec.msb_zero, ite_self]
  · simp only [Term.eval, termNat, ← Nat.succ_eq_add_one]
    trans (BitStream.ofBitVec (BitVec.ofNat w n)).incr
    exact BitStream.ofBitVec_incr
    exact BitStream.incr_congr ih

def quoteThm (qMapIndexToFVar : Q(Nat → BitStream)) (w : Q(Nat)) (nat: Nat) :
  Q(@BitStream.EqualUpTo $w (BitStream.ofBitVec (@BitVec.ofNat $w $nat)) (@Term.eval (termNat $nat) $qMapIndexToFVar)) := q(termNat_correct $qMapIndexToFVar $w $nat)


/--
Given an Expr e, return a pair e', p where e' is an expression and p is a proof that e and e' are equal on the fist w bits
-/
partial def first_rep (w : Q(Nat)) (e : Q( BitStream)) : SimpM (Σ (x : Q(BitStream)),  Q(@BitStream.EqualUpTo $w $e $x))  := do
  match e with
    | ~q(@HSub.hSub BitStream BitStream BitStream _ $a $b) => do
      let ⟨ anext, aproof ⟩ ← first_rep w a
      let ⟨ bnext, bproof ⟩ ← first_rep w b
      return ⟨
        q(@HSub.hSub BitStream BitStream BitStream _ $anext $bnext),
        q(@BitStream.sub_congr $w $a $anext $b $bnext $aproof $bproof)
      ⟩
    | ~q(BitStream.ofBitVec (OfNat.ofNat $b)) => do
      let ofNat := q(OfNat.ofNat $b)
      let .some nat := ofNat.nat?
        | throwError m!"The bv_automata tactic expects {repr ofNat} to be of the form of a nat literal, but it is not"
      let length : Q(Nat) := w
      let context  ← getLCtx
      let contextLength := context.getFVarIds.size - 1
      let lastFVar := (context.getAt? contextLength)
      match lastFVar with
      | none => throwError m!"The bv_automata tactic expects the last variable to be a fvar, but it is not"
      | some lastFVar => do
        let qMapIndexToFVar : Q(Nat → BitStream) := .fvar lastFVar.fvarId
        return ⟨
          q(Term.eval (termNat $nat) $qMapIndexToFVar),
          quoteThm qMapIndexToFVar length nat
      ⟩
    | ~q(BitStream.ofBitVec (BitVec.ofNat $w $b)) => do
      let .some nat := b.nat?
        | throwError m!"The bv_automata tactic expects {b} (representation form: {repr b}) to be of the form of a nat literal, but it is not"
      let length : Q(Nat) := w
      let context ← getLCtx
      let contextLength := context.getFVarIds.size - 1
      let lastFVar := (context.getAt? contextLength)
      match lastFVar with
      | none => throwError m!"The bv_automata tactic expects the last variable to be a fvar, but it is not"
      | some lastFVar => do
        let qMapIndexToFVar : Q(Nat → BitStream) := .fvar lastFVar.fvarId
        return ⟨
          q(Term.eval (termNat $nat) $qMapIndexToFVar),
          quoteThm qMapIndexToFVar length nat
      ⟩
    | ~q(@BitStream.ofBitVec $w ($a - $b)) => do
      let ⟨ anext, aproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $a)
      let ⟨ bnext, bproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $b)
      let eproof ← mkAppM ``BitStream.ofBitVec_sub_congr #[aproof, bproof]
      return ⟨
        q(@HSub.hSub BitStream BitStream BitStream _ $anext $bnext),
        eproof
      ⟩
    | ~q(@BitStream.ofBitVec $w (- $a)) => do
      let ⟨ anext, aproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $a)
      let eproof ← mkAppM ``BitStream.ofBitVec_neg_congr #[aproof]
      return ⟨
        q(@Neg.neg BitStream _ $anext),
        eproof
      ⟩
    | ~q(@HAdd.hAdd BitStream BitStream BitStream _ $a $b) => do
      let ⟨ anext, aproof ⟩ ← first_rep w a
      let ⟨ bnext, bproof ⟩ ← first_rep w b
      return ⟨
        q($anext + $bnext),
        .app (.app (.app (.app (.app (.app (.app (.const ``BitStream.add_congr []) w) a) anext) b) bnext) aproof) bproof
      ⟩
    | ~q(@HAnd.hAnd BitStream BitStream BitStream _ $a $b) => do
      let ⟨ anext, aproof ⟩ ← first_rep w a
      let ⟨ bnext, bproof ⟩ ← first_rep w b
      return ⟨
        q($anext &&& $bnext),
        .app (.app (.app (.app (.app (.app (.app (.const ``BitStream.and_congr []) w) a) anext) b) bnext) aproof) bproof
      ⟩
    | ~q(@HOr.hOr BitStream BitStream BitStream _ $a $b) => do
      let ⟨ anext, aproof ⟩ ← first_rep w a
      let ⟨ bnext, bproof ⟩ ← first_rep w b
      return ⟨
        q($anext ||| $bnext),
        .app (.app (.app (.app (.app (.app (.app (.const ``BitStream.or_congr []) w) a) anext) b) bnext) aproof) bproof
      ⟩
    | ~q(@HXor.hXor BitStream BitStream BitStream _ $a $b) => do
      let ⟨ anext, aproof ⟩ ← first_rep w a
      let ⟨ bnext, bproof ⟩ ← first_rep w b
      return ⟨
        q($anext ^^^ $bnext),
        .app (.app (.app (.app (.app (.app (.app (.const ``BitStream.xor_congr []) w) a) anext) b) bnext) aproof) bproof
      ⟩
    | ~q(@BitStream.ofBitVec $w ($a + $b)) => do
      let ⟨ anext, aproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $a)
      let ⟨ bnext, bproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $b)
      let eproof ← mkAppM ``BitStream.ofBitVec_add_congr #[aproof, bproof]
      return ⟨
        q(@HAdd.hAdd BitStream BitStream BitStream _ $anext $bnext),
        eproof
      ⟩
    | ~q(@BitStream.ofBitVec $w ($a ^^^ $b)) => do
      let ⟨ anext, aproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $a)
      let ⟨ bnext, bproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $b)
      let eproof ← mkAppM ``BitStream.ofBitVec_xor_congr #[aproof, bproof]
      return ⟨
        q(@HXor.hXor BitStream BitStream BitStream _ $anext $bnext),
        eproof
      ⟩
    | ~q(@BitStream.ofBitVec $w ($a &&& $b)) => do
      let ⟨ anext, aproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $a)
      let ⟨ bnext, bproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $b)
      let eproof ← mkAppM ``BitStream.ofBitVec_and_congr #[aproof, bproof]
      return ⟨
        q(@HAnd.hAnd BitStream BitStream BitStream _ $anext $bnext),
        eproof
      ⟩
    | ~q(@BitStream.ofBitVec $w ($a ||| $b)) => do
      let ⟨ anext, aproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $a)
      let ⟨ bnext, bproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $b)
      let eproof ← mkAppM ``BitStream.ofBitVec_or_congr #[aproof, bproof]
      return ⟨
        q(@HOr.hOr BitStream BitStream BitStream _ $anext $bnext),
        eproof
      ⟩
    | ~q(@BitStream.ofBitVec $w (~~~ $a)) => do
      let ⟨ anext, aproof ⟩ ← first_rep w q(@BitStream.ofBitVec $w $a)
      let eproof ← mkAppM ``BitStream.ofBitVec_not_congr #[aproof]
      return ⟨
        q(@Complement.complement BitStream _ $anext),
        eproof
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
    | .app (.app (.const ``BitStream.ofBitVec []) w) (.fvar x) => do
      let context  ← getLCtx
      let contextLength := context.getFVarIds.size - 1
      let lastFVar := context.getAt? contextLength
      match lastFVar with
      | none => throwError m!"The bv_automata tactic expects the last variable to be a fvar, but it is not"
      | some lastFVar => do
        let qMapIndexToFVar : Q(Nat → BitStream) := .fvar lastFVar.fvarId
        let p : Q(Nat) := quoteFVar x
        return ⟨
          q(Term.eval (Term.var $p) $qMapIndexToFVar),
          .app (.app (.const ``BitStream.equal_up_to_refl []) w) (.app (.app (.const ``BitStream.ofBitVec []) w) (.fvar x))
        ⟩
    | ~q(Term.eval $t $f) =>
      return ⟨
        e,
        .app (.app (.const ``BitStream.equal_up_to_refl []) w) e
      ⟩
    | e =>
      throwError m!"bv_automata does not support the expression {e} (representation is: {repr e})"

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

def introduceMapIndexToFVar : TacticM Unit := withMainContext <|  do
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
  introduceMapIndexToFVar
  intro mapIndexToFVar
  simp only [
    reduce_bitvec2,
  ]
  try simp only [
    ← eval_sub,
    ← eval_add,
    ← eval_neg,
    ← eval_and,
    ← eval_xor,
    ← eval_or,
    ← eval_not,
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

def alive_1 {w : ℕ} (x x_1 x_2 : BitVec w) : (x_2 &&& x_1 ^^^ x_1) + 1#w + x = x - (x_2 ||| ~~~x_1) := by
  bv_automata

/--
info: 'alive_1' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms alive_1

def false_statement {w : ℕ} (x y : BitVec w) : x = y := by
  try bv_automata
  sorry

def test_OfNat_ofNat (x : BitVec 1) : 1 + x = x + 1 := by
  bv_automata

/--
info: 'test_OfNat_ofNat' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test_OfNat_ofNat

def test_BitVec_ofNat (x : BitVec 1) : 1 + x = x + 1#1 := by
  bv_automata

/--
info: 'test_BitVec_ofNat' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test_BitVec_ofNat

def test0 {w : Nat} (x y : BitVec (w + 1)) : x + 0 = x := by
  bv_automata

/--
info: 'test0' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test0

def test_simple2 {w : Nat} (x y : BitVec (w + 1)) : x = x := by
  bv_automata

/--
info: 'test_simple2' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test_simple2

def test1 {w : Nat} (x y : BitVec (w + 1)) : (x ||| y) - (x ^^^ y) = x &&& y := by
  bv_automata

/--
info: 'test1' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test1

def test2 (x y : BitVec 300) : (x &&& y) + (x ||| y) = x + y := by
  bv_automata

/--
info: 'test2' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test2

def test3 (x y : BitVec 300) : ((x ||| y) - (x ^^^ y)) = (x &&& y) := by
  bv_automata

/--
info: 'test3' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test3

def test4 (x y : BitVec 2) : (x + -y) = (x - y) := by
  bv_automata

/--
info: 'test4' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test4

def test5 (x y z : BitVec 2) : (x + y + z) = (z + y + x) := by
  bv_automata

/--
info: 'test5' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test5

def test6 (x y z : BitVec 2) : (x + (y + z)) = (x + y + z) := by
  bv_automata

/--
info: 'test6' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test6

def test11 (x y : BitVec 2) : (x + y) = ((x |||  y) +  (x &&&  y)) := by
  bv_automata

/--
info: 'test11' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test11

def test15 (x y : BitVec 2) : (x - y) = (( x &&& (~~~ y)) - ((~~~ x) &&&  y)) := by
  bv_automata

/--
info: 'test15' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test15

def test17 (x y : BitVec 2) : (x ^^^ y) = ((x ||| y) - (x &&& y)) := by
  bv_automata

/--
info: 'test17' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test17

def test18 (x y : BitVec 2) : (x &&&  (~~~ y)) = ((x ||| y) - y) := by
  bv_automata

/--
info: 'test18' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test18

def test19 (x y : BitVec 2) : (x &&&  (~~~ y)) = (x -  (x &&& y)) := by
  bv_automata

/--
info: 'test19' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test19

def test21 (x y : BitVec 2) : (~~~(x - y)) = (~~~x + y) := by
  bv_automata

/--
info: 'test21' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test21

def test23 (x y : BitVec 2) : (~~~(x ^^^ y)) = ((x &&& y) + ~~~(x ||| y)) := by
  bv_automata

/--
info: 'test23' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test23

def test24 (x y : BitVec 2) : (x ||| y) = (( x &&& (~~~y)) + y) := by
  bv_automata

/--
info: 'test24' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test24

def test25 (x y : BitVec 2) : (x &&& y) = (((~~~x) ||| y) - ~~~x) := by
  bv_automata

/--
info: 'test25' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test25

def test26 {w : Nat} (x y : BitVec (w + 1)) : 1 + x + 0 = 1  + x := by
  bv_automata

/--
info: 'test26' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test26

def test27 (x y : BitVec 5) : 2 + x  = 1  + x + 1 := by
  bv_automata

/--
info: 'test27' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test27

def test28 {w : Nat} (x y : BitVec (w + 1)) : x &&& x &&& x &&& x &&& x &&& x = x := by
  bv_automata

/--
info: 'test28' depends on axioms: [propext, sorryAx, Classical.choice, Lean.ofReduceBool, Quot.sound]
-/
#guard_msgs in #print axioms test28

-- This test is commented out because it takes over a minute to run
-- def broken_test (x y : BitVec 5) : 2 + x  + 2 =  x + 4 := by
--   bv_automata
