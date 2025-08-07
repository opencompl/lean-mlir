/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework
import SSA.Core.Util
import Mathlib.Tactic.Linarith

namespace Tensor1D
/-
simple examples of 1D tensors, as per MLIR.
-/

/-- Type of tensor dimensions and indexes into tensor dimensions.
  NOTE: see interaction with `linarith` where we need to unfold `Index` into `ℕ`
  https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/Ergonomics.3A.20linarith.20does.20not.20work.20on.20Nat.20alias/near/365631549
-/
abbrev Index := ℕ

-- pure simply typed lambda calculus
structure Tensor1d (α : Type) [Inhabited α] where
  size : Index
  val :  Index → α
  spec : ∀ (ix: Index), ix >= size -> val ix = default

-- TODO: create equivalence relation for tensors
-- that says tensors are equivalent if they have the same size and
-- the same values at each index upto the size.
def Tensor1d.empty [Inhabited α] : Tensor1d α where
  size := 0
  val := fun _ => default
  spec := by {
    intros _ix _IX
    simp;
  }



-- [0..[left..left+len)..size)
-- if the (left + len) is larger than size, then we don't have a valid extract,
-- so we return a size zero tensor.

set_option warn.sorry false in
def Tensor1d.extract [Inhabited α] (t: Tensor1d α)
  (left: Index) (len: Index) : Tensor1d α :=
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
      try simp[A] at right
      -- TODO: how to substitute?
      have LEN : len < t.size := by simp[Index] at *; linarith
      intros H
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
    have CONTRA : False := by simp[Index] at *; linarith
    simp at CONTRA
  }

-- Note that this theorem is wrong if we cannot state what happens
-- when we are out of bounds, because the side that is (map extract) will have
-- (f default), while (extract map) will be (default)
-- theorem 1: extract (map) = map extract
theorem Tensor1d.extract_map [Inhabited α] (t: Tensor1d α) (left len: Index) :
  (t.extract left len).map f = (t.map f).extract left len := by {
    simp[Tensor1d.extract, Tensor1d.map]
    funext ix;
    by_cases VALID_EXTRACT : left + len < t.size <;> simp[VALID_EXTRACT]
    by_cases VALID_INDEX : ix < len <;> simp[VALID_INDEX]
    have IX_INBOUNDS : ix + left < t.size := by simp[Index] at *; linarith
    simp[IX_INBOUNDS]
}

def Tensor1d.fill [Inhabited α] (t: Tensor1d α) (v: α) : Tensor1d α where
  size := t.size
  val := fun ix => if ix < t.size then v else default
  spec := by {
    intros ix IX;
    simp;
    intros H
    have CONTRA : False := by simp[Index] at *; linarith
    simp at CONTRA
  }

-- theorem 2: extract (fill v) = fill (extract v)

