/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Lean
import SSA.Core.Framework
import SSA.Projects.SLLVM.Dialect.Attr

/-! # SLLVM Dialect
We formalize an IR consisting of `arith + ptr + scf` MLIR dialects.
This IR is conceptually similar to LLVM IR, except it uses only *structured*
control flow, hence we'll call this IR Structured LLVM.

Note that in the formalization, we assume a 64-bit architecture!
Nothing in the formalization itself should depend on the exact pointer-width,
but this assumption does affect which optimizations are admitted.

-/
namespace StructuredLLVM

abbrev Width := Nat

namespace SLLVM

inductive Ty
  | bitvec (w : Width)
  | ptr
  | unit

inductive Op
  | bv_add (w : Width)    -- Add two signless integers
  | ptr_add               -- Add a signless integer to a pointer
  | load (ty : Ty)
  | store (ty : Ty)

structure State where
  memory : LLVM.Ptr → BitVec 8

end SLLVM

abbrev SLLVMMonad := StateM SLLVM.State

def SLLVM : Dialect where
  Op := SLLVM.Op
  Ty := SLLVM.Ty
  m := SLLVMMonad

section Imaginary

open Dialect -- Bring macros into scope
open Qq

structure MetaSignature (Ty : Q(Type)) where
  (arguments : List Q($Ty))
  (regions : (List Q($Ty)) × Q($Ty) )
  (outType : Q($Ty))

def_signature for SLLVM
  | .bv_add w => (bitvec w, bitvec w) -> bitvec w

end Imaginary
