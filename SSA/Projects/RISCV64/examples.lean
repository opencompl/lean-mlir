
import SSA.Projects.RISCV64.Syntax
import SSA.Projects.RISCV64.Base
import SSA.Projects.RISCV64.Semantics
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Util

open MLIR AST in
open RISCV64
/-- contains riscv dialect and evaultes them. Purpose was to check the semantics of my dialect and to get familar with
 invkoing it on an IR level. -/

--typing test
def RISCVEg1 := [RV64_com| {
  ^entry (%0: !i64):
  "ret" (%0) : (!i64) -> ()
}]
#check RISCVEg1
#eval RISCVEg1
#reduce RISCVEg1
#check RISCVEg1.denote

-- self addition test
def RISCVEg2 := [RV64_com| {
  ^entry (%0: !i64):
    %1 = "add" (%0, %0) : (!i64, !i64) -> (!i64)
    "ret" (%1) : (!i64) -> ()
}]
#check RISCVEg2
#eval RISCVEg2
#reduce RISCVEg2
#check RISCVEg2.denote


#check HVector.cons (BitVec.ofNat 64 1) .nil
#check HVector TyDenote.toType [RISCV64.Ty.bv]
#check HVector -- returns a function from List α to lub type universe of both types.

def lh : HVector TyDenote.toType [RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 1) .nil
def test_selfadd : BitVec 64 := RISCVEg2.denote (Ctxt.Valuation.ofHVector lh)
#eval test_selfadd

--addiw
def RISCVEg3 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "addw" (%0, %0) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
--def lh3 : HVector TyDenote.toType [toRISCV.Ty.bv ,toRISCV.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 1) <| HVector.cons (BitVec.ofNat 64 2) .nil
def lh3 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 0) <| HVector.cons (BitVec.ofNat 64 2) .nil --checking edge cases
def test_addw : BitVec 64 := RISCVEg3.denote  (Ctxt.Valuation.ofHVector lh3)
#eval test_addw


-- to do: rethink order of operations
--sllw
def RISCVEg4 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "sllw" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh4 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 0) <| HVector.cons (BitVec.ofNat 64 1) .nil --checking edge cases
def test_sllw : BitVec 64 := RISCVEg4.denote  (Ctxt.Valuation.ofHVector lh4)
#eval test_sllw

--srlw
def RISCVEg5 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "srlw" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh5 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 32) <| HVector.cons (BitVec.ofNat 64 1) .nil --checking edge cases
def test_srlw : BitVec 64 := RISCVEg5.denote  (Ctxt.Valuation.ofHVector lh5)
#eval test_srlw

--sraw -- attention to the order of the elements when putting them in
def RISCVEg6 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "sraw" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh6 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 (16)) <| HVector.cons (BitVec.ofNat 64 2) .nil --checking edge cases
def test_sraw : BitVec 64 := RISCVEg6.denote  (Ctxt.Valuation.ofHVector lh6)
#eval test_sraw


-- addition test
def RISCVEg7 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "add" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]

def lh7 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 1) <| HVector.cons (BitVec.ofNat 64 19) .nil
def test_add : BitVec 64 := RISCVEg7.denote  (Ctxt.Valuation.ofHVector lh7)
#eval test_add


--slt --extract semanitcs at edge cases -> didnt understand it yet  !!list here is built reverse
def RISCVEg8 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "slt" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]

--testing the sign behavior edge cases , but this test should be true in the unisgned case
def lh8 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 0) <| HVector.cons (BitVec.ofNat 64 (1)) .nil--checking edge cases
def test_slt : BitVec 64 := RISCVEg8.denote  (Ctxt.Valuation.ofHVector lh8)
#eval test_slt

--sltu checks if 2nd arg smaller than first arg, list is reverse but here checks if 2nd elem is smaller than first after reversing list e.g 10 <= 12
def RISCVEg9 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "sltu" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh9 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 9223372036854775808) <| HVector.cons (BitVec.ofNat 64 (18446744073709551615)) .nil --18444 <= 92-- yields tue
--def lh9 : HVector TyDenote.toType [toRISCV.Ty.bv ,toRISCV.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 10) <| HVector.cons (BitVec.ofNat 64 12) .nil --checking edge cases
def test_sltu : BitVec 64 := RISCVEg9.denote  (Ctxt.Valuation.ofHVector lh9)
#eval test_sltu

