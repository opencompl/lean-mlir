/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We represent inputs and variables for FSM instantiations.

Authors: Siddharth Bhat

-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Defs
import Mathlib.Data.Finset.Union
import Mathlib.Data.Fintype.Defs
import Mathlib.Data.FinEnum
import Mathlib.Data.Multiset.FinsetOps

/--
An inductive type representing the variables in the unrolled FSM circuit,
where we unroll for 'n' steps.
-/
structure Inputs (ι : Type) (n : Nat) : Type  where
  ix : Fin n
  input : ι
deriving DecidableEq, Hashable


namespace Inputs

def elimEmpty {α : Sort u} (i : Inputs Empty i) : α :=
  i.input.elim

def elim0 {α : Sort u} (i : Inputs ι 0) : α :=
  i.ix.elim0

def latest (i : ι) : Inputs ι (n+1) where
  ix := ⟨n, by omega⟩
  input := i

def castLe (i : Inputs ι n) (hn : n ≤ m) : Inputs ι m where
  ix := ⟨i.ix, by omega⟩
  input := i.input

@[simp]
theorem castLe_mk_eq_mk {α : Type _} {n m : Nat} (i : Fin n) (h : n ≤ m) (x : α) :
    (Inputs.mk i x).castLe h = Inputs.mk (i.castLE (by omega)) x := by
  simp [Inputs.castLe]
  rfl

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

-- at 0:
-- + free s0.

-- at 1:
-- + free s0
-- --- x ---
-- + o0 = evalWith(s0, i0).
-- + s1 = carryWith(s0, i0)
-- --- x ---

-- at 2:
-- + free s0
-- --- x ---
-- + o0 = evalWith(s0, i0).
-- + s1 = carryWith(s0, i0)
-- --- x ---
-- + o1 = evalWith(s1, i1).
-- + s2 = carryWith(s1, i1)

inductive Vars (σ : Type) (ι : Type) (n : Nat)
| state (s : Inputs σ (n + 1))
| inputs (is : Inputs ι n)
| outputs (os : Fin n) -- there is one output bit for each step.
deriving DecidableEq, Hashable

/--
A state variable for the initial state.
-/
def Vars.state0 (s : σ) {n : Nat} : Vars σ ι n :=
  .state (Inputs.mk ⟨0, by omega⟩ s)

def Vars.stateN (s : σ) (i : Nat) {n : Nat} (hin : i ≤ n := by omega) : Vars σ ι n :=
  .state (Inputs.mk ⟨i, by omega⟩ s)

@[simp]
theorem state0_eq_stateN_zero {σ : Type} {ι : Type} {n : Nat} (s : σ) :
    (Vars.state0 s : Vars σ ι n) = Vars.stateN s 0 := by
  simp [Vars.state0, Vars.stateN]

theorem stateN_zero_eq_state0 {σ : Type} {ι : Type} {n : Nat} (s : σ) :
    Vars.stateN s 0 = (Vars.state0 s : Vars σ ι n) := by
  simp [Vars.state0, Vars.stateN]


def Vars.inputN (inp : ι) (k : Nat) {n : Nat} (hkn : k < n := by omega) : Vars σ ι n :=
  .inputs (Inputs.mk ⟨k, by omega⟩ inp)


instance [Inhabited σ] : Inhabited (Vars σ ι n) where
  default := .state (Inputs.mk ⟨0, by omega⟩ default)

instance  [Inhabited ι] : Inhabited (Vars σ ι (n + 1)) where
  default := .inputs (Inputs.latest default)

instance [DecidableEq σ] [DecidableEq ι] [Fintype σ] [Fintype ι] : Fintype (Vars σ ι n) where
  elems :=
    let ss : Finset (Inputs σ (n + 1)) := Finset.univ
    let ss : Finset (Vars σ ι n) := ss.map ⟨Vars.state, by intros s s'; simp⟩

    let ii : Finset (Inputs ι n) := Finset.univ
    let ii : Finset (Vars σ ι n) := ii.map ⟨Vars.inputs, by intros ii ii'; simp⟩

    let oo : Finset (Fin n) := Finset.univ
    let oo : Finset (Vars σ ι n) := oo.map ⟨Vars.outputs, by intros o o'; simp⟩

    ss ∪ ii ∪ oo
  complete := by
    intros x
    simp
    rcases x with s | i  <;> simp

open Lean in
def Vars.format (fσ : σ → Format) (fι : ι → Format) {n : Nat} (v : Vars σ ι n) : Format :=
  match v with
  | .state ss => ss.format fσ
  | .inputs is => is.format fι
  | .outputs os => f!"{os}"

def Vars.castLe {n m : Nat} (v : Vars σ ι n) (hnm : n ≤ m) : Vars σ ι m :=
  match v with
  | .state ss => .state (ss.castLe (by omega))
  | .inputs is => .inputs (is.castLe hnm)
  | .outputs os =>
    .outputs (os.castLE (by omega))

def Vars.castShift {n m : Nat} (v : Vars σ ι n) (hnm : n ≤ m) : Vars σ ι m :=
  match v with
  | .state ss => .state (ss.castShift (by omega))
  | .inputs is => .inputs (is.castShift hnm)
  | .outputs os =>
    .outputs ⟨os.val + (m - n), by omega⟩

-- @[simp]
-- theorem Vars.castLe_state {n m : Nat} (s : σ) (hnm : n ≤ m) :
--    (Vars.state s : Vars σ ι n).castLe hnm = Vars.state s := by rfl

/-- casting to the same width equals vars-/
@[simp]
theorem Vars.castLe_eq_self {n : Nat} (v : Vars σ ι n) (h : n ≤ n) :
    v.castLe h = v := by
  rcases v with x | i
  · simp [Vars.castLe]
  · simp [Vars.castLe]
  · simp [Vars.castLe]

@[simp]
theorem Vars.castLe_outputs_mk_eq_outputs {n i m : Nat} (hi : i < n) (hnm : n ≤ m) :
  ((Vars.outputs ⟨i, hi⟩ : Vars σ ι n).castLe (by omega) : Vars σ ι m) =
     Vars.outputs ⟨i, by omega⟩ := by
  simp [Vars.castLe]

@[simp]
theorem Vars.castLe_stateN_eq_stateN  {n i m : Nat} (hi : i ≤ n) (hnm : n ≤ m) :
  (Vars.stateN s i : Vars σ ι n).castLe hnm =
  Vars.stateN s i (hin := by omega) := by
  rfl

@[simp]
theorem Vars.castLe_state_Inputs_mk_eq_state_castLe_Inputs_mk {n m : Nat}
    (hnm : n ≤ m) {s : σ} {i : Fin (n + 1)} :
    (Vars.state (Inputs.mk i s) : Vars σ ι n).castLe hnm =
    (Vars.state (Inputs.mk (i.castLE (by omega)) s) : Vars σ ι m) := by
  simp [Vars.castLe]


@[simp]
theorem Vars.castLe_inputs_eq_inputs {n i m : Nat} (hi : i < n) (hnm : n ≤ m) :
  (Vars.inputN inp i hi : Vars σ ι n).castLe hnm =
  Vars.inputN inp i (by omega) := by
  rfl

/-- casting to the same width equals vars-/
@[simp]
theorem Vars.castLe_castLe_eq_castLe_self {α : Type _} {p q r : Nat}
  (v : Vars α σ p) (h : p ≤ q) (h' : q ≤ r) :
    (v.castLe h).castLe h' = v.castLe (by omega) := by
  rcases v with x | i
  · simp [Vars.castLe]
  · simp [Vars.castLe]
  · simp [Vars.castLe]


