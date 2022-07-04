/-
## Finite interaction trees

The semantics framework for this project is extremely inspired by the Vellvm
project [1] and is essentially centered around interaction trees and monadic
transformers.

Interactions trees are a particular instance of the freer monad; essentially,
an ITree is a program that can have side effets through *interactions*, and
these interactions can either be interpreted into the program or kept as
observable side-effects.

When giving semantics to a program, one usually starts with a rather simple
ITree where most of the complex features of the language (memory, I/O,
exceptions, randomness, non-determinism, etc) are hidden behind interactions.
The interactions are then interpreted, which consists of (1) enriching the
program's environment by a monadic transformation, and (2) replacing the
interaction with an actual implementation.

This approach allows monadic domains to be used while keeping each family of
interactions separate. This is relevant for Vellvm as LLVM IR has many complex
features, and even more relevant for MLIR since each dialect can bring more
interactions and environment transforms and all of them have to be studied and
defined independently.

The datatype of interaction trees normally has built-in non-termination by
being defined coinductively. Support for coinduction is still limited in Lean4,
so we currently use a finite version of ITrees (hence called Fitree) which can
only model programs that always terminate.

[1]: https://github.com/vellvm/vellvm
-/

import MLIR.Semantics.SimpItree
import MLIR.Dialects
import MLIR.Util.WriterT

/- Extendable effect families -/

-- | Polymorphic to and sum.
def pto (E: Type u → Type v₁) (F: Type u → Type v₂) :=
  ∀ T, E T → F T
def psum (E: Type u → Type v₁) (F: Type u → Type v₂) :=
  fun T => E T ⊕ F T
inductive PVoid: Type -> Type u

infixr:40 " ~> " => pto
infixr:60 " +' " => psum

class Member (E: Type → Type) (F: Type → Type) where
  inject : E ~> F

instance {E}: Member E E where
  inject := (fun _ => id)

instance {E F G} [Member E F]: Member E (F +' G) where
  inject T := Sum.inl ∘ Member.inject T

instance {E F G} [Member E G]: Member E (F +' G) where
  inject T := Sum.inr ∘ Member.inject T

instance {E F G H} [Member E G] [Member F H]: Member (E +' F) (G +' H) where
  inject T := Sum.cases (Member.inject T) (Member.inject T)

-- Effects can now be put in context automatically by typeclass resolution
example E:      Member E E := inferInstance
example E F:    Member E (E +' F) := inferInstance
example E F:    Member E (F +' (F +' E)) := inferInstance
example E F G:  Member (E +' F) (E +' F +' G) := inferInstance

@[simp_itree]
def Fitree.case_ (h1: E ~> G) (h2: F ~> G): E +' F ~> G :=
  fun R ef => match ef with
  | Sum.inl e => h1 R e
  | Sum.inr f => h2 R f


/- Examples of interactions -/

inductive StateE {S: Type}: Type → Type where
  | Read: Unit → StateE S
  | Write: S → StateE PUnit

inductive WriteE {W: Type}: Type → Type where
  | Tell: W → WriteE Unit


/- The monadic domain; essentially finite Interaction Trees -/

inductive Fitree (E: Type → Type) (R: Type) where
  | Ret (r: R): Fitree E R
  | Vis {T: Type} (e: E T) (k: T → Fitree E R): Fitree E R

@[simp_itree]
def Fitree.ret {E R}: R → Fitree E R :=
  Fitree.Ret

@[simp_itree]
def Fitree.trigger {E: Type → Type} {F: Type → Type} {T} [Member E F]
    (e: E T): Fitree F T :=
  Fitree.Vis (Member.inject _ e) Fitree.ret

@[simp_itree]
def Fitree.bind {E R T} (t: Fitree E T) (k: T → Fitree E R) :=
  match t with
  | Ret r => k r
  | Vis e k' => Vis e (fun r => bind (k' r) k)

-- TODO: consider making this a coercion
def Fitree.inject {E: Type → Type} {F: Type → Type} {T} [Member E F]
    (fe: Fitree E T): Fitree F T :=
  match fe with 
  | Ret r => Ret r
  | Vis e k' => Vis (Member.inject _ e) (fun r => inject (k' r))
  

def Fitree.map {E } (f: α → β) (fa: Fitree E α): Fitree E β :=
   match fa with
   | .Ret r => .Ret (f r)
   | .Vis e k' => .Vis e (fun r => map f (k' r))

theorem Fitree_map_functorial (f: α → β) (g: β → γ) (fa: Fitree E α):
   fa.map (g ∘ f) = (fa.map f).map g := by {
  intros;
  unfold Fitree.map;
  induction fa;
  simp;
  unfold Fitree.map;
  simp;
  case Vis IH => {
   simp;
   unfold Fitree.map;
   simp;
   funext x; -- classical!
   apply IH;
  }
}

instance {E}: Monad (Fitree E) where
  pure := Fitree.ret
  bind := Fitree.bind

