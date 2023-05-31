import SSA.Core.WellTypedFramework
import SSA.Core.Util
import SSA.Experimental.Bits.Decide

inductive BaseType
  | bitvec : BaseType
  deriving DecidableEq

instance : Inhabited BaseType := ⟨BaseType.bitvec⟩

def Term.equiv : Term → Term → Prop
  | t₁, t₂ => t₁.eval = t₂.eval

def Term.equiv_refl : ∀ t, Term.equiv t t := by
  intro t
  simp [Term.equiv, Term.eval]

def Term.equiv_symm {t₁ t₂ : Term} : Term.equiv t₁ t₂ → Term.equiv t₂ t₁ := by
  intro h
  simp [Term.equiv, Term.eval] at *
  rw [h]

def Term.equiv_trans {t₁ t₂ t₃ : Term} : Term.equiv t₁ t₂ → Term.equiv t₂ t₃ → Term.equiv t₁ t₃ := by
  intro h₁ h₂
  simp [Term.equiv, Term.eval] at *
  rw [h₁, h₂]

def Term.equiv_equiv : Equivalence Term.equiv := ⟨Term.equiv_refl, Term.equiv_symm, Term.equiv_trans⟩

instance instSetoid : Setoid Term := ⟨Term.equiv, Term.equiv_equiv⟩

def Bitvec := Quotient instSetoid

def Term.equiv_pair : Term × Term → Term × Term → Prop
  | (t₁, t₂), (t₁',t₂') => Term.equiv t₁ t₁' ∧ Term.equiv t₂ t₂'

namespace Bitvec

theorem and_equiv : ∀ {x y x' y' : Term}, 
  x ≈ x' → y ≈ y' → (Term.and x y) ≈ (Term.and x' y') := by
  {
    intro x y x' y' hx hy
    simp [HasEquiv.Equiv, Setoid.r, Term.equiv, Term.and, Term.eval]
    rw [hx, hy]
  }

  theorem and_equiv_lift₁ : ∀ (a b₁ b₂ : Term), b₁ ≈ b₂ → 
  Quotient.mk instSetoid (Term.and a b₁) = Quotient.mk instSetoid (Term.and a b₂) := by
  intro _ _ _ h
  simp [HasEquiv.Equiv, Setoid.r, Term.equiv, Term.and, Term.eval]
  rw [h]

  theorem and_equiv_lift₂ : ∀ (a₁ a₂ b : Term), a₁ ≈ a₂ → 
  Quotient.mk instSetoid (Term.and a₁ b) = Quotient.mk instSetoid (Term.and a₂ b) := by
  intro _ _ _ h
  simp [HasEquiv.Equiv, Setoid.r, Term.equiv, Term.and, Term.eval]
  rw [h]

def and : Bitvec → Bitvec → Bitvec := Quot.lift₂ (fun t₁ t₂ => Quotient.mk instSetoid $ Term.and t₁ t₂) and_equiv_lift₁ and_equiv_lift₂

theorem not_equiv {x x' : Term} : x ≈ x' → (Term.not x) ≈ (Term.not x') := by
  intro hx
  simp [HasEquiv.Equiv, Setoid.r, Term.equiv, Term.not, Term.eval]
  rw [hx]

-- These should be automatically generated somehow
theorem not_equiv_lift {x x' : Term} : x ≈ x' → 
  Quotient.mk instSetoid (Term.not x) = Quotient.mk instSetoid (Term.not x') := by
  intro hx
  simp [HasEquiv.Equiv, Setoid.r, Term.equiv, Term.not, Term.eval]
  rw [hx]

def not : Bitvec → Bitvec := Quotient.lift (fun t => Quotient.mk instSetoid $ Term.not t) @not_equiv_lift

end Bitvec

instance : Goedel BaseType where
toType := fun
  | .bitvec => Bitvec

abbrev UserType := SSA.UserType BaseType

inductive Op : Type
| and
| or
| xor
| not
| ls
| add
| sub
| neg
| incr
| decr
| const : Term → Op

@[simp, reducible]
def argUserType : Op → UserType
| Op.and | Op.or | Op.xor | Op.add | Op.sub => 
  .pair (.base (BaseType.bitvec)) (.base (BaseType.bitvec))
| Op.not | Op.ls | Op.neg | Op.incr | Op.decr => .base (BaseType.bitvec)
| Op.const _ => .unit

@[simp, reducible]
def outUserType : Op → UserType := fun _ => .base BaseType.bitvec

@[simp]
def rgnDom : Op → UserType := fun _ => .unit
@[simp]
def rgnCod : Op → UserType := fun _ => .unit


@[simp]
def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → Goedel.toType (rgnCod o))) :
  Goedel.toType (outUserType o) :=
    match o with
     | Op.and => Bitvec.and arg.1 arg.2
     | Op.not => Bitvec.not arg
     | _ => sorry
     -- | Op.or => Term.or arg.1 arg.2
     -- | Op.xor => Term.xor arg.1 arg.2
     -- | Op.ls => Term.ls arg
     -- | Op.add => Term.add arg.1 arg.2
     -- | Op.sub => Term.sub arg.1 arg.2
     -- | Op.neg => Term.neg arg
     -- | Op.incr => Term.incr arg
     -- | Op.decr => Term.decr arg
     -- | Op.const c => c

instance TUS : SSA.TypedUserSemantics Op BaseType where
  argUserType := argUserType
  rgnDom := rgnDom
  rgnCod := rgnCod
  outUserType := outUserType
  eval := eval


open EDSL
syntax "and" term : dsl_op
syntax "or" term : dsl_op
syntax "xor" term : dsl_op
syntax "not" term : dsl_op
syntax "ls" term : dsl_op
syntax "add" term : dsl_op
syntax "sub" term : dsl_op
syntax "neg" term : dsl_op
syntax "incr" term : dsl_op
syntax "decr" term : dsl_op
syntax "const" term : dsl_op

macro_rules
  | `([dsl_op| add $w ]) => `(Op.add $w)
  | `([dsl_op| and $w ]) => `(Op.and $w)
  | `([dsl_op| decr $w ]) => `(Op.decr $w)
  | `([dsl_op| incr $w ]) => `(Op.incr $w)
  | `([dsl_op| ls $w ]) => `(Op.ls $w)
  | `([dsl_op| neg $w ]) => `(Op.neg $w)
  | `([dsl_op| const $w ]) => `($w)
  | `([dsl_op| or $w ]) => `(Op.or $w)
  | `([dsl_op| sub $w ]) => `(Op.sub $w)
  | `([dsl_op| xor $w ]) => `(Op.xor $w)

