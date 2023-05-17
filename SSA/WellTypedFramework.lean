import SSA.Framework
import Mathlib.Data.Option.Basic
import Mathlib.Data.List.AList

/-- Typeclass for a `baseType` which is a Gödel code of
Lean types. -/
class Goedel (β : Type) : Type 1 where
  toType : β → Type
open Goedel /- make toType publically visible in module. -/

notation "⟦" x "⟧" => Goedel.toType x

instance : Goedel Unit where toType := fun _ => Unit

namespace SSA

/-- A `UserType` is a type of user-defined values in `SSA` programs.
    The main objective of `UserType` is to be able to have decidability
    properties, like decidable equality, for the restricted set of types
    in the user-defined semantics, since Lean's `Type` does not have these
    properties. -/
inductive UserType (β : Type) : Type where
  | base : β → UserType β
  | pair : UserType β → UserType β → UserType β
  | triple : UserType β → UserType β → UserType β → UserType β
  | unit : UserType β
  | region : UserType β → UserType β → UserType β
  deriving DecidableEq

namespace UserType

instance: Inhabited (UserType β) where default := UserType.unit

@[reducible]
def toType [Goedel β] : UserType β → Type
  | .base t =>  ⟦t⟧
  | .pair k₁ k₂ => (toType k₁) × (toType k₂)
  | .triple k₁ k₂ k₃ => toType k₁ × toType k₂ × toType k₃
  | .unit => Unit
  | .region k₁ k₂ => toType k₁ → Option (toType k₂)

instance [Goedel β] : Goedel (UserType β) where
  toType := toType

def mkPair [Goedel β] {k₁ k₂ : UserType β}: ⟦k₁⟧ → ⟦k₂⟧ → ⟦k₁.pair k₂⟧
  | k₁, k₂ => (k₁, k₂)

def mkTriple [Goedel β] {k₁ k₂ k₃ : UserType β}: ⟦k₁⟧ → ⟦k₂⟧ → ⟦k₃⟧ → ⟦k₁.triple k₂ k₃⟧
  | k₁, k₂, k₃ => (k₁, k₂, k₃)

def fstPair [Goedel β] {k₁ k₂ : UserType β} : ⟦k₁.pair k₂⟧ → ⟦k₁⟧
  | (k₁, _) => k₁

def sndPair [Goedel β] {k₁ k₂ : UserType β} : ⟦k₁.pair k₂⟧ → ⟦k₂⟧
  | (_, k₂) => k₂

def fstTriple [Goedel β] {k₁ k₂ k₃ : UserType β} : ⟦k₁.triple k₂ k₃⟧ → ⟦k₁⟧
  | (k₁, _, _) => k₁

def sndTriple [Goedel β] {k₁ k₂ k₃ : UserType β} : ⟦k₁.triple k₂ k₃⟧ → ⟦k₂⟧
  | (_, k₂, _) => k₂

def trdTriple [Goedel β] {k₁ k₂ k₃ : UserType β} : ⟦k₁.triple k₂ k₃⟧ → ⟦k₃⟧
  | (_, _, k₃) => k₃

end UserType



/-- Typeclass for a user semantics of `Op`, with base type `β`.
    The type β has to implement the `Goedel` typeclass, mapping into `Lean` types.
    This typeclass has several arguments that have to be defined to give semantics to
    the operations of type `Op`:
    * `argUserType` and `outUserType`, functions of type `Op → UserType β`, give the type of the
      arguments and the output of the operation.
    * `rgnDom` and `rgnCod`, functions of type `Op → UserType β`, give the type of the
      domain and codomain of regions within the operation.
    * `eval` gives the actual evaluation semantics of the operation, by defining a function for
      every operation `o : Op` of type `toType (argUserType o) → (toType (rgnDom o) → toType (rgnCod o)) → toType (outUserType o)`.
-/
class OperationTypes (Op : Type) (β : Type) where
  argUserType : Op → UserType β
  rgnDom : Op → UserType β
  rgnCod : Op → UserType β
  outUserType : Op → UserType β

class TypedUserSemantics (Op : Type) (β : Type) [Goedel β] extends OperationTypes Op β where
  eval : ∀ (o : Op), toType (argUserType o) → (toType (rgnDom o) →
    toType (rgnCod o)) → toType (outUserType o)

inductive Context (α : Type) : Type
  | empty : Context α
  | cons : Var → α → Context α → Context α