--and
def RISCVEg10 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "and" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]

--bitwise and
def lh10 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 7) <| HVector.cons (BitVec.ofNat 64 (7)) .nil --18444 <= 92-- yields tue
--def lh9 : HVector TyDenote.toType [toRISCV.Ty.bv ,toRISCV.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 10) <| HVector.cons (BitVec.ofNat 64 12) .nil --checking edge cases
def test_and : BitVec 64 := RISCVEg10.denote  (Ctxt.Valuation.ofHVector lh10)
#eval test_and


--or
def RISCVEg11 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "or" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh11 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 1) <| HVector.cons (BitVec.ofNat 64 (2)) .nil --18444 <= 92-- yields tue
--def lh9 : HVector TyDenote.toType [toRISCV.Ty.bv ,toRISCV.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 10) <| HVector.cons (BitVec.ofNat 64 12) .nil --checking edge cases
def test_or : BitVec 64 := RISCVEg11.denote  (Ctxt.Valuation.ofHVector lh11)
#eval test_or


-- xor test
def RISCVEg12 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "xor" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh12 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 1) <| HVector.cons (BitVec.ofNat 64 1) .nil
def test_xor : BitVec 64 := RISCVEg12.denote  (Ctxt.Valuation.ofHVector lh12)
#eval test_xor

--sll
def RISCVEg13 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "sll" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh13 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 1) <| HVector.cons (BitVec.ofNat 64 1) .nil
def test_sll : BitVec 64 := RISCVEg13.denote  (Ctxt.Valuation.ofHVector lh13)
#eval test_sll

--srl
def RISCVEg14 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "srl" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh14 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 1) <| HVector.cons (BitVec.ofNat 64 1) .nil
def test_srl : BitVec 64 := RISCVEg14.denote  (Ctxt.Valuation.ofHVector lh14)
#eval test_srl


--sub
-- add support for subtraction
def RISCVEg15 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ): -- 0 10
    %2 = "sub"  (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh15 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 4) <| HVector.cons (BitVec.ofNat 64 10) .nil
def test_sub : BitVec 64 := RISCVEg15.denote  (Ctxt.Valuation.ofHVector lh15)
#eval test_sub --interprete it as signed or unsigned

--addiw test (uses an immediate as part of the "op code")
def RISCVEg16 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "addiw" (%0) { imm = 19 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh16 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 1) .nil
def test_addiw : BitVec 64 := RISCVEg16.denote  (Ctxt.Valuation.ofHVector lh16)
#eval test_addiw


-- lui rd, imm : places imm into 20 upper bit of rd, filling rest with 12 bit of zeros
def RISCVEg17 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "lui" (%0) { imm = 19 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh17 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 1) .nil
def test_lui : BitVec 64 := RISCVEg17.denote  (Ctxt.Valuation.ofHVector lh17)
#eval test_lui

-- auipc rd, imm -> adds 20 bit immediate and fills rest with 12 zeros and adds it to the pc and places it in rd
def RISCVEg18 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "auipc" (%0) { imm = 19 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh18 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 1) .nil
def test_auipc : BitVec 64 := RISCVEg18.denote  (Ctxt.Valuation.ofHVector lh18)
#eval test_auipc


def RISCVEg19 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "slliw" (%0) { shamt = 1 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh19 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 1) .nil
def test_slliw : BitVec 64 := RISCVEg19.denote  (Ctxt.Valuation.ofHVector lh18)
#eval test_slliw

def RISCVEg20 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "srliw" (%0) { shamt = 19 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh20 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 1) .nil
def test_srliw : BitVec 64 := RISCVEg20.denote  (Ctxt.Valuation.ofHVector lh20)
#eval test_srliw

def RISCVEg21 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "sraiw" (%0) { shamt = 19 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh21 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 1) .nil
def test_sraiw : BitVec 64 := RISCVEg21.denote  (Ctxt.Valuation.ofHVector lh21)
#eval test_sraiw

