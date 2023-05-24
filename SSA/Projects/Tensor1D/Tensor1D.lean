import SSA.Core.Framework
import SSA.Core.WellTypedFramework
import SSA.Core.Util

/-
simple examples of 1D and 2D tensor transformations, as per MLIR tensors.
-/

namespace Val
-- pure simply typed lambda calculus
structure Tensor1d (α : Type) [Inhabited α] where
  size : Nat
  val :  Nat → α
  spec : ∀ (ix: Nat), ix >= size -> val ix = default

-- TODO: create equivalence relation for tensors
-- that says tensors are equivalent if they have the same size and
-- the same values at each index upto the size.
def Tensor1d.empty [Inhabited α] : Tensor1d α where
  size := 0
  val := fun _ => default
  spec := by {
    intros _ix _IX
    simp[val];
  }



-- [0..[left..left+len)..size)
-- if the (left + len) is larger than size, then we don't have a valid extract,
-- so we return a size zero tensor.
def Tensor1d.extract [Inhabited α] (t: Tensor1d α)
  (left: Nat) (len: Nat) : Tensor1d α :=
  let right := if (left + len) < t.size then left + len else 0
  let size := right - left
  { size := size,
    val := fun ix =>
    if left + len < t.size
    then if (ix < len) then t.val (ix + left) else default
    else default,
    spec := by {
      intros ix IX;
      by_cases A:(left + len < t.size) <;> simp[A] at right ⊢;
      simp[A] at right
      -- TODO: how to substitute?
      have LEN : len < t.size := by linarith
      sorry
    }
  }

def Tensor1d.map [Inhabited α] (f : α → α) (t : Tensor1d α) : Tensor1d α where
  size := t.size
  val := fun ix => if ix < t.size then f (t.val ix) else default
  spec := by {
    intros ix IX;
    simp;
    intros H
    have CONTRA : False := by linarith
    simp at CONTRA
  }


-- This should morally be some sort of `mapM`
def Tensor1d.map? [Inhabited α] (f : α → Option α) (t : Tensor1d α) : Option (Tensor1d α) :=
  size := t.size
  val := fun ix => if ix < t.size then f (t.val ix) else default
  spec := by {
    intros ix IX;
    simp;
    intros H
    have CONTRA : False := by linarith
    simp at CONTRA
  }


-- Note that this theorem is wrong if we cannot state what happens
-- when we are out of bounds, because the side that is (map extract) will have
-- (f default), while (extract map) will be (default)
-- theorem 1: extract (map) = map extract
theorem Tensor1d.extract_map [Inhabited α] (t: Tensor1d α) (left len: Nat) :
  (t.extract left len).map f = (t.map f).extract left len := by {
    simp[Tensor1d.extract, Tensor1d.map]
    funext ix;
    by_cases VALID_EXTRACT : left + len < t.size <;> simp[VALID_EXTRACT]
    by_cases VALID_INDEX : ix < len <;> simp[VALID_INDEX]
    have IX_INBOUNDS : ix + left < t.size := by linarith
    simp[IX_INBOUNDS]
}

def Tensor1d.fill [Inhabited α] (t: Tensor1d α) (v: α) : Tensor1d α where
  size := t.size
  val := fun ix => if ix < t.size then v else default
  spec := by {
    intros ix IX;
    simp;
    intros H
    have CONTRA : False := by linarith
    simp at CONTRA
  }

-- theorem 2: extract (fill v) = fill (extract v)

theorem Tensor1d.extract_fill [Inhabited α] (t: Tensor1d α):
  (t.extract left len).fill v = (t.fill v).extract left len := by {
    simp[Tensor1d.extract, Tensor1d.fill]
    funext ix;
    by_cases VALID_EXTRACT : left + len < t.size <;> simp[VALID_EXTRACT]
    by_cases VALID_INDEX : ix < len <;> simp[VALID_INDEX]
    have IX_INBOUNDS : ix + left < t.size := by linarith
    simp[IX_INBOUNDS]
}


