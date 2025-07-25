import SSA.Projects.RISCV64.Semantics
import SSA.Core.Framework
/- This file has a number of very large inductive types, which seem to cause Lean to run out of heartbeats.
We avoid the issue by increasing the heartbeats. Since this applies to most inductives in this file, we do so globally.
Additionally, this file contains definitions that match on these large inductive types. These also causes Lean to require
more heartbeats.  -/
set_option maxHeartbeats 1000000000000000000
set_option maxRecDepth 10000000000000

open RV64Semantics

namespace RISCV64
/-! ## The `RISCV64` dialect -/

/-! ## Dialect operation definitions -/
/--
`Op` models the RV64I base instruction set [1] plus selected RISC-V ISA extensions:
`M` for standard integer division and multiplication [2],
`B` for bit manipulation instructions (comprises instructions provided by the `Zba`, `Zbb`, and `Zbs` extensions) [3],
and `Zicond` for conditional operations [4].

We model RV64 as an SSA IR, meaning that instructions won't specify any registers
(instead, they'll later receive SSA values).
However, any other attributes (e.g., flags or immediate values) are still encoded as part of the operation.

[1] https://github.com/riscv/riscv-isa-manual/blob/main/src/rv64.adoc
[2] https://github.com/riscv/riscv-isa-manual/blob/main/src/m-st-ext.adoc
[3] https://github.com/riscv/riscv-isa-manual/blob/main/src/b-st-ext.adoc
[4] https://github.com/riscvarchive/riscv-zicond/blob/main/zicondops.adoc
-/
inductive Op
  | li : (val : BitVec 20) → Op
  | lui (imm : BitVec 20)
  | auipc (imm : BitVec 20)
  | addi (imm : BitVec 12)
  | andi (imm : BitVec 12)
  | ori (imm : BitVec 12)
  | xori (imm : BitVec 12)
  | addiw (imm : BitVec 12)
  | add
  | slli (shamt : BitVec 6)
  | sub
  | and
  | or
  | xor
  | sll
  | srl
  | sra
  | addw
  | subw
  | sllw
  | srlw
  | sraw
  -- fence missing, future work.
  | slti (imm : BitVec 12)
  | sltiu (imm : BitVec 12)
  | srli (shamt : BitVec 6)
  | srai (shamt : BitVec 6)
  | slliw (shamt : BitVec 5)
  | srliw (shamt : BitVec 5)
  | sraiw (shamt : BitVec 5)
  | slt
  | sltu
  -- RISC-V `M` extension instructions (multiply & divide)
  | mul    -- performs signed multiplication on 64 x 64 bits and returns the lower 64 bits of the result .
  | mulu   -- performs unsigned multiplication on 64 x 64 bits and returns the lower 64 bits of the result .
  | mulw
  | mulh   -- performs signed multiplication on 64 x 64 bits and returns the upper 64 bits of the result.
  | mulhu  -- performs unsigned multiplication on 64 x 64 bits and returns the upper 64 bits of the result.
  | mulhsu -- performs multiplication on (rs1 signed) x (rs2 unsigned) and returns the upper 64 bits of the result.
  | divw
  | divwu
  | div    -- signed division
  | divu   -- unsigned division
  | remw
  | rem    --sign of result is according to sign of dividend
  | remwu
  | remu
  -- RISC-V `Zba` extension
  | add.uw
  | sh1add.uw
  | sh2add.uw
  | sh3add.uw
  | sh1add
  | sh2add
  | sh3add
  -- slli.uw missing
  -- part of the RISC-V `Zbb` & `Zbkb` extension
  | rol
  | ror
  | rolw
  | rorw
  | sext.b
  | sext.h
  | zext.h
  /-
  in the future:
  |pack
  |packh
  -/
  -- part of the RISC-V `Zbs` extension
  | bclr
  | bclri (shamt : BitVec 6)
  | bext
  | bexti (shamt : BitVec 6)
  | binv
  | binvi (shamt : BitVec 6)
  | bset
  | bseti (shamt : BitVec 6)
  /- RISC-V `Zicond` conditional operations extension  -/
  | czero.eqz
  | czero.nez
  deriving DecidableEq, Repr, Lean.ToExpr

/--
## Dialect type definitions
Defining a type system for the `RISCV64` dialect. `bv` represents bit vector.
-/
inductive Ty
  | bv : Ty
  deriving DecidableEq, Repr, Inhabited, Lean.ToExpr

instance : ToString (Ty) where
  toString t := match t with
  | Ty.bv => "bv"

/-!
Connecting the `bv` type to its underlying Lean type `BitVec 64`. By providing a `TyDenote` instance,
we define how the `RISCV64` types transalte into actual Lean types.
-/
instance : TyDenote Ty where
  toType := fun
  | Ty.bv => BitVec 64

instance (ty : Ty) : Inhabited (TyDenote.toType ty) where
  default := match ty with
  | .bv  => 0#64

instance : ToString (Ty) where
  toString t :=  match t with
  | Ty.bv => "!riscv.reg"

/-! ## Dialect operation definitions-/
/--
Specifing the signature of each `RISCV64` operation. `Sig` refers to the input types
for each operation as a list of types.

We mark it as `simp` and `reducible` such that the type checker and elaborator
always fully unfold a `sig` to its underlying definition and when the simplifier
encounters a `sig` it can replace it by its definition.
-/
@[simp, reducible]
def Op.sig : Op → List Ty
  | .li _ => []
  | .mulu  => [Ty.bv, Ty.bv]
  | .mulh  => [Ty.bv, Ty.bv]
  | .mulhu  => [Ty.bv, Ty.bv]
  | .mulhsu  => [Ty.bv, Ty.bv]
  | .divu =>  [Ty.bv, Ty.bv]
  | .rol => [Ty.bv, Ty.bv]
  | .ror => [Ty.bv, Ty.bv]
  | .remwu  => [Ty.bv, Ty.bv]
  | .remu  =>  [Ty.bv, Ty.bv]
  | .addiw (_imm : BitVec 12) => [Ty.bv]
  | .lui (_imm : BitVec 20) => [Ty.bv]
  | .auipc (_imm : BitVec 20)  => [Ty.bv]
  | .slliw (_shamt : BitVec 5)  => [Ty.bv]
  | .srliw (_shamt : BitVec 5) => [Ty.bv]
  | .sraiw (_shamt : BitVec 5) => [Ty.bv]
  | .slli (_shamt : BitVec 6) => [Ty.bv]
  | .srli (_shamt : BitVec 6) => [Ty.bv]
  | .srai (_shamt : BitVec 6) => [Ty.bv]
  | .addw => [Ty.bv, Ty.bv]
  | .subw => [Ty.bv, Ty.bv]
  | .sllw => [Ty.bv, Ty.bv]
  | .srlw => [Ty.bv, Ty.bv]
  | .sraw => [Ty.bv, Ty.bv]
  | .add => [Ty.bv, Ty.bv]
  | .slt => [Ty.bv, Ty.bv]
  | .sltu => [Ty.bv, Ty.bv]
  | .and => [Ty.bv, Ty.bv]
  | .or => [Ty.bv, Ty.bv]
  | .xor => [Ty.bv, Ty.bv]
  | .sll => [Ty.bv, Ty.bv]
  | .srl => [Ty.bv, Ty.bv]
  | .sub => [Ty.bv, Ty.bv]
  | .sra => [Ty.bv, Ty.bv]
  | .remw  => [Ty.bv, Ty.bv]
  | .rem  =>  [Ty.bv, Ty.bv]
  | .mul => [Ty.bv, Ty.bv]
  | .mulw => [Ty.bv, Ty.bv]
  | .div  =>  [Ty.bv, Ty.bv]
  | .divw  =>  [Ty.bv, Ty.bv]
  | .divwu  =>  [Ty.bv, Ty.bv]
  | .addi (_imm : BitVec 12) => [Ty.bv]
  | .slti (_imm : BitVec 12) => [Ty.bv]
  | .sltiu (_imm : BitVec 12) => [Ty.bv]
  | .andi (_imm : BitVec 12) => [Ty.bv]
  | .ori (_imm : BitVec 12) => [Ty.bv]
  | .xori (_imm : BitVec 12) => [Ty.bv]
  | .czero.eqz =>  [Ty.bv, Ty.bv]
  | .czero.nez =>  [Ty.bv, Ty.bv]
  | .sext.b => [Ty.bv]
  | .sext.h => [Ty.bv]
  | .zext.h => [Ty.bv]
  | .bclr => [Ty.bv, Ty.bv]
  | .bext => [Ty.bv, Ty.bv]
  | .binv => [Ty.bv, Ty.bv]
  | .bset  => [Ty.bv, Ty.bv]
  | .bclri (_shamt : BitVec 6) => [Ty.bv]
  | .bexti (_shamt : BitVec 6) => [Ty.bv]
  | .binvi (_shamt : BitVec 6) => [Ty.bv]
  | .bseti (_shamt : BitVec 6) => [Ty.bv]
  | .rolw => [Ty.bv, Ty.bv]
  | .rorw => [Ty.bv, Ty.bv]
  | .add.uw => [Ty.bv, Ty.bv]
  | .sh1add.uw => [Ty.bv, Ty.bv]
  | .sh2add.uw => [Ty.bv, Ty.bv]
  | .sh3add.uw => [Ty.bv, Ty.bv]
  | .sh1add => [Ty.bv, Ty.bv]
  | .sh2add => [Ty.bv, Ty.bv]
  | .sh3add => [Ty.bv, Ty.bv]

/--
Specifing the `outTy` of each `RISCV64` operation.
Again, we mark  it as `simp` and `reducible`.
-/
@[simp, reducible]
def Op.outTy : Op  → Ty
  | .li _ => Ty.bv
  | .mulu => Ty.bv
  | .mulh => Ty.bv
  | .mulhu => Ty.bv
  | .mulhsu => Ty.bv
  | .divu => Ty.bv
  | .rol => Ty.bv
  | .ror => Ty.bv
  | .remwu => Ty.bv
  | .remu =>  Ty.bv
  | .addiw (_imm : BitVec 12) => Ty.bv
  | .lui (_imm : BitVec 20) => Ty.bv
  | .auipc (_imm : BitVec 20) => Ty.bv
  | .slliw (_shamt : BitVec 5) => Ty.bv
  | .srliw (_shamt : BitVec 5) => Ty.bv
  | .sraiw (_shamt : BitVec 5) => Ty.bv
  | .slli (_shamt : BitVec 6) => Ty.bv
  | .srli (_shamt : BitVec 6) => Ty.bv
  | .srai (_shamt : BitVec 6) => Ty.bv
  | .addw => Ty.bv
  | .subw => Ty.bv
  | .sllw => Ty.bv
  | .srlw => Ty.bv
  | .sraw => Ty.bv
  | .add => Ty.bv
  | .slt => Ty.bv
  | .sltu => Ty.bv
  | .and => Ty.bv
  | .or => Ty.bv
  | .xor => Ty.bv
  | .sll => Ty.bv
  | .srl => Ty.bv
  | .sub => Ty.bv
  | .sra => Ty.bv
  | .remw  => Ty.bv
  | .rem => Ty.bv
  | .mul => Ty.bv
  | .mulw => Ty.bv
  | .div => Ty.bv
  | .divw => Ty.bv
  | .divwu => Ty.bv
  | .addi (_imm : BitVec 12) => Ty.bv
  | .slti (_imm : BitVec 12) => Ty.bv
  | .sltiu (_imm : BitVec 12) => Ty.bv
  | .andi (_imm : BitVec 12) => Ty.bv
  | .ori (_imm : BitVec 12) => Ty.bv
  | .xori (_imm : BitVec 12) => Ty.bv
  | .czero.eqz => Ty.bv
  | .czero.nez => Ty.bv
  | .sext.b => Ty.bv
  | .sext.h => Ty.bv
  | .zext.h => Ty.bv
  | .bclr => Ty.bv
  | .bext => Ty.bv
  | .binv => Ty.bv
  | .bset => Ty.bv
  | .bclri (_shamt : BitVec 6) => Ty.bv
  | .bexti (_shamt : BitVec 6) => Ty.bv
  | .binvi (_shamt : BitVec 6) => Ty.bv
  | .bseti (_shamt : BitVec 6) => Ty.bv
  | .rolw => Ty.bv
  | .rorw => Ty.bv
  | .add.uw => Ty.bv
  | .sh1add.uw => Ty.bv
  | .sh2add.uw => Ty.bv
  | .sh3add.uw => Ty.bv
  | .sh1add => Ty.bv
  | .sh2add => Ty.bv
  | .sh3add => Ty.bv

/-- Combine `outTy` and `sig` together into a `Signature`. -/
@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []}

