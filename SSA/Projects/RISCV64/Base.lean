import SSA.Projects.RISCV64.Semantics
import SSA.Core.Framework
import SSA.Core.Framework.Macro
/- This file has a number of very large inductive types, which seem to cause Lean to run out of heartbeats.
We avoid the issue by increasing the heartbeats. Since this applies to most inductives in this file, we do so globally.
Additionally, this file contains definitions that match on these large inductive types,. These also causes Lean to require
more heartbeats.  -/
set_option maxHeartbeats 1000000000000000000


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
  | li : (val : Int) → Op
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
  -- slli.uw missing, future work.
  -- part of the RISC-V `Zbb` & `Zbkb` extension
  | rol
  | ror
  | rolw
  | rorw
  | sext.b
  | sext.h
  | zext.h
  /-
  |pack missing, future work.
  |packh missing, future work.
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
  deriving DecidableEq, Repr


/-!## Dialect type definitions -/
/--
`Ty` models the types of the RV64 dialect.
Recall that RV64I has a fixed 64-bit address space, so we choose to only have 64-bit wide bitvectors.
 `bv` represents the type of 64-bit wide bitvectors -/
inductive Ty
  | bv : Ty
  deriving DecidableEq, Repr, Inhabited

instance : ToString (Ty) where
  toString t := repr t |>.pretty

/--
Connecting the `bv` type to its underlying Lean type `BitVec 64`. By providing a `TyDenote` instance,
we define how the `RISCV64` types translate into actual Lean types.
-/
instance : TyDenote Ty where
  toType := fun
  | Ty.bv => BitVec 64

instance (ty : Ty) : Inhabited (TyDenote.toType ty) where
  default := match ty with
  | .bv  => 0#64

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
  |.li _ => []
  |.mulu  => [Ty.bv, Ty.bv]
  |.mulh  => [Ty.bv, Ty.bv]
  |.mulhu  => [Ty.bv, Ty.bv]
  |.mulhsu  => [Ty.bv, Ty.bv]
  |.divu =>  [Ty.bv, Ty.bv]
  |.rol => [Ty.bv, Ty.bv]
  |.ror => [Ty.bv, Ty.bv]
  |.remwu  => [Ty.bv, Ty.bv]
  |.remu  =>  [Ty.bv, Ty.bv]
  |.addiw _imm => [Ty.bv]
  |.lui _imm => []
  |.auipc _imm => [Ty.bv]
  |.slliw _shamt => [Ty.bv]
  |.srliw _shamt => [Ty.bv]
  |.sraiw _shamt => [Ty.bv]
  |.slli _shamt => [Ty.bv]
  |.srli _shamt => [Ty.bv]
  |.srai _shamt => [Ty.bv]
  |.addw => [Ty.bv, Ty.bv]
  |.subw => [Ty.bv, Ty.bv]
  |.sllw => [Ty.bv, Ty.bv]
  |.srlw => [Ty.bv, Ty.bv]
  |.sraw => [Ty.bv, Ty.bv]
  |.add => [Ty.bv, Ty.bv]
  |.slt => [Ty.bv, Ty.bv]
  |.sltu => [Ty.bv, Ty.bv]
  |.and => [Ty.bv, Ty.bv]
  |.or => [Ty.bv, Ty.bv]
  |.xor => [Ty.bv, Ty.bv]
  |.sll => [Ty.bv, Ty.bv]
  |.srl => [Ty.bv, Ty.bv]
  |.sub => [Ty.bv, Ty.bv]
  |.sra => [Ty.bv, Ty.bv]
  |.remw  => [Ty.bv, Ty.bv]
  |.rem  =>  [Ty.bv, Ty.bv]
  |.mul => [Ty.bv, Ty.bv]
  |.mulw => [Ty.bv, Ty.bv]
  |.div  =>  [Ty.bv, Ty.bv]
  |.divw  =>  [Ty.bv, Ty.bv]
  |.divwu  =>  [Ty.bv, Ty.bv]
  |.addi _imm => [Ty.bv]
  |.slti _imm => [Ty.bv]
  |.sltiu _imm => [Ty.bv]
  |.andi _imm => [Ty.bv]
  |.ori _imm => [Ty.bv]
  |.xori _imm => [Ty.bv]
  |.czero.eqz =>  [Ty.bv, Ty.bv]
  |.czero.nez =>  [Ty.bv, Ty.bv]
  |.sext.b => [Ty.bv]
  |.sext.h => [Ty.bv]
  |.zext.h => [Ty.bv]
  |.bclr => [Ty.bv, Ty.bv]
  |.bext => [Ty.bv, Ty.bv]
  |.binv => [Ty.bv, Ty.bv]
  |.bset  => [Ty.bv, Ty.bv]
  |.bclri _shamt => [Ty.bv]
  |.bexti _shamt => [Ty.bv]
  |.binvi _shamt => [Ty.bv]
  |.bseti _shamt => [Ty.bv]
  |.rolw => [Ty.bv, Ty.bv]
  |.rorw => [Ty.bv, Ty.bv]
  |.add.uw => [Ty.bv, Ty.bv]
  |.sh1add.uw => [Ty.bv, Ty.bv]
  |.sh2add.uw => [Ty.bv, Ty.bv]
  |.sh3add.uw => [Ty.bv, Ty.bv]
  |.sh1add => [Ty.bv, Ty.bv]
  |.sh2add => [Ty.bv, Ty.bv]
  |.sh3add => [Ty.bv, Ty.bv]