-- insert a slice into a tensor.
-- if 'sliceix' is larger than t.size, then the tensor is illegal
def Tensor1d.insertslice  [Inhabited α] (t: Tensor1d α)
  (sliceix: Nat)
  (slice : Tensor1d α) : Tensor1d α where
  size := if sliceix > t.size then 0 else t.size + slice.size
  val := fun ix =>
    if sliceix > t.size then default -- slice invalid
    else if ix >= t.size + slice.size then default -- index invalid
    else
      let go (ix: Nat) : α :=
        if ix < sliceix then t.val sliceix
        else if ix < sliceix + slice.size then slice.val (ix - sliceix)
        else t.val (ix - (sliceix + slice.size))
      go ix
  spec := by {
    intros ix
    intros H
    by_cases A:(sliceix > t.size) <;> simp[A]
    simp[A] at H
    by_cases B:(ix < t.size + slice.size) <;> simp[B]
    have CONTRA : False := by linarith
    simp at CONTRA
  }

theorem not_lt_is_geq {a b: Nat} (NOT_LT: ¬ (a < b)): a >= b := by {
  linarith
}
-- extracting an inserted slice returns the slice.
-- need preconditions to verify that this is well formed.
-- TODO: show tobias this example of how we need ability to talk
-- about failure.
-- Also show how this proof is manual, and yet disgusting, because of lack of
-- proof automation. We want 'match goal'.
theorem extractslice_insertslice [Inhabited α]
  (t: Tensor1d α)
  (sliceix: Nat)
  (slice: Tensor1d α)
  (CORRECT: ((t.insertslice sliceix slice).extract sliceix slice.size).size ≠ 0)
  : (t.insertslice sliceix slice).extract sliceix slice.size = slice := by {
    simp[Tensor1d.insertslice, Tensor1d.extract]
    cases slice ; simp;
    case mk slicesize sliceval spec => {
      by_cases A:(t.size < sliceix) <;> simp[A]
      case pos => {simp[Tensor1d.insertslice, Tensor1d.extract, A] at CORRECT };
      case neg => {
        have B : t.size >= sliceix := not_lt_is_geq A

        by_cases C:(sliceix < t.size) <;> simp[C]
        case neg => {simp[Tensor1d.insertslice, Tensor1d.extract, A, B, C] at CORRECT }
        case pos => {
            funext ix
            by_cases D: (ix < slicesize) <;> simp[D]
            case neg => {
              -- here we fail, because we do not know that 'slice' behaves like a
              -- real tensor that returns 'default' outside of its range.
              -- This is something we need to add into the spec of a Tensor.
              have E : ix >= slicesize := by linarith
              simp[spec _ E]
            }
            case pos => {
              simp
              norm_num
              by_cases E:(t.size + slicesize <= ix + sliceix) <;> simp[E]
              case pos => {
                have CONTRA : False := by linarith;
                simp at CONTRA;
              }
              case neg => {
                intros K
                have CONTRA : False := by linarith
                simp at CONTRA
              }
            }
        }
      }
    }
}

-- | TODO: implement fold
-- def Tensor1d.fold_rec (n: Nat) (arr: Fin n → α) (f: β → α → β) (seed: β): β :=
--   match n with
--   | 0 => seed
--   | n + 1 => f (Tensor1d.fold_rec n arr f seed) (arr n)

-- def Tensor1d.fold (f : β → α → β)  (seed : β) (t : Tensor1d α) : β :=
--   Tensor1d.fold_rec t.size t.val f seed

structure Tensor2d (α : Type) where
  size0 : Nat
  size1 : Nat
  val :  Fin size0 → Fin size1 → α

def Tensor2d.transpose (t: Tensor2d α) : Tensor2d α where
  size0 := t.size1
  size1 := t.size0
  val := fun ix0 => fun ix1 => t.val ix1 ix0


-- theorem: transpose is an involution
theorem Tensor2d.transpose_involutive (t: Tensor2d α):
  (t.transpose).transpose = t := by {
    simp[Tensor2d.transpose]
}


