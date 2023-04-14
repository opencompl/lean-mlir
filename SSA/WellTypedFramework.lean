import SSA.Framework

-- Why do we ask for them to make this explicitly?
class TypeSemantics (Kind : Type) : Type 1 where
  toType : Kind → Type
  pair : Kind → Kind → Kind
  triple : Kind → Kind → Kind → Kind
  mkPair : ∀ {k1 k2 : Kind}, toType k1 → toType k2 → toType (pair k1 k2)
  fstPair : ∀ {k1 k2 : Kind}, toType (pair k1 k2) → toType k1
  sndPair : ∀ {k1 k2 : Kind}, toType (pair k1 k2) → toType k2
  mkTriple : ∀ {k1 k2 k3 : Kind}, toType k1 → toType k2 → toType k3 → toType (triple k1 k2 k3)
  fstTriple : ∀ {k1 k2 k3 : Kind}, toType (triple k1 k2 k3) → toType k1
  sndTriple : ∀ {k1 k2 k3 : Kind}, toType (triple k1 k2 k3) → toType k2
  trdTriple : ∀ {k1 k2 k3 : Kind}, toType (triple k1 k2 k3) → toType k3

-- Couldn't we do something like this for them?
inductive TypeSemanticsInstance (BaseType : Type) : Type where
  | base : BaseType → TypeSemanticsInstance BaseType
  | pair : TypeSemanticsInstance BaseType → TypeSemanticsInstance BaseType → TypeSemanticsInstance BaseType
  | triple : TypeSemanticsInstance BaseType → TypeSemanticsInstance BaseType → TypeSemanticsInstance BaseType → TypeSemanticsInstance BaseType
  | unit : TypeSemanticsInstance BaseType

namespace TypeSemanticsInstance

def toType {BaseType : Type} : TypeSemanticsInstance BaseType → Type
  | .base _ => BaseType
  | .pair k₁ k₂ => (toType k₁) × (toType k₂)
  | .triple k₁ k₂ k₃ => toType k₁ × toType k₂ × toType k₃
  | .unit => Unit

def mkPair {BaseType : Type} {k₁ k₂ : TypeSemanticsInstance BaseType}: toType k₁ → toType k₂ → toType (.pair k₁ k₂)
  | k₁, k₂ => (k₁, k₂)

def mkTriple {BaseType : Type} {k₁ k₂ k₃ : TypeSemanticsInstance BaseType}: toType k₁ → toType k₂ → toType k₃ → toType (.triple k₁ k₂ k₃)
  | k₁, k₂, k₃ => (k₁, k₂, k₃)

def fstPair {BaseType : Type} {k₁ k₂ : TypeSemanticsInstance BaseType} : toType (.pair k₁ k₂) → toType k₁
  | (k₁, _) => k₁

def sndPair {BaseType : Type} {k₁ k₂ : TypeSemanticsInstance BaseType} : toType (.pair k₁ k₂) → toType k₂
  | (_, k₂) => k₂

def fstTriple {BaseType : Type} {k₁ k₂ k₃ : TypeSemanticsInstance BaseType} : toType (.triple k₁ k₂ k₃) → toType k₁
  | (k₁, _, _) => k₁

def sndTriple {BaseType : Type} {k₁ k₂ k₃ : TypeSemanticsInstance BaseType} : toType (.triple k₁ k₂ k₃) → toType k₂
  | (_, k₂, _) => k₂

def trdTriple {BaseType : Type} {k₁ k₂ k₃ : TypeSemanticsInstance BaseType} : toType (.triple k₁ k₂ k₃) → toType k₃
  | (_, _, k₃) => k₃

end TypeSemanticsInstance

instance {Kind : Type} : TypeSemantics (TypeSemanticsInstance Kind) where
  toType := TypeSemanticsInstance.toType
  pair := TypeSemanticsInstance.pair
  triple := TypeSemanticsInstance.triple
  mkPair := TypeSemanticsInstance.mkPair
  fstPair := TypeSemanticsInstance.fstPair
  sndPair := TypeSemanticsInstance.sndPair
  mkTriple := TypeSemanticsInstance.mkTriple
  fstTriple := TypeSemanticsInstance.fstTriple
  sndTriple := TypeSemanticsInstance.sndTriple
  trdTriple := TypeSemanticsInstance.trdTriple