-- slli rd, rs1, shamt : logical left shift of rs1 with value held in lower 5 bits of immediate
def RISCVEg22 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "slli" (%0) { shamt = 19 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh22 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 1) .nil
def test_slli : BitVec 64 := RISCVEg22.denote  (Ctxt.Valuation.ofHVector lh22)
#eval test_slli

-- srli rd, rs1, shamt logical right shift on rs1 and shift amount given by lower 5 bits of shamt
def RISCVEg23 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "srli" (%0) { shamt = 0 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh23 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 1) .nil
def test_srli : BitVec 64 := RISCVEg23.denote  (Ctxt.Valuation.ofHVector lh23)
#eval test_srli

-- RV64M: rem rd, rs1, rs2, unsigned reminder of rs1 by rs1 -- rs1, rs2
def RISCVEg24 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "rem" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : ( !i64, !i64 ) -> ()
}]
def lh24 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv] := HVector.cons (BitVec.ofNat 64 9) <| HVector.cons (BitVec.ofNat 64 (8)) .nil
def test_rem : BitVec 64 := RISCVEg24.denote  (Ctxt.Valuation.ofHVector lh24)
#eval test_rem

-- document how to implement this, was hard to do it right to get the attributes correct
-- RV64M: mul rd, rs1, rs2, signed multiplication of rs1 by rs2 and places lower bits into rd
def RISCVEg25 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "mul" (%0, %0) : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : ( !i64, !i64 ) -> ()
}]
def lh25 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv] := HVector.cons (BitVec.ofNat 64 7) <| HVector.cons (BitVec.ofNat 64 8) .nil
def test_mul : BitVec 64 := RISCVEg25.denote  (Ctxt.Valuation.ofHVector lh25)
#eval test_mul


def RISCVEg26 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "mulw" (%0, %1)  : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : ( !i64, !i64 ) -> ()
}]
def lh26 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv] := HVector.cons (BitVec.ofNat 64 7) <| HVector.cons (BitVec.ofNat 64 8) .nil
def test_mulw : BitVec 64 := RISCVEg26.denote  (Ctxt.Valuation.ofHVector lh26)
#eval test_mulw

--RV64M: div rd, rs1, rs2  : signed division of rs1 by rs2
def RISCVEg27 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "div" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : ( !i64, !i64 ) -> ()
}]
def lh27 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv] := HVector.cons (BitVec.ofNat 64 4) <| HVector.cons (BitVec.ofNat 64 8) .nil
def test_div : BitVec 64 := RISCVEg27.denote  (Ctxt.Valuation.ofHVector lh27)
#eval test_div

-- divw
def RISCVEg28 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "divw" (%0, %1)  : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : ( !i64, !i64 ) -> ()
}]
def lh28 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv] := HVector.cons (BitVec.ofNat 64 56) <| HVector.cons (BitVec.ofNat 64 8) .nil
def test_divw : BitVec 64 := RISCVEg28.denote  (Ctxt.Valuation.ofHVector lh28)
#eval test_divw

