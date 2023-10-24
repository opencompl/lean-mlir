import SSA.Core.Framework
import Std.Data.BitVec

open Std (BitVec)

inductive Op
  | const (x : BitVec 32)
  | add

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

instance : Goedel Ty where
  toType
  | .int => BitVec 32

instance : OpDenote Op Ty where
  denote
  -- The denotation of `const x` is the constant value `x`
  | .const x, _ ,_ => x
  -- The denotation of `add` applied to arguments `x` and `y` is `x + y`
  | .add    , (.cons (x : BitVec 32) <| .cons (y : BitVec 32) .nil), _ => x + y