open TypeSemantics

class TypedUserSemantics (Op : Type) (Kind : Type) [TypeSemantics Kind] where
  argKind : Op → Kind
  rgnDom : Op → Kind
  rgnCod : Op → Kind
  outKind : Op → Kind
  eval : ∀ (o : Op), toType (argKind o) → (toType (rgnDom o) →
    toType (rgnCod o)) → toType (outKind o)

variable (Op : Type) (Kind : Type) [TypeSemantics Kind] [TypedUserSemantics Op Kind]

namespace TypedUserSemantics

abbrev EnvT :=
  Var → Option (Σ (k : Kind), toType k)

variable {Op} {Kind}

@[simp]
def EnvT.empty : EnvT Kind := fun _ => none
notation "∅" =>  Env.empty

@[simp]
def EnvT.set (e : EnvT Kind) (var : Var) {k : Kind} (val : toType k) : EnvT Kind :=
  fun needle => if needle == var then some ⟨k, val⟩ else e needle
notation e "[" var " := " val "]" => EnvT.set e var val

variable (Op) (Kind)

abbrev RegEnv : Type :=
  Var → Option (Σ (k₁ k₂ : Kind), toType k₁ → toType k₂)

variable {Op} {Kind}

@[simp]
def RegEnv.empty : RegEnv Kind := fun _ => none

@[simp]
def RegEnv.set (e : RegEnv Kind) (var : Var) {k₁ k₂ : Kind} (val : toType k₁ → toType k₂) : RegEnv Kind :=
  fun needle => if needle == var then some ⟨k₁, k₂, val⟩ else e needle

end TypedUserSemantics

open TypedUserSemantics

def SSAIndex.teval : SSAIndex → Type
  | .STMT => EnvT Kind
  | .TERMINATOR => Option (Σ (k : Kind), toType k)
  | .EXPR => Option (Σ (k : Kind), toType k)
  | .REGION => Option (Σ (k₁ k₂ : Kind), toType k₁ → toType k₂)

variable {Op} {Kind}

def SSA.teval (e : EnvT Kind) (re : RegEnv Kind) : SSA Op k → k.teval Kind
  | .assign lhs rhs rest => fun val =>
    do rest.teval (e.set lhs (← (rhs.teval e re)).2) re val
  | .nop => e
  | .ret above v => (above.teval e re) v
  | .pair fst snd => do
      let ⟨k₁, fst⟩ ← e fst
      let ⟨k₂, snd⟩ ← e snd
      pure <| ⟨TypeSemantics.pair k₁ k₂, mkPair fst snd⟩
  | .triple fst snd third => do
      let ⟨k₁, fst⟩ ← e fst
      let ⟨k₂, snd⟩ ← e snd
      let ⟨k₃, third⟩ ← e third
      pure <| ⟨TypeSemantics.triple k₁ k₂ k₃, mkTriple fst snd third⟩
  | .op o arg r => do
      sorry -- pure <| ⟨_, TypedUserSemantics.eval o _ _⟩
  | .var v => e v
  | .rgnvar v => re v
  | .rgn0 => sorry
  | .rgn arg body => sorry

class OpArity (Op : Type) where
  arity : Op → TypeSemanticsInstance Unit × TypeSemanticsInstance Unit

-- This is ignoring the output for now; I'm also mapping to bools becase I forget how to define this as an inductive proposition
def WellTypedArity {BaseType : Type} : TypeSemanticsInstance Unit → TypeSemanticsInstance BaseType → Bool
    | .unit, .unit => true
    | .base (), .base _ => true
    | .pair k₁ k₂, .pair k₁' k₂' => WellTypedArity k₁ k₁' && WellTypedArity k₂ k₂'
    | .triple k₁ k₂ k₃, .triple k₁' k₂' k₃' => WellTypedArity k₁ k₁' && WellTypedArity k₂ k₂' && WellTypedArity k₃ k₃'
    | _, _ => false

def WellTypedAp (Op : Type) (BaseType : Type) [OpArity Op] : Op → TypeSemanticsInstance BaseType → Bool
  | o, k => WellTypedArity (OpArity.arity o).1 k