-- addi rd, rs1, imm adds sign-extended 12 bit immediate to rs1, ignores overflow
def RISCVEg29 := [RV64_com| {
  ^entry (%0: !i64):
    %2 = "addi" (%0)  { imm = 10 : !i64 } : ( !i64 ) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh29 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 8) .nil
def test_addi : BitVec 64 := RISCVEg29.denote  (Ctxt.Valuation.ofHVector lh29)
#eval test_addi

--slti rd, rs1, imm, places 1 into rd if rs1 is less than immediate, signed
def RISCVEg30 := [RV64_com| {
  ^entry (%0: !i64):
    %2 = "slti" (%0)  { imm = 10 : !i64 } : ( !i64 ) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh30 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 1) .nil
def test_slti : BitVec 64 := RISCVEg30.denote  (Ctxt.Valuation.ofHVector lh30)
#eval test_slti

-- sltiu rd, rs1, imm places 1 into rd if rs1 is less than immediate
def RISCVEg31 := [RV64_com| {
  ^entry (%0: !i64):
    %2 = "sltiu" (%0)  { imm = 10 : !i64 } : ( !i64 ) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh31 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 8) .nil
def test_sltiu : BitVec 64 := RISCVEg31.denote  (Ctxt.Valuation.ofHVector lh31)
#eval test_sltiu

-- andi rd, rs1, imm (sign extended 12 bit imm bitwise or)
def RISCVEg32 := [RV64_com| {
  ^entry (%0: !i64):
    %2 = "andi" (%0)  { imm = 15 : !i64 } : ( !i64 ) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh32 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 16) .nil
def test_andi : BitVec 64 := RISCVEg32.denote  (Ctxt.Valuation.ofHVector lh32)
#eval test_andi

-- ori rd, rs1, imm (sign extended 12 bit imm bitwise or)
def RISCVEg33 := [RV64_com| {
  ^entry (%0: !i64):
    %2 = "ori" (%0)  { imm = 10 : !i64 } : ( !i64 ) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh33 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 8) .nil
def test_ori : BitVec 64 := RISCVEg33.denote  (Ctxt.Valuation.ofHVector lh33)
#eval test_ori

-- xori rd, rs1, imm (sign extended 12 bit imm bitwise xor)
def RISCVEg34 := [RV64_com| {
  ^entry (%0: !i64):
    %2 = "xori" (%0)  { imm = 7 : !i64 } : ( !i64 ) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh34 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 2) .nil
def test_xori : BitVec 64 := RISCVEg34.denote  (Ctxt.Valuation.ofHVector lh34)
#eval test_xori

-- czero.eqz rd rs1, rs2 --> checks if rs2 is zero the returns zero else returns rs1, here list is built reverse, - rs1 rs2
def RISCVEg35 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "czero.eqz" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh35 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 1) <| HVector.cons (BitVec.ofNat 64 1) .nil
def test_czero.eqz : BitVec 64 := RISCVEg35.denote  (Ctxt.Valuation.ofHVector lh35)
#eval test_czero.eqz --interprete it as signed or unsigned

-- czero.nez rd, rs1, rs2 --> returns zero if rs2 is nonzero else moves rs1 to rd , -rs1 rs2
def RISCVEg36 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "czero.nez" (%0, %1) : (!i64, !i64) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh36 : HVector TyDenote.toType [RISCV64.Ty.bv ,RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 19) <| HVector.cons (BitVec.ofNat 64 0) .nil
def test_czero.nez : BitVec 64 := RISCVEg36.denote  (Ctxt.Valuation.ofHVector lh36)
#eval test_czero.nez --interprete it as signed or unsigned

-- ZBB: sext.b rd, rs : sign extends the least significant byte by copying the most signifcant bit in the byte to all others -> either all 0 or 1 in the front
def RISCVEg37 := [RV64_com| {
  ^entry (%0: !i64):
    %2 = "sext.b" (%0) : ( !i64) -> (!i64)
    "ret" (%2) : (!i64 ) -> ()
}]
def lh37 : HVector TyDenote.toType [RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 0) .nil
def test_sext.b : BitVec 64 := RISCVEg37.denote  (Ctxt.Valuation.ofHVector lh37)
#eval test_sext.b

-- ZBB: sext.h rd rs : sign-extend the least significant 16 bits by copying bit 15 to all other more significant bits
def RISCVEg38 := [RV64_com| {
  ^entry (%0: !i64):
    %2 = "sext.h" (%0) : ( !i64) -> (!i64)
    "ret" (%2) : (!i64 ) -> ()
}]
def lh38 : HVector TyDenote.toType [RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 (1)) .nil
def test_sext.h : BitVec 64 := RISCVEg38.denote  (Ctxt.Valuation.ofHVector lh38)
#eval test_sext.h

-- ZBB: zext.h rd, rs : zero extends the least signifcant 16 bits by 0
def RISCVEg39 := [RV64_com| {
  ^entry (%0: !i64):
    %2 = "zext.h" (%0) : ( !i64) -> (!i64)
    "ret" (%2) : (!i64 ) -> ()
}]
def lh39 : HVector TyDenote.toType [RISCV64.Ty.bv] :=  HVector.cons (BitVec.ofNat 64 5) .nil
def test_zext.h : BitVec 64 := RISCVEg39.denote  (Ctxt.Valuation.ofHVector lh39)
#eval test_zext.h

-- bclr rd, rs1, rs2 : reads index from the lower bits of rs2 and returns rs1 with that bit cleared
def RISCVEg40 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64):
    %2 = "bclr" (%0, %1) : ( !i64,!i64 ) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh40 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv ] := HVector.cons (BitVec.ofNat 64 8) <| HVector.cons (BitVec.ofNat 64 3) .nil
def test_bclr: BitVec 64 := RISCVEg40.denote  (Ctxt.Valuation.ofHVector lh40)
#eval test_bclr

--ZBS: bext rd, rs1, rs2 -- returns single bit extracted from rs1 at the index in the last 6 bits of rs2
def RISCVEg41 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64):
    %2 = "bext" (%0, %1) : ( !i64,!i64 ) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh41 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv] := HVector.cons (BitVec.ofNat 64 3) <| HVector.cons (BitVec.ofNat 64 2) .nil
def test_bext: BitVec 64 := RISCVEg41.denote  (Ctxt.Valuation.ofHVector lh41)
#eval test_bext

-- ZBS: binv rd, rs1, rs2 :: returns rs1 with a single bit inverted specificed by the lower 6 bits of rs2
def RISCVEg42 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64):
    %2 = "binv" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh42 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv ] := HVector.cons (BitVec.ofNat 64 0) <| HVector.cons (BitVec.ofNat 64 0) .nil
