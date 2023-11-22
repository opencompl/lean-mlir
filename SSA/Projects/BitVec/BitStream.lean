import Mathlib.Logic.Equiv.Basic
import Std.Data.BitVec

open Std (BitVec)

/-- Return the number of ones (i.e., `true` bits) in a bitvector -/
def Std.BitVec.countOnes : {w : Nat} → BitVec w → Fin (w+1)
  | 0, _    => 0
  | w+1, x  =>
    let c := countOnes (x.truncate w)
    bif x.getLsb 0 then c.succ else c.castSucc

/-!
  A `BitStream` is an infinite stream of bits (i.e., `Bool`s).
  This is also known as a "2-adic number".

  We use this notion to study operation on bitvectors of arbitrary width, and to develop
  a normalization tactic for open bitvector expressions with certain operations.
-/

/--
A `BitStream` is an infinite stream of bits (i.e., `Bool`s).
This is also known as a "2-adic number".
-/
structure BitStream where
  {σ : Type}
  transition : σ → Bool × σ
  state : σ

namespace BitStream

def next (s : BitStream) : Bool × BitStream :=
  let ⟨bit, nextState⟩ := s.transition s.state
  ⟨bit, ⟨s.transition, nextState⟩⟩

/-- Compute a finite prefix of a bit stream -/
def truncate (s : BitStream) : (w : Nat) → BitVec w
  | 0 => BitVec.nil
  | w+1 =>
      let ⟨b, s⟩ := s.next
      BitVec.cons b (s.truncate w)

/--
A `BitStream.Transform` represents an `n`-ary operation on bitstreams as a labelled transition
system.
That is, the transition function is now also allowed to depend on a `n`-ary bitvector, which
represents the head bits of each of the `n` operand streams.
-/
structure Transform (n : ℕ) where
  {σ : Type}
  transition : BitVec n → σ → Bool × σ
  state : σ


namespace Transform

/-- A nullary transform is just a bitstream -/
def collapse (t : Transform 0) : BitStream where
    σ           := t.σ
    transition  := t.transition BitVec.nil
    state       := t.state

/-- By applying a `n+1`-ary transform to a bitstream, we obtain an `n`-ary transform -/
def apply (t : Transform (n+1)) (arg : BitStream) : Transform n where
    σ := t.σ × arg.σ
    transition := fun inputBits ⟨transformState, argState⟩ =>
      let ⟨argBit, newArgState⟩ := arg.transition argState
      let ⟨outBit, newTransformState⟩ :=
        t.transition (BitVec.cons argBit inputBits) transformState
      ⟨outBit, ⟨newTransformState, newArgState⟩⟩
    state := ⟨t.state, arg.state⟩

-- /-- A nullary transform is equivalent to a bitstream -/
-- theorem nulEquiv : Transform 0 ≃ BitStream where
--   toFun  := collapse
--   invFun :=

/-- A generic way to construct transforms without state -/
def stateless (n : ℕ) (f : BitVec n → Bool) : Transform n where
  σ               := Unit
  transition w _  := ⟨f w, ()⟩
  state           := ()

def bitwise (f : Bool → Bool → Bool) := stateless 2 (fun w => f (w.getLsb 0) (w.getLsb 1))

/-!
## Transforms
Concrete instances of transforms
-/
section Ops

def not : Transform 1 := stateless 1 (fun w => !(w.getLsb 0))

def and : Transform 2 := bitwise (· && ·)
def or  : Transform 2 := bitwise (· || ·)
def xor : Transform 2 := bitwise Bool.xor

def add : Transform 2 where
  σ           := Bool -- a single carry bit
  transition  := fun input carry =>
                    let x : BitVec 2 := .ofFin <| (BitVec.cons carry input).countOnes
                    -- The lower bit is the output, the higher bit the new carry
                    ⟨x.getLsb 0, x.getLsb 1⟩
  state       := false -- carry starts false

end Ops

end Transform

end BitStream
