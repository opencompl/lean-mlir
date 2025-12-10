import Mathlib.Data.Stream.Defs
import Mathlib.Logic.Function.Iterate
import Mathlib.Data.Stream.Init
import Batteries.Data.List.Basic
import LeanMLIR.HVector

/-!
We introduce the `HandshakeStream` type to model latency-insensitive hardware abstraction.
Each elemet of a `HandshakeStream β` is either an element `b` of type `β` or `none`.
-/

namespace HandshakeStream

/-! # Basic Definitions -/

/-- An infinite sequence of *potential* values. -/
def Stream (β : Type) := Stream' (Option β)

def map {α β : Type} (s : Stream α) (f : α → β) : Stream β :=
  fun i => (s i).map f

def mapOpt {α β : Type} (s : Stream α) (f : α → (Option β)) : Stream β :=
  fun i => (s i).bind f

def corec {α} {β} (s0 : β) (f : β → (Option α × β)) : Stream α :=
  Stream'.corec (f · |>.fst) (f · |>.snd) s0

def corec_prod {β} (s0 : β) (f : β → (Option α × Option γ × β)) : Stream α × Stream γ :=
  let f' := fun b =>
    let x := f b
    (x.fst, x.snd.fst)
  let g := (f · |>.snd.snd)
  let x := Stream'.corec f' g s0
  (
    fun i => (x i).fst,
    fun i => (x i).snd,
  )

/-- Return the first element of a stream -/
def head : Stream α → Option α := Stream'.head

/-- Drop the first element of a stream -/
def tail : Stream α → Stream α := Stream'.tail

/-- Expand a finite list of values into a stream, by appending an infinte amount of `none`s -/
def ofList (vals : List α) : Stream α :=
  fun i => (vals[i]?).join

/-- Return the first `n` messages (including `none`s) as a list -/
def toList (n : Nat) (x : Stream α) : List (Option α) :=
  List.ofFn (fun (i : Fin n) => x i)

/--
  Returns the tail of a stream `x`, if the first element is a `none`.
  Otherwise, returns `x` unchanged.
-/
def dropFirstNone (x : Stream α) : Stream α :=
  if x.head.isNone then
    x.tail
  else
    x

/--
Transpose a vector of streams into a single stream of vectors, such that all
values (i.e., not-`none` entries of the stream) are preserved.

See also `transpose`, which is a bit more lenient about the shape of the input
vector, at the cost of needing an extra proof.
-/
def transpose' {A : α → Type} {as : List α}
    (xs : HVector (fun a => Stream (A a)) as) :
    Stream (HVector A as) :=
  corec xs fun xs =>
    let xs := xs.map fun _ x => HandshakeStream.dropFirstNone x
    let out := xs.mapM fun _ x => x.head
    -- ^^ `out` is `none` if *any* of `x.head` is `none`.
    let xs :=
      if out.isSome
        then xs.map fun _ x => x.tail
        else xs

    (out, xs)

/--
Transpose a vector of streams into a single stream of vectors, such that all
values (i.e., not-`none` entries of the stream) are preserved.

See also `transpose'`, which does not require the extra proof.
-/
def transpose {A} {as : List α} (xs : HVector A as)
    {B : α → Type}
    (h : ∀ (i : Fin as.length), A as[i] = Stream (B as[i])) :
    Stream (HVector B as) :=
  transpose' <| xs.castFun h

/-!
  # Weak Bisimulation
  We establish a notion of equivalence that allows us to remove any finite sequence of
  `none`s from a stream.
-/

/-- Two streams are considered equivalent if they contain the same `some _` messages,
  in the same order. That is, any finite sequence of `none`s may be ignored. -/
coinductive Bisim : Stream α → Stream α → Prop where
| step {a b : Stream α} {n m : Nat} : Bisim (a.drop (n + 1)) (b.drop (m+1))
    → a.get n = b.get m
    → (∀ i < n, a.get i = none)
    → (∀ j < m, b.get j = none)
    → Bisim a b

/-- Set up scoped notation `x ~ y` for equivalence -/
scoped infix:50 " ~ " => Bisim

theorem rfl {a : Stream α} : a ~ a := by
  apply Bisim.coinduct (fun a b => a = b)
  · intro a b hyp
    rw [hyp]
    refine ⟨0, 0, ?_⟩
    grind
  · rfl

