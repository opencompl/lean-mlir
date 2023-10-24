import SSA.Core.Framework
import Std.Data.BitVec

open Std (BitVec)

inductive Op
  | const (x : BitVec 32)
  | add
  | repeat

inductive Ty
  | int

instance : OpSignature Op Ty where
  signature
  | .const _ => {
      sig     := [],  -- `const` takes no arguments,
      outTy   := .int -- returns an int, and
      regSig  := []   -- has no associated regions
    }
  | .add => {
      sig     := [.int, .int] -- `add` takes two arguments, both of type int,
      outTy   := .int         -- returns an int, and
      regSig  := []           -- has no associated regions
    }
  | .repeat => {

    }

instance : Goedel Ty where
  toType
  | .int => BitVec 32 -- The denotation of an `int` is a bitvector of length 32