/--
Bundling the `Ops`and `Ty`into a dialect and abbreviating `RISCV64`
into a dialect named `RV64`.
We pass our `Op.signature` as an instance -/
@[simp]
abbrev RV64 : Dialect where
  Op := Op
  Ty := Ty

instance : DialectSignature RV64 := ⟨Op.signature⟩

def opToString (op : RISCV64.Op) : String :=
  let op  : String := match op with
  | .li imm => s! "li \{immediate = { imm.toInt } : i20 }"
  | .mulu => "mulu"
  | .mulh => "mulh"
  | .mulhu => "mulhu"
  | .mulhsu => "mulhsu"
  | .divu => "divu"
  | .rol => "rol"
  | .ror => "ror"
  | .remwu => "remwu"
  | .remu => "remu"
  | .addiw (_imm : BitVec 12) => s!"addiw \{immediate = { _imm.toInt} : i12 } : !riscv.reg }"
  | .lui (_imm : BitVec 20) => s!"lui \{immediate = { _imm.toInt} : i20 } : !riscv.reg }"
  | .auipc (_imm : BitVec 20) => s!"auipc \{imm = { _imm.toInt} : i20 } : !riscv.reg }"
  | .slliw (_shamt : BitVec 5) => s!"slliw \{shamt = { _shamt.toInt} : i5 } : !riscv.reg }"
  | .srliw (_shamt : BitVec 5) => s!"srliw \{shamt = { _shamt.toInt} : i5 } : !riscv.reg }"
  | .sraiw (_shamt : BitVec 5) => s!"sraiw \{shamt = { _shamt.toInt} :i5 } : !riscv.reg }"
  | .slli (_shamt : BitVec 6) => s!"slli \{shamt = { _shamt.toInt} : i6 } : !riscv.reg }"
  | .srli (_shamt : BitVec 6) => s!"srli \{shamt = { _shamt.toInt} : i6 } : !riscv.reg }"
  | .srai (_shamt : BitVec 6) => s!"srai \{shamt = { _shamt.toInt} : i6 } : !riscv.reg }"
  | .addw => "addw"
  | .subw => "subw"
  | .sllw => "sllw"
  | .srlw => "srlw"
  | .sraw => "sraw"
  | .add => "add"
  | .slt => "slt"
  | .sltu => "sltu"
  | .and => "and"
  | .or => "or"
  | .xor => "xor"
  | .sll => "sll"
  | .srl => "srl"
  | .sub => "sub"
  | .sra => "sra"
  | .remw  => "remw"
  | .rem => "rem"
  | .mul => "mul"
  | .mulw => "mulw"
  | .div => "div"
  | .divw => "divw"
  | .divwu => "diwu"
  | .addi (_imm : BitVec 12) => s!"addi \{immediate = { _imm.toInt } : !riscv.reg }"
  | .slti (_imm : BitVec 12) => s!"slti \{immediate = { _imm.toInt } : !riscv.reg }"
  | .sltiu (_imm : BitVec 12) => s!"sltiu \{immediate = { _imm.toInt } : !riscv.reg }"
  | .andi (_imm : BitVec 12) => s!"andi \{immediate = { _imm.toInt } : !riscv.reg }"
  | .ori (_imm : BitVec 12) => s!"ori \{immediate = { _imm.toInt } : !riscv.reg }"
  | .xori (_imm : BitVec 12) => s!"xori \{immediate = { _imm.toInt } : !riscv.reg }"
  | .czero.eqz => "czero.eqz"
  | .czero.nez => "czero.nez"
  | .sext.b => "sext.b"
  | .sext.h => "sext.h"
  | .zext.h => "zext.h"
  | .bclr => "bclr"
  | .bext => "bext"
  | .binv => "binv"
  | .bset => "bset"
  | .bclri (_shamt : BitVec 6) => s!"bclri \{immediate = { _shamt.toInt} : i6 } : !riscv.reg }"
  | .bexti (_shamt : BitVec 6) =>s!"bexti \{immediate = { _shamt.toInt} : i6 } : !riscv.reg }"
  | .binvi (_shamt : BitVec 6) => s!"binvi \{immediate = { _shamt.toInt} : i6 } : !riscv.reg }"
  | .bseti (_shamt : BitVec 6) => s!"bseti \{immediate = { _shamt.toInt} : i6 } : !riscv.reg }"
  | .rolw => "rolw"
  | .rorw => "rorw"
  | .add.uw => "add.uw"
  | .sh1add.uw => "sh1add.uw"
  | .sh2add.uw => "sh2add.uw"
  | .sh3add.uw => "sh3add.uw"
  | .sh1add => "sh1add"
  | .sh2add => "sh2add"
  | .sh3add => "sh3add"
  s!"\"riscv.{op}\""