@[symm] theorem symm {a b : Stream α} : a ~ b → b ~ a := by
  intro hb
  apply Bisim.coinduct (fun x y => y ~ x)
  · intro s1 s2 hyp
    rw [Bisim] at hyp
    grind
  · exact hb


theorem trans {a b : Stream α} : a ~ b → b ~ c → a ~ c := by
  intros hab hbc
  apply Bisim.coinduct (fun x z => ∃ y, x ~ y ∧ y ~ z)
  · sorry
  · exact ⟨b, hab, hbc⟩


def StreamWithoutNones' (α : Type) : Type :=
  Quot (Bisim : Stream α → Stream α → Prop)

instance StreamSetoid (α : Type) : Setoid (Stream α) where
  r := Bisim
  iseqv := Equivalence.mk (refl := by apply HandshakeStream.rfl) HandshakeStream.symm HandshakeStream.trans

def StreamWithoutNones (α : Type) : Type :=
  Quotient (StreamSetoid α)

/--
  info: 'HandshakeStream.StreamWithoutNones' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound]
-/
#guard_msgs in
#print axioms StreamWithoutNones

def remNone {α : Type} (lst : Stream α) : (StreamWithoutNones α) := Quotient.mk _ lst

def StreamWithoutNones.hasStream (x : StreamWithoutNones α) : Set (Stream α) :=
  { y | x = Quotient.mk _ y }

/-- A determinate component with no `none` elements-/
def nondeterminify (f : Stream α → Stream α) (x : StreamWithoutNones α) : Set (StreamWithoutNones α) :=
  { Quotient.mk _ (f y) | y ∈ StreamWithoutNones.hasStream x }

def nondeterminify2 (f : Stream α → Stream α → Stream α) (x : StreamWithoutNones α × StreamWithoutNones α) : Set (StreamWithoutNones α) :=
  { x1 | ∃ y1 y2, (y1 ∈ StreamWithoutNones.hasStream x.fst)
                  ∧ (y2 ∈ StreamWithoutNones.hasStream x.snd)
                  ∧ Quotient.mk _ (f y1 y2) = x1 }

/-! # Synchronizing maps
  We define synchronized sets of streams with different cardinality and state-space.
-/

/-- Synchronize two input streams, as soon as two elements are available
  apply a function `f` applied to the two elements and to the state-space, and push its result to the output stream.
-/
def syncMapAccum₂ (init : σ) (f : α → β → σ → γ × σ) (xs : Stream α) (ys : Stream β) :
    Stream γ :=
  HandshakeStream.corec (⟨xs, ys, init⟩ : _ × _ × _) fun ⟨xs, ys, s⟩ =>
    match xs 0, ys 0 with
    | some x, some y =>
      let ⟨z, s'⟩ := f x y s
      ⟨some z, xs.tail, ys.tail, s'⟩
    | _, _ =>
      let xs := if (xs 0).isNone then xs.tail else xs
      let ys := if (ys 0).isNone then ys.tail else ys
      ⟨none, xs, ys, s⟩

/-- Synchronize two input streams, as soon as two elements are available
  apply a stateless function `f` applied to the two elements, and push its result to the output stream. -/
def syncMap₂ (f : α → β → γ) (xs : Stream α) (ys : Stream β) : Stream γ :=
  HandshakeStream.corec (xs, ys) fun ⟨xs, ys ⟩ =>
    match xs 0, ys 0 with
    | some x, some y => ⟨some <| f x y, xs.tail, ys.tail⟩
    | _, _ =>
      let xs := if (xs 0).isNone then xs.tail else xs
      let ys := if (ys 0).isNone then ys.tail else ys
      ⟨none, xs, ys⟩

/-- Synchronize two input streams, as soon as three elements are available
  apply a stateless function `f` applied to the three elements, and push its result to the output stream.-/
def syncMap₃ (f : α → β → γ → δ) (xs : Stream α) (ys : Stream β) (zs : Stream γ) :
    Stream δ :=
  HandshakeStream.corec (xs, ys, zs) fun ⟨xs, ys, zs⟩ =>
    match xs 0, ys 0, zs 0 with
    | some x, some y, some z => ⟨some <| f x y z, xs.tail, ys.tail, zs.tail⟩
    | _, _, _ =>
      let xs := if (xs 0).isNone then xs.tail else xs
      let ys := if (ys 0).isNone then ys.tail else ys
      let zs := if (zs 0).isNone then zs.tail else zs
      ⟨none, xs, ys, zs⟩
