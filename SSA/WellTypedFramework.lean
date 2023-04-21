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

inductive TypeData (Kind : Type) : Type
  | none : TypeData Kind
  | some : Kind → TypeData Kind
  | any : TypeData Kind
  | unused : TypeData Kind -- Or bound

@[simp]
def TypeData.inf (Kind : Type) [DecidableEq Kind] :
    TypeData Kind → TypeData Kind → TypeData Kind
  | .none, _ => .none
  | _, .none => .none
  | .some k₁, .some k₂ => if k₁ = k₂ then .some k₁ else .none
  | .some k, _ => .some k
  | _, .some k => .some k
  | .any, _ => .any
  | _, .any => .any
  | _, _ => .unused

--@[simp]
def TypeData.toType {Kind : Type} [TypeSemantics Kind] :
    TypeData Kind → Type
  | TypeData.none => Empty
  | TypeData.some k => TypeSemantics.toType k
  | TypeData.any => Σ (k : Kind), TypeSemantics.toType k
  | TypeData.unused => Unit

def TypeData.rToType {Kind : Type} [TypeSemantics Kind] :
    TypeData (Kind × Kind) → Type
  | TypeData.none => Empty
  | TypeData.some (k₁, k₂) => TypeSemantics.toType k₁ → TypeSemantics.toType k₂
  | TypeData.any => Σ (k₁ k₂ : Kind),
      TypeSemantics.toType k₁ → TypeSemantics.toType k₂
  | TypeData.unused => Unit

-- @[simp]
-- def SSAIndex.teval (Op : Type) (Kind : Type) [TypeSemantics Kind]
--     [TypedUserSemantics Op Kind] : SSAIndex → Type
--   | .STMT => Σ (sem : Var → TypeData Kind), (∀ v, (sem v).toType)
--   | .REGION => Σ k₁ k₂ : Kind, TypeSemantics.toType k₁ → TypeSemantics.toType k₂
--   | .TERMINATOR => Σ k : Kind, TypeSemantics.toType k
--   | .EXPR => Σ k : Kind, TypeSemantics.toType k

def SSAIndex.teval (Op : Type) {Kind : Type} [TypeSemantics Kind]
    [TypedUserSemantics Op Kind] (sem : Var → TypeData Kind) :
    SSAIndex → Type
  | .TERMINATOR => Σ (v : Var), ((∀ v, (sem v).toType) → (sem v).toType)
  | .EXPR => Σ (t : TypeData Kind), ((∀ v, (sem v).toType) → t.toType)
  | .REGION => Σ (t : TypeData (Kind × Kind)), ((∀ v, (sem v).toType) → t.rToType)
  | .STMT => (∀ v, (sem v).toType) → Σ (s : Var → TypeData Kind),  (∀ v, (s v).toType)

open TypeData

def SSA.teval [TypeSemantics Kind] [TypedUserSemantics Op Kind] :
    {k : SSAIndex} → SSA Op k →
    Σ (sem : Var → TypeData Kind),k.teval Op sem
| _, .assign lhs rhs rest =>
  let ⟨sem₁, rest⟩ := SSA.teval (Kind := Kind) rest
  let ⟨sem₂, rhs⟩ := SSA.teval (Kind := Kind) rhs
  ⟨fun v => if v = lhs then .unused else sem₁ v, fun cont =>
    ⟨fun v => if v = lhs then _ else _, _⟩

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