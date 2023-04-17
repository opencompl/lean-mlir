import SSA.Framework

class TypeSemantics (Kind : Type) : Type 1 where
  toType : Kind → Type
  unit : Kind
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

inductive Context (Kind : Type) where
  | empty : Context Kind
  | push : Context Kind → Var → Kind → Context Kind

inductive CVar {Kind : Type} : Context Kind → Kind → Type where
  | here : ∀ {Γ : Context Kind} {k : Kind}, CVar (Γ.push v k) k
  | there : ∀ {Γ : Context Kind} {k₁ k₂ : Kind} {v : Var}, CVar Γ k₁ → CVar (Γ.push v k₂) k₁

/-- Us mucking around to avoid mutual inductives.  -/
inductive TSSAIndex : Type
/-- LHS := RHS. LHS is a `Var` and RHS is an `SSA Op .EXPR` -/
| STMT
/-- Ways of making an RHS -/
| EXPR : Kind → TSSAIndex
/-- The final instruction in a region. Must be a return -/
| TERMINATOR : Kind → TSSAIndex
/-- a lambda -/
| REGION : Kind → Kind → TSSAIndex

inductive TSSA (Op : Type) {Kind : Type} [TypeSemantics Kind] [TypedUserSemantics Op Kind] :
    (Γ : Context Kind) → (Γr : Context (Kind × Kind)) → TSSAIndex Kind → Type where
  /-- lhs := rhs; rest of the program -/
  | assign {k : Kind} (lhs : Var) (rhs : TSSA Op Γ Γr (.EXPR k))
      (rest : TSSA Op (Γ.push lhs k) Γr .STMT) : TSSA Op Γ Γr .STMT
  /-- no operation. -/
  | nop : TSSA Op Γ Γr .STMT
  /-- above; ret v -/
  | ret {k : Kind} (above : TSSA Op Γ Γr .STMT) (v : CVar Γ k) : TSSA Op Γ Γr (.TERMINATOR k)
  /-- (fst, snd) -/
  | pair (fst : CVar Γ k₁) (snd : CVar Γ k₂) : TSSA Op Γ Γr (.EXPR (pair k₁ k₂))
  /-- (fst, snd, third) -/
  | triple (fst : CVar Γ k₁) (snd : CVar Γ k₂) (third : CVar Γ k₃) : TSSA Op Γ Γr (.EXPR (triple k₁ k₂ k₃))
  /-- op (arg) { rgn } rgn is an argument to the operation -/
  | op (o : Op) (arg : CVar Γ (argKind o)) (rgn : TSSA Op Γ Γr (.REGION (rgnDom o) (rgnCod o))) :
      TSSA Op Γ Γr (.EXPR (outKind o))
  /- fun arg => body -/
  | rgn {arg : Var} {dom cod : Kind} (body : TSSA Op (Γ.push arg dom) Γr (.TERMINATOR cod)) :
      TSSA Op Γ Γr (.REGION dom cod)
  /- no function / non-existence of region. -/
  | rgn0 : TSSA Op Γ Γr (.REGION unit unit)
  /- a region variable. --/
  | rgnvar (v : CVar Γr (k₁, k₂)) : TSSA Op Γ Γr (.REGION k₁ k₂)
  /-- a variable. -/

/- TODO - Write a translation that takes a pair of SSA and optionally returns a pair
 of valid contexts and TSSA. Write the evaluation for a TSSA. -/


-- If we have a well-typed environment then we can define the type of variables in the environment? hmmm
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
      let ⟨k₁, k₂, f⟩ ← r.teval e re
      if ⟨(e arg).1 k₁ = argKind o
        pure <| ⟨_, TypedUserSemantics.eval o _ _⟩
  | .var v => e v
  | .rgnvar v => re v
  | .rgn0 => sorry
  | .rgn arg body => sorry