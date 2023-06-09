import SSA.Core.WellTypedFramework
import Mathlib.Data.Matrix.Basic
import Mathlib.Data.Nat.Basic
import SSA.Core.Util


/-- Tensor2d with existential dimension sizes. -/
structure Tensor2d' (α : Type) where
  n₀ : ℕ
  n₁ : ℕ
  mat : Matrix (Fin n₀) (Fin n₁) α


def Tensor2d'.transpose (t : Tensor2d' α) : Tensor2d' α where
  n₀ := t.n₁
  n₁ := t.n₀
  mat := t.mat.transpose

theorem Tensor2d'.transpose_transpose (t : Tensor2d' α) : t.transpose.transpose = t := rfl

def Tensor2d'.map (f : α → β) (t : Tensor2d' α) : Tensor2d' β where
  n₀ := t.n₀
  n₁ := t.n₁
  mat := t.mat.map f

theorem Tensor2d'.map_functorial (g : β → γ) (f : α → β) (t : Tensor2d' α) : t.map (g ∘ f) = (t.map f).map g := rfl


/-- K combinator / constant function. -/
def const (a : α) (_b : β) : α := a

def Tensor2d'.fill (v : β) (t : Tensor2d' α) : Tensor2d' β := t.map (const v)

/-- extract a submatrix of (sz₀ × sz₁) size at offset (δ₀, δ₁). Fails if this is out of bounds. -/
def Tensor2d'.extract (δ₀ δ₁ : ℕ) (sz₀ sz₁ : ℕ) (t : Tensor2d' α) : Option (Tensor2d' α) :=
  if SZ0 : δ₀ + sz₀ ≤ t.n₀ then
    if SZ1 : δ₁ + sz₁ ≤ t.n₁ then
      {
        n₀ := sz₀,
        n₁ := sz₁,
        mat := Matrix.of fun (ix₀ : Fin sz₀) (ix₁ : Fin sz₁) =>
          have INBOUNDS0 : δ₀ + ix₀ < t.n₀ := by linarith[ix₀.isLt]
          have INBOUNDS1 : δ₁ + ix₁ < t.n₁ := by linarith[ix₁.isLt]
          t.mat ⟨δ₀ + ix₀, INBOUNDS0⟩ ⟨δ₁ + ix₁, INBOUNDS1⟩
        : Tensor2d' α
      }
    else none
  else none

/-- This implies fill_extract -/
theorem Tensor2d'.map_extract (δ₀ δ₁ sz₀ sz₁ : ℕ) (t : Tensor2d' α) (f : α → β) :
  (t.map f).extract δ₀ δ₁ sz₀ sz₁ = (t.extract δ₀ δ₁ sz₀ sz₁).map (Tensor2d'.map f) := by {
    simp only [extract];
    have MAP_n₀ : (map f t).n₀ = t.n₀ := rfl
    simp only [MAP_n₀]
    have MAP_n₁ : (map f t).n₁ = t.n₁ := rfl
    simp only [MAP_n₁]
    by_cases H₀ : δ₀ + sz₀ ≤ t.n₀ <;> simp[H₀];
    by_cases H₁ : δ₁ + sz₁ ≤ t.n₁ <;> simp[H₁];
    simp only [map, Matrix.map, Matrix.of_apply, Int.ofNat_add_ofNat, Eq.ndrec, Int.rawCast, Int.cast_id,
      Nat.rawCast, Nat.cast_id, Int.ofNat_eq_coe, eq_mp_eq_cast, id_eq]
}