-- https://wiki.haskell.org/Monad_laws
theorem Fitree_monad_left_identity (a: α) (h: α → Fitree E β):
  Fitree.bind (Fitree.ret a) h = h a := by {
  unfold Fitree.ret;
  unfold Fitree.bind;
  simp;
}

-- https://wiki.haskell.org/Monad_laws
theorem Fitree_monad_right_identity (ma: Fitree E α):
  Fitree.bind ma Fitree.ret = ma := by {
  unfold Fitree.ret;
  unfold Fitree.bind;
  induction ma;
  simp;
  simp;
  funext x; -- classical
  unfold Fitree.bind;
  case Vis IH =>
  apply IH;
}

-- https://wiki.haskell.org/Monad_laws
theorem Fitree_monad_assoc (ma: Fitree E α)
  (g: α → Fitree E β) (h: β → Fitree E γ):
  Fitree.bind (Fitree.bind ma g) h =
  Fitree.bind ma (fun x => Fitree.bind (g x) h) := by {
  induction ma;
  case Ret r => {
    simp [Fitree.bind];
  }
  case Vis T e k IH => {
     simp [Fitree.bind];
     funext v;
     simp [Fitree.bind];
     apply IH;
  }
}

@[simp_itree]
def Fitree.translate {E F R} (f: E ~> F): Fitree E R → Fitree F R
  | Ret r => Ret r
  | Vis e k => Vis (f _ e) (fun r => translate f (k r))

-- Interpretation into the monad of finite ITrees
@[simp_itree]
def interp {M} [Monad M] {E} (h: E ~> M):
    forall {R}, Fitree E R → M R :=
  fun t =>
    match t with
    | Fitree.Ret r => pure r
    | Fitree.Vis e k => bind (h _ e) (fun t => interp h (k t))

@[simp_itree]
def interp' {E F} (h: E ~> Fitree PVoid):
    forall {R}, Fitree (E +' F) R → Fitree F R :=
  fun t =>
    interp (Fitree.case_
      (fun _ e => (h _ e).translate $ fun _ e => nomatch e)
      (fun _ e => Fitree.trigger e)) t

-- Interpretation into the state monad. This is semantically equivalent to
-- `interp`, but the specialization is useful to write state-specific theorems.
@[simp_itree]
def interp_state {M S} [Monad M] {E} (h: E ~> StateT S M):
    forall {R}, Fitree E R → StateT S M R :=
  interp h

-- Interpretation into the writer monad
@[simp_itree]
def interp_writer {M} [Monad M] {E} (h: E ~> WriterT M):
    forall {R}, Fitree E R → WriterT M R :=
  interp h

-- Interpretation into the option monad
@[simp_itree]
def interp_option {M} [Monad M] {E} (h: E ~> OptionT M):
    forall {R}, Fitree E R → OptionT M R :=
  interp h

-- Since we only use finite ITrees, we can actually run them when they're
-- fully interpreted (which leaves only the Ret constructor)
@[simp_itree]
def Fitree.run {R}: Fitree PVoid R → R
  | Ret r => r
  | Vis e k => nomatch e


/- Predicates to reason about the absence of events -/

inductive Fitree.no_event_l {E F R}: Fitree (E +' F) R → Prop :=
  | Ret r: no_event_l (Ret r)
  | Vis f k: (∀ t, no_event_l (k t)) → no_event_l (Vis (Sum.inr f) k)

-- TODO: Tactic to automate the proof of no_event_l


/- Rewriting tactic simp_itree -/

open Lean Elab.Tactic Parser.Tactic

def toSimpLemma (name : Name) : Syntax :=
  mkNode `Lean.Parser.Tactic.simpLemma
    #[mkNullNode, mkNullNode, mkIdent name]

elab "simp_itree" : tactic => do
  -- TODO: Also handle .lemmaNames, not just unfolding!
  let lemmas := (← SimpItreeExtension.getTheorems).toUnfold.fold
    (init := #[]) (fun acc n => acc.push (toSimpLemma n))
  let trlemmas: Syntax.TSepArray `Lean.Parser.Tactic.simpStar "," :=
    ⟨lemmas.reverse⟩
  evalTactic $ ← `(tactic|simp [$trlemmas,*,
    Member.inject,
    StateT.bind, StateT.pure, StateT.lift,
    OptionT.bind, OptionT.pure, OptionT.mk, OptionT.lift,
    bind, pure, cast_eq, Eq.mpr])

elab "dsimp_itree" : tactic => do
  -- TODO: Also handle .lemmaNames, not just unfolding!
  let lemmas := (← SimpItreeExtension.getTheorems).toUnfold.fold
    (init := #[]) (fun acc n => acc.push (toSimpLemma n))
  evalTactic $ ← `(tactic|dsimp [$(⟨lemmas.reverse⟩),*,
    Member.inject,
    StateT.bind, StateT.pure, StateT.lift,
    OptionT.bind, OptionT.pure, OptionT.mk, OptionT.lift,
    bind, pure, cast_eq, Eq.mpr])
