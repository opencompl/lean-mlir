import SSA.Core.Framework.Refinement
import SSA.Projects.SLLVM.Tactic.SimpSet

namespace LeanMLIR

structure BlockId where
  id : Nat
  deriving DecidableEq, Hashable, Inhabited

/-!
**SIMPLIFICATION**
We don't support storing poison, only fully-defined values!
-/

structure LiveBlock where
  (length : Nat)
  (bytes : BitVec (8 * length))

inductive Block where
  /-- A block of memory which was allocated and then freed. -/
  | dead
  /-- A live piece of memory (i.e., has been allocated and not yet freed). -/
  | live (b : LiveBlock)

structure MemoryState where
  mem : Std.HashMap BlockId Block
  nextFreeBlock : Nat
  deriving Inhabited

structure Pointer where
  id : BlockId
  /-- Offset in bytes -/
  offset : BitVec 64
  deriving Inhabited

/-! ## Basic Definitions -/

instance : GetElem? MemoryState BlockId Block (fun m i => i ∈ m.mem) where
  getElem mem id h := mem.mem[id]
  getElem? mem id  := mem.mem[id]?

def LiveBlock.lengthInBits (b : LiveBlock) : Nat :=
  8 * b.length

def Pointer.offsetInBits (p : Pointer) : Nat :=
  8 * p.offset.toNat

/-! ## Refinement -/
section Refinement

instance : Refinement MemoryState where
  IsRefinedBy s t := ∀ (id : BlockId),
    s[id]? = t[id]?

end Refinement