instance : ToString (Op) where
  toString := opToString

/--
## Dialect semantics
We assign semantics defined in `RV64` to each operation.
This defines the meaning of each operation in Lean.
When writting RISC-V-like abstract MLIR ISA intuitively
we write `op  arg1 arg2`.
The `RISCV64` semantics are defined to first process the second operand
then the first. Therefore we first pass `.get 1` then `.get 0` into the
functions that define our semantics.
-/
@[simp, reducible]
instance : DialectDenote (RV64) where
  denote
  | .li imm, _ , _ =>  BitVec.signExtend 64 (imm)
  | .addiw imm, regs, _ => pure64_RISCV_ADDIW imm (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .lui imm, regs , _ => UTYPE_pure64_RISCV_LUI imm
  | .auipc imm, regs, _ => UTYPE_pure64_RISCV_AUIPC imm (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .slliw shamt, regs, _ => SHIFTIWOP_pure64_RISCV_SLLIW_bv shamt (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .srliw shamt, regs, _ => SHIFTIWOP_pure64_RISCV_SRLIW_bv shamt (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sraiw shamt, regs, _ => SHIFTIWOP_pure64_RISCV_SRAIW_bv shamt (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .slli shamt, regs, _ => SHIFTIOP_pure64_RISCV_SLLI_bv shamt (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .srli shamt, regs, _ => SHIFTIOP_pure64_RISCV_SRLI_bv shamt (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .srai shamt, regs, _ => SHIFTIOP_pure64_RISCV_SRAI_bv shamt  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .addw, regs, _ => RTYPEW_pure64_RISCV_ADDW (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .subw, regs, _ => RTYPEW_pure64_RISCV_SUBW (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sllw, regs, _ => RTYPEW_pure64_RISCV_SLLW_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .srlw, regs, _ => RTYPEW_pure64_RISCV_SRLW_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sraw, regs, _ => RTYPEW_pure64_RISCV_SRAW_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .add, regs, _ => RTYPE_pure64_RISCV_ADD (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .slt, regs, _ => RTYPE_pure64_RISCV_SLT (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sltu, regs, _ => RTYPE_pure64_RISCV_SLTU (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .and, regs, _ => RTYPE_pure64_RISCV_AND (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .or, regs, _ => RTYPE_pure64_RISCV_OR (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .xor, regs, _ => RTYPE_pure64_RISCV_XOR (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sll, regs, _ => RTYPE_pure64_RISCV_SLL_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .srl, regs, _ => RTYPE_pure64_RISCV_SRL_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sub, regs, _ => RTYPE_pure64_RISCV_SUB (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sra, regs, _ => RTYPE_pure64_RISCV_SRA_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .remw, regs, _ => SIGNED_pure64_REMW_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .remwu, regs, _ => UNSIGNED_pure64_REMW_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .rem, regs, _ => SIGNED_pure64_REM_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .remu, regs, _ => UNSIGNED_pure64_REM_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .mulu, regs, _ => pure64_MUL_bv_fff (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .mulhu,regs, _ => pure64_MUL_bv_tff (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .mul ,regs, _ => pure64_MUL_ftt (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .mulhsu ,regs, _ => pure64_MUL_bv_ttf (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .mulh,regs, _ => pure64_MUL_bv_ttt (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .mulw,  regs, _ => pure64_MULW_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .div, regs, _ => SIGNED_pure64_DIV_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .divu,  regs, _ => UNSIGNED_pure64_DIV_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .divw, regs, _ => SIGNED_pure64_DIVW (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .divwu, regs, _ => UNSIGNED_pure64_DIVW (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .addi imm, reg, _ => ITYPE_pure64_RISCV_ADDI  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .slti imm, reg, _ => ITYPE_pure64_RISCV_SLTI  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sltiu imm, reg, _ => ITYPE_pure64_RISCV_SLTIU  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .andi imm, reg, _ => ITYPE_pure64_RISCV_ANDI  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .ori imm, reg, _ => ITYPE_pure64_RISCV_ORI  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .xori imm, reg, _ => ITYPE_pure64_RISCV_XORI  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .czero.eqz, regs, _ => ZICOND_RTYPE_pure64_RISCV_CZERO_EQZ (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .czero.nez, regs, _ => ZICOND_RTYPE_pure64_RISCV_CZERO_NEZ (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sext.b, reg, _ => ZBB_EXTOP_pure64_RISCV_SEXTB (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sext.h, reg, _ => ZBB_EXTOP_pure64_RISCV_SEXTH (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .zext.h, reg, _ => ZBB_EXTOP_pure64_RISCV_ZEXTH (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .bclr, regs, _ => ZBS_RTYPE_pure64_RISCV_BCLR_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .bext, regs, _ => ZBS_RTYPE_pure64_RISCV_BEXT_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .binv, regs, _ => ZBS_RTYPE_pure64_BINV_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .bset, regs, _ => ZBS_RTYPE_pure64_RISCV_BSET_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .bclri shamt , reg, _ => ZBS_IOP_pure64_RISCV_BCLRI_bv shamt (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .bexti shamt, reg, _ => ZBS_IOP_pure64_RISCV_BEXTI_bv shamt (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .binvi shamt, reg, _ => ZBS_IOP_pure64_RISCV_BINVI_bv shamt (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .bseti shamt, reg, _ => ZBS_IOP_pure64_RISCV_BSETI_bv shamt (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .rolw, regs, _ => ZBB_RTYPEW_pure64_RISCV_ROLW (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .rorw, regs, _ => ZBB_RTYPEW_pure64_RISCV_RORW (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .rol, regs, _ => ZBB_RTYPE_pure64_RISCV_ROL_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .ror, regs, _ => ZBB_RTYPE_pure64_RISCV_ROR_bv (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .add.uw, regs, _ => ZBA_RTYPEUW_pure64_RISCV_ADDUW (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sh1add.uw , regs, _ => ZBA_RTYPEUW_pure64_RISCV_SH1ADDUW (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sh2add.uw, regs, _ => ZBA_RTYPEUW_pure64_RISCV_SH2ADDUW (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sh3add.uw, regs, _ => ZBA_RTYPEUW_pure64_RISCV_SH3ADDUW (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sh1add, regs, _ => ZBA_RTYPE_pure64_RISCV_SH1ADD (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sh2add, regs, _ => ZBA_RTYPE_pure64_RISCV_SH2ADD (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  | .sh3add, regs, _ => ZBA_RTYPE_pure64_RISCV_SH3ADD (regs.getN 1 (by simp [DialectSignature.sig, signature]))  (regs.getN 0 (by simp [DialectSignature.sig, signature]))

end RISCV64
