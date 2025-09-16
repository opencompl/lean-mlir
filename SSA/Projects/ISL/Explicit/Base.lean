import SSA.Projects.ISL.Implicit.Base

/-!
# Explicit ISL Dialect

This file defines a variation of the ISL dialect, where the register-file is
passed as an explicit SSA variable, making reads and writes pure operations.

-/
namespace LeanMLIR.ISL

/--
The types of `ExplicitISL` are the types of regular `ISL` plus a new `regFile`
type for the explicit register file state.
-/
inductive ExpTy where
  | isl : ISL.Ty → ExpTy
  | regFile

@[match_pattern] abbrev ExpTy.regIndex := isl .regIndex
@[match_pattern] abbrev ExpTy.bits w := isl (.bits w)

/-!
## Dialect
-/

def ExplicitISL : Dialect where
  Op := ISLOp
  Ty := ExpTy
  m := Id -- This dialect has no side-effects!

/-!
## Operation Signatures
-/

open ISLOp in
open RegFile (registerWidth) in
def_signature for ExplicitISL
  | regConst _ => () -> .regIndex
  | regRead => (.regIndex, .regFile) -> [.bits registerWidth, .regFile]
  | regWrite => (.regIndex, .bits registerWidth, .regFile) -> [.regFile]
  | @bitsConst w _ => () -> [.bits w]
  | bitsAdd w => (.bits w, .bits w) -> [.bits w]

/-!
## Semantics
-/

instance : TyDenote ExplicitISL.Ty where
  toType := fun
    | .isl ty => ⟦ty⟧
    | .regFile => RegFile

def_denote for ExplicitISL
  | .regConst r   => [r]ₕ
  | .regRead      => fun r regFile => [regFile.read r, regFile]ₕ
  | .regWrite     => fun r v regFile => [regFile.write r v]ₕ
  | .bitsConst x  => [x]ₕ
  | .bitsAdd _    => fun (x y : BitVec _) => [x + y]ₕ