-- theorem: map fusion -- map (f ∘ g) = map f ∘ map g
theorem Tensor1d.map_fusion [Inhabited α] (t: Tensor1d α):
  (t.map (g ∘ f)) = (t.map f).map g := by {
    simp[Tensor1d.map]
    funext ix
    by_cases H:(ix < t.size) <;> simp[H]
}

-- for loop
def scf.for.loop (f : Nat → β → β) (n n_minus_i: Nat) (acc: β) : β :=
  let i := n - n_minus_i
  match n_minus_i with
    | 0 => acc
    | n_minus_i' + 1 =>
      scf.for.loop f n n_minus_i' (f i acc)

def scf.for (n: Nat) (f: Nat → β → β) (seed: β) : β :=
  let i := 0
  scf.for.loop f n (n - i) seed

-- theorem 1 : for peeling at beginning
theorem scf.for.peel_begin (n : Nat) (f : Nat → β → β) (seed : β) :
  scf.for.loop f (n + 1) n (f 0 seed) = scf.for.loop f (n + 1) (n + 1) seed := by {
    simp[scf.for.loop]
  }

-- theorem 2 : for peeling at ending
theorem scf.for.peel_end (n : Nat) (f : Nat → β → β) (seed : β) :
  scf.for.loop f (n + 1) 0 (f n seed) = f n (scf.for.loop f n 0 seed) := by {
    simp[scf.for.loop]
  }


-- theorem 3: for fusion: if computations commute, then they can be fused.
-- TODO:
/-
theorem scf.for.fusion (n : Nat) (f g : Nat → β → β)  (seed : β)
  (COMMUTE : ∀ (ix : ℕ)  (v : β),  f ix (g ix v) = g ix (f ix v)) :
  scf.for.loop f n n (scf.for.loop g n n seed) =
  scf.for.loop (fun i acc => f i (g i acc)) n n seed := by {
    induction n;
    case zero => {
      simp[loop];
    }
    case succ n' IH => {
      simp[loop];
      sorry
    }
  }
-/


theorem scf.for.zero_n (f: Nat → β → β) (seed : β) :
  scf.for 0 f seed = seed := by {
    simp[scf.for, loop]
  }

  def scf.for.one_n (f: Nat → β → β) (seed : β) :
  scf.for 1 f seed = f 0 seed := by {
    simp[scf.for, loop]
  }

-- theorem 3 : arbitrary for peeling
/-
theorem scf.for.peel_add (n m : Nat) (f : Nat → β → β) (seed : β)  :
  scf.for.loop f (n + m) ((n + m) - n) (scf.for.loop f n (n - 0) seed) = scf.for.loop f (n + m) (n + m - 0) seed := by {
    simp[scf.for.loop]
    revert m;
    induction n;
    case zero => {
      simp[loop]
    }
    case succ n' IH => {
      intros m;
      simp[loop];
      sorry
    }
  }
-/


-- theorem 4 : tiling
-- proof obligation for chris :)
theorem Tensor1d.tile [Inhabited α] (t : Tensor1d α) (SIZE : 4 ∣ t.size) (f : α → α):
  t.map f = scf.for (t.size / 4) (fun i acc =>
    let tile := t.extract (i * 4) 4
    let mapped_tile := tile.map f
    let out := acc.insertslice (i * 4) mapped_tile
    out) (Tensor1d.empty) := by {
    cases t;
    sorry
}







namespace ArithScfLinalg

open Val

inductive Op
| add
| const (v: Int)
| sub
-- | mul
-- | run
-- | for_
-- | if_
-- | fold1d -- fold
| map1d
| extract1d
-- | fill
-- | transpose

inductive BaseType
| int : BaseType
| nat : BaseType
| tensor1d  : BaseType
| tensor2d : BaseType
deriving DecidableEq, Inhabited

instance : Goedel BaseType where
  toType
  | .int => Int
  | .nat => Nat
  | .tensor1d => Tensor1d Int
  | .tensor2d => Tensor2d Int


abbrev UserType := SSA.UserType BaseType