/--
Specifing the `outTy` of each `RISCV64` operation.
Again, we mark  it as `simp` and `reducible`.
-/
@[simp, reducible]
def Op.outTy : Op  → Ty
  |.li _ => Ty.bv
  |.mulu => Ty.bv
  |.mulh => Ty.bv
  |.mulhu => Ty.bv
  |.mulhsu => Ty.bv
  |.divu => Ty.bv
  |.rol => Ty.bv
  |.ror => Ty.bv
  |.remwu => Ty.bv
  |.remu =>  Ty.bv
  |.addiw _imm => Ty.bv
  |.lui _imm => Ty.bv
  |.auipc _imm => Ty.bv
  |.slliw _shamt => Ty.bv
  |.srliw _shamt => Ty.bv
  |.sraiw _shamt => Ty.bv
  |.slli _shamt => Ty.bv
  |.srli _shamt => Ty.bv
  |srai _shamt => Ty.bv
  |.addw => Ty.bv
  |.subw => Ty.bv
  |.sllw => Ty.bv
  |.srlw => Ty.bv
  |.sraw => Ty.bv
  |.add => Ty.bv
  |.slt => Ty.bv
  |.sltu => Ty.bv
  |.and => Ty.bv
  |.or => Ty.bv
  |.xor => Ty.bv
  |.sll => Ty.bv
  |.srl => Ty.bv
  |.sub => Ty.bv
  |.sra => Ty.bv
  |.remw  => Ty.bv
  |.rem => Ty.bv
  |.mul => Ty.bv
  |.mulw => Ty.bv
  |.div => Ty.bv
  |.divw => Ty.bv
  |.divwu => Ty.bv
  |.addi _imm => Ty.bv
  |.slti _imm => Ty.bv
  |.sltiu _imm => Ty.bv
  |.andi _imm => Ty.bv
  |.ori _imm => Ty.bv
  |.xori _imm => Ty.bv
  |.czero.eqz => Ty.bv
  |.czero.nez => Ty.bv
  |.sext.b => Ty.bv
  |.sext.h => Ty.bv
  |.zext.h => Ty.bv
  |.bclr => Ty.bv
  |.bext => Ty.bv
  |.binv => Ty.bv
  |.bset => Ty.bv
  |.bclri _shamt => Ty.bv
  |.bexti _shamt => Ty.bv
  |.binvi _shamt => Ty.bv
  |.bseti _shamt => Ty.bv
  |.rolw => Ty.bv
  |.rorw => Ty.bv
  |.add.uw => Ty.bv
  |.sh1add.uw => Ty.bv
  |.sh2add.uw => Ty.bv
  |.sh3add.uw => Ty.bv
  |.sh1add => Ty.bv
  |.sh2add => Ty.bv
  |.sh3add => Ty.bv

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

