import SSA.Framework
import SSA.WellTypedFramework

namespace Examples

inductive SimpleKind
  | nat
  | bool
  deriving DecidableEq

inductive SimpleVal
  | nat : Nat → SimpleVal
  | bool : Bool → SimpleVal

inductive IsTyped : SimpleVal → SimpleKind → Prop
  | nat : ∀ n, IsTyped (.nat n) .nat
  | bool : ∀ b, IsTyped (.bool b) .bool

def SimpleVal.typeCheck : SimpleVal → SimpleKind
  | .nat _ => .nat
  | .bool _ => .bool

theorem typeCheckSound (v : SimpleVal) : IsTyped v (v.typeCheck) :=
  match v with
    | .nat n => IsTyped.nat n
    | .bool b => IsTyped.bool b

theorem typeCheckComplete (v : SimpleVal) (k : SimpleKind) : k ≠ v.typeCheck → ¬ IsTyped v k := by
 cases v <;> cases k <;> intros neq contra <;> contradiction

instance (v : SimpleVal) (k : SimpleKind) : Decidable (IsTyped v k) :=
 if h : k = v.typeCheck then
   isTrue (h ▸ typeCheckSound v)
 else
   isFalse (typeCheckComplete v k h)

def SimpleKind.toType : SimpleKind → Type
  | nat => Nat
  | bool => Bool

instance : TypeSemanticsBase SimpleKind where toType := SimpleKind.toType

inductive UntypedPair
  | mk (v₁ v₂ : SimpleVal)


inductive TypedPair : SimpleKind → SimpleKind → Type
  | mk {k₁ k₂ : SimpleKind} (v₁ v₂ : SimpleVal) (htyped₁ : IsTyped v₁ k₁) (htyped₂ : IsTyped v₂ k₂) : TypedPair k₁ k₂

def typeCheckPair : UntypedPair → Option (TypedPair k₁ k₂)
  | UntypedPair.mk v₁ v₂ =>
    if h₁ : v₁.typeCheck = k₁ then
      if h₂ : v₂.typeCheck = k₂ then
        let htyped₁ := h₁ ▸ typeCheckSound v₁
        let htyped₂ := h₂ ▸ typeCheckSound v₂
        some (TypedPair.mk v₁ v₂ htyped₁ htyped₂)
      else
        none
   else
      none

-- #eval typeCheckPair (UntypedPair.mk (SimpleVal.nat 42) (SimpleVal.bool true))
-- don't know how to synthesize implicit argument
-- don't know how to synthesize implicit argument
--
inductive SimpleOp
  | add
  | xor

inductive SimpleApp
  | add ( v : TypedPair (.nat) (.nat) ) : SimpleApp
  | xor ( v : TypedPair (.bool) (.bool) ) : SimpleApp

def AppUntyped : SimpleOp → UntypedPair → Option SimpleApp
 | .add, pair => match typeCheckPair pair with
   | some v => match v with
     | @TypedPair.mk (.nat) (.nat) _ _ _ _ => some $ SimpleApp.add v
   | none => none
  | .xor, pair => match typeCheckPair pair with
   | some v => match v with
     | @TypedPair.mk (.bool) (.bool) _ _ _ _ => some $ SimpleApp.xor v
   | none => none


#check AppUntyped .add (UntypedPair.mk (SimpleVal.nat 42) (SimpleVal.nat 1))


end Examples
