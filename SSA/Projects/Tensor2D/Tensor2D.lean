import SSA.Core.WellTypedFramework
import Mathlib.Data.Matrix.Basic
import Mathlib.Data.Nat.Basic
import SSA.Core.Util


/-- Type of tensor dimensions and indexes into tensor dimensions.
  NOTE: see interaction with `linarith` where we need to unfold `Index` into `ℕ`
    https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/Ergonomics.3A.20linarith.20does.20not.20work.20on.20Nat.20alias/near/365631549
-/
abbrev Index := ℕ

/-- Tensor2d with existential dimension sizes. -/
structure Tensor2d' (α : Type) where
  dim₀ : Index
  dim₁ : Index
  mat : Matrix (Fin dim₀) (Fin dim₁) α

def Tensor2d'.error (α : Type) : Tensor2d' α where
  dim₀ := 0
  dim₁ := 0
  mat := Matrix.of fun x _y => x.elim0

def Tensor2d'.transpose (t : Tensor2d' α) : Tensor2d' α where
  dim₀ := t.dim₁
  dim₁ := t.dim₀
  mat := t.mat.transpose

theorem Tensor2d'.transpose_transpose (t : Tensor2d' α) : t.transpose.transpose = t := rfl

def Tensor2d'.map (f : α → β) (t : Tensor2d' α) : Tensor2d' β where
  dim₀ := t.dim₀
  dim₁ := t.dim₁
  mat := t.mat.map f

theorem Tensor2d'.map_functorial (g : β → γ) (f : α → β) (t : Tensor2d' α) : t.map (g ∘ f) = (t.map f).map g := rfl

theorem Tensor2d'.map_error (f : α → β) : (Tensor2d'.error α).map f = Tensor2d'.error β := by {
  simp[map, error]
}
/-- K combinator / constant function. -/
def const (a : α) (_b : β) : α := a

def Tensor2d'.fill (v : β) (t : Tensor2d' α) : Tensor2d' β := t.map (const v)