def test_inv: BitVec 64 := RISCVEg42.denote  (Ctxt.Valuation.ofHVector lh42)
#eval test_inv

-- ZBS: bset rd, rs1, rs2 :: returns rs1 with bit given by index of least 6 bits of rs2 set
def RISCVEg43 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64):
    %2 = "bset" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh43 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv ] := HVector.cons (BitVec.ofNat 64 1) <| HVector.cons (BitVec.ofNat 64 0) .nil
def test_bset: BitVec 64 := RISCVEg43.denote  (Ctxt.Valuation.ofHVector lh43)
#eval test_bset

-- ZBB: rolw rd, rs1, rs2 :: rotate left word -> rotates the left significant word of rs1 by amount given by least signifi. 5 bits of rs2 and sign exten ds to 64
def RISCVEg44 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64):
    %2 = "rolw" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh44 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv] := HVector.cons (BitVec.ofNat 64 64) <| HVector.cons (BitVec.ofNat 64 4) .nil
def test_rolw: BitVec 64 := RISCVEg44.denote  (Ctxt.Valuation.ofHVector lh44)
#eval test_rolw

-- ZBB: ror rd, rs1, rs2 :: rotate the bits of rs1 to the right by amount given in the least 6 bits of rs2
def RISCVEg45 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64):
    %2 = "rorw" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : (!i64, !i64 ) -> ()
}]
def lh45 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv] := HVector.cons (BitVec.ofNat 64 64) <| HVector.cons (BitVec.ofNat 64 4) .nil
def test_rorw: BitVec 64 := RISCVEg45.denote  (Ctxt.Valuation.ofHVector lh45)
#eval test_rorw

-- bclri rd, rs1, shamt :: returns rs1 with a bit cleared specified by shamt
def RISCVEg46 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "bclri" (%0) { imm = 1 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh46 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 7) .nil
def test_bclri : BitVec 64 := RISCVEg46.denote  (Ctxt.Valuation.ofHVector lh46)
#eval test_bclri

-- ZBS:  bexti rd1, rs1, shamt :: extracts bit from rs1 at index shamt
def RISCVEg47 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "bexti" (%0) { imm = 63 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh47 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 7) .nil
def test_bexit : BitVec 64 := RISCVEg47.denote  (Ctxt.Valuation.ofHVector lh47)
#eval test_bexit

-- ZBS: binvi rd, rs1, shamt :: returns a single bit inverted at the location given by shamt (its lower 6 bits)
def RISCVEg48 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "binvi" (%0) { imm = 2 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh48 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 0) .nil
def test_binvi : BitVec 64 := RISCVEg48.denote  (Ctxt.Valuation.ofHVector lh48)
#eval test_binvi

