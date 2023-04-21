import SSA.Framework
import Mathlib.Data.Option.Basic

class TypeSemantics (Kind : Type) : Type 1 where
  toType : Kind → Type
  -- unit : Kind
  -- pair : Kind → Kind → Kind
  -- triple : Kind → Kind → Kind → Kind
  -- mkPair : ∀ {k1 k2 : Kind}, toType k1 → toType k2 → toType (pair k1 k2)
  -- fstPair : ∀ {k1 k2 : Kind}, toType (pair k1 k2) → toType k1
  -- sndPair : ∀ {k1 k2 : Kind}, toType (pair k1 k2) → toType k2
  -- mkTriple : ∀ {k1 k2 k3 : Kind}, toType k1 → toType k2 → toType k3 → toType (triple k1 k2 k3)
  -- fstTriple : ∀ {k1 k2 k3 : Kind}, toType (triple k1 k2 k3) → toType k1
  -- sndTriple : ∀ {k1 k2 k3 : Kind}, toType (triple k1 k2 k3) → toType k2
  -- trdTriple : ∀ {k1 k2 k3 : Kind}, toType (triple k1 k2 k3) → toType k3

open TypeSemantics

class TypedUserSemantics (Op : Type) (Kind : Type) [TypeSemantics Kind] where
  argKind : Op → Kind
  rgnDom : Op → Kind
  rgnCod : Op → Kind
  outKind : Op → Kind
  eval : ∀ (o : Op), toType (argKind o) → (toType (rgnDom o) →
    toType (rgnCod o)) → toType (outKind o)

inductive TypeData (Kind : Type) (v : Var) : Type
  | none : TypeData Kind v
  | some : Kind → TypeData Kind v
  | any : TypeData Kind v
  | unused : TypeData Kind v -- Or bound

def TypeData.toType {Kind : Type} [TypeSemantics Kind] {v : Var} :
    TypeData Kind v → Type
  | TypeData.none => Empty
  | TypeData.some k => TypeSemantics.toType k
  | TypeData.any => Σ (k : Kind), TypeSemantics.toType k
  | TypeData.unused => Unit

@[simp]
def SSAIndex.teval (Op : Type) (Kind : Type) [TypeSemantics Kind]
    [TypedUserSemantics Op Kind] : SSAIndex → Type
  | .STMT => Σ (sem : ∀ v : Var, TypeData Kind v), (∀ v, (sem v).toType)
  | .REGION => Σ k₁ k₂ : Kind, TypeSemantics.toType k₁ → TypeSemantics.toType k₂
  | .TERMINATOR => Σ k : Kind, TypeSemantics.toType k
  | .EXPR => Σ k : Kind, TypeSemantics.toType k

open TypeData

def SSA.teval [TypeSemantics Kind] [TypedUserSemantics Op Kind] :
    {k : SSAIndex} → SSA Op k →
    Σ (sem : ∀ v : Var, TypeData Kind v),
    ((∀ v, (sem v).toType) → k.teval Op Kind)
| _, .assign lhs rhs rest =>
  let ⟨sem₁, eval₁⟩ := SSA.teval (Kind := Kind) rest
  let ⟨sem₂, eval₂⟩ := SSA.teval (Kind := Kind) rhs
  ⟨fun v => if v = lhs then .unused else sem₁ v, fun cont => by
    dsimp

      ⟩
| _, .nop => _
| _, .ret above v => _
| _, .pair fst snd => _
| _, .triple fst snd third => _
| _, .op o arg r => _
| _, .var v => _
| _, .rgnvar v => _
| _, .rgn0 => _
| _, .rgn arg body => _