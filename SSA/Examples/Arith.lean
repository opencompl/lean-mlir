import SSA.WellTypedFramework

namespace Arith

-- TODO: base these on the actual arith dialect and the target rewrite(s)
inductive BaseType
  | Nat
  | Bool
  deriving Repr, DecidableEq

instance : Goedel BaseType where
  toType := fun
    | BaseType.Nat => Nat
    | BaseType.Bool => Bool

abbrev UserType := SSA.UserType BaseType

inductive Op
  | Add
  | Sub
  | Mul
  | Div
  | Eq
  | Lt
  | Gt
  | And
  | Or
  | Not
  deriving Repr, DecidableEq

def argKind : Op → UserType := sorry
def rgnDom : Op → UserType := sorry
def rgnCod : Op → UserType := sorry
def outKind : Op → UserType := sorry
def eval : ∀ (o : Op), Goedel.toType (argKind o) → (Goedel.toType (rgnDom o) →
    Goedel.toType (rgnCod o)) → Goedel.toType (outKind o) := sorry

instance : SSA.TypedUserSemantics Op BaseType where
  argKind := argKind
  rgnDom := rgnDom
  rgnCod := rgnCod
  outKind := outKind
  eval := eval