/-! ## Dialect semantics -/
/-- We assign semantics defined in `RV64` to each operation.
This defines the meaning of each operation in Lean.
When writting RISC-V-like abstract MLIR ISA intuitively
we write `op  arg1 arg2`.
The `RISCV64` semantics are defined to first process the second operand
then the first. Therefore we first pass `.get 1` then `.get 0` into the
functions that define our semantics. -/

def_denote for RV64 where
  |.li imm =>  BitVec.ofInt 64 imm
  |.addiw imm => λ rs1 =>  ADDIW_pure64 imm rs1
  |.lui imm => UTYPE_pure64_lui imm
  |.auipc imm => λ rs1 => UTYPE_pure64_AUIPC imm rs1
  |.slliw shamt => λ rs1 => SHIFTIWOP_pure64_RISCV_SLLIW shamt rs1
  |.srliw shamt => λ rs1 => SHIFTIWOP_pure64_RISCV_SRLIW shamt rs1
  |.sraiw shamt => λ rs1 => SHIFTIWOP_pure64_RISCV_SRAIW shamt rs1
  |.srli shamt => λ rs1 => SHIFTIOP_pure64_RISCV_SRLI shamt rs1
  |.slli shamt => λ rs1 => SHIFTIOP_pure64_RISCV_SRLI shamt rs1
  |.srai shamt => λ rs1 => SHIFTIOP_pure64_RISCV_SRAI shamt  rs1
  |.addw => λ rs1 rs2 => RTYPEW_pure64_RISCV_SUBW rs2  rs1
  |.subw => λ rs1 rs2 => RTYPEW_pure64_RISCV_SUBW rs2 rs1
  |.sllw => λ rs1 rs2 => RTYPEW_pure64_RISCV_SLLW rs2 rs1
  |.srlw => λ rs1 rs2 => RTYPEW_pure64_RISCV_SRLW rs2  rs1
  |.sraw => λ rs1 rs2 => RTYPEW_pure64_RISCV_SRAW rs2 rs1
  |.add => λ rs1 rs2 => RTYPE_pure64_RISCV_ADD rs2 rs1
  |.slt => λ rs1 rs2 => RTYPE_pure64_RISCV_SLT rs2 rs1
  |.sltu => λ rs1 rs2 => RTYPE_pure64_RISCV_SLTU rs2 rs1
  |.and => λ rs1 rs2 => RTYPE_pure64_RISCV_AND rs2 rs1
  |.or => λ rs1 rs2 => RTYPE_pure64_RISCV_OR rs2 rs1
  |.xor => λ rs1 rs2 => RTYPE_pure64_RISCV_XOR rs2 rs1
  |.sll => λ rs1 rs2 => RTYPE_pure64_RISCV_SLL rs2 rs1
  |.srl => λ rs1 rs2 => RTYPE_pure64_RISCV_SRL rs2 rs1
  |.sub => λ rs1 rs2 => RTYPE_pure64_RISCV_SUB rs2 rs1
  |.sra => λ rs1 rs2 => RTYPE_pure64_RISCV_SRA rs2 rs1
  |.remw => λ rs1 rs2 => REMW_pure64_signed rs2 rs1
  |.remwu => λ rs1 rs2 => REMW_pure64_unsigned rs2 rs1
  |.rem => λ rs1 rs2 => REM_pure64_signed rs2 rs1
  |.remu => λ rs1 rs2 => REM_pure64_unsigned rs2 rs1
  |.mulu => λ rs1 rs2 => MUL_pure64_fff rs2 rs1
  |.mulhu => λ rs1 rs2 =>  MUL_pure64_tff rs2 rs1
  |.mul => λ rs1 rs2 => MUL_pure64_ftt rs2 rs1
  |.mulhsu => λ rs1 rs2 => MUL_pure64_ttf rs2 rs1
  |.mulh => λ rs1 rs2 => MUL_pure64_ttt rs2 rs1
  |.mulw => λ rs1 rs2 => MULW_pure64 rs2 rs1
  |.div => λ rs1 rs2 => DIV_pure64_signed rs2 rs1
  |.divu => λ rs1 rs2 => DIV_pure64_unsigned rs2 rs1
  |.divw => λ rs1 rs2 => DIVW_pure64_signed rs2 rs1
  |.divwu => λ rs1 rs2 => DIVW_pure64_unsigned rs2 rs1
  |.addi imm => λ rs1 => ITYPE_pure64_RISCV_ADDI  imm rs1
  |.slti imm => λ rs1 => ITYPE_pure64_RISCV_SLTI  imm rs1
  |.sltiu imm => λ rs1 => ITYPE_pure64_RISCV_SLTIU  imm rs1
  |.andi imm => λ rs1 => ITYPE_pure64_RISCV_ANDI  imm rs1
  |.ori imm => λ rs1 => ITYPE_pure64_RISCV_ORI  imm rs1
  |.xori imm => λ rs1 => ITYPE_pure64_RISCV_XORI  imm rs1
  |.czero.eqz => λ rs1 rs2 => ZICOND_RTYPE_pure64_RISCV_CZERO_EQZ rs2 rs1
  |.czero.nez => λ rs1 rs2 => ZICOND_RTYPE_pure64_RISCV_RISCV_CZERO_NEZ rs2 rs1
  |.sext.b => λ rs1 => ZBB_EXTOP_pure64_RISCV_SEXTB rs1
  |.sext.h => λ rs1 => ZBB_EXTOP_pure64_RISCV_SEXTH rs1
  |.zext.h => λ rs1 => ZBB_EXTOP_pure64_RISCV_ZEXTH rs1
  |.bclr => λ rs1 rs2 => ZBS_RTYPE_pure64_RISCV_BCLR rs2 rs1
  |.bext => λ rs1 rs2=> ZBS_RTYPE_pure64_RISCV_BEXT rs2 rs1
  |.binv => λ rs1 rs2 => ZBS_RTYPE_pure64_BINV rs2 rs1
  |.bset => λ rs1 rs2=> ZBS_RTYPE_pure64_RISCV_BSET rs2 rs1
  |.bclri shamt => λ rs1 => ZBS_IOP_pure64_RISCV_BCLRI shamt rs1
  |.bexti shamt => λ rs1 => ZBS_IOP_pure64_RISCV_BEXTI shamt rs1
  |.binvi shamt => λ rs1 => ZBS_IOP_pure64_RISCV_BINVI shamt rs1
  |.bseti shamt  => λ rs1 => ZBS_IOP_pure64_RISCV_BSETI shamt rs1
  |.rolw => λ rs1 rs2 => ZBB_RTYPEW_pure64_RISCV_ROLW rs2 rs1
  |.rorw => λ rs1 rs2 => ZBB_RTYPEW_pure64_RISCV_RORW rs2 rs1
  |.rol => λ rs1 rs2 => ZBB_RTYPE_pure64_RISCV_ROL rs2 rs1
  |.ror => λ rs1 rs2 => ZBB_RTYPE_pure64_RISCV_ROR rs2 rs1
  |.add.uw => λ rs1 rs2 => ZBA_RTYPEUW_pure64_RISCV_ADDUW rs2 rs1
  |.sh1add.uw => λ rs1 rs2 => ZBA_RTYPEUW_pure64_RISCV_SH1ADDUW rs2 rs1
  |.sh2add.uw => λ rs1 rs2 => ZBA_RTYPEUW_pure64_RISCV_SH2ADDUW rs2 rs1
  |.sh3add.uw => λ rs1 rs2 => ZBA_RTYPEUW_pure64_RISCV_SH3ADDUW rs2 rs1
  |.sh1add => λ rs1 rs2 => ZBA_RTYPE_pure64_RISCV_SH1ADD rs2 rs1
  |.sh2add => λ rs1 rs2 => ZBA_RTYPE_pure64_RISCV_SH2ADD rs2 rs1
  |.sh3add => λ rs1 rs2 => ZBA_RTYPE_pure64_RISCV_SH3ADD rs2 rs1

end RISCV64
