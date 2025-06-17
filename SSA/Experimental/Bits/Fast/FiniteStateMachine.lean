import Mathlib.Data.FinEnum
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Fintype.Sigma
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic.Zify
import Mathlib.Tactic.Ring
import SSA.Experimental.Bits.FinEnum
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.Circuit

open Sum

section FSM
variable {α β α' β' : Type} {γ : β → Type}


instance : Hashable Empty where
  hash x := x.elim

instance : Hashable Unit where
  hash _ := 42

instance [Hashable a] [Hashable b] : Hashable (a ⊕ b) where
  hash
  | .inl a => hash (false, a)
  | .inr b => hash (true, b)

structure Inputs (ι : Type) (n : Nat) : Type  where
  ix : Fin n
  input : ι
deriving DecidableEq, Hashable

namespace Inputs

def elim0 {α : Sort u} (i : Inputs ι 0) : α :=
  i.ix.elim0

def latest (i : ι) : Inputs ι (n+1) where
  ix := ⟨n, by omega⟩
  input := i

def castLe (i : Inputs ι n) (hn : n ≤ m) : Inputs ι m where
  ix := ⟨i.ix, by omega⟩
  input := i.input

@[simp]
theorem castLe_eq_self {α : Type _} {n : Nat} (i : Inputs α n) (h : n ≤ n) :
    i.castLe h = i := by
  simp [Inputs.castLe]