-- Can we get rid of the code repetition here? (not that copilot has any trouble completing this)
@[simp]
def argUserType : Op → UserType
| Op.add => .pair (.base BaseType.int) (.base BaseType.int)
| Op.sub => .pair (.base BaseType.int) (.base BaseType.int)
| Op.map1d => .base BaseType.tensor1d
| Op.extract1d => .triple (.base BaseType.tensor1d) (.base BaseType.nat) (.base BaseType.nat)
| Op.const _ => .unit

@[simp]
def outUserType : Op → UserType
| Op.add => .base (BaseType.int)
| Op.sub => .base (BaseType.int)
| Op.const _ => .base (BaseType.int)
| Op.map1d =>  .base BaseType.tensor1d
| Op.extract1d =>  .base BaseType.tensor1d

@[simp]
def rgnDom : Op → UserType
| Op.add => .unit
| Op.sub => .unit
| Op.const _ => .unit
| Op.map1d => .base BaseType.int
| Op.extract1d => .unit

@[simp]
def rgnCod : Op → UserType
| Op.add => .unit
| Op.sub => .unit
| Op.const _ => .unit
| Op.map1d => .base BaseType.int
| Op.extract1d => .unit

def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → Option (Goedel.toType (rgnCod o)))) :
  Option (Goedel.toType (outUserType o)) := .some <|
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
    some $ x - y
  -- | .run, v, r => r v
  -- | .if_, (.bool cond), r => if cond then r (.inl .unit) else r (.inr .unit)
  -- | .for_, (.pair (.nat n) (.int seed)), r =>
      -- .int <| scf.for n (fun ix acc => (r (.pair (.int ix) (.int acc))).int!) seed
  | .map1d =>
    let t : Tensor1d Int := arg;
    -- @sid: @chris, the `option` is bad :( I don't want the option.
    let r : Int → Option Int := _rgn;
    let t' := t.map fun v => (r v).get!
    t'
  | .extract1d =>
    let (t, l, len) := arg;
    let t : Tensor1d Int := t;
    let l : Nat := l;
    let len : Nat := len;
    some $ t.extract l len


/-
instance TUS : SSA.TypedUserSemantics Op BaseType where
  argUserType := argUserType
  rgnDom := rgnDom
  rgnCod := rgnCod
  outUserType := outUserType
  eval := eval
-/

/-
syntax "map1d" : dsl_op
syntax "extract1d" : dsl_op
syntax "const" "(" term ")" : dsl_op

macro_rules
| `([dsl_op| map1d]) => `(Op.map1d)
| `([dsl_op| extract1d]) => `(Op.extract1d)
| `([dsl_op| const ($x)]) => `(Op.const $x) -- note that we use the syntax extension to enrich the base DSL
-/

-- Why do these not get set?
register_simp_attr SSA.teval
register_simp_attr EnvU.set
-- register_simp_attr Op.const
register_simp_attr argUserType
register_simp_attr eval
register_simp_attr outUserType
-- register_simp_attr BitVector.width
register_simp_attr uncurry

theorem Option.some_eq_pure {α : Type u} : @some α = @pure _ _ _ := rfl

/-
open SSA in
theorem extract_map :
  let Γ : Context UserType := List.toAList [⟨42, .unit⟩]
  ∀ (e : EnvC Γ),  -- for metavariable in typeclass
  SSA.teval e.toEnvU [dsl_region| dsl_rgn %v0 =>
    %v1 := op:map1d %v0 { %r0 };
    %v2 := op:const(v) %v42;
    %v3 := op:const(43) %v42;
    %v4 := triple:%v1 %v2 %v3;
    %v5 := op:extract1d %v4
    dsl_ret %v5
  ] =
  SSA.teval e.toEnvU [dsl_region| dsl_rgn %v0 =>
    %v1 := op:const(v) %v42;
    %v2 := op:const(43) %v42;
    %v3 := triple: %v0 %v1 %v2;
    %v4 := op:extract1d %v3;
    %v5 := op:map1d %v4 { %r0 }
    dsl_ret %v5
  ] := by {
    sorry
    -- @chris, @andres: Can I have some help rewriting this to eliminate all the overhead?
  }
-/

end ArithScfLinalg