theorem Tensor2d'.fill_extract (δ₀ δ₁ sz₀ sz₁ : ℕ) (t : Tensor2d' α) (v : β) :
  (t.fill v).extract δ₀ δ₁ sz₀ sz₁ = (t.extract δ₀ δ₁ sz₀ sz₁).map (Tensor2d'.fill v) := by {
    simp only[fill, Tensor2d'.map_extract]
}


inductive Op
| add
| const (v: Nat)
| sub
| map2d
| fill2d

inductive BaseType
| int : BaseType
| nat : BaseType
| tensor2d : BaseType
deriving DecidableEq, Inhabited

def BaseType.toType : BaseType → Type
| .int => Int
| .nat => Nat
| .tensor2d => Tensor2d' Int -- TODO: eventually generalize to arbitrary type.

instance : Goedel BaseType where toType := BaseType.toType

abbrev UserType := SSA.UserType BaseType

-- Can we get rid of the code repetition here? (not that copilot has any trouble completing this)
@[simp]
def argUserType : Op → UserType
| Op.add => ↑(BaseType.int, BaseType.int)
| Op.sub => ↑(BaseType.int, BaseType.int)
| Op.const _ => ()
| Op.map2d => BaseType.tensor2d
| Op.fill2d => (BaseType.int, BaseType.tensor2d)

@[simp]
def outUserType : Op → UserType
| Op.add => BaseType.int
| Op.sub => BaseType.int
| Op.const _ => BaseType.nat
| Op.map2d | Op.fill2d => BaseType.tensor2d

@[simp]
def rgnDom : Op → UserType
| Op.add | Op.sub | Op.const _ | Op.fill2d  => .unit
| Op.map2d => BaseType.int

@[simp]
def rgnCod : Op → UserType
| Op.add | Op.sub | Op.const _ | Op.fill2d  => .unit
| Op.map2d => BaseType.int

def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → (Goedel.toType (rgnCod o)))) :
  (Goedel.toType (outUserType o)) :=
  match o with
  | .const v => v
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

instance TUS : SSA.TypedUserSemantics Op BaseType where
  argUserType := argUserType
  rgnDom := rgnDom
  rgnCod := rgnCod
  outUserType := outUserType
  eval := eval

syntax "map2d" : dsl_op2
syntax "fill2d" : dsl_op2

open EDSL2 in
macro_rules
| `([dsl_op2| map2d]) => `(Op.map2d)
| `([dsl_op2| fill2d]) => `(Op.fill2d)


-- Why do these not get set?
register_simp_attr SSA.teval
register_simp_attr EnvU.set
-- register_simp_attr Op.const
register_simp_attr argUserType
register_simp_attr eval
register_simp_attr outUserType
-- register_simp_attr BitVector.width
register_simp_attr uncurry

-- TODO: what is the most convenient way to state extract?
-- TODO: there is no way in MLIR to talk about composition of functions, so `map . map` is out.

open SSA EDSL2 in
theorem map_fill_2d :
  TSSA.eval (e := e) (Op := Op) (β := BaseType) [dsl_bb2|
    return op:fill2d ($(i), op:map2d $(v), $(f))
  ] =
  TSSA.eval (e := e) (Op := Op) (β := BaseType) [dsl_bb2|
    return op:map2d (op:fill2d ($(i), $(v))), $(f)
  ] := by {
    dsimp only[TSSAIndex.eval, TSSA.eval]
    -- TODO: at this point, why do we have (eval Op.map2d (TSSA.eval v fun T v => ...))? why is the TSSA.eval unfolded?
    -- TODO: it seems to be that `(e arg)` in TSSA.eval gets evaluated eagerly. I do not want it to β-reduce this redex. Can I control this @chris?
    -- TODO: at this point, having a tactic to find and replace subterms would be awesome.
    -- TODO2: We should not let the proof state explode to this anyway.
    simp[UserType.mkPair]
    generalize I:(TSSA.eval i e) = ival 
    generalize F:(TSSA.eval f EnvC.empty) = f 
    generalize ARG:(TSSA.eval v fun T v =>
          match T, v with
          | T, Context.Var.prev v => e v
          | .(UserType.UserType.ofBase BaseType.int), Context.Var.last => ival) = arg
    -- TODO: this cannot even be generalized, even though it is the same subterm.
    simp only[TypedUserSemantics.eval, eval]
    rw[Tensor2d'.]
    sorry
  }