@[simp]
theorem castLe_castLe_eq_castLe {α : Type _} {p q r : Nat}
  (i : Inputs α p) (h : p ≤ q) (h' : q ≤ r) :
    (i.castLe h).castLe h' = i.castLe (by omega) := by
  simp [Inputs.castLe]

/-- casts bits in `[0..n)` to `[m-n..m)` by shifting the index. -/
def castShift (i : Inputs ι n) (hn : n ≤ m) : Inputs ι m where
  ix := ⟨m - 1 - i.ix, by omega⟩
  input := i.input

def map (f : ι → ι') (i : Inputs ι n) : Inputs ι' n where
  ix := i.ix
  input := f i.input

def univ [DecidableEq ι] [Fintype ι] (n : Nat) :
    { univ : Finset (Inputs ι n) // ∀ x : Inputs ι n, x ∈ univ } :=
  let ixs : Finset (Fin n) := Finset.univ
  let inputs : Finset ι := Finset.univ
  let out := ixs.biUnion
      (fun ix => inputs.map ⟨fun input => Inputs.mk ix input, by intros a b; simp⟩)
  ⟨out, by
    intros i
    obtain ⟨ix, input⟩ := i
    simp [out]
    constructor
    · apply Fintype.complete
    · apply Fintype.complete
  ⟩


instance [DecidableEq ι] [Fintype ι] :
    Fintype (Inputs ι n) where
  elems := univ n |>.val
  complete := univ n |>.property

open Lean in
/-- Format an Inputs -/
def format (f : ι → Format) (is : Inputs ι n) : Format :=
  f!"⟨{f is.input}@{is.ix}⟩"

end Inputs


inductive Vars (σ : Type) (ι : Type) (n : Nat)
| state (s : σ)
| inputs (is : Inputs ι n)
deriving DecidableEq, Hashable

instance [Inhabited σ] : Inhabited (Vars σ ι n) where
  default := .state (default)

instance  [Inhabited ι] : Inhabited (Vars σ ι (n + 1)) where
  default := .inputs (Inputs.latest default)

instance [DecidableEq σ] [DecidableEq ι] [Fintype σ] [Fintype ι] : Fintype (Vars σ ι n) where
  elems :=
    let ss : Finset σ := Finset.univ
    let ss : Finset (Vars σ ι n) := ss.map ⟨Vars.state, by intros s s'; simp⟩
    let ii : Finset (Inputs ι n) := Finset.univ
    let ii : Finset (Vars σ ι n) := ii.map ⟨Vars.inputs, by intros ii ii'; simp⟩
    ss ∪ ii
  complete := by
    intros x
    simp
    rcases x with s | i  <;> simp

open Lean in
def Vars.format (fσ : σ → Format) (fι : ι → Format) {n : Nat} (v : Vars σ ι n) : Format :=
  match v with
  | .state s => fσ s
  | .inputs is => is.format fι

def Vars.castLe {n m : Nat} (v : Vars σ ι n) (hnm : n ≤ m) : Vars σ ι m :=
  match v with
  | .state s => .state s
  | .inputs is => .inputs (is.castLe hnm)

def Vars.castShift {n m : Nat} (v : Vars σ ι n) (hnm : n ≤ m) : Vars σ ι m :=
  match v with
  | .state s => .state s
  | .inputs is => .inputs (is.castShift hnm)

@[simp]
theorem Vars.castLe_state {n m : Nat} (s : σ) (hnm : n ≤ m) :
   (Vars.state s : Vars σ ι n).castLe hnm = Vars.state s := by rfl

/-- casting to the same width equals vars-/
@[simp]
theorem Vars.castLe_eq_self {α : Type _} {n : Nat} (v : Vars α σ n) (h : n ≤ n) :
    v.castLe h = v := by
  rcases v with x | i
  · simp [Vars.castLe]
  · simp [Vars.castLe]

/-- casting to the same width equals vars-/
@[simp]
theorem Vars.castLe_castLe_eq_castLe_self {α : Type _} {p q r : Nat}
  (v : Vars α σ p) (h : p ≤ q) (h' : q ≤ r) :
    (v.castLe h).castLe h' = v.castLe (by omega) := by
  rcases v with x | i
  · simp [Vars.castLe]
  · simp [Vars.castLe]

inductive Var (σ : Nat) (ι : Nat)
| state (s : Fin σ)
| input (i : Fin ι)
deriving DecidableEq, Hashable, Repr


/-- `FSM n` represents a function `BitStream → ⋯ → BitStream → BitStream`,
where `n` is the number of `BitStream` arguments,
as a finite state machine.
-/
structure FSM (ι : Nat) where
  /--
  The arity of the (finite) type `α` determines how many bits the internal carry state of this
  FSM has -/
  σ : ℕ
  /--
  `initCarry` is the value of the initial internal carry state.
  It maps each `α` to a bit, thus it is morally a bitvector where the width is the arity of `α`
  -/
  (initCarry : BitVec σ)
  /-- AIG for the transition function. -/
  (aig : Std.Sat.AIG (Var σ ι))
  /-- Circuit for the output. -/
  outputCirc : aig.Ref
  /-- Circuit for the next state, which has width 'σ' -/
  nextStateCirc : aig.RefVec σ



open Lean in
def formatSum (fα : α → Lean.Format) (fβ : β → Lean.Format) (x : α ⊕ β) : Lean.Format :=
  match x with | .inl x => f!"(l {fα x})" | .inr x => f!"(r {fβ x})"


open Lean in
instance FormatSum [formatα : ToFormat α] [formatβ : ToFormat β] : ToFormat (α ⊕ β) where
  format x := match x with | .inl x => f!"(l {format x})" | .inr x => f!"(r {format x})"

namespace FSM

variable {ι : Nat} (p : FSM ι)

/-- The size of the state space of the finite state machine. -/
def stateSpaceSize : Nat := Nat.pow 2 p.σ

/--
Return the total size of the FSM as a function of all of its circuits.
Note that this implicitly counts the size of the state space of the FSM,
and consequently, is the natural notion of complexity of the FSM.
-/
def circuitSize : Nat := Id.run do
  return 0

instance {α : Type _} [Hashable α] {f : α → Type _} [∀ (a : α), Hashable (f a)] : Hashable (Sigma f) where
  hash v := hash (v.fst, v.snd)

instance [Hashable α] [Hashable β] : Hashable (Sum α β) where
  hash
  | .inl a => hash (false, a)
  | .inr b => hash (true, b)

def composeBinary : Prop := sorry
def composeUnary : Prop := sorry


open Std Sat AIG in
def binop (op : {α : Type} → [DecidableEq α] → [Hashable α] → (aig : AIG α) → aig.BinaryInput → Entrypoint α) : FSM 2 :=
  let aig : Std.Sat.AIG (Var (σ := 0) (ι := 2)) := Std.Sat.AIG.empty
  let res := aig.mkAtomCached (Var.input 0)
  let aig := res.aig
  let l : aig.Ref := res.ref

  let res := aig.mkAtomCached (Var.input 1)
  let aig := res.aig
  let r : aig.Ref := res.ref
  have := by apply Std.Sat.AIG.LawfulOperator.le_size (f := Std.Sat.AIG.mkAtomCached)
  let l : aig.Ref := l.cast this
  let res := op ⟨l, r⟩
  let aig := res.aig
  let outputCirc : aig.Ref := res.ref
  let nextBitCirc : aig.RefVec 0 := RefVec.empty
  {
    σ := 0,
    aig := aig,
    outputCirc := outputCirc,
    nextStateCirc := nextBitCirc,
    initCarry := BitVec.zero 0
  }



open Std Sat AIG in
def and : FSM 2 := binop (fun aig binInput => aig.mkAndCached binInput)

open Std Sat AIG in
def or : FSM 2 := binop (fun aig binInput => aig.mkOrCached binInput)

open Std Sat AIG in
def xor : FSM 2 := binop (fun aig binInput => aig.mkXorCached binInput)


open Std Sat AIG in
/-- Equality, or alternatively, negation of the xor -/
def nxor : FSM 2 := binop (fun aig binInput => aig.mkBEqCached binInput)



/--
Scan a sequence of booleans with the bitwise and operator
Thus:

```lean
(scanAnd)[0] = in[0] &&& True
(scanAnd)[1] = in[1] &&& scanAnd[0]
(scanAnd)[2] = in[2] &&& scanAnd[1]
```
-/
def scanAnd  : FSM Unit :=
  {
   α := Unit,
   initCarry := fun () => true,
   nextBitCirc := fun _a => (Circuit.var true (inl ())) &&& (Circuit.var true (inr ()))
  }

def scanOr  : FSM Unit :=
  {
   α := Unit,
   initCarry := fun () => false,
   nextBitCirc := fun _α => (Circuit.var true (inl ())) ||| (Circuit.var true (inr ()))
  }


def add : FSM Bool :=
  { α := Unit,
    initCarry := λ _ => false,
    nextBitCirc := fun a =>
      match a with
      | some () =>
             (Circuit.var true (inr true)  &&& Circuit.var true (inr false))
             ||| (Circuit.var true (inr true)  &&& Circuit.var true (inl ()))
             ||| (Circuit.var true (inr false) &&& Circuit.var true (inl ()))
      | none => Circuit.var true (inr true) ^^^
                Circuit.var true (inr false) ^^^
                Circuit.var true (inl ()) }

/-!
We don't really need subtraction or negation FSMs,
given that we can reduce both those operations to just addition and bitwise complement -/

def sub : FSM Bool :=
  { α := Unit,
    initCarry := fun _ => false,
    nextBitCirc := fun a =>
      match a with
      | some () =>
             (Circuit.var false (inr true) &&& Circuit.var true (inr false)) |||
             ((Circuit.var false (inr true) ^^^ Circuit.var true (inr false)) &&&
              (Circuit.var true (inl ())))
      | none => Circuit.var true (inr true) ^^^
                Circuit.var true (inr false) ^^^
                Circuit.var true (inl ()) }


/-!
We define a borrow automata, whose output stream is the internal state of the subtraction automata,
which is the bits to be borrowed.

Compare against subAux.2
-/

def borrow : FSM Bool :=
  { α := Unit,
    -- Internal state is the current borrow.
    initCarry := fun _ => false,
    -- | TODO: check that this is in fact the borrow bit of the subtraction automata.
    -- Check that we do correctly compute the borrow bit here.
    nextBitCirc := fun _i =>
      let borrow := Circuit.var true (inl ())
      let a := Circuit.var true (inr true)
      let nota := Circuit.var false (inr true)
      let b := Circuit.var true (inr false)
      -- let borrow := (subAux x y n).2
      -- computing x - y:
      -- x y b | out-borrow
      -- 0 0 0 | 0
      -- 0 0 1 | 1
      -- 0 1 0 | 1
      -- 0 1 1 | 1
      -- 1 0 0 | 0
      -- 1 0 1 | 0
      -- 1 1 0 | 0
      -- 1 1 1 | 1
      -- (!a && b || ((!(xor a b)) && borrow))
      (nota &&& b/- !a && b-/) |||
      ((~~~ (a ^^^ b) /- !(xor a b) -/) &&& borrow)

  }


def neg : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun a =>
      match a with
      | some () => Circuit.var false (inr ()) &&& Circuit.var true (inl ())
      | none => Circuit.var false (inr ()) ^^^ Circuit.var true (inl ())  }


def not : FSM Unit :=
  { α := Empty,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.var false (inr ()) }


def zero : FSM (Fin 0) :=
  { α := Empty,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.fals }


def one : FSM (Fin 0) :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun a =>
      match a with
      | some () => Circuit.fals
      | none => Circuit.var true (inl ()) }


def negOne : FSM (Fin 0) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := fun _ => Circuit.tru }


/--
An FSM whose first output is `b`, and later outputs are whatever the input is.
-/
def ls (b : Bool) : FSM Unit :=
  { α := Unit,
    initCarry := fun _ => b,
    nextBitCirc := fun x =>
      match x with
      | none => Circuit.var true (inl ()) -- next state bit = state bit
      | some () => Circuit.var true (inr ()) } --


def var (n : ℕ) : FSM (Fin (n+1)) :=
  { α := Empty,
    i := by infer_instance,
    initCarry := Empty.elim,
    nextBitCirc := λ _ => Circuit.var true (inr (Fin.last _)) }

def incr : FSM Unit :=
  { α := Unit,
    initCarry := fun _ => true,
    nextBitCirc := fun x =>
      match x with
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
      | some _ => (Circuit.var true (inr ())) &&& (Circuit.var true (inl ())) }


def decr : FSM Unit :=
  { α := Unit,
    i := by infer_instance,
    initCarry := λ _ => true,
    nextBitCirc := fun x =>
      match x with
      | none => (Circuit.var true (inr ())) ^^^ (Circuit.var true (inl ()))
      | some _ => (Circuit.var false (inr ())) &&& (Circuit.var true (inl ())) }


def repeatBit : FSM Unit where
  α := Unit
  initCarry := fun () => false
  nextBitCirc := fun _ =>
    .or (.var true <| .inl ()) (.var true <| .inr ())

-- @[simp] theorem eval_repeatBit :
--     repeatBit.eval x = BitStream.repeatBit (x ()) := by
--   unfold BitStream.repeatBit
--   rw [eval_eq_eval', eval']
--   apply BitStream.corec_eq_corec
--     (R := fun a b => a.1 () = b.2 ∧ (a.2 ()) = b.1)
--   · simp [repeatBit]
--   · intro ⟨y, a⟩ ⟨b, x⟩ h
--     simp at h
--     simp [h, nextBit, BitStream.head]

end FSM

/-- An `FSMTermSolution `t` is an FSM with a witness that the FSM evaluates to the same value as `t` does -/
structure FSMTermSolution (t : Term) extends FSM (Fin t.arity) where
  ( good : t.evalFin = toFSM.eval )


/-- Compose two automata together, where `q` is an FSM -/
def composeUnaryAux
    (p : FSM Unit)
    (q : FSM arity) :
    FSM arity :=
  p.compose
    arity
    _
    (λ _ => id)
    (λ _ => q)

/-- Compose two automata together, where `q` is an FSMTermSolution -/
def composeUnary
    (p : FSM Unit)
    {t : Term}
    (q : FSMTermSolution t) :
    FSM (Fin t.arity) := composeUnaryAux p q.toFSM

def composeBinaryAux
    (p : FSM Bool)
    (q₁ : FSM (Fin a₁))
    (q₂ : FSM (Fin a₂)) :
    FSM (Fin (max a₁ a₂)) :=
  p.compose (Fin (max a₁ a₂))
    (λ b => Fin (cond b a₁ a₂))
    (λ b i => Fin.castLE (by cases b <;> simp) i)
    (λ b => match b with
      | true => q₁
      | false => q₂)

/-- Compose two binary opeators -/
def composeBinary
    (p : FSM Bool)
    {t₁ t₂ : Term}
    (q₁ : FSMTermSolution t₁)
    (q₂ : FSMTermSolution t₂) :
    FSM (Fin (max t₁.arity t₂.arity)) := composeBinaryAux p q₁.toFSM q₂.toFSM


@[simp] lemma composeUnaryAux_eval
    (p : FSM Unit)
    (q : FSM arity)
    (x : arity → BitStream) :
    (composeUnaryAux p q).eval x = p.eval (λ _ => q.eval x) := by
  simp [composeUnaryAux, FSM.eval_compose]

@[simp] lemma composeUnary_eval
    (p : FSM Unit)
    {t : Term}
    (q : FSMTermSolution t)
    (x : Fin t.arity → BitStream) :
    (composeUnary p q).eval x = p.eval (λ _ => t.evalFin x) := by
  simp [composeUnary, FSM.eval_compose, q.good]

@[simp] lemma composeBinaryAux_eval
    (p : FSM Bool)
    (q₁ : FSM (Fin a₁))
    (q₂ : FSM (Fin a₂))
    (x : Fin (max a₁ a₂) → BitStream) :
    (composeBinaryAux p q₁ q₂).eval x = p.eval
      (λ b => cond b (q₁.eval (fun i => x (Fin.castLE (by simp) i)))
                  (q₂.eval (fun i => x (Fin.castLE (by simp) i)))) := by
  rw [composeBinaryAux, FSM.eval_compose]
  ext b
  cases b <;> dsimp <;> congr <;> funext b <;> cases b <;> simp

@[simp] lemma composeBinary_eval
    (p : FSM Bool)
    {t₁ t₂ : Term}
    (q₁ : FSMTermSolution t₁)
    (q₂ : FSMTermSolution t₂)
    (x : Fin (max t₁.arity t₂.arity) → BitStream) :
    (composeBinary p q₁ q₂).eval x = p.eval
      (λ b => cond b (t₁.evalFin (fun i => x (Fin.castLE (by simp) i)))
                  (t₂.evalFin (fun i => x (Fin.castLE (by simp) i)))) := by
  rw [composeBinary, composeBinaryAux, FSM.eval_compose, q₁.good, q₂.good]
  ext b
  cases b <;> dsimp <;> congr <;> funext b <;> cases b <;> simp

instance {α β : Type} [Fintype α] [Fintype β] (b : Bool) :
    Fintype (cond b α β) := by
  cases b <;> simp <;> infer_instance


namespace FSM

/--
A finite state machine whose outputs are the bits of the natural number `n`,
in least to most significant bit order.

See that this uses only as much as as *log₂ n*, which is the correct
number of bits necessary to count up to `n`.
-/
def ofNat (n : Nat)  : FSM (Fin 0) :=
  match hn : n with
  | 0 => FSM.zero
--   | 1 => FSM.one
  | n' + 1 =>
    let bit := n.testBit 0
    let m := n / 2
    have h : m < n := by
      simp [m];
      apply Nat.div_lt_iff_lt_mul _ |>.mpr
      · omega
      · decide
    composeUnaryAux (FSM.ls bit) (ofNat m)


/-- Test the 'k'th bit of an integer.

* negSucc:
   - (n + 1)
   = -n - 1
   = (!x + 1) - 1 = !x
-/
def _root_.Int.testBit' (i : Int) (k : Nat) : Bool :=
  match i with
  | .ofNat n => n.testBit k
  | .negSucc n => !(n.testBit k)

/--
the 'k'th bit of 'w' is equal to the 'k'th bit we get by testing the integer representation.
-/
theorem BitVec.getLsbD_eq_toInt_testBit' (b : BitVec w) (hk : k < w) : b.getLsbD k = b.toInt.testBit' k := by
  rw [BitVec.getLsbD]
  rw [BitVec.toInt_eq_toNat_cond]
  by_cases hb : 2 * b.toNat < 2^w
  · simp [hb]
    rw [Int.testBit'.eq_def]
  · simp [hb]
    have : ↑b.toNat - 2 ^ w = Int.subNatNat b.toNat (2 ^ w) := by norm_cast
    rw [Int.testBit'.eq_def, this, Int.subNatNat_of_lt (by omega)]
    simp
    let notb := (~~~ b).toNat
    rw [show 2^w - b.toNat - 1 = 2^w - 1 - b.toNat by omega, ← BitVec.toNat_not]
    rw [← BitVec.getLsbD, ← BitVec.getLsbD]
    simp
    omega


/--
If `i < -1`, then `i` is less than `i / 2`.
If `i = -1`, then `-1 / 2 = -1` (floor division of integers).
-/
private theorem Int.lt_of_neg {i : Int} (hi : i < - 1) : i < i / 2 := by
  have h : (2 ∣ i) ∨ (2 ∣ (i - 1)) := by
    omega
  rcases h with h | h
  · rw [Int.div_def]
    apply Int.lt_ediv_of_mul_lt <;> omega
  · have hi : i = (i - 1) + 1 := by omega
    conv =>
      rhs
      rw [hi]
    rw [Int.add_ediv_of_dvd_left]
    · simp only [Int.reduceDiv, add_zero]
      apply Int.lt_ediv_of_mul_lt
      · omega
      · exact h
      · omega
    · omega

/-- Build a finite state machine for the integer `i` -/
def ofInt (x : Int) : FSM (Fin 0) :=
  match x with
  | .ofNat n => ofNat n
  | .negSucc n =>
      composeUnaryAux neg (ofNat (n + 1))

/--
The result of `FSM.ofInt x` matches with `BitStream.ofInt x`.
-/
theorem eval_ofInt (x : Int) (i : Nat) {env : Fin 0 → BitStream} :
    (ofInt x).eval env i = BitStream.ofInt x i := by
  rcases x with x | x
  · simp [ofInt, BitStream.ofInt]
  · simp only [ofInt, composeUnaryAux_eval, eval_neg, BitStream.ofInt]
    -- TODO: why does 'congr' not work here?
    apply congrFun
    apply congrArg
    ext i
    simp


/-- Identity finite state machine -/
def id : FSM Unit := {
 α := Empty,
 initCarry := Empty.elim,
 nextBitCirc := fun a =>
   match a with
   | none => (Circuit.var true (inr ()))
   | some f => f.elim
}

@[simp]
def eval_id (env: Unit → BitStream) (i : Nat) : id.eval env i = (env ()) i := rfl

/-- Build logical shift left automata by `n` bits -/
def shiftLeft (n : Nat) : FSM Unit :=
  match n with
  | 0 => FSM.id
  | n + 1 => composeUnaryAux (FSM.ls false) (shiftLeft n)

@[simp]
theorem eval_shiftLeft (k : Nat) (env : Unit → BitStream) (i : Nat) :
    (shiftLeft k).eval env i = ((decide (k ≤ i)) && ((env ()) (i - k))) := by
  induction k generalizing i
  case zero =>
    simp [shiftLeft]
  case succ k ih =>
    simp[shiftLeft]
    rcases i with rfl | i
    · simp
    · simp [ih]

/--
Build an FSM whose state is `true` at step `n`,
and `false` everywhere else.
-/
def trueOnlyAt (n : Nat) : FSM (Fin 0) := ofNat (1 <<< n)

/- `Nat.testBit 1 i = false` if and only if `i` is nonzero. -/
@[simp]
private theorem _root_.Nat.testBit_one_eq_false_iff (i : Nat) :
    Nat.testBit 1 i = false ↔ i ≠ 0 := by
  constructor
  · simp only [ne_eq]
    by_cases hi : i = 0 <;> simp [hi]
  · intros h
    rw [Nat.testBit, Nat.shiftRight_eq_div_pow]
    have : 2^i ≥ 2 := by
      exact Nat.le_self_pow h 2
    simp only [Nat.one_and_eq_mod_two, Nat.mod_two_bne_zero, beq_eq_false_iff_ne,
      ne_eq, Nat.mod_two_not_eq_one]
    rw [Nat.mod_eq_of_lt]
    · apply Nat.div_eq_zero_iff |>.mpr; omega
    · apply Nat.div_lt_of_lt_mul
      omega

/--
`falseOnlyAt n` builds an FSM that is `false` at state `n` and
`true` everywhere else. This is useful to build a predicate that
checks if we are in the `n`th state.
-/
@[simp]
theorem eval_trueOnlyAt (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (trueOnlyAt n).eval env i = decide (i = n) := by
  simp [trueOnlyAt]
  by_cases hn : i = n
  · simp [hn]
  · simp [hn]
    omega

/--
Build an FSM whose state is `false` at step `n`,
and `true` everywhere else.
-/
def falseOnlyAt (n : Nat) : FSM (Fin 0) :=
  composeUnaryAux FSM.not (trueOnlyAt n)

/--
`falseOnlyAt n` builds an FSM that is `false` at state `n` and
`true` everywhere else. This is useful to build a predicate that
checks if we are in the `n`th state.
-/
@[simp] theorem eval_falseOnlyAt (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (falseOnlyAt n).eval env i = !decide (i = n) := by simp [falseOnlyAt]

/--
Build an FSM whose value is 'true' for states [0, 1, ... n),
and 'false' after.
-/
def trueUptoExcluding (n : Nat) : FSM (Fin 0) :=
  ofNat (BitVec.allOnes n).toNat
@[simp] theorem eval_trueUptoExcluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (trueUptoExcluding n).eval env i = decide (i < n) := by simp [trueUptoExcluding]

def falseAfterIncluding (n : Nat) : FSM (Fin 0) := trueUptoExcluding n
private theorem falseAfterIncluding_false_iff (n i : Nat) {env : Fin 0 → BitStream} :
  (falseAfterIncluding n).eval env i = false ↔ i ≥ n := by simp [falseAfterIncluding];
@[simp] theorem eval_falseAfterIncluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (falseAfterIncluding n).eval env i = decide (i < n) := by
  simp [falseAfterIncluding]

/--
Build an FSM whose value is 'true' for states [0, 1, ... n] (including the endpoint),
and 'false' after.
-/
def trueUptoIncluding (n : Nat) : FSM (Fin 0) := ofNat (BitVec.allOnes (n+1)).toNat
@[simp] theorem eval_trueUptoIncluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (trueUptoIncluding n).eval env i = decide (i ≤ n) := by
  simp [trueUptoIncluding]; omega
def falseAfterExcluding (n : Nat) : FSM (Fin 0) := trueUptoIncluding n
private theorem falseAfterExcluding_false_iff (n i : Nat) {env : Fin 0 → BitStream} :
  (falseAfterExcluding n).eval env i = false ↔ i > n := by simp [falseAfterExcluding]
@[simp] theorem eval_falseAfterExcluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (falseAfterExcluding n).eval env i = decide (i ≤ n) := by simp [falseAfterExcluding]

/--
Build an FSM whose value is and 'false' for the first [0, 1, ... n), and 'true' for [n, n + 1, ...).
-/
def falseUptoExcluding (n : Nat) : FSM (Fin 0) := composeUnaryAux FSM.not (FSM.trueUptoExcluding n)
@[simp] theorem eval_falseUptoExcluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (falseUptoExcluding n).eval env i = decide (n ≤ i) := by
  simp [falseUptoExcluding];
  by_cases hi : i < n <;> (simp [hi]; try omega)
/--
Psychological theorem to see that 'i < n'
if and only if 'falseUptoExcluding' evaluates to 'false
-/
private theorem falseUptoExcluding_eq_false_iff (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    ((falseUptoExcluding n).eval env i = false) ↔ i < n := by simp;

/--
Build an FSM whose value is false' for the first [0, 1, ... n],
and 'true' for (n, n + 1, ...) (excluding the startpoint)
-/
def falseUptoIncluding (n : Nat) : FSM (Fin 0) :=
  composeUnaryAux FSM.not (FSM.trueUptoIncluding n)
@[simp] theorem eval_falseUptoIncluding (n : Nat) (i : Nat) {env : Fin 0 → BitStream} :
    (falseUptoIncluding n).eval env i = decide (n < i) := by
  simp [falseUptoIncluding];
  by_cases hi : n < i <;> (simp [hi]; try omega)


end FSM

open Term

/--
Note that **this is the value that is run by decide**.
-/
def termEvalEqFSM : ∀ (t : Term), FSMTermSolution t
  | ofNat n =>
    { toFSM := FSM.ofNat n,
      good := by ext; simp [Term.evalFin] }
  | var n =>
    { toFSM := FSM.var n,
      good := by ext; simp [Term.evalFin] }
  | zero =>
    { toFSM := FSM.zero,
      good := by ext; simp [Term.evalFin] }
  | one =>
    { toFSM := FSM.one,
      good := by ext; simp [Term.evalFin] }
  | negOne =>
    { toFSM := FSM.negOne,
      good := by ext; simp [Term.evalFin] }
  | Term.and t₁ t₂ =>
    let q₁ := termEvalEqFSM t₁
    let q₂ := termEvalEqFSM t₂
    { toFSM := composeBinary FSM.and q₁ q₂,
      good := by ext; simp }
  | Term.or t₁ t₂ =>
    let q₁ := termEvalEqFSM t₁
    let q₂ := termEvalEqFSM t₂
    { toFSM := composeBinary FSM.or q₁ q₂,
      good := by ext; simp }
  | Term.xor t₁ t₂ =>
    let q₁ := termEvalEqFSM t₁
    let q₂ := termEvalEqFSM t₂
    { toFSM := composeBinary FSM.xor q₁ q₂,
      good := by ext; simp }
  | Term.not t =>
    let q := termEvalEqFSM t
    { toFSM := by dsimp [arity]; exact composeUnary FSM.not q,
      good := by ext; simp }
  | add t₁ t₂ =>
    let q₁ := termEvalEqFSM t₁
    let q₂ := termEvalEqFSM t₂
    { toFSM := composeBinary FSM.add q₁ q₂,
      good := by ext; simp }
  | sub t₁ t₂ =>
    let q₁ := termEvalEqFSM t₁
    let q₂ := termEvalEqFSM t₂
    { toFSM := composeBinary FSM.sub q₁ q₂,
      good := by ext; simp }
  | neg t =>
    let q := termEvalEqFSM t
    { toFSM := by dsimp [arity]; exact composeUnary FSM.neg q,
      good := by ext; simp }
  | shiftL t k =>
     let q := termEvalEqFSM t
     {
       toFSM := by dsimp [arity]; exact composeUnary (FSM.shiftLeft k) q,
       good := by
         ext x i
         simp only [evalFin, BitStream.eval_shiftLeft, Bool.if_false_left, arity.eq_13, id_eq,
           composeUnary_eval, FSM.eval_shiftLeft]
         by_cases hi : i < k
         · simp [hi]
         · simp [hi]; omega
     }

/-!
FSM that implement bitwise-and. Since we use `0` as the good state,
we keep the invariant that if both inputs are good and our state is `0`, then we produce a `0`.
If not, we produce an infinite sequence of `1`.
-/
def and : FSM Bool :=
  { α := Unit,
    initCarry := fun _ => false,
    nextBitCirc := fun a =>
      match a with
      | some () =>
             -- Only if both are `0` we produce a `0`.
             (Circuit.var true (inr false)  |||
             ((Circuit.var false (inr true) |||
              -- But if we have failed and have value `1`, then we produce a `1` from our state.
              (Circuit.var true (inl ())))))
      | none => -- must succeed in both arguments, so we are `0` if both are `0`.
                Circuit.var true (inr true) |||
                Circuit.var true (inr false)
                }

/-!
FSM that implement bitwise-or. Since we use `0` as the good state,
we keep the invariant that if either inputs is `0` then our state is `0`.
If not, we produce a `1`.
-/
def or : FSM Bool :=
  { α := Unit,
    initCarry := fun _ => false,
    nextBitCirc := fun a =>
      match a with
      | some () =>
             -- If either succeeds, then the full thing succeeds
             ((Circuit.var true (inr false)  &&&
             ((Circuit.var false (inr true)) |||
             -- On the other hand, if we have failed, then propagate failure.
              (Circuit.var true (inl ())))))
      | none => -- can succeed in either argument, so we are `0` if either is `0`.
                Circuit.var true (inr true) &&&
                Circuit.var true (inr false)
                }

/-- An `FSMPredicateSolution `t` is an FSM with a witness that the FSM evaluates to the same value as `t` does -/
structure FSMPredicateSolution (p : Predicate) extends FSM (Fin p.arity) where
  ( good : p.evalFin = toFSM.eval )


def fsmUlt (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeUnaryAux (FSM.ls true) <| (composeUnaryAux FSM.not <| composeBinaryAux FSM.borrow a b)

@[simp]
theorem eval_fsmUlt_eq_evalFin_Predicate_ult (t₁ t₂ : Term) :
   (fsmUlt (termEvalEqFSM t₁).toFSM (termEvalEqFSM t₂).toFSM).eval = (Predicate.binary .ult t₁ t₂).evalFin  := by
  ext x i
  generalize ha : termEvalEqFSM t₁ = a
  generalize hb : termEvalEqFSM t₂ = b
  simp [fsmUlt, Predicate.evalUlt, a.good, b.good]

def fsmEq (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeUnaryAux FSM.scanOr <| composeUnaryAux (FSM.ls false) <|  composeBinaryAux FSM.xor a b

/-- Evaluation FSM.eq is the same as evaluating Predicate.eq.evalFin. -/
@[simp]
theorem eval_fsmEq_eq_evalFin_Predicate_eq (t₁ t₂ : Term) :
   (fsmEq (termEvalEqFSM t₁).toFSM (termEvalEqFSM t₂).toFSM).eval = (Predicate.binary .eq t₁ t₂).evalFin  := by
  ext x i
  generalize ha : termEvalEqFSM t₁ = a
  generalize hb : termEvalEqFSM t₂ = b
  simp [fsmEq, Predicate.evalEq, a.good, b.good]

def fsmNeq (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeUnaryAux FSM.scanAnd <| composeUnaryAux (FSM.ls true) <| composeBinaryAux FSM.nxor a b

/-- Evaluation FSM.eq is the same as evaluating Predicate.eq.evalFin. -/
@[simp]
theorem eval_fsmNeq_eq_evalFin_Predicate_neq (t₁ t₂ : Term) :
   (fsmNeq (termEvalEqFSM t₁).toFSM (termEvalEqFSM t₂).toFSM).eval = (Predicate.binary .neq t₁ t₂).evalFin  := by
  ext x i
  generalize ha : termEvalEqFSM t₁ = a
  generalize hb : termEvalEqFSM t₂ = b
  simp [fsmNeq, Predicate.evalNeq, a.good, b.good]

def fsmLand (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeBinaryAux FSM.or a b

def fsmLor (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeBinaryAux FSM.and a b

def fsmUle (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l ⊔ (k ⊔ l))) :=
  let ult := fsmUlt a b
  let eq := fsmEq a b
  fsmLor ult eq


def fsmMsbEq (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l)) :=
  composeUnaryAux (FSM.ls false) <| composeBinaryAux FSM.xor a b

-- theorem fsmMsbNeq_eq_Predicate_MsbNeq (t₁ t₂ : Term) :
--   (Predicate.msbNeq t₁ t₂).evalFin = (fsmMsbNeq (termEvalEqFSM t₁).toFSM (termEvalEqFSM t₂).toFSM).eval := sorry

def fsmSlt (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l ⊔ (k ⊔ l))) :=
  let msbCheck := fsmMsbEq a b
  let ult := fsmUlt a b
  composeBinaryAux FSM.xor ult msbCheck

/--
TODO: implement FSM.cast so we don't need to accumulate `max`s in this godforsaken fashion.
This needs a `Circuit.cast` as well, so we do this after we have verified end-to-end
correctness.
-/
def fsmSle (a : FSM (Fin k)) (b : FSM (Fin l)) : FSM (Fin (k ⊔ l ⊔ (k ⊔ l) ⊔ (k ⊔ l))) :=
  let slt := fsmSlt a b
  let eq := fsmEq a b
  let out := fsmLor slt eq
  out


/--
Evaluating the eq predicate equals the FSM value.
Note that **this is the value that is run by decide**.
-/
def predicateEvalEqFSM : ∀ (p : Predicate), FSMPredicateSolution p
  | .width .eq n =>
    {
      toFSM := FSM.falseOnlyAt n
      good := by
        ext i x
        simp only [Predicate.evalFin, Bool.decide_eq_true, Predicate.arity.eq_1,
          FSM.eval_falseOnlyAt]
        by_cases h : x = n  <;> simp [h]
    }
  | .width .neq n =>
     {
      toFSM := FSM.trueOnlyAt n
      good := by
        ext i x
        simp only [Predicate.evalFin, Bool.decide_eq_true, Predicate.arity.eq_2,
          FSM.eval_trueOnlyAt]
        by_cases h : x = n <;> simp [h]
     }
  | .width .ge n =>
     {
      toFSM := FSM.falseAfterIncluding n
      good := by ext; simp
     }
  | .width .gt n =>
     {
      toFSM := FSM.falseAfterExcluding n
      good := by ext; simp
     }
  | .width .lt n =>
     {
      toFSM := FSM.falseUptoExcluding n
      good := by ext; simp
     }
  | .width .le n =>
     {
      toFSM := FSM.falseUptoIncluding n
      good := by ext; simp
     }
  | .binary .eq t₁ t₂ =>
    let t₁ := termEvalEqFSM t₁
    let t₂ := termEvalEqFSM t₂
    {
     -- At width 0, all things are equal.
     toFSM := fsmEq t₁.toFSM t₂.toFSM
     good := by
      ext x i
      rw [eval_fsmEq_eq_evalFin_Predicate_eq]
    }
  | .binary .neq t₁ t₂ =>
    let t₁ := termEvalEqFSM t₁
    let t₂ := termEvalEqFSM t₂
    {
     -- At width 0, all things are equal, so the predicate is untrue.
     -- If it ever becomes `0`, it should stay `0` forever, because once
     -- two bitstreams become disequal, they stay disequal!
     toFSM := fsmNeq t₁.toFSM t₂.toFSM
     good := by ext; rw [eval_fsmNeq_eq_evalFin_Predicate_neq]
    }
   | .land p q =>
     let x₁ := predicateEvalEqFSM p
     let x₂ :=  predicateEvalEqFSM q
     {
       -- If this ever becomes `1`, it should stay `1`,
       -- since once it's falsified, it should stay falsified!
       toFSM := fsmLand x₁.toFSM x₂.toFSM
       good := by ext x i; simp [Predicate.evalLand, fsmLand, x₁.good, x₂.good]
     }
   | .lor p q =>
     let x₁ := predicateEvalEqFSM p
     let x₂ :=  predicateEvalEqFSM q
     {
       -- If it ever becomes `1`, it should stay `1`,
       -- since one it's falsified, it should stay falsified!
       toFSM := fsmLor  x₁.toFSM x₂.toFSM
       good := by ext x i; simp [Predicate.evalLor, fsmLor, x₁.good, x₂.good]
     }
   | .binary .slt t₁ t₂ =>
     let a := termEvalEqFSM t₁
     let b := termEvalEqFSM t₂
     { toFSM := fsmSlt a.toFSM b.toFSM
       good := by
        ext;
        simp [Predicate.evalSlt, fsmSlt,
          Predicate.evalUlt, fsmUlt, a.good, b.good, Predicate.evalMsbEq, fsmMsbEq, a.good, b.good]
     }
   | .binary .sle t₁ t₂ =>
      let a := termEvalEqFSM t₁
      let b := termEvalEqFSM t₂
      {
        toFSM := fsmSle a.toFSM b.toFSM
        good := by
          ext x i
          simp [fsmSle,
            Predicate.evalLor, fsmLor,
            Predicate.evalSlt, fsmSlt, Predicate.evalUlt,
            fsmUlt, a.good, b.good, Predicate.evalMsbEq, fsmMsbEq,
            Predicate.evalEq, fsmEq, a.good, b.good]
      }
   | .binary .ult t₁ t₂ =>
      let a := termEvalEqFSM t₁
      let b := termEvalEqFSM t₂
      let out := {
       -- a <u b if when we compute (a - b), we must borrow a value.
       toFSM := fsmUlt a.toFSM b.toFSM
       good := by
         ext x i
         simp [fsmUlt, a.good, b.good, Predicate.evalUlt]
      }
      out
   | .binary .ule t₁ t₂ =>
      let a := termEvalEqFSM t₁
      let b := termEvalEqFSM t₂
      {
        toFSM := fsmUle a.toFSM b.toFSM
        good := by
          ext x i
          simp [fsmUle, fsmUlt, fsmEq, fsmLor, a.good, b.good, Predicate.evalLor, Predicate.evalUlt, Predicate.evalEq]
      }



end FSM
