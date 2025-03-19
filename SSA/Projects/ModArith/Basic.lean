/-
Released under Apache 2.0 license as described in the file LICENSE.

This file contains the definition of the MLIR `ModArith` dialect as
implemented in HEIR, see:
  https://heir.dev/docs/dialects/modarith/

It is structurally similar to `Poly.Basic.lean` but focuses on arithmetic
directly in ℤ/qℤ (ZMod q), rather than polynomials over ℤ/qℤ.

Authors: Jaeho Choi<zerozerozero0216@gmail.com>
-/
import Mathlib.Data.ZMod.Basic
import SSA.Core.Framework

open ZMod

/-!
  # ModArith Dialect

  The `ModArith` dialect is a simpler variant that models integer arithmetic
  **modulo `q`**, i.e., arithmetic in the ring `ZMod q`.

  We assume `q > 1` as a fact. We denote our base ring as: `R = ZMod q`.

  The dialect's type system includes (for example) `index`, `integer`, and
  a specialized type `modLike` for elements in `ZMod q`.

  Operations: Add, Sub, Mul, and constants for this ring, plus integers and
  indices.
-/

section CommRing
/- We assume `q > 1`. -/
variable (q : ℕ) [Fact (q > 1)]

/--
By analogy to `R q n` from the `Poly` dialect, we simply define
`R q := ZMod q`. The ring structure on `ZMod q` is already known
to mathlib.
-/
abbrev R := ZMod q

end CommRing

/-!
## Dialect type definitions

Here, we define a small type system for the `ModArith` dialect:
  1. `index` – if you also want natural-number indices (mirroring MLIR’s index).
  2. `integer` – for full-range integers in Lean (ℤ).
  3. `modLike` – for our ring `ZMod q`.

You can freely add more types or rename them according to your needs.
-/
inductive Ty (q : ℕ) where
| index
| integer
| modLike
deriving DecidableEq, Repr

instance : Inhabited (Ty q) := ⟨Ty.index⟩

/--
We provide a `TyDenote` instance: this is how we translate each
dialect type into an actual Lean type.
-/
instance : TyDenote (Ty q) where
toType
| Ty.index   => Nat
| Ty.integer => Int
| Ty.modLike => R q  -- i.e. `ZMod q`

/-!
## Dialect operation definitions

Here are some sample operations. Adjust as appropriate for the
`modarith` dialect: e.g. you might have add/sub/mul, an operation for
returning constants mod q, an integer constant, index constant, etc.
-/
inductive Op (q : ℕ) where
| add : Op q        -- (modLike, modLike) → modLike
| sub : Op q        -- (modLike, modLike) → modLike
| mul : Op q        -- (modLike, modLike) → modLike
| const (c : R q) : Op q  -- produce a constant in ZMod q
| const_int (c : Int) : Op q  -- produce a constant integer
| const_idx (c : Nat) : Op q  -- produce a constant index

/--
For each operation, we specify its input `sig` (a list of
types) and its `outTy` (the output type).
-/
@[simp, reducible]
def Op.sig : Op q → List (Ty q)
| .add            => [Ty.modLike, Ty.modLike]
| .sub            => [Ty.modLike, Ty.modLike]
| .mul            => [Ty.modLike, Ty.modLike]
| .const _        => []
| .const_int _    => []
| .const_idx _    => []

@[simp, reducible]
def Op.outTy : Op q → Ty q
| .add         => Ty.modLike
| .sub         => Ty.modLike
| .mul         => Ty.modLike
| .const _     => Ty.modLike
| .const_int _ => Ty.integer
| .const_idx _ => Ty.index

/-- Put them together into a `Signature`. -/
@[simp, reducible]
def Op.signature : Op q → Signature (Ty q)
| o => { sig := o.sig, outTy := o.outTy, regSig := [] }

/-!
## The `ModArith` dialect

We bundle up our `Op` and `Ty` into a dialect called `ModArith q`.
-/
abbrev ModArith (q : ℕ) [Fact (q > 1)] : Dialect where
Op := Op q
Ty := Ty q

instance (q : ℕ) [Fact (q > 1)] : DialectSignature (ModArith q) := ⟨Op.signature⟩

/-!
## Dialect semantics

Finally, we provide the Lean semantics for each operation in the dialect:
i.e., how to interpret `add`, `sub`, `mul`, etc. as Lean functions.
-/
noncomputable instance (q : ℕ) [Fact (q > 1)] : DialectDenote (ModArith q) where
denote
  | .add, arg, _ =>
      -- Add mod q
      (fun args : R q × R q => args.1 + args.2) arg.toPair
  | .sub, arg, _ =>
      -- Sub mod q
      (fun args : R q × R q => args.1 - args.2) arg.toPair
  | .mul, arg, _ =>
      -- Mul mod q
      (fun args : R q × R q => args.1 * args.2) arg.toPair
  | .const c, _, _ =>
      -- A constant in ZMod q
      c
  | .const_int c, _, _ =>
      -- A plain integer (ℤ)
      c
  | .const_idx c, _, _ =>
      -- A plain index (ℕ)
      c