inductive Context.Var {α : Type} : Context α → α → Type
  | first {Γ : Context α} (v : SSA.Var) (a : α) :
      Context.Var (Context.cons v a Γ) a
  | next {Γ : Context α} :
      Context.Var Γ a → Context.Var (Context.cons v' a' Γ) a

instance {α : Type} : EmptyCollection (Context α) :=
  ⟨Context.empty⟩

def EnvC [Goedel β] (c : Context (UserType β)) :=
  ∀ (a : UserType β), c.Var a → ⟦a⟧

@[simp]
def SSAIndex.teval (Op : Type) (β : Type) [Goedel β]
    [OperationTypes Op β] : SSAIndex → Type
| .STMT => Option (EnvU β)
| .TERMINATOR => Option (UVal β)
| .EXPR => Option (UVal β)
| .REGION => ∀ (k₁ k₂ : UserType β), k₁.toType → Option k₂.toType

@[simp]
def SSA.teval {Op : Type} [TUS : TypedUserSemantics Op β]
  (e : EnvU β) : SSA Op k → k.teval Op β
| .assign lhs rhs rest => do
  rest.teval (e.set lhs (← rhs.teval e))
| .nop => return e
| .unit => return ⟨.unit, ()⟩
| .ret above v => do (← above.teval e) v
| .pair fst snd => do
  let fst ← e fst
  let snd ← e snd
  return ⟨.pair fst.fst snd.fst, (fst.2, snd.2)⟩
| .triple fst snd third => do
  let fst ← e fst
  let snd ← e snd
  let third ← e third
  return ⟨.triple fst.fst snd.fst third.fst, (fst.2, snd.2, third.2)⟩
| .op o arg r => do
  let ⟨argK, argV⟩ ← e arg
  let f := teval e r
  if h : TUS.argUserType o = argK
    then by
          subst argK
          exact do return ⟨TUS.outUserType o, ← TUS.eval o argV (f _ _)⟩
    else none
| .var v => e v
| .rgnvar v => fun k₁ k₂ x => do
  let ⟨k, f⟩ ← e v
  match k, f with
  | .region dom cod, f =>
    if h : k₁ = dom ∧ k₂ = cod
      then by
            rcases h with ⟨rfl, rfl⟩
            exact f x
      else none
  | _, _ => failure
| .rgn0 => fun k₁ k₂ _ =>
    if h : k₁ = .unit ∧ k₂ = .unit
    then by rcases h with ⟨rfl, rfl⟩; exact return ()
    else none
| .rgn arg body => fun k₁ k₂ x => do
  let fx ← teval (e.set arg ⟨k₁, x⟩) body
  match fx with
  | ⟨k₂', y⟩ =>
    if h : k₂' = k₂
    then by subst h; exact return y
    else none
-- @chris: TODO: implement `eval`:
--   `SSA Op i → Environment (Option Context β) → Option i.eval` or some such.

-- We can recover the case with the TypeSemantics as an instance
def TypeSemantics : Type 1 :=
  ℕ → Type

inductive NatBaseType (TS : TypeSemantics) : Type
  | ofNat : ℕ → NatBaseType TS
deriving DecidableEq

instance : Goedel (NatBaseType TS) where toType :=
  fun n => match n with
    | .ofNat m => TS m

variable {TS : TypeSemantics}
abbrev NatUserType := UserType (NatBaseType TS)
abbrev NatTypeData := TypeData (NatBaseType TS)

@[simp]
def NatTypeData.toType (TS : TypeSemantics) : @NatTypeData TS → Type
  | TypeData.some (.ofNat k) => TS k
  | TypeData.unit => Unit
  | TypeData.pair t₁ t₂ => (NatTypeData.toType TS t₁) × (NatTypeData.toType TS t₂)
  | TypeData.triple t₁ t₂ t₃ => (NatTypeData.toType TS t₁) × (NatTypeData.toType TS t₂) × (NatTypeData.toType TS t₃)
  | TypeData.any => Σ (k : NatUserType), @UserType.toType (@NatBaseType TS) instGoedelNatBaseType k
  | TypeData.unused => Unit
  | TypeData.region t₁ t₂ => (NatTypeData.toType TS t₁) → (NatTypeData.toType TS t₂)

end SSA

register_simp_attr Bind.bind
register_simp_attr Option.bind
register_simp_attr TypedUserSemantics.eval
register_simp_attr TypedUserSemantics.argUserType
register_simp_attr TypedUserSemantics.outUserType
register_simp_attr TypedUserSemantics.regionDom
register_simp_attr TypedUserSemantics.regionCod
