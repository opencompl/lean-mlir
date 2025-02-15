/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

/-!
## Arith Dialect

This module formalizes the integer fragment of the arith dialect.

> The arith dialect is intended to hold basic integer and floating point
> mathematical operations. This includes unary, binary, and ternary arithmetic
> ops, bitwise and shift ops, cast ops, and compare ops. Operations in this
> dialect also accept vectors and tensors of integers or floats. The dialect
> assumes integers are represented by bitvectors with a two’s complement representation.
> Unless otherwise stated, the operations within this dialect propagate poison values,
> i.e., if any of its inputs are poison, then the output is poison.
> Unless otherwise stated, operations applied to vector and tensor values
> propagates poison elementwise.
https://mlir.llvm.org/docs/Dialects/ArithOps/

NOTE: we only formalize the integer operations, there is support for floating
point operations, nor for vectors or tensors of integers or floats, yet.

The arith dialect provides only operations, no types. Instead, it's operations
are specified as operating on "signless-integer-like" or "floating-point-like"
types.

-/
