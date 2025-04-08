
/-!
# LLVM Memory Model

This file formalizes a *sequential* memory model for LLVM, inspired by
- [Reconciling high-level optimizations and low-level code in LLVM](https://dl.acm.org/doi/10.1145/3276495)
- [An SMT Encoding of LLVM’s Memory Model for Bounded Translation Validation](https://web.ist.utl.pt/nuno.lopes/pubs/alive2-mem-cav21.pdf)

Note that in the formalization, we assume a 64-bit architecture!
Nothing in the formalization itself should depend on the exact pointer-width,
but this assumption does affect which optimizations are admitted.

TODO:
- [ ] Multiple address spaces
- [ ] The actual memory model (for now we just pretend it's flat)

-/

namespace StructuredLLVM

/-! ## Basic Memory-related Types -/

/-- A "raw" address is just the physical address in memory -/
def RawAddress := BitVec 64

/-- A pointer is a raw address, with additional provenance tracking,
or it might be a poison value.

TODO: actually implement provenance tracking
TODO: add the possibility of poison
-/
def Pointer : Type :=
  RawAddress

structure Memory where
  mem : RawAddress → BitVec 8

/-! ## Pointer Arithmetic -/

namespace Pointer

end Pointer

/-! ## Memory-related Definitions -/
section MemoryDefs

/-!
The memory model will of course form the basis of formalizing memory side effects
of the (structured) LLVM dialect. In LeanMLIR, side effects are formalized through
a monad, so we define the basic memory API as monadic definitions.

However, to maintain loose coupling with other side-effects, we don't hard-code
the specific monad here. Instead, we define the API on arbitrary monads, with
appropriate constraints.
-/

/-! We use `r` for definitions that only read memory -/
variable {r} [Monad r] [MonadReaderOf Memory r]
/-! We use `s` for definitions that additionally write to memory as well -/
variable {s} [Monad s] [MonadStateOf Memory s]

/-
TODO: is this complexity really worth it? We could also introduce a single
`Effects/Basic` file that *just* defines the relevant monad stack, and then
have `Effects/Memory`, `Effects/UB`, etc. that has the actual monadic/side-effecting
functions, operating on the concrete monad stack.

Counterpoint: we'd likely write such definitions in terms of `readThe` and related
helpers to access the state anyway, so it's not much different in that regard.
It'll mostly matter once we need to throw UB: at that point we'd have to introduce
some typeclass that captures the question of "does monad `r` allow for a UB side-effect".
That complexity likely is not worth it; let's move things around when we get to the UB point.
For now, we just model a flat memory model, so there's no need for UB anyway.
-/

/-- Read a single byte from memory -/
def read_byte (p : Pointer) : r (BitVec 8) := do
  -- TODO: if `p` is poison, raise ub
  let { mem } ← readThe Memory
  return mem p

end MemoryDefs
