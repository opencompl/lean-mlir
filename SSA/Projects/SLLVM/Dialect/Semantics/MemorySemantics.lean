/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Projects.SLLVM.Dialect.Semantics.HasUB
import SSA.Projects.SLLVM.Dialect.Semantics.EffectM
import SSA.Projects.SLLVM.Dialect.Semantics.ArithSemantics
import SSA.Projects.SLLVM.Tactic.SimpSet

namespace LeanMLIR

/-! ## Instructions -/
namespace SLLVM
open BitVec

/-- A memorySSA'd state, which tracks:
* the content of memory blocks
* whether UB has occurred (within the def-use chain of the state)
-/
def MemorySSAState := PoisonOr MemoryState

/--
Return the block pointed to by `p`, or throw UB if this block
- doesn't exists (i.e., hasn't been allocated yet), or
- has been freed already
-/
def getLiveBlockOrUB (p : Pointer) : MemorySSAM LiveBlock := do
  let m ← getThe MemoryState
  let some (.live block) := m[p.id]?
    | throwUB
  return block

/--
`load p n` will load `n` bits from the location pointed to by `p`.

Raises UB if:
- `p` is poison
- The block pointed to by `p.id` has not been allocated yet or has been freed already
- The range of bits to be read is out of range of the block pointed to by `p.id`

**SIMPLIFICATION**: we don't model alignment constraints at all
-/
def load (p : SLLVM.Ptr) (w : Nat) : MemorySSAM (LLVM.IntW w) := do
  let p ← p.getOrUB
  let block ← getLiveBlockOrUB p
  throwUBIf <| p.offsetInBits + w > block.lengthInBits
  return .value <| block.bytes.extractLsb' p.offsetInBits w

/--
A wrapper around `load` which makes the operation pure, operating against the
state in a (memory)SSA variable.
-/
def loadPure (m : MemorySSAState) (p : SLLVM.Ptr) (w : Nat) : MemorySSAState × LLVM.IntW w :=
  match m with
  | .poison => (.poison, .poison)
  | .value m =>
    match (load p w).run m with
    | .poison => (.poison, .poison)
    | .value ⟨x, m⟩ => ⟨.value m, x⟩

/--
`store p x` will store the value `x` at the location pointed to by `p`.

Raises UB if:
- `p` is poison
- The block pointed to by `p.id` has not been allocated yet or has been freed already
- The range of bits to be written is out of range of the block pointed to by `p.id`

**SIMPLIFICATION**: we don't model alignment constraints at all
-/
def store (p : SLLVM.Ptr) (x : LLVM.IntW w) : MemorySSAM Unit := do
  let p ← p.getOrUB
  let x ← x.getOrUB
  let block ← getLiveBlockOrUB p
  throwUBIf <| p.offsetInBits + w > block.lengthInBits
  let bytes := block.bytes ||| (x.zeroExtend _ >>> p.offsetInBits)
  modifyThe MemoryState fun m => { m with
    mem := m.mem.insert p.id (.live { block with bytes })
  }
  return ()

/--
A wrapper around `store` which makes the operation pure, operating against the
state in a (memory)SSA variable.
-/
def storePure (m : MemorySSAState) (p : SLLVM.Ptr) (x : LLVM.IntW w) : MemorySSAState := do
  let m ← m
  Prod.snd <$> (store p x).run m

/--
Allocate the next available block of `w` bits on the stack.

Note: we currently only ever model a single function body, so there is no
mechanism yet to de-allocate a block of memory.
-/
def alloca (w : Nat) : EffectM SLLVM.Ptr := do
  let blockId : BlockId ← modifyGetThe AllocState fun s =>
    (⟨s.nextFreeBlock⟩, { s with nextFreeBlock := s.nextFreeBlock + 1})
  let ptr := .value { id := blockId, offset := 0 }
  modifyThe MemoryState fun s => { s with
      mem := s.mem.insert blockId <| .live {
        length := (w + 7) / 8
        bytes := 0#_
      }
    }
  return ptr