/-- extract a submatrix of (sz₀ × sz₁) size at offset (δ₀, δ₁). Fails if this is out of bounds. -/
def Tensor2d'.extract (δ₀ δ₁ : Index) (sz₀ sz₁ : Index) (t : Tensor2d' α) : (Tensor2d' α) :=
  if SZ0 : δ₀ + sz₀ ≤ t.dim₀ then
    if SZ1 : δ₁ + sz₁ ≤ t.dim₁ then
      {
        dim₀ := sz₀,
        dim₁ := sz₁,
        mat := Matrix.of fun (ix₀ : Fin sz₀) (ix₁ : Fin sz₁) =>
          have INBOUNDS0 : δ₀ + ix₀ < t.dim₀ := by simp[Index] at *; linarith[ix₀.isLt]
          have INBOUNDS1 : δ₁ + ix₁ < t.dim₁ := by simp[Index] at *; linarith[ix₁.isLt]
          t.mat ⟨δ₀ + ix₀, INBOUNDS0⟩ ⟨δ₁ + ix₁, INBOUNDS1⟩
        : Tensor2d' α
      }
    else Tensor2d'.error (α := α)
  else Tensor2d'.error (α := α)

/-- This implies fill_extract -/
theorem Tensor2d'.map_extract (δ₀ δ₁ sz₀ sz₁ : ℕ) (t : Tensor2d' α) (f : α → β) :
  (t.map f).extract δ₀ δ₁ sz₀ sz₁ = (t.extract δ₀ δ₁ sz₀ sz₁).map f := by {
    simp only [extract];
    have MAP_dim₀ : (map f t).dim₀ = t.dim₀ := rfl
    simp only [MAP_dim₀]
    have MAP_dim₁ : (map f t).dim₁ = t.dim₁ := rfl
    simp only [MAP_dim₁]
    by_cases H₀ : δ₀ + sz₀ ≤ t.dim₀ <;> simp[H₀, Tensor2d'.map_error];
    by_cases H₁ : δ₁ + sz₁ ≤ t.dim₁ <;> simp[H₁, Tensor2d'.map_error];
    simp only [map, Matrix.map, Matrix.of_apply, Int.ofNat_add_ofNat, Eq.ndrec, Int.rawCast, Int.cast_id,
      Nat.rawCast, Nat.cast_id, Int.ofNat_eq_coe, eq_mp_eq_cast, id_eq]
}

theorem Tensor2d'.fill_extract (δ₀ δ₁ sz₀ sz₁ : ℕ) (t : Tensor2d' α) (v : β) :
  (t.fill v).extract δ₀ δ₁ sz₀ sz₁ = (t.extract δ₀ δ₁ sz₀ sz₁).fill v := by {
    simp only[fill, Tensor2d'.map_extract]
}


inductive Op
| add
-- TODO: generalize 'const'
| constIx (v: Nat) | constTensor (t : Tensor2d' Int) | constInt (v : Int)
| sub
| map2d
| fill2d
| extract2d 

inductive BaseType
| int : BaseType
| ix : BaseType
| tensor2d : BaseType
deriving DecidableEq, Inhabited

def BaseType.toType : BaseType → Type
| .int => Int
| .ix => Index
| .tensor2d => Tensor2d' Int -- TODO: eventually generalize to arbitrary type.

instance : Goedel BaseType where toType := BaseType.toType

abbrev UserType := SSA.UserType BaseType

-- Can we get rid of the code repetition here? (not that copilot has any trouble completing this)
@[simp]
def argUserType : Op → UserType
| Op.add => ↑(BaseType.int, BaseType.int)
| Op.sub => ↑(BaseType.int, BaseType.int)
| Op.constIx _  => ()
| Op.constTensor _  => ()
| Op.constInt _  => ()
| Op.map2d => BaseType.tensor2d
| Op.fill2d => (BaseType.int, BaseType.tensor2d)
| Op.extract2d => (((BaseType.ix, BaseType.ix), (BaseType.ix, BaseType.ix)), BaseType.tensor2d)

@[simp]
def outUserType : Op → UserType
| Op.add => BaseType.int
| Op.sub => BaseType.int
| Op.constIx _ => BaseType.ix 
| Op.constTensor _ => BaseType.tensor2d
| Op.constInt _ => BaseType.int
| Op.map2d | Op.fill2d => BaseType.tensor2d
| Op.extract2d => BaseType.tensor2d

@[simp]
def rgnDom : Op → UserType
| Op.add | Op.sub | Op.fill2d | Op.extract2d  => .unit
| Op.constIx _ | Op.constTensor _ | Op.constInt _ => .unit
| Op.map2d => BaseType.int

@[simp]
def rgnCod : Op → UserType
| Op.add | Op.sub | Op.fill2d  | Op.extract2d => .unit
| Op.constIx _ | Op.constTensor _ | Op.constInt _ => .unit
| Op.map2d => BaseType.int

def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → (Goedel.toType (rgnCod o)))) :
  (Goedel.toType (outUserType o)) :=
  match o with
  | .constIx v => v
  | .constTensor v => v
  | .constInt v => v
  | .add => 
    let (x, y) := arg;
    let x : Int := x;
    let y : Int := y;
    x + y
  | .sub =>
    let (x, y) := arg;
    let x : Int := x;
    let y : Int := y;
    x - y
  | .map2d => 
    let t : Tensor2d' Int := arg
    let f : Int → Int := _rgn
    t.map f
  | .fill2d => 
    let (v, t) : Int × Tensor2d' Int  := arg
    t.fill v
  | .extract2d => 
    let ((δ, sz), t) := arg
    t.extract δ.fst δ.snd sz.fst sz.snd
    
instance TUS : SSA.TypedUserSemantics Op BaseType where
  argUserType := argUserType
  rgnDom := rgnDom
  rgnCod := rgnCod
  outUserType := outUserType
  eval := eval

syntax "map2d" : dsl_op2
syntax "fill2d" : dsl_op2
syntax "extract2d" : dsl_op2
syntax "constIx" "(" term ")" : dsl_op2
syntax "constTensor" "(" term ")" : dsl_op2
syntax "constInt" "(" term ")" : dsl_op2

open EDSL2 in
macro_rules
| `([dsl_op2| map2d]) => `(Op.map2d)
| `([dsl_op2| fill2d]) => `(Op.fill2d)
| `([dsl_op2| extract2d]) => `(Op.extract2d)
| `([dsl_op2| constIx($t)]) => `(Op.constIx $t)
| `([dsl_op2| constTensor($t)]) => `(Op.constTensor $t)
| `([dsl_op2| constInt($t)]) => `(Op.constInt $t)

-- NOTE: there is no way in MLIR to talk about composition of functions, so `map . map` is out
--       as a peephole rewrite
-- TODO: enable not writing the unit argument if not used.
-- TOTHINK: See that we encode the variables as constant values.
--          We should instead be able to have these be SSA variables of the
--          correct type. Not sure how to achieve this, as doing this
--          naively leads to errors about incorrect types:
--          https://github.com/bollu/ssa/issues/28
open SSA EDSL2 in
theorem map_fill_2d 
    (t : Tensor2d' Int)
    (sz₀ sz₁ ix₀ ix₁: Index) 
    (i : Int):
  TSSA.eval
  (e := e) (Op := Op) (β := BaseType) [dsl_bb2|
    return op:fill2d (op:constInt(i) (), 
      op:extract2d (
          ((op:constIx(sz₀) () , op:constIx(sz₁) ()),
           (op:constIx(ix₀) (), op:constIx(ix₁) ())),
           op:constTensor(t) ()))
  ] =
  TSSA.eval (e := e) (Op := Op) (β := BaseType) [dsl_bb2|
    return op:extract2d 
      (((op:constIx(sz₀) (), op:constIx(sz₁) ()),
        (op:constIx(ix₀) (), op:constIx(ix₁) ())),
        op:fill2d (op:constInt(i) (), op:constTensor(t) ()))
  ] := by {
    dsimp only[TSSAIndex.eval, TSSA.eval]
    simp[UserType.mkPair, TypedUserSemantics.eval, eval]
    simp[Tensor2d'.fill_extract]
  }