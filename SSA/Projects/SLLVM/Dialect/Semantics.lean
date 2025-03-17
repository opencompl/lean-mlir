/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.SLLVM.Dialect.Signature

/-! ## SLLVM Operation Semantics -/

namespace SideEffects

instance : TyDenote (Dialect.Ty SLLVM) where
  toType := fun
    | .bitvec w => BitVec w
    | .ptr => LLVM.Ptr
    | .unit => Unit

-- instance : DialectDenote SLLVM where
--   denote := fun
--     | .bv_add _, x ::ₕ (y ::ₕ .nil) => _

section Meta

open Lean Meta

#check ConstantInfo

@[command_elab]
def Fpp := 2

set_option trace.Meta true in
#eval do
  let info ← getConstInfoCtor ``SLLVM.Ty.bitvec
  trace[Meta] "{info}"

open Lean

syntax:10 (name := lxor) term:10 " LXOR " term:11 : term

@[macro lxor] def lxorImplSomeOtherName : Macro
  | `($l:term LXOR $r:term) => `(!$l && $r) -- we can use the quotation mechanism to create `Syntax` in macros
  | _ => Macro.throwUnsupported

#eval true LXOR true -- false
#eval true LXOR false -- false
#eval false LXOR true -- true
#eval false LXOR false -- false
