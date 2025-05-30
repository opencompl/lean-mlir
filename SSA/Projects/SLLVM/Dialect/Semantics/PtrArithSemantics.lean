/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Algebra.Order.Floor.Div

import SSA.Projects.SLLVM.Dialect.Semantics.ArithSemantics

namespace LeanMLIR.SLLVM

def Ptr := PoisonOr Pointer

/-! ## Instructions -/
open EffectM

/--
`Ptr.add p off` models an addition of a (signed integer) offset to a pointer.
Thus, it corresponds to a simple form of GEP:
`llvm.getelementptr i8, i8* %p, i64 %offset`
-/
@[simp_sllvm]
def Ptr.add (p : Ptr) (offset : LLVM.IntW 64) : EffectM Ptr := pure <| do
  let p ← p
  let offset ← offset
  match p with
  | .logical bid o => return .logical bid (o + offset)

/-! ## load -/

/--
`IsInBounds` returns true when the `n` bits starting from the given
`offset` are completely in bounds of the current memory block.
-/
@[simp_sllvm]
abbrev MemBlock.IsInBounds (self : MemBlock) (offset : BitVec 64) (n : Nat) : Prop :=
  offset.toNat + (n ⌈/⌉ 8) < self.size.toNat

def MemBlock.load (self : MemBlock) (offset : BitVec 64) (n : Nat) : BitVec n :=
  self.bytes.extractLsb' (offset.toNat * 8) n

def load (w : Nat) (p : Ptr) : EffectM (LLVM.IntW w) := do
  if p.isPoison then
    ub -- dereferencing poison
  else
    let mem ← StateT.get
    match p.getValue with
    | .logical bid offset =>
      let block? := mem.blocks.lookup bid
      let block := block?.getD default
      if block?.isNone ∨ ¬block.IsInBounds offset w then
        ub -- dereferencing an out-of-bounds pointer
      else
        value <| block.load offset w

/-! ## store -/

def MemBlock.store (self : MemBlock) (offset : BitVec 64) (val : LLVM.IntW n)
    (h : self.IsInBounds offset n)
    : MemBlock :=
  let size := 8 * self.size.toNat
  let offset := 8 * offset.toNat
  { self with bytes :=
      self.bytes
      &&& ((-1#offset ++ 0#n ++ -1#(size - offset -n))
            |>.cast (m := size) <| by
                simp_all [IsInBounds, Nat.ceilDiv_eq_add_pred_div]; omega
          )
      ||| (val.getValue.zeroExtend size <<< offset)
  }
/-
TODO: what happens when we store a poison value?
Currently, we just ignore such stores, but I believe the LLVM memory models wants
us to store poison-ness of bits in memory.
-/

theorem MemBlock.load_store (block : MemBlock) (offset : BitVec 64) (val : BitVec n)
    (h : block.IsInBounds offset n) :
    (block.store offset (.value val) h).load offset n  = val := by
  simp [load, store, BitVec.extractLsb'_and, BitVec.extractLsb'_or]
  have h₁ {w} (start len : Nat) (x : BitVec w) (n : Nat) :
      BitVec.extractLsb' start len (x <<< start)
      = BitVec.extractLsb' 0 len x := by
    sorry
  stop
  bv_decide

-- def store {w} (x : LLVM.IntW w) (p : Ptr) : EffectM Unit := do
--   if p.isPoison then
--     ub -- dereferencing poison
--   else
--     match p.getValue with
--     | .logical bid offset =>
--       StateT.modifyGet (fun s =>
--         s.mod
--       )
--       -- let block? := mem.blocks.lookup bid
--       -- let block := block?.getD default
--       -- if block?.isNone ∨ ¬block.IsInBounds offset w then
--       --   ub -- dereferencing an out-of-bounds pointer
--       -- else
      --   value <| block.load offset w