-- ZBS: bset rd, rs1, rs2 :: returns rs1 with a single bit set at the index specified by in the lower 6 bits of imm
def RISCVEg49 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "bseti" (%0) { imm = 63 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh49 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 0) .nil
def test_seti : BitVec 64 := RISCVEg49.denote  (Ctxt.Valuation.ofHVector lh49)
#eval test_seti

-- constant : used in rewrites to model constant aka known register input ?
def RISCVEg50 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "RV64.const" () { val = 250 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh50 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 1) .nil
def test_const : BitVec 64 := RISCVEg50.denote  (Ctxt.Valuation.ofHVector lh50)
#eval test_const

def RISCVEg200 := [RV64_com| {
  ^entry (%0 : !i64, %1 : !i64 ):
    %2 = "const" () { val = 1 : !i64 } : ( !i64) -> (!i64)
    %3 = "add" (%0, %1) : ( !i64,!i64 ) -> (!i64)
    %4 = "add" (%0, %0) : ( !i64,!i64 ) -> (!i64)
    %5 = "sub" (%1, %0) : ( !i64,!i64 ) -> (!i64)
    "ret" (%5) : ( !i64 ) -> ()
}]

def lh200 : HVector TyDenote.toType [RISCV64.Ty.bv,RISCV64.Ty.bv] := HVector.cons (BitVec.ofNat 64 1) <| HVector.cons (BitVec.ofNat 64 3) .nil
def test_RISCVEg200 : BitVec 64 := RISCVEg200.denote  (Ctxt.Valuation.ofHVector lh200)
#eval test_RISCVEg200


-- srai rd rs1 shamt -> shifts by the amount specifed by the imm aka its lower 6 bits
def RISCVEg51 := [RV64_com| {
  ^entry (%0 : !i64 ):
    %2 = "srai" (%0) { shamt = 1 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh51 : HVector TyDenote.toType [RISCV64.Ty.bv] := .cons (BitVec.ofNat 64 16) .nil
def test_srai : BitVec 64 := RISCVEg51.denote  (Ctxt.Valuation.ofHVector lh51)
#eval test_srai

--sra rd, rs1, rs2 :: right shift of rs1 by the shift amount in the lower 6 bits of rs2
def RISCVEg52 := [RV64_com| {
  ^entry (%0 : !i64, %1 : !i64  ):
    %2 = "sra" (%0, %1 ) : (!i64,!i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh52 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv] := HVector.cons (BitVec.ofNat 64 16) <| HVector.cons (BitVec.ofNat 64 2) .nil
def test_sra : BitVec 64 := RISCVEg52.denote (Ctxt.Valuation.ofHVector lh52)
#eval test_sra

def RISCVEg53 := [RV64_com| {
  ^entry (%0 : !i64, %1 : !i64  ):
    %2 = "rol" (%0, %1 ) : (!i64,!i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh53 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv]
  := HVector.cons (BitVec.ofNat 64 2) <| HVector.cons (BitVec.ofNat 64 1) .nil

def test_rol : BitVec 64 := RISCVEg53.denote (Ctxt.Valuation.ofHVector lh53)
#eval test_rol


def RISCVEg54 := [RV64_com| {
  ^entry (%0 : !i64, %1 : !i64  ):
    %2 = "ror" (%0, %1 ) : (!i64,!i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh54 : HVector TyDenote.toType [RISCV64.Ty.bv, RISCV64.Ty.bv]
  := HVector.cons (BitVec.ofNat 64 8) <| HVector.cons (BitVec.ofNat 64 1) .nil

def test_ror : BitVec 64 := RISCVEg54.denote (Ctxt.Valuation.ofHVector lh54)
#eval test_ror


def RISCVEg55 := [RV64_com| {
  ^entry ():
    %2 = "const" () { val = 670 : !i64 } : ( !i64) -> (!i64)
    "ret" (%2) : ( !i64 ) -> ()
}]
def lh55 : HVector TyDenote.toType ([] : List RISCV64.Ty) := .nil
def test_const1 : BitVec 64 := RISCVEg55.denote  (Ctxt.Valuation.ofHVector lh55)
#eval test_const1
#check TyDenote.toType
