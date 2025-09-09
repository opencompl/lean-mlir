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
Free a block of memory

Raises UB if:
- `p` is poison
- The block pointed to by `p.id` has not been allocated yet or has been freed already
-/
def free (p : SLLVM.Ptr) : EffectM Unit := do
  let p ← p.getOrUB
  let _ ← getLiveBlockOrUB p
  modifyThe MemoryState fun m => { m with
    mem := m.mem.insert p.id .dead
  }

/--
Allocate a block of `n` *bytes* of memory, and return a pointer pointing to the
start of the freshly allocated block.

Raises UB if `n` is poison.
-/
def malloc (n : LLVM.IntW w) : EffectM SLLVM.Ptr := do
  let n ← n.getOrUB
  let p ← modifyGetThe MemoryState (allocate (8 * n.toNat))
  .value p
where
  allocate (length : Nat) (m : MemoryState) : Pointer × MemoryState :=
    let blockId := ⟨m.nextFreeBlock⟩
    let nextFreeBlock := m.nextFreeBlock + 1
    if blockId ∈ m.mem then
      allocate length { m with nextFreeBlock }
    else
      let mem := m.mem.insert blockId (.live ⟨length, 0#_⟩)
      ⟨ { id := blockId, offset := 0 },
        { mem, nextFreeBlock }
      ⟩
  partial_fixpoint

/-!
TODO: Note that the above will deterministically pick the next available address.
This is *not* actually the semantics we'd want. In reality, we probably need
to say the an allocation non-deterministally picks any available address.
Similarly, when definining the semantics of `split`, we'd probably want it to
non-deterministally split up the available addresses between the two memory
states.

In any case, introducing non-determinism into `EffectM` and figuring this out
exactly is left as work for a future PR. This is also why we don't have an
`SLLVM.Op` for allocation yet.
-/
