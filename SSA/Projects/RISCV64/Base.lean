import SSA.Projects.RISCV64.PseudoOpSemantics
import RISCV.Instructions
import LeanMLIR

open RV64

namespace RISCV64
open LeanMLIR

/-! ## The `RISCV64` dialect -/

/-- Risc-V instruction kind. -/
inductive RiscVKind
| k32
| k64
deriving DecidableEq, Repr, Inhabited, Lean.ToExpr

@[reducible]
def RiscVKind.denoteWidth : RiscVKind → Nat
  | k32 => 32
  | k64 => 64

def RiscVKind.denoteLogWidth : RiscVKind → Nat
  | k32 => 5
  | k64 => 6

def RiscVKind.denoteImmWidth : RiscVKind → Nat
  | k32 => 12
  | k64 => 20


/-! ## Dialect operation definitions -/

-- Options needed for `Deriving DecidableEQ` on large inductives:
set_option maxHeartbeats 1000000000000000000 in
set_option maxRecDepth 10000000000000 in
/--
`Op` models the RV64I base instruction set [1] plus selected RISC-V ISA extensions:
`M` for standard integer division and multiplication [2],
`B` for bit manipulation instructions (comprises instructions provided by the `Zba`, `Zbb`, and `Zbs` extensions) [3].

