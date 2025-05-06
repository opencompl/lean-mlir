import SSA.Core.MLIRSyntax.EDSL
set_option maxHeartbeats 1000000000000000000
/-!
  ## Dialect semantics
  This file contains the semantics for each modelled `RISCV-64` dialect instruction
  as defined by
  This give us the guarantee that the dialect semantics faithfully implements the intended
  Risc-V semantics.
  The semantic defintions do not contain toInt and toNat when possible. For this
  we rewrote the Sail semantics into pure bit vector only operations including a proof
  of correctness.
  This rewrite should allow to gain in automation using the bv_decide.
-/

namespace RV64Semantics

def ADDIW_pure64 (imm : BitVec 12) (rs1_val : BitVec 64) :  BitVec 64 :=
     BitVec.signExtend 64 (BitVec.setWidth 32 (BitVec.add (BitVec.signExtend 64 imm) rs1_val))

-- loads immediate into upper 20 bits and then fills the rest up with 0 and returns it as the result
def UTYPE_pure64_lui (imm : BitVec 20) (pc : BitVec 64) : BitVec 64 :=
     BitVec.signExtend 64 (imm ++ (0x000 : (BitVec 12)))

def UTYPE_pure64_AUIPC (imm : BitVec 20) (pc : BitVec 64)  : BitVec 64 :=
    BitVec.add (BitVec.signExtend 64 (BitVec.append imm (0x000 : (BitVec 12)))) pc