theorem Tensor1d.extract_fill [Inhabited α] (t: Tensor1d α):
  (t.extract left len).fill v = (t.fill v).extract left len := by {
    simp[Tensor1d.extract, Tensor1d.fill]
    funext ix;
    by_cases VALID_EXTRACT : left + len < t.size <;> simp[VALID_EXTRACT]
    by_cases VALID_INDEX : ix < len <;> simp[VALID_INDEX]
    have IX_INBOUNDS : ix + left < t.size := by simp[Index] at *; linarith
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
    have CONTRA : False := by simp[Index] at *; linarith
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
    cases slice
    simp;
    rename_i slicesize sliceval spec
    by_cases A : (t.size < sliceix) <;> simp[A]

    case pos => simp[Tensor1d.insertslice, Tensor1d.extract, A] at CORRECT ;
    case neg =>
      have B : t.size >= sliceix := not_lt_is_geq A

      by_cases C:(sliceix < t.size) <;> simp[C]
      case neg => simp [Tensor1d.insertslice, Tensor1d.extract, A, C] at CORRECT
      case pos =>
          funext ix
          by_cases D: (ix < slicesize) <;> simp[D]
          case neg =>
            -- here we fail, because we do not know that 'slice' behaves like a
            -- real tensor that returns 'default' outside of its range.
            -- This is something we need to add into the spec of a Tensor.
            have E : ix >= slicesize := by simp[Index] at *; linarith
            simp[spec _ E]
          case pos =>
            try simp
            by_cases E:(t.size + slicesize <= ix + sliceix) <;> simp[E]
            case pos =>
              have CONTRA : False := by simp[Index] at *; linarith;
              simp at CONTRA;
            case neg =>
              intros K
              have CONTRA : False := by simp[Index] at *; linarith
              simp at CONTRA
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
  scf.for.loop f (n + m) ((n + m) - n) (scf.for.loop f n (n - 0) seed) =
  scf.for.loop f (n + m) (n + m - 0) seed := by {
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
proof_wanted Tensor1d.tile [Inhabited α] (t : Tensor1d α) (_ : 4 ∣ t.size) (f : α → α):
  t.map f = scf.for (t.size / 4) (fun i acc =>
    let tile := t.extract (i * 4) 4
    let mapped_tile := tile.map f
    let out := acc.insertslice (i * 4) mapped_tile
    out) (Tensor1d.empty)

/--
We make the following simplifying assumptions in the IR:
- Currently, there is no way to *build* a tensor, we only have operations on them.
- Constants are only natural numbers, which represent indexing into tensors.
- 1D tensors are functions from indexes (natural) to tensor values (integers).


This matches the MLIR model, which has a separate `index` type for indexing
and `iXX/f32/f64` types for values held in tensors.
-/
inductive Op
| /-- add two integers -/ add_int
| /-- create a constant index -/ const_ix (v: Index)
| /-- subtract two integers -/ sub_int
| /-- map a function onto a tensor -/ map1d
| /-- extract a value at an index of a tensor -/ extract1d
deriving DecidableEq

inductive Ty
| /-- values held in tensors -/ int : Ty
| /-- shapes and indexes of tensors -/ ix : Ty
| /-- tensor type -/ tensor1d  : Ty
deriving DecidableEq, Inhabited

instance : TyDenote Ty where
  toType
  | .int => Int
  | .ix => Index
  | .tensor1d => Tensor1d Int

@[reducible, simp]
def Op.outTy : Op → Ty
  | .add_int => .int
  | .sub_int => .int
  | .const_ix _ => .ix
  | .map1d =>  .tensor1d
  | .extract1d =>  .tensor1d

@[reducible, simp]
def Op.sig : Op → List Ty
  | .add_int => [.int, .int]
  | .sub_int => [.int, .int]
  | .map1d => [.tensor1d]
  | .extract1d => [.tensor1d, .ix, .ix]
  | .const_ix _ => []

@[reducible, simp]
def Op.regSig : Op → RegionSignature Ty
  | .map1d => [([Ty.int], .int)]
  | _ => []

set_option linter.dupNamespace false in
def Tensor1D : Dialect where
  Op := Op
  Ty := Ty

instance : DialectSignature Tensor1D where
  signature op := { sig := op.sig, regSig := op.regSig, outTy := op.outTy, effectKind := .pure }

/-
-- Error: unknown free variable: _kernel_fresh.459
@[reducible]
instance : DialectDenote Op Ty where
  denote
  | .const_ix v, _, _ => v
  | .add_int, (.cons x (.cons y nil)), _ =>
      let x : Int := x;
      let y : Int := y
      x + y
  | .sub_int, (.cons x (.cons y nil)), _ =>
    let x : Int := x;
    let y : Int := y;
    x - y
  | .map1d, (.cons t .nil), (.cons r .nil) =>
    let t : Tensor1d Int := t;
    -- Is there a cleaner way to build the data below?
    let r : Int → Int := fun v =>  r (Ctxt.Valuation.ofHVector <| (.cons v .nil))
    let t' := t.map r
    t'
  | .extract1d, (.cons t (.cons l (.cons len .nil))), _ =>
    let t : Tensor1d Int := t;
    let l : Index := l;
    let len : Index := len;
    t.extract l len
-/
/-
open SSA EDSL in
theorem extract_map (r0 : TSSA Op Context.empty _) :
  TSSA.eval (e := e) [dsl_region| rgn{ %v0 =>
    ^bb
      %v42 := unit: ;
      %v1 := op:map1d %v0, rgn$(r0) ; -- TODO: add syntax for DSL regions.
      %v2 := op:const(v) %v42;
      %v3 := op:const(101) %v42;
      %v4 := triple:%v1 %v2 %v3;
      %v5 := op:extract1d %v4
      dsl_ret %v5
  }] =
  TSSA.eval (e := e) [dsl_region| rgn{ %v0 =>
    ^bb
      %v42 := unit: ;
      %v1 := op:const(v) %v42;
      %v2 := op:const(101) %v42;
      %v3 := triple: %v0 %v1 %v2;
      %v4 := op:extract1d %v3;
      -- jeez, so having intrinsically well typed terms means that I
      -- cannot reuse the same variable r0 as they occur in different
      -- contexts. crazy!
      %v5 := op:map1d %v4, rgn$(r0) -- TODO: add syntax for region variables
      dsl_ret %v5
  }] := by {
    simp
    simp[TypedUserSemantics.eval];
    simp[eval];
    funext arg;
    simp[UserType.mkTriple]
    simp[Tensor1d.extract_map]
  }
-/
end Tensor1D
