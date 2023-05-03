import SSA.WellTypedFramework

namespace InstCombine

-- TODO: base these on the actual arith dialect and the target rewrite(s)
inductive BaseType
  | BitVector (width : Nat)
  deriving Repr, DecidableEq

instance : Goedel BaseType where
  toType := fun
    | BaseType.BitVector _ => List Bool

abbrev UserType := SSA.UserType BaseType

-- See: https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
inductive Op
  | and
  | or
  | xor
  | shr
  | lshr
  | ashr
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

end InstCombine
/-
Optimization: InstCombineShift: 239
  %Op0 = shl %X, C
  %r = lshr %Op0, C
=>
  %r = and %X, (-1 u>> C)
-/
