/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Projects.SLLVM.Dialect.Semantics.EffectM
import SSA.Projects.SLLVM.Dialect.Semantics.ArithSemantics
import SSA.Projects.SLLVM.Tactic.SimpSet



/-- `x.getOrUB` raises UB if `x` is poison. -/
def PoisonOr.getOrUB  : PoisonOr α → LeanMLIR.EffectM α
  | .value x => pure x
  | .poison => .ub

/-- `x.getOrUB` raises UB if `x` is `none` -/
def Option.getOrUB : Option α → LeanMLIR.EffectM α
  | .some x => pure x
  | .none => .ub

namespace LeanMLIR

/-! ## Instructions -/
namespace SLLVM
open BitVec

/--
Return the block pointed to by `p`, or throw UB if this block
- doesn't exists (i.e., hasn't been allocated yet), or
- has been freed already
-/
def getLiveBlockOrUB (p : Pointer) : EffectM LiveBlock := do
  let m ← getThe MemoryState
  let some (.live block) := m[p.id]?
    | .ub
  return block

/-- throw UB if `p` is true -/
def throwUBIf (p : Prop) [Decidable p] : EffectM Unit :=
  if p then .ub else pure ()


/--
`load p n` will load `n` bits from the location pointed to by `p`.

Raises UB if:
- `p` is poison
- The block pointed to by `p.id` has not been allocated yet or has been freed already
- The range of bits to be read is out of range of the block pointed to by `p.id`

**SIMPLIFICATION**: we don't model alignment constraints at all
-/
def load (p : SLLVM.Ptr) (w : Nat) : EffectM (LLVM.IntW w) := do
  let p ← p.getOrUB
  let block ← getLiveBlockOrUB p
  throwUBIf <| p.offsetInBits + w > block.lengthInBits
  .value <| block.bytes.extractLsb' p.offsetInBits w

/--
`store p x` will store the value `x` at the location pointed to by `p`.

Raises UB if:
- `p` is poison
- The block pointed to by `p.id` has not been allocated yet or has been freed already
- The range of bits to be written is out of range of the block pointed to by `p.id`

**SIMPLIFICATION**: we don't model alignment constraints at all
-/
def store (p : SLLVM.Ptr) (x : LLVM.IntW w) : EffectM Unit := do
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