We model RV64 as an SSA IR, meaning that instructions won't specify any registers
(instead, they'll later receive SSA values).
However, any other attributes (e.g., flags or immediate values) are still encoded as part of the operation.

[1] https://github.com/riscv/riscv-isa-manual/blob/main/src/rv64.adoc
[2] https://github.com/riscv/riscv-isa-manual/blob/main/src/m-st-ext.adoc
[3] https://github.com/riscv/riscv-isa-manual/blob/main/src/b-st-ext.adoc
-/
inductive Op
  /- # RV64I Base Integer Instruction Set -/
  | li : (val : BitVec 64) → Op
  | lidep (k : RiscVKind) (imm : BitVec k.denoteImmWidth) : Op
  | li32 (imm : BitVec RiscVKind.k32.denoteImmWidth) : Op
  | li64 (imm : BitVec RiscVKind.k64.denoteImmWidth) : Op
  | ordep (k : RiscVKind) : Op
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
  | slti (imm : BitVec 12)
  | sltiu (imm : BitVec 12)
  | srli (shamt : BitVec 6)
  | srai (shamt : BitVec 6)
  | slliw (shamt : BitVec 5)
  | srliw (shamt : BitVec 5)
  | sraiw (shamt : BitVec 5)
  | slt
  | sltu
  /- # M Extension for Integer Multiplication and Division -/
  | mul
  | mulw
  | mulh
  | mulhu
  | mulhsu
  | divw
  | divuw
  | div
  | divu
  | remw
  | rem
  | remuw
  | remu
  /- # "B" Extension for Bit Manipulation -/
  /- ## Zba: Address generation -/
  | adduw
  | sh1adduw
  | sh2adduw
  | sh3adduw
  | sh1add
  | sh2add
  | sh3add
  | slliuw (shamt : BitVec 6)
  /- ## Zbb: Basic bit-manipulation -/
  | andn
  | orn
  | xnor
  | clz
  | clzw
  | ctz
  | ctzw
  | max
  | maxu
  | min
  | minu
  | sextb
  | sexth
  | zexth
  | rol
  | rolw
  | ror
  | rori (_shamt : BitVec 6)
  | roriw (_shamt : BitVec 5)
  | rorw
  /- ## Zbs: Single-bit instructions -/
  | bclr
  | bclri (shamt : BitVec 6)
  | bext
  | bexti (shamt : BitVec 6)
  | binv
  | binvi (shamt : BitVec 6)
  | bset
  | bseti (shamt : BitVec 6)
  /- ## Zbkb: Bit-manipulation for Cryptography -/
  | pack
  | packh
  | packw
  /- ## Pseudo instructions -/
  | mv
  | not
  | neg
  | negw
  | sextw
  | zextb
  | zextw
  | seqz
  | snez
  | sltz
  | sgtz
  deriving DecidableEq, Repr, Lean.ToExpr
/-!
**NOTE:** the `deriving` clause is prone to causing stack overflows in the
lsp while interactively editing. This is not surprising, given the quadratic
nature of `deriving DecidableEq`, but annoying nonetheless.
However, nothing in the current file actually depends on these derives, so
the workaround is to comment out the line above while editing.
Once satisfied, uncommment, and build via the CLI (which does not seem to
trigger the stack overflow)!
-/

/--
## Type System
The `RISCV64` dialect only uses `bv` type (bitvector).
-/
inductive Ty
  | bv64 : Ty
  | bv32 : Ty
  | bvk (k : RiscVKind) : Ty
  deriving DecidableEq, Repr, Inhabited, Lean.ToExpr

/--
The `bv` type denotes to the Lean type `BitVec 64`.
The `TyDenote` instance specifies how the `RISCV64` types transalate into actual Lean types.
-/
instance : TyDenote Ty where
  toType
  | .bv64 => BitVec 64
  | .bv32 => BitVec 32
  | .bvk k => BitVec k.denoteWidth

instance (ty : Ty) : Inhabited (TyDenote.toType ty) where
  default := match ty with
  | .bv64  => 0#64
  | .bv32  => 0#32
  | .bvk k => BitVec.ofNat (k.denoteWidth) 0

open Ty
/-! ## Dialect operation definitions -/


/--
`Op.sig` specifies the input types of each `RISCV64` operation
We mark it as `simp` and `reducible` such that the type checker and elaborator
always fully unfold a `sig` to its underlying definition and when the simplifier
encounters a `sig` it can replace it by its definition.
-/
@[simp, reducible]
def Op.sig : Op → List Ty
  | .li _ => []
  | .lidep _ _ => []
  | .li32 _ => []
  | .li64 _ => []
  | .ordep k => [.bvk k, .bvk k]
  | .mulh  => [bv64, bv64]
  | .mulhu  => [bv64, bv64]
  | .mulhsu  => [bv64, bv64]
  | .divu =>  [bv64, bv64]
  | .remuw  => [bv64, bv64]
  | .remu  =>  [bv64, bv64]
  | .addiw (_imm : BitVec 12) => [bv64]
  | .lui (_imm : BitVec 20) => [bv64]
  | .auipc (_imm : BitVec 20)  => [bv64]
  | .slliw (_shamt : BitVec 5)  => [bv64]
  | .srliw (_shamt : BitVec 5) => [bv64]
  | .sraiw (_shamt : BitVec 5) => [bv64]
  | .slli (_shamt : BitVec 6) => [bv64]
  | .srli (_shamt : BitVec 6) => [bv64]
  | .srai (_shamt : BitVec 6) => [bv64]
  | .addw => [bv64, bv64]
  | .subw => [bv64, bv64]
  | .sllw => [bv64, bv64]
  | .srlw => [bv64, bv64]
  | .sraw => [bv64, bv64]
  | .add => [bv64, bv64]
  | .slt => [bv64, bv64]
  | .sltu => [bv64, bv64]
  | .and => [bv64, bv64]
  | .or => [bv64, bv64]
  | .xor => [bv64, bv64]
  | .sll => [bv64, bv64]
  | .srl => [bv64, bv64]
  | .sub => [bv64, bv64]
  | .sra => [bv64, bv64]
  | .remw  => [bv64, bv64]
  | .rem  =>  [bv64, bv64]
  | .mul => [bv64, bv64]
  | .mulw => [bv64, bv64]
  | .div  =>  [bv64, bv64]
  | .divw  =>  [bv64, bv64]
  | .divuw  =>  [bv64, bv64]
  | .addi (_imm : BitVec 12) => [bv64]
  | .slti (_imm : BitVec 12) => [bv64]
  | .sltiu (_imm : BitVec 12) => [bv64]
  | .andi (_imm : BitVec 12) => [bv64]
  | .ori (_imm : BitVec 12) => [bv64]
  | .xori (_imm : BitVec 12) => [bv64]
  | .bclr => [bv64, bv64]
  | .bext => [bv64, bv64]
  | .binv => [bv64, bv64]
  | .bset  => [bv64, bv64]
  | .bclri (_shamt : BitVec 6) => [bv64]
  | .bexti (_shamt : BitVec 6) => [bv64]
  | .binvi (_shamt : BitVec 6) => [bv64]
  | .bseti (_shamt : BitVec 6) => [bv64]
  | .adduw => [bv64, bv64]
  | .sh1adduw => [bv64, bv64]
  | .sh2adduw => [bv64, bv64]
  | .sh3adduw => [bv64, bv64]
  | .sh1add => [bv64, bv64]
  | .sh2add => [bv64, bv64]
  | .sh3add => [bv64, bv64]
  | .slliuw (_shamt : BitVec 6) => [bv64]
  | .andn => [bv64, bv64]
  | .orn => [bv64, bv64]
  | .xnor => [bv64, bv64]
  | .clz
  | .clzw
  | .ctz
  | .ctzw
  | .max => [bv64, bv64]
  | .maxu => [bv64, bv64]
  | .min  => [bv64, bv64]
  | .minu  => [bv64, bv64]
  | .sextb => [bv64]
  | .sexth => [bv64]
  | .zexth => [bv64]
  | .rol => [bv64, bv64]
  | .rolw => [bv64, bv64]
  | .ror => [bv64, bv64]
  | .rori (_shamt : BitVec 6) =>[bv64]
  | .roriw (_shamt : BitVec 5) =>[bv64]
  | .rorw => [bv64, bv64]
  | .pack => [bv64, bv64]
  | .packh => [bv64, bv64]
  | .packw => [bv64, bv64]
  | .mv => [bv64]
  | .not => [bv64]
  | .neg => [bv64]
  | .negw => [bv64]
  | .sextw => [bv64]
  | .zextb => [bv64]
  | .zextw => [bv64]
  | .seqz => [bv64]
  | .snez => [bv64]
  | .sltz => [bv64]
  | .sgtz => [bv64]

/--
`Op.outTy` specifies the output type of each `RISCV64` operation.
-/
@[simp, reducible]
def Op.outTy : Op  → Ty
  | .li _ => bv64
  | .ordep k => bvk k
  | .lidep k _ => if k = .k64 then bv64 else bv32
  | .li32 _ => bv32
  | .li64 _ => bv64
  | .mulh => bv64
  | .mulhu => bv64
  | .mulhsu => bv64
  | .divu => bv64
  | .remuw => bv64
  | .remu =>  bv64
  | .addiw (_imm : BitVec 12) => bv64
  | .lui (_imm : BitVec 20) => bv64
  | .auipc (_imm : BitVec 20) => bv64
  | .slliw (_shamt : BitVec 5) => bv64
  | .srliw (_shamt : BitVec 5) => bv64
  | .sraiw (_shamt : BitVec 5) => bv64
  | .slli (_shamt : BitVec 6) => bv64
  | .srli (_shamt : BitVec 6) => bv64
  | .srai (_shamt : BitVec 6) => bv64
  | .addw => bv64
  | .subw => bv64
  | .sllw => bv64
  | .srlw => bv64
  | .sraw => bv64
  | .add => bv64
  | .slt => bv64
  | .sltu => bv64
  | .and => bv64
  | .or => bv64
  | .xor => bv64
  | .sll => bv64
  | .srl => bv64
  | .sub => bv64
  | .sra => bv64
  | .remw  => bv64
  | .rem => bv64
  | .mul => bv64
  | .mulw => bv64
  | .div => bv64
  | .divw => bv64
  | .divuw => bv64
  | .addi (_imm : BitVec 12) => bv64
  | .slti (_imm : BitVec 12) => bv64
  | .sltiu (_imm : BitVec 12) => bv64
  | .andi (_imm : BitVec 12) => bv64
  | .ori (_imm : BitVec 12) => bv64
  | .xori (_imm : BitVec 12) => bv64
  | .bclr => bv64
  | .bext => bv64
  | .binv => bv64
  | .bset => bv64
  | .bclri (_shamt : BitVec 6) => bv64
  | .bexti (_shamt : BitVec 6) => bv64
  | .binvi (_shamt : BitVec 6) => bv64
  | .bseti (_shamt : BitVec 6) => bv64
  | adduw => bv64
  | .sh1adduw => bv64
  | .sh2adduw => bv64
  | .sh3adduw => bv64
  | .sh1add => bv64
  | .sh2add => bv64
  | .sh3add => bv64
  | .slliuw (_shamt : BitVec 6) => bv64
  | .andn =>  bv64
  | .orn =>  bv64
  | .xnor =>  bv64
  | .clz => bv64
  | .clzw => bv64
  | .ctz => bv64
  | .ctzw => bv64
  | .max =>  bv64
  | .maxu =>  bv64
  | .min  =>  bv64
  | .minu  =>  bv64
  | .sextb => bv64
  | .sexth => bv64
  | .zexth => bv64
  | .rol => bv64
  | .rolw => bv64
  | .ror => bv64
  | .rori (_shamt : BitVec 6) => bv64
  | .roriw (_shamt : BitVec 5) => bv64
  | .rorw => bv64
  | .pack => bv64
  | .packh => bv64
  | .packw => bv64
  | .mv => bv64
  | .not => bv64
  | .neg => bv64
  | .negw => bv64
  | .sextw => bv64
  | .zextb => bv64
  | .zextw => bv64
  | .seqz => bv64
  | .snez => bv64
  | .sltz => bv64
  | .sgtz => bv64

/--
`Dialect` bundles `RISCV64.Op` and `RISCV64.Ty` into a dialect named `RV64`.
-/
@[simp]
abbrev RV64 : Dialect where
  Op := Op
  Ty := Ty

/--
Combining `RISCV64.outTy` and `RISCV64.sig` yields the signature of the dialect.
-/
instance : DialectSignature RV64 where
  signature o := {sig := Op.sig o, returnTypes := [Op.outTy o], regSig := []}

/-! ## Printing Infrastructure -/

instance : ToString Ty where
  toString
  | .bv64 => "!riscv.reg"
  | .bv32 => "!riscv.reg32"
  | .bvk k => s!"!riscv.reg{ k.denoteWidth }"


open RISCV64.Op in
def opName (op : RISCV64.Op) : String :=
  let op  : String := match op with
  | .li _ => "li"
  | .lidep _ _ => "lidep"
  | .ordep _ => "ordep"
  | .li32 _ => "li32"
  | .li64 _ => "li64"
  | .mulh => "mulh"
  | .mulhu => "mulhu"
  | .mulhsu => "mulhsu"
  | .divu => "divu"
  | .remuw => "remuw"
  | .remu => "remu"
  | .addiw _ => "addiw"
  | .lui _ => "lui"
  | .auipc _ => "auipc"
  | .slliw _ => "slliw"
  | .srliw _ => "srliw"
  | .sraiw _ => "sraiw"
  | .slli _ => "slli"
  | .srli _ => "srli"
  | .srai _ => "srai"
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
  | .divuw => "divuw"
  | .addi _ => "addi"
  | .slti _ => "slti"
  | .sltiu _ => "sltiu"
  | .andi _ => "andi"
  | .ori _ => "ori"
  | .xori _ => "xori"
  | .bclr => "bclr"
  | .bext => "bext"
  | .binv => "binv"
  | .bset => "bset"
  | .bclri _ => "bclri"
  | .bexti _ => "bexti"
  | .binvi _ => "binvi"
  | .bseti _ => "bseti"
  | .adduw => "add.uw"
  | .sh1adduw => "sh1add.uw"
  | .sh2adduw => "sh2add.uw"
  | .sh3adduw => "sh3add.uw"
  | .sh1add => "sh1add"
  | .sh2add => "sh2add"
  | .sh3add => "sh3add"
  | .slliuw _ => "slli.uw"
  | .andn => "andn"
  | .orn => "orn"
  | .xnor => "xnor"
  | .clz => "clz"
  | .clzw => "clzw"
  | .ctz => "ctz"
  | .ctzw => "ctzw"
  | .max => "max"
  | .maxu => "maxu"
  | .min  => "min"
  | .minu  => "minu"
  | .sextb => "sext.b"
  | .sexth => "sext.h"
  | .zexth => "zext.h"
  | .rol => "rol"
  | .rolw => "rolw"
  | .ror => "ror"
  | .rori _ => "rori"
  | .roriw _ => "roriw"
  | .rorw => "rorw"
  | .pack => "pack"
  | .packh => "packh"
  | .packw => "packw"
  -- pseudo-instructions
  | .mv => "mv"
  | .not => "not"
  | .neg => "neg"
  | .negw => "negw"
  | .sextw => "sext.w"
  | .zextb => "zext.b"
  | .zextw => "zext.w"
  | .seqz => "seqz"
  | .snez => "snez"
  | .sltz => "sltz"
  | .sgtz => "sgtz"
  op

def printAttributes: RISCV64.Op → String
  | .li imm => s! "\{immediate = { imm.toInt } : i64 }"
  | .addiw (imm : BitVec 12) => s!"\{immediate = { imm.toInt} : si12 }"
  | .lui (imm : BitVec 20) => s!"\{immediate = { imm.toInt} : ui20 } "
  | .auipc (imm : BitVec 20) => s!"\{immediate = { imm.toInt} : si20 }" -- adding a s such that xdsl can parsee it, double-check when needed and when not
  | .slliw (imm : BitVec 5) => s!"\{immediate = { imm.toNat} : ui5 }"
  | .srliw (imm : BitVec 5) => s!"\{immediate = { imm.toNat} : ui5 }"
  | .sraiw (imm : BitVec 5) => s!"\{immediate = { imm.toNat} : ui5 }"
  | .slli (imm : BitVec 6) => s!"\{immediate = { imm.toNat} : ui6 }"
  | .srli (imm : BitVec 6) => s!"\{immediate = { imm.toNat} : ui6 }"
  | .srai (imm : BitVec 6) => s!"\{immediate = { imm.toNat} : ui6 }"
  | .addi (imm : BitVec 12) => s!"\{immediate = { imm.toInt } : si12 }"
  | .slti (imm : BitVec 12) => s!"\{immediate = { imm.toInt } : si12 }"
  | .sltiu (imm : BitVec 12) => s!"\{immediate = { imm.toInt } : si12 }"
  | .andi (imm : BitVec 12) => s!"\{immediate = { imm.toInt } : si12 }"
  | .ori (imm : BitVec 12) => s!"\{immediate = { imm.toInt } : si12 }"
  | .xori (imm : BitVec 12) => s!"\{immediate = { imm.toInt } : si12 }"
  | .bclri (imm : BitVec 6) => s!"\{immediate = { imm.toInt} : i6 }"
  | .bexti (imm : BitVec 6) =>s!"\{immediate = { imm.toInt} : i6 }"
  | .binvi (imm : BitVec 6) => s!"\{immediate = { imm.toInt} : i6 }"
  | .bseti (imm : BitVec 6) => s!"\{immediate = { imm.toInt} : i6 }"
  | .slliuw (imm : BitVec 6) => s!"\{immediate = { imm.toNat} : ui6 }"
  | .rori (imm : BitVec 6) => s!"\{immediate = { imm.toInt} : i5 }"
  | .roriw (imm : BitVec 5) => s!"\{immediate = { imm.toInt} : i5 }"
  | _ => ""

instance : DialectPrint RV64 where
  printOpName op := "riscv." ++ opName op
  printTy := toString
  printAttributes := printAttributes
  dialectName := "riscv"
  printReturn _ := "riscv.ret"
  printFunc _ := "riscv_func.func @f"

/--
We extend `hvector_get_elem_tactic` so that `HVector.getN` can automatically
prove that indices are in-bounds when defining the semantics of RV64.
-/
macro_rules
| `(tactic| hvector_get_elem_tactic) =>
    `(tactic| simp [DialectSignature.sig, signature])

/--
## Dialect semantics
We assign authoritative semantics derived in `sail-riscv/RISCV/Instructions` to each operation.
The `RV64` semantics first process the second operand, then the first.
Therefore we first pass `.get 1` then `.get 0` into the functions that define our semantics.
-/
@[simp, simp_denote]
abbrev Op.denote : (o : RV64.Op) → HVector toType o.sig → ⟦o.outTy⟧
  | .li imm, _  => imm
  | .ordep k, regs =>
    -- provide type hint to nudge unification.
    let x1 : BitVec k.denoteWidth := regs.getN 1
    let x0 : BitVec k.denoteWidth := regs.getN 0
    -- let x1 := regs.getN 1
    -- let x0 := regs.getN 0
    -- sorry
    -- sorry
    ((x0 ||| x1))
  | .lidep k imm, _ =>
    match hk : k with
    | .k32 => imm.zeroExtend _ -- 12 → 64
    | .k64 => imm.zeroExtend _ -- 20 → 64
  | .li32 imm, _ => imm.zeroExtend _ -- 12 → 64
  | .li64 imm, _ => imm.zeroExtend _ -- 20 → 64
  | .addiw imm, regs => RV64.addiw imm (regs.getN 0)
  | .lui imm, regs  => RV64.lui imm
  | .auipc imm, regs => RV64.auipc imm (regs.getN 0)
  | .slliw shamt, regs => RV64.slliw shamt (regs.getN 0)
  | .srliw shamt, regs => RV64.srliw shamt (regs.getN 0)
  | .sraiw shamt, regs => RV64.sraiw shamt (regs.getN 0)
  | .slli shamt, regs => RV64.slli shamt (regs.getN 0)
  | .srli shamt, regs => RV64.srli shamt (regs.getN 0)
  | .srai shamt, regs => RV64.srai shamt (regs.getN 0)
  | .addw, regs => RV64.addw (regs.getN 1) (regs.getN 0)
  | .subw, regs => RV64.subw (regs.getN 1) (regs.getN 0)
  | .sllw, regs => RV64.sllw (regs.getN 1) (regs.getN 0)
  | .srlw, regs => RV64.srlw (regs.getN 1) (regs.getN 0)
  | .sraw, regs => RV64.sraw (regs.getN 1) (regs.getN 0)
  | .add, regs => RV64.add (regs.getN 1) (regs.getN 0)
  | .slt, regs => RV64.slt (regs.getN 1) (regs.getN 0)
  | .sltu, regs => RV64.sltu (regs.getN 1) (regs.getN 0)
  | .and, regs => RV64.and (regs.getN 1) (regs.getN 0)
  | .or, regs => RV64.or (regs.getN 1) (regs.getN 0)
  | .xor, regs => RV64.xor (regs.getN 1) (regs.getN 0)
  | .sll, regs => RV64.sll (regs.getN 1) (regs.getN 0)
  | .srl, regs => RV64.srl (regs.getN 1) (regs.getN 0)
  | .sub, regs => RV64.sub (regs.getN 1) (regs.getN 0)
  | .sra, regs => RV64.sra (regs.getN 1) (regs.getN 0)
  | .remw, regs => RV64.remw (regs.getN 1) (regs.getN 0)
  | .remuw, regs => RV64.remuw (regs.getN 1) (regs.getN 0)
  | .rem, regs => RV64.rem (regs.getN 1) (regs.getN 0)
  | .remu, regs => RV64.remu (regs.getN 1) (regs.getN 0)
  | .mulhu,regs => RV64.mulhu (regs.getN 1) (regs.getN 0)
  | .mul ,regs => RV64.mul (regs.getN 1) (regs.getN 0)
  | .mulhsu ,regs => RV64.mulhsu (regs.getN 1) (regs.getN 0)
  | .mulh,regs => RV64.mulh (regs.getN 1) (regs.getN 0)
  | .mulw,  regs => RV64.mulw (regs.getN 1) (regs.getN 0)
  | .div, regs => RV64.div (regs.getN 1) (regs.getN 0)
  | .divu, regs => RV64.divu (regs.getN 1) (regs.getN 0)
  | .divw, regs => RV64.divw (regs.getN 1) (regs.getN 0)
  | .divuw, regs => RV64.divuw (regs.getN 1) (regs.getN 0)
  | .addi imm, reg => RV64.addi imm (reg.getN 0)
  | .slti imm, reg => RV64.slti imm (reg.getN 0)
  | .sltiu imm, reg => RV64.sltiu imm (reg.getN 0)
  | .andi imm, reg => RV64.andi imm (reg.getN 0)
  | .ori imm, reg => RV64.ori imm (reg.getN 0)
  | .xori imm, reg => RV64.xori imm (reg.getN 0)
  | .bclr, regs => RV64.bclr (regs.getN 1) (regs.getN 0)
  | .bext, regs => RV64.bext (regs.getN 1) (regs.getN 0)
  | .binv, regs => RV64.binv (regs.getN 1) (regs.getN 0)
  | .bset, regs => RV64.bset (regs.getN 1) (regs.getN 0)
  | .bclri shamt , reg => RV64.bclri shamt (reg.getN 0)
  | .bexti shamt, reg => RV64.bexti shamt (reg.getN 0)
  | .binvi shamt, reg => RV64.binvi shamt (reg.getN 0)
  | .bseti shamt, reg => RV64.bseti shamt (reg.getN 0)
  | .adduw, regs => RV64.adduw (regs.getN 1) (regs.getN 0)
  | .sh1adduw , regs => RV64.sh1adduw (regs.getN 1) (regs.getN 0)
  | .sh2adduw, regs => RV64.sh2adduw (regs.getN 1) (regs.getN 0)
  | .sh3adduw, regs => RV64.sh3adduw (regs.getN 1) (regs.getN 0)
  | .sh1add, regs => RV64.sh1add (regs.getN 1) (regs.getN 0)
  | .sh2add, regs => RV64.sh2add (regs.getN 1) (regs.getN 0)
  | .sh3add, regs => RV64.sh3add (regs.getN 1) (regs.getN 0)
  | .slliuw shamt, regs => RV64.slliuw shamt (regs.getN 0)
  | .andn, regs => RV64.andn (regs.getN 1) (regs.getN 0)
  | .orn, regs => RV64.orn (regs.getN 1) (regs.getN 0)
  | .xnor, regs => RV64.xnor (regs.getN 1) (regs.getN 0)
  | .clz, regs => RV64.clz (regs.getN 1)
  | .clzw, regs => RV64.clzw (regs.getN 1)
  | .ctz, regs => RV64.ctz (regs.getN 1)
  | .ctzw, regs => RV64.ctzw (regs.getN 1)
  | .max, regs => RV64.max (regs.getN 1) (regs.getN 0)
  | .maxu, regs => RV64.maxu (regs.getN 1) (regs.getN 0)
  | .min, regs => RV64.min (regs.getN 1) (regs.getN 0)
  | .minu, regs => RV64.minu (regs.getN 1) (regs.getN 0)
  | .sextb, reg => RV64.sextb (reg.getN 0)
  | .sexth, reg => RV64.sexth (reg.getN 0)
  | .zexth, reg => RV64.zexth (reg.getN 0)
  | .rol, regs => RV64.rol (regs.getN 1) (regs.getN 0)
  | .rolw, regs => RV64.rolw (regs.getN 1) (regs.getN 0)
  | .ror, regs => RV64.ror (regs.getN 1) (regs.getN 0)
  | .rori shamt, regs => RV64.rori shamt (regs.getN 0)
  | .roriw shamt, regs => RV64.roriw shamt (regs.getN 0)
  | .rorw, regs => RV64.rorw (regs.getN 1) (regs.getN 0)
  | .pack, regs => RV64.pack (regs.getN 1) (regs.getN 0)
  | .packh, regs => RV64.packh (regs.getN 1) (regs.getN 0)
  | .packw, regs => RV64.packw (regs.getN 1) (regs.getN 0)
  -- pseudo-instructions
  | .mv, regs  => RV64.mv_pseudo (regs.getN 0)
  | .not, regs => RV64.not_pseudo (regs.getN 0)
  | .neg, regs => RV64.neg_pseudo (regs.getN 0)
  | .negw, regs => RV64.negw_pseudo (regs.getN 0)
  | .sextw, regs => RV64.sextw_pseudo (regs.getN 0)
  | .zextb, regs => RV64.zextb_pseudo (regs.getN 0)
  | .zextw, regs => RV64.zextw_pseudo (regs.getN 0)
  | .seqz, regs => RV64.seqz_pseudo (regs.getN 0)
  | .snez, regs => RV64.snez_pseudo (regs.getN 0)
  | .sltz, regs => RV64.sltz_pseudo (regs.getN 0)
  | .sgtz, regs => RV64.sgtz_pseudo (regs.getN 0)

@[simp, reducible]
instance : DialectDenote RV64 where
  denote o args _ := [o.denote args]ₕ
