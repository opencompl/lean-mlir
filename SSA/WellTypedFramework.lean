import SSA.Framework

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
      pure <| ⟨_, TypedUserSemantics.eval o _ _⟩
  | .var v => e v
  | .rgnvar v => re v
  | .rgn0 => sorry
  | .rgn arg body => sorry