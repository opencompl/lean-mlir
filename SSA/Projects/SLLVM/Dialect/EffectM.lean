/-!
# LLVM Effect Monad

This file defines `StructuredLLVM.EffectM`; the monad which defines the core
effects that the structured LLVM dialect allows.

These effects are:
- Immediate undefined behaviour, which is modelled in the `UB` monad
- Memory effects, essentially a `StructuredLLVM.Memory` state monad

-/

namespace StructuredLLVM

/-! ## Undefined Behaviour -/

/-- A value `UB m α` is either `ub` (i.e., *immediate* undefined behaviour), or
some *defined* value of type `m α`.

That is, `UB` is equivalent to `OptionT` -/
def UB (m : Type u → Type v) : Type u → Type v :=
  OptionT m
-- TODO: in future we likely want a `UB` inductive type with custom constructors,
--       to disambiguate from poison

namespace UB

variable {m} [Monad m]

/-- `ub` is *immediate* undefined behaviour, as a side effect. -/
def ub : UB m α := OptionT.fail

end UB

/-! ## Memory -/

namespace Memory

end Memory

def Time := Nat
def BlockId := Nat
def CallId := Nat

inductive BlockType
  | heap
  | stack
  | «global»
  | function

structure LifeRange where
  startTime : Time
  /-- The end time of this range, where `none` represents infinity -/
  endTime : Option Time

structure Block where
  /--
  `type` disambiguates heap-allocations from stack or other allocations.
  -/
  type : BlockType
  /--
  The life range of the block.

  When a block is deallocated (e.g., with free or on function exit), it is not deleted from memory.
  Instead, we set the end of the lifetime range to the current memory time stamp,
  and increment said time stamp.
  -/
  lifeRange : LifeRange
  /--
  The number of bytes in this block.
  -/
  blockSize : Nat
  alignment : Nat
  /--
  The actual data.
  -/
  contents : BitVec (n * 8)
  P : _

open Memory in
structure Memory where
  /--
  The current abstract timestamp. When a new memory block is created (e.g., with
  malloc or alloca) or deallocated, the time stamp is incremented by one.
  -/
  currentTime : Time
  blocks : BlockId → Option Block
  calls : CallId → Option Time


/-- A monad that caries mutable LLVM memory state -/
def MemoryEffect := StateT Memory
