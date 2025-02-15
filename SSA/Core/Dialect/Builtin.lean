/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework

/-!
## Builtin Dialect

This module formalizes a limited subset of the MLIR builtin dialect:

> The builtin dialect contains a core set of Attributes, Operations, and Types
> that have wide applicability across a very large number of domains and abstractions.
> Many of the components of this dialect are also instrumental in the implementation of the core IR.

NOTE: any references to "the builtin dialect" in this file will refer to the limited
subset of the MLIR builtin dialect that we actually formalize!

References:
[1]: https://mlir.llvm.org/docs/Dialects/Builtin/
-/

namespace LeanMLIR.Dialect

/-! ## Operations and Types -/
namespace Builtin

/-- `Builtin` has no operations -/
def BuiltinOp := Empty

/- TODO: define vectors, which need `Scalability` as one of their arguments
inductive Scalability
  | scalable
  | fixed
-/

/-- Types of the `Builtin` dialect -/
inductive BuiltinTy
  /-- Signless integer type with arbitrary precision up to a fixed limit. -/
  -- TODO: signed and unsigned integers
  | int (w : Nat)
  /-- Integer-like type with unknown platform-dependent bit width -/
  | index
  -- TODO: define vectors, with the following definition:
  -- /-- Multi-dimensional SIMD vector type -/
  -- | vector (elem : Ty) (dims : List (Nat × Scalability))

/-!
## TODO: Type or Type Constructors?

The MLIR builtin dialect also specifies a tuple type constructor.
This presents somewhat of a challenge in our framework: presumably we'd want to
have tuples whose elements are not just builtin types, but also may contain types
from other dialects in the IR mix. This means that either (a) the builtin dialect
should actually also be a dialect transformer, or (b) we should say that a dialect
doesn't have types, but rather type constructors.

With approach (a) we'd have to specify some way to take the fixpoint of a collection
of transformers, since we no longer have any dialect to start applying the transformers
to. This seems complicated, but actually might be what we want regardless.

Consider the combination `ptr + arith + builtin`. Assume we've defined `Builtin`
as a plain dialect, and both `Ptr` and `Arith` as dialect transformers. If we
accidentally defined the composition as `Ptr <| Arith <| Builtin`, then the
`Arith` transformer is only applied to `Builtin`, and thus it seems the resulting
dialect would not actually allow for arithmetic operations to operate on pointers.
Now, in this specific example, `Arith <| Ptr <| Builtin` would work, but suppose
that the `Arith` dialect actually defined its own types: then this ordering would
mean we could not have pointers to arith types.
Having the final IR be dependent on the order of definition seems a bit brittle
to begin with, the hypothetical shows there could be situations where no ordering
has the full desired semantics. Consequently: we'll need some way to take a
fixpoint of an unordered set of dialect transformers regardless of the type
constructor issue.

NOTE: The vector type explicitly states it's elements must be
"integer or index or floating point" (**not** integer-like), so it isn't
part of this discussion.
-/

end Builtin

open Builtin in
/-- The builtin dialect provides a core set of types intended to be the basis
of all other dialects. -/
def Builtin : Dialect where
  Op := BuiltinOp
  Ty := BuiltinTy

/-! ## Semantics -/
namespace Builtin

/-- The signature is trivial, since the `Builtin` dialect has no operations -/
instance : DialectSignature Builtin where
  signature := Empty.elim

instance : TyDenote Builtin.Ty where
  toType ty := match ty with
    /- TODO: come up with denotations for `int` type.

    We could simply re-use `IntW` from the InstCombine dialect.
    Alternatively, it might be cleaner to define a `PoisonM` monad, equivalent to
    `Option`, but which would be self-documenting as a model for poison.

    In fact, in the arith dialect we might want to specify that integer-like types
    are denoted as `PoisonM _`, so that we can unify some of the poison handling
    in the arith dialect (i.e., define `Arith.IntegerLike.add` to be of type
      `OverflowFlags → α → α → PoisonM α`
    rather than
      `OverflowFlags → ⟦ty⟧ → ⟦ty⟧ → ⟦ty⟧`
    So that trivial poison propagation can be handled by arith, rather than having
    to be defined in each instance of `IntegerLike`.
    -/
    | .int w => sorry
    /- TODO: denotation for `index`

    What should be the denotation of `index`? It's defined as
      "Integer-like type with unknown platform-dependent bit width"
    Some (flawed) options:

    (a) `BitVec 64`
      Most common platforms nowadays are 64bits, so we could just pick that as
      a sensible default. This would mean that we'd verify optimizations as
      correct that rely on this specific width (e.g., rewriting `u64::MAX + 1`
      to `0`/`poison`), meaning we cannot trust the results on other platforms.

    (b) `Nat`
      This would prevent any optimizations that rely on specific overflowing
      behaviour, but, it would *allow* optimizations that might be wrong in the
      presence of overflows / poison. For example, it would allow the removal of
      a `u128` to `index` to `u128` casting roundtrip and replacing it with a
      no-op, even though on a 64-bit platform the first cast would truncate to
      64 bits and the second cast would zero-extend the truncated value,
      yielding a completely different (poison-free!) value.

    -/
    | .index => sorry

/-- Operation semantics are again trivial, since `Builtin` has no operations -/
instance : DialectDenote Builtin where
  denote op _ := Empty.elim op