def SHIFTIWOP_pure64_RISCV_SLLIW (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.signExtend 64 ( (BitVec.extractLsb' 0 32 rs1_val) <<< (shamt))

-- wip: still needs to be rewritten into bitvec only operations
def SHIFTIWOP_pure64_RISCV_SRLIW (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.signExtend 64 ( (BitVec.extractLsb' 0 32 rs1_val) >>> (shamt))

def SHIFTIWOP_pure64_RISCV_SRAIW (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.signExtend 64 (BitVec.sshiftRight' (BitVec.extractLsb 31 0 rs1_val) shamt)

def SHIFTIOP_pure64_RISCV_SLLI (shamt : BitVec 6) (rs1_val : BitVec 64)  : BitVec 64 :=
    rs1_val <<< shamt

def SHIFTIOP_pure64_RISCV_SRLI (shamt : BitVec 6) (rs1_val : BitVec 64) : BitVec 64 :=
    rs1_val >>> shamt

def SHIFTIOP_pure64_RISCV_SRAI (shamt : (BitVec 6)) (rs1_val : (BitVec 64)): BitVec 64 :=
    BitVec.sshiftRight' rs1_val  shamt

def RTYPEW_pure64_RISCV_ADDW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
      let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
      let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
      BitVec.signExtend 64 (BitVec.add rs1_val32 rs2_val32)

def RTYPEW_pure64_RISCV_SUBW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
      let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
      let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
      BitVec.signExtend 64 (BitVec.sub rs1_val32 rs2_val32)

def RTYPEW_pure64_RISCV_SLLW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
    let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
    let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
    let shamt := BitVec.extractLsb' 0 5 rs2_val32;
    BitVec.signExtend 64 (rs1_val32 <<< shamt)

def RTYPEW_pure64_RISCV_SRLW (rs2_val : BitVec 64) (rs1_val : BitVec 64)  : BitVec 64 :=
    let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
    let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
    let shamt := BitVec.extractLsb' 0 5 rs2_val32;
    BitVec.signExtend 64 (rs1_val32 >>> shamt)

def RTYPEW_pure64_RISCV_SRAW (rs2_val : (BitVec 64)) (rs1_val : (BitVec 64)) :=
  BitVec.signExtend 64
      (BitVec.sshiftRight' (BitVec.extractLsb 31 0 rs1_val) (BitVec.extractLsb 4 0 rs2_val))

def RTYPE_pure64_RISCV_ADD (rs2_val : BitVec 64) (rs1_val : BitVec 64) :BitVec 64 :=
      BitVec.add rs1_val rs2_val

def RTYPE_pure64_RISCV_SLT (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
    let b := BitVec.slt rs1_val rs2_val;
    BitVec.setWidth 64 (BitVec.ofBool b)

def RTYPE_pure64_RISCV_SLTU (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
    let b := BitVec.ult rs1_val rs2_val;
      BitVec.setWidth 64 (BitVec.ofBool b)

def RTYPE_pure64_RISCV_AND (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
      BitVec.and rs2_val rs1_val

def RTYPE_pure64_RISCV_OR(rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
      BitVec.or rs2_val rs1_val

def RTYPE_pure64_RISCV_XOR(rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
      BitVec.xor rs2_val rs1_val

def RTYPE_pure64_RISCV_SLL (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
       let shamt := (BitVec.extractLsb 5 0 rs2_val);
        rs1_val <<< shamt

def RTYPE_pure64_RISCV_SRL (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
      let shamt := (BitVec.extractLsb 5 0 rs2_val)
      rs1_val  >>> shamt

def RTYPE_pure64_RISCV_SUB (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.sub rs1_val rs2_val

def RTYPE_pure64_RISCV_SRA (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
    BitVec.sshiftRight' rs1_val  (BitVec.extractLsb 5 0 rs2_val)

/- wip : working on removing toNats and toInts in this definiton, therefore waiting for a
 bit vec lemma to be upstreamed. -/
def REMW_pure64_unsigned (rs2_val : BitVec 64) (rs1_val : BitVec 64): BitVec 64 :=
 BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt 33
        (if (rs2_val.toNat: Int) % ↑(2 ^ 32) = 0 then (rs1_val.toNat : Int) % ↑(2 ^ 32)
        else ((rs1_val.toNat: Int) % ↑(2 ^ 32)).tmod ((rs2_val.toNat : Int) % ↑(2 ^ 32)))))

def REMW_pure64_signed (rs2_val : (BitVec 64)) (rs1_val : (BitVec 64)) : BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt (33)
        (if (BitVec.extractLsb 31 0 rs2_val).toInt = 0 then (BitVec.extractLsb 31 0 rs1_val).toInt
        else (BitVec.extractLsb 31 0 rs1_val).toInt.tmod (BitVec.extractLsb 31 0 rs2_val).toInt)))

def REM_pure64_unsigned (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64  :=
  BitVec.extractLsb' 0 64
    (BitVec.ofInt (65) (if (rs2_val.toNat: Int) = 0 then (rs1_val.toNat: Int)  else ((rs1_val.toNat :Int)).tmod (rs2_val.toNat : Int)))

def REM_pure64_signed (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64  :=
    BitVec.extractLsb' 0 64
    (BitVec.ofInt (65) (if rs2_val.toInt = 0 then rs1_val.toInt else rs1_val.toInt.tmod rs2_val.toInt))

-- wip: getting rid of toInt and toNat
def MULW_pure64 (rs2_val : (BitVec 64)) (rs1_val : (BitVec 64)) : BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.extractLsb 31 0
      (BitVec.extractLsb' 0 64
        (BitVec.ofInt 65 ((BitVec.extractLsb 31 0 rs1_val).toInt * (BitVec.extractLsb 31 0 rs2_val).toInt))))

/-!
## mul operations flags
 the suffix indicates how the flags are assumed to be set.
{ high := _, signed_rs1:= _, signed_rs2 := _  }
-/

def  MUL_pure64_fff (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  rs2_val * rs1_val

def  MUL_pure64_fft (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 63 0
    (BitVec.extractLsb' 0 128
      (BitVec.ofInt 129 (Int.ofNat (Int.mul (Int.ofNat rs1_val.toNat)  (rs2_val.toInt)).toNat)))
--wip
def MUL_pure64_ftf (rs2_val : BitVec 64) (rs1_val : BitVec 64)  : BitVec 64 :=
  BitVec.extractLsb 63 0 (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (rs1_val.toInt * rs2_val.toNat)))

--wip
def MUL_pure64_tff (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 127 64 (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (rs1_val.toNat * rs2_val.toNat)))

-- wip
def MUL_pure64_tft (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
   BitVec.extractLsb 127 64 (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (rs1_val.toNat * rs2_val.toInt)))

-- wip
def MUL_pure64_ttf (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 127 64 (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (rs1_val.toInt * rs2_val.toNat)))

def MUL_pure64_ftt (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  rs2_val * rs1_val

-- wip
def MUL_pure64_ttt (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 127 64 (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (rs1_val.toInt * rs2_val.toInt)))

def DIVW_pure64_signed (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt 33
        (if
            2147483647 <
              if (BitVec.extractLsb 31 0 rs2_val).toInt = 0 then -1
              else (BitVec.extractLsb 31 0 rs1_val).toInt.tdiv (BitVec.extractLsb 31 0 rs2_val).toInt then
          -2147483648
        else
          if (BitVec.extractLsb 31 0 rs2_val).toInt = 0 then -1
          else (BitVec.extractLsb 31 0 rs1_val).toInt.tdiv (BitVec.extractLsb 31 0 rs2_val).toInt)))

-- wip: need to remove toInts and toNats
def  DIVW_pure64_unsigned (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
       BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt 33
        (if (rs2_val.toNat: Int)  % 4294967296 = 0 then -1
        else ((rs1_val.toNat : Int) % 4294967296).tdiv ((rs2_val.toNat : Int) % 4294967296))))

def DIV_pure64_signed (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  if rs2_val = 0#64 then
    -1#64
  else
    rs1_val.sdiv rs2_val

def DIV_pure64_unsigned (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  if rs2_val = 0#64 then
    (-1)
  else
    rs1_val.udiv rs2_val

def ITYPE_pure64_RISCV_ADDI (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
    let immext : BitVec 64 := (BitVec.signExtend 64 imm) ;
    BitVec.add rs1_val immext

def ITYPE_pure64_RISCV_SLTI (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
       let immext : BitVec 64 := (BitVec.signExtend 64 imm);
       let b := BitVec.slt rs1_val immext;
       BitVec.zeroExtend 64 (BitVec.ofBool b)

def ITYPE_pure64_RISCV_SLTIU (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
       let immext : BitVec 64 := (BitVec.signExtend 64 imm);
       let b := BitVec.ult rs1_val immext;
       BitVec.setWidth 64 (BitVec.ofBool b)

def  ITYPE_pure64_RISCV_ANDI (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
    let immext : BitVec 64 := (BitVec.signExtend 64 imm);
      BitVec.and rs1_val immext

def ITYPE_pure64_RISCV_ORI (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
      let immext : BitVec 64 := (BitVec.signExtend 64 imm) ;
      BitVec.or rs1_val immext

def  ITYPE_pure64_RISCV_XORI (imm : (BitVec 12)) (rs1_val : (BitVec 64)) : BitVec 64 :=
      let immext : BitVec 64 := (BitVec.signExtend 64 imm) ;
      BitVec.xor rs1_val immext

def ZICOND_RTYPE_pure64_RISCV_CZERO_EQZ (rs2_val : (BitVec 64)) (rs1_val : (BitVec 64)) :=
      (if rs2_val = BitVec.zero 64 then BitVec.zero 64 else rs1_val)

def ZICOND_RTYPE_pure64_RISCV_RISCV_CZERO_NEZ (rs2_val : (BitVec 64)) (rs1_val : (BitVec 64)) :=
   (if rs2_val = BitVec.zero 64 then rs1_val else BitVec.zero 64)

def ZBS_RTYPE_pure64_RISCV_BCLR (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.and rs1_val (BitVec.not ((BitVec.zeroExtend 64 1#1) <<< (BitVec.extractLsb  5 0 rs2_val)))

def ZBB_EXTOP_pure64_RISCV_SEXTB (rs1_val : BitVec 64) :=
  BitVec.signExtend 64 (BitVec.extractLsb 7 0 rs1_val)

def ZBB_EXTOP_pure64_RISCV_SEXTH  (rs1_val : BitVec 64) :=
  BitVec.signExtend 64 (BitVec.extractLsb 15 0 rs1_val)

def ZBB_EXTOP_pure64_RISCV_ZEXTH  (rs1_val : BitVec 64) :=
  BitVec.zeroExtend 64 (BitVec.extractLsb 15 0 rs1_val)

def ZBS_RTYPE_pure64_RISCV_BEXT (rs2_val : BitVec 64) (rs1_val : BitVec 64)  :=
  BitVec.setWidth 64
    (match
      BitVec.and rs1_val ( (BitVec.setWidth 64 1#1) <<< (BitVec.extractLsb 5 0 rs2_val)) !=
        0#64 with
    | true => 1#1
    | false => 0#1)

 def ZBS_RTYPE_pure64_BINV (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.xor rs1_val ((BitVec.zeroExtend 64 1#1) <<< (BitVec.extractLsb 5 0 rs2_val))

def ZBS_RTYPE_pure64_RISCV_BSET (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
    BitVec.or rs1_val ((BitVec.zeroExtend 64 1#1) <<< (BitVec.extractLsb 5 0 rs2_val))

def ZBS_IOP_pure64_RISCV_BCLRI (shamt : BitVec 6) (rs1_val : BitVec 64) :=
    BitVec.and rs1_val (BitVec.not ( (BitVec.setWidth 64 1#1) <<< shamt))

def ZBS_IOP_pure64_RISCV_BEXTI (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.setWidth 64
      (match (BitVec.and (rs1_val) ( (BitVec.setWidth 64 1#1) <<< shamt)) != 0#64 with
      | true => 1#1
      | false => 0#1)

def ZBS_IOP_pure64_RISCV_BINVI (shamt : BitVec 6) (rs1_val : BitVec 64) :=
    BitVec.xor rs1_val  ( (BitVec.zeroExtend 64 1#1) <<< shamt)

def ZBS_IOP_pure64_RISCV_BSETI (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.or rs1_val ( (BitVec.zeroExtend 64 1#1) <<< shamt)

-- wip: remove toNats
def ZBB_RTYPEW_pure64_RISCV_RORW (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.signExtend (64)
      (BitVec.or (BitVec.ushiftRight (BitVec.setWidth 32 rs1_val) (rs2_val.toNat % 32))
        (BitVec.shiftLeft (BitVec.setWidth 32 rs1_val)
          ((2 ^ 5 - rs2_val.toNat % 32 +
              32 % 2 ^ (5 + 1)) %
            2 ^ 5)))

-- wip: remove toNats
def ZBB_RTYPEW_pure64_RISCV_ROLW (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.signExtend 64
    (BitVec.or (BitVec.shiftLeft (BitVec.setWidth 32 rs1_val) (BitVec.extractLsb 4 0 rs2_val).toNat)
      (BitVec.ushiftRight (BitVec.setWidth 32 rs1_val) (
        ((BitVec.sub ((BitVec.extractLsb' 0 (5)
            (BitVec.ofInt (6)
              (32))))
          (BitVec.extractLsb 4 0 rs2_val)))).toNat))

 def ZBB_RTYPE_pure64_RISCV_ROL (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.or (BitVec.shiftLeft  rs1_val (BitVec.extractLsb 5 0 rs2_val).toNat)
    (rs1_val >>> (BitVec.extractLsb' 0 6 (64#7) - BitVec.extractLsb 5 0 rs2_val))

 def ZBB_RTYPE_pure64_RISCV_ROR (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.or ( rs1_val >>> (BitVec.extractLsb 5 0 rs2_val))
    ( rs1_val  <<<  ((BitVec.extractLsb' 0 6 (BitVec.ofInt (7) (64)) - BitVec.extractLsb 5 0 rs2_val)))

 def ZBA_RTYPEUW_pure64_RISCV_ADDUW (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.zeroExtend 64 (BitVec.extractLsb 31 0 rs1_val) <<< 0#2 + rs2_val

def  ZBA_RTYPEUW_pure64_RISCV_SH1ADDUW (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.add (BitVec.zeroExtend (64) (BitVec.extractLsb 31 0 rs1_val) <<< 1#2)  (rs2_val)

def ZBA_RTYPEUW_pure64_RISCV_SH2ADDUW (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.add (BitVec.zeroExtend (64) (BitVec.extractLsb 31 0 rs1_val) <<< 2#2) rs2_val

def  ZBA_RTYPEUW_pure64_RISCV_SH3ADDUW (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.add (BitVec.zeroExtend (64) (BitVec.extractLsb 31 0 rs1_val) <<< 3#2)  rs2_val

def ZBA_RTYPE_pure64_RISCV_SH1ADD (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.add (rs1_val <<< 1#2) rs2_val

def ZBA_RTYPE_pure64_RISCV_SH2ADD (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.add (rs1_val <<< 2#2) rs2_val

def ZBA_RTYPE_pure64_RISCV_SH3ADD(rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.add (rs1_val <<< 3#2) rs2_val

/-
to complete in the future:
extend with
ZBB_RYTPE_pure64_RISCV_
|pack
|packh
slli.uw
 -/

end RV64Semantics
