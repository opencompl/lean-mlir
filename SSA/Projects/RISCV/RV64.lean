import SSA.Core.MLIRSyntax.EDSL

set_option maxHeartbeats 1000000000000000000
namespace RV64

-- Bool for indicating the sign bit

-- trying to model the semanitcs we have proven using the SAIL modell
-- as the reference eexecution semantics

-- the semantics of my pure functions, semantic preservation proven in Lean
-- Question: is there a way to do it automatically because now I am just copying it over manually
structure mul_op where
  high : Bool
  signed_rs1 : Bool
  signed_rs2 : Bool
  deriving BEq, DecidableEq, Repr


namespace Int
  inductive Int : Type where
    /-- A natural number is an integer (`0` to `∞`). -/
    | ofNat   : Nat → Int
    /-- The negation of the successor of a natural number is an integer
      (`-1` to `-∞`). -/
    | negSucc : Nat → Int

end Int

def ADDIW_pure64 (imm : BitVec 12) (rs1_val : BitVec 64) :  BitVec 64 :=
     BitVec.signExtend 64 (BitVec.setWidth 32 (BitVec.add (BitVec.signExtend 64 imm) rs1_val))

-- loads immediate into upper 20 bits and then fills the rest up with 0 and returns it as the result
def UTYPE_pure64_lui (imm : BitVec 20) (pc : BitVec 64) : BitVec 64 :=
     BitVec.signExtend 64 (imm ++ (0x000 : (BitVec 12)))

-- loads immediate into upper 20 bits and then fills the rest up with 0 and returns, adds the program counter and then returns it as a result
def UTYPE_pure64_AUIPC (imm : BitVec 20) (pc : BitVec 64)  : BitVec 64 :=
    BitVec.add (BitVec.signExtend 64 (BitVec.append imm (0x000 : (BitVec 12)))) pc

def SHIFTIWOP_pure64_RISCV_SLLIW (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.signExtend 64 (BitVec.shiftLeft (BitVec.extractLsb' 0 32 rs1_val) (shamt).toNat)


-- logical rightshift, filled with zeros x/2^s rounding down
def SHIFTIWOP_pure64_RISCV_SRLIW (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.signExtend 64 (BitVec.ushiftRight (BitVec.extractLsb' 0 32 rs1_val) (shamt).toNat)


def SHIFTIWOP_pure64_RISCV_SRAIW (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64
    :=
    BitVec.signExtend 64
      (BitVec.setWidth 32
       (BitVec.extractLsb
         (31 + shamt.toNat)
          shamt.toNat
          (BitVec.signExtend ((32) + shamt.toNat) (BitVec.extractLsb 31 0 rs1_val))
        )
      )

def SHIFTIOP_pure64_RISCV_SLLI (shamt : BitVec 6) (rs1_val : BitVec 64)  : BitVec 64
    := BitVec.shiftLeft rs1_val shamt.toNat

def SHIFTIOP_pure64_RISCV_SRLI (shamt : BitVec 6) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.ushiftRight rs1_val shamt.toNat

-- here I didnt specify a return type bc it depends
def SHIFTIOP_pure64_RISCV_SRAI (shamt : (BitVec 6)) (rs1_val : (BitVec 64)): BitVec 64 :=
    let value := rs1_val ;
    let shift := shamt.toNat;
    BitVec.setWidth 64 (BitVec.extractLsb (63 + shift) shift (BitVec.signExtend (64 + shift) value)) -- had to this to tell lean how to hanlde the type
   -- (BitVec.extractLsb (63 + shift)  shift  (BitVec.signExtend ((64 + shift)) value) : BitVec 64)

-- simple integer operations on 32-bit word and then sign extend result to 64 bits
def RTYPEW_pure64_RISCV_ADDW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
      let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
      let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
      BitVec.signExtend 64 (BitVec.add rs1_val32 rs2_val32)

def RTYPEW_pure64_RISCV_SUBW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
      let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
      let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
      BitVec.signExtend 64 (BitVec.sub rs1_val32 rs2_val32)

-- can be all done by rfl
def RTYPEW_pure64_RISCV_SLLW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
    let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
    let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
    let shamt := BitVec.extractLsb' 0 5 rs2_val32;
    BitVec.signExtend 64 (BitVec.shiftLeft rs1_val32 shamt.toNat)

-- can be all done by rfl
def RTYPEW_pure64_RISCV_SRLW (rs2_val : BitVec 64) (rs1_val : BitVec 64)  : BitVec 64 :=
    let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
    let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
    let shamt := BitVec.extractLsb' 0 5 rs2_val32;
    BitVec.signExtend 64 (BitVec.ushiftRight rs1_val32 shamt.toNat)

def RTYPEW_pure64_RISCV_SRAW (rs2_val : (BitVec 64)) (rs1_val : (BitVec 64)) :=
BitVec.signExtend 64
           (BitVec.setWidth 32
              (BitVec.extractLsb
                 (31 + rs2_val.toNat % 4294967296 % 32)
                     (rs2_val.toNat % 4294967296 % 32)
                          (BitVec.signExtend (32 + rs2_val.toNat % 4294967296 % 32)
                              (BitVec.extractLsb 31 0 rs1_val))))


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
       let shamt := (BitVec.extractLsb 5 0 rs2_val).toNat;
       BitVec.shiftLeft rs1_val shamt

def RTYPE_pure64_RISCV_SRL (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
      let shamt := (BitVec.extractLsb 5 0 rs2_val).toNat;
      BitVec.ushiftRight rs1_val shamt

def RTYPE_pure64_RISCV_SUB (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.sub rs1_val rs2_val

def RTYPE_pure64_RISCV_SRA (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
BitVec.setWidth 64
      (BitVec.extractLsb
        (63 + (BitVec.extractLsb 5 0 rs2_val).toNat)
        (BitVec.extractLsb 5 0 rs2_val).toNat
        (BitVec.signExtend
          (64 + (BitVec.extractLsb 5 0 rs2_val).toNat) rs1_val))


def REMW_pure64_unsigned (rs2_val : BitVec 64) (rs1_val : BitVec 64): BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt 33
        (Int.ofNat
          (if Int.ofNat (BitVec.extractLsb 31 0 rs2_val).toNat = 0 then Int.ofNat (BitVec.extractLsb 31 0 rs1_val).toNat
            else
              (Int.ofNat (BitVec.extractLsb 31 0 rs1_val).toNat).tmod
                (Int.ofNat (BitVec.extractLsb 31 0 rs2_val).toNat)).toNat)))

def REMW_pure64_signed (rs2_val : (BitVec 64)) (rs1_val : (BitVec 64)) : BitVec 64 :=
    BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt 33
        (Int.ofNat
          (if (BitVec.extractLsb 31 0 rs2_val).toInt = 0 then (BitVec.extractLsb 31 0 rs1_val).toInt
            else (BitVec.extractLsb 31 0 rs1_val).toInt.tmod (BitVec.extractLsb 31 0 rs2_val).toInt).toNat)))

--    PureFunctions.execute_REM_pure64 (False) rs2_val rs1_val  important to set sign bit to false
def REM_pure64_unsigned (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64  :=
   BitVec.extractLsb' 0 64
    (BitVec.ofInt 65
      (Int.ofNat
        (if Int.ofNat rs2_val.toNat = 0 then Int.ofNat rs1_val.toNat
          else (Int.ofNat rs1_val.toNat).tmod (Int.ofNat rs2_val.toNat)).toNat))


def REM_pure64_signed (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64  :=
    BitVec.extractLsb' 0 64
    (BitVec.ofInt 65
      (Int.ofNat (if rs2_val.toInt = 0 then rs1_val.toInt else rs1_val.toInt.tmod rs2_val.toInt).toNat))


def MULW_pure64 (rs2_val : (BitVec 64)) (rs1_val : (BitVec 64)) : BitVec 64 :=
    BitVec.signExtend 64
    (BitVec.extractLsb 31 0
      (BitVec.extractLsb' 0 64
        (BitVec.ofInt 65
          ((BitVec.extractLsb 31 0 rs1_val).toInt * (BitVec.extractLsb 31 0 rs2_val).toInt).toNat)))

def MUL_pure64_fff (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
     BitVec.extractLsb 63 0
        (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (max (Int.mul (Int.ofNat rs1_val.toNat) (Int.ofNat rs2_val.toNat)) 0)))


def  MUL_pure64_fft (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 63 0
    (BitVec.extractLsb' 0 128
      (BitVec.ofInt 129 (Int.ofNat (Int.mul (Int.ofNat rs1_val.toNat)  (rs2_val.toInt)).toNat)))

#check BitVec.ofInt
#check (Int.ofNat (Int.mul (BitVec.toInt 0#64) (Int.ofNat (BitVec.toNat 0#64))).toNat)

def MUL_pure64_ftf (rs2_val : BitVec 64) (rs1_val : BitVec 64)  : BitVec 64 :=
    BitVec.extractLsb 63 0
      (BitVec.extractLsb' 0 128
        (BitVec.ofInt 129
        (Int.ofNat (Int.mul (BitVec.toInt rs1_val) (Int.ofNat (BitVec.toNat rs2_val))).toNat)))

def MUL_pure64_tff (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.extractLsb 127 64
      (BitVec.extractLsb' 0 128
        (BitVec.ofInt 129 (Int.ofNat (Int.mul (Int.ofNat rs1_val.toNat) (Int.ofNat rs2_val.toNat)).toNat)))


def MUL_pure64_tft (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.extractLsb 127 64
    (BitVec.extractLsb' 0 128
      (BitVec.ofInt 129 (Int.ofNat (Int.mul (Int.ofNat rs1_val.toNat) rs2_val.toInt).toNat)))


def MUL_pure64_ttf (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 127 64
    (BitVec.extractLsb' 0 128
      (BitVec.ofInt 129 (Int.ofNat (Int.mul rs1_val.toInt (Int.ofNat rs2_val.toNat)).toNat)))

def MUL_pure64_ftt (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 63 0
    (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (Int.ofNat (Int.mul rs1_val.toInt rs2_val.toInt).toNat)))

def MUL_pure64_ttt (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 127 64
    (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (Int.ofNat (Int.mul rs1_val.toInt rs2_val.toInt).toNat)))

def DIVW_pure64_signed (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt 33
        (max
          (if
              2147483647 <
                if (BitVec.extractLsb 31 0 rs2_val).toInt = 0 then -1
                else (BitVec.extractLsb 31 0 rs1_val).toInt.tdiv (BitVec.extractLsb 31 0 rs2_val).toInt then
            -2147483648
          else
            if (BitVec.extractLsb 31 0 rs2_val).toInt = 0 then -1
            else (BitVec.extractLsb 31 0 rs1_val).toInt.tdiv (BitVec.extractLsb 31 0 rs2_val).toInt)
          0)))

def  DIVW_pure64_unsigned (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt 33
        (Int.ofNat
          (if Int.ofNat (BitVec.extractLsb 31 0 rs2_val).toNat = 0 then -1
            else
              (Int.ofNat (BitVec.extractLsb 31 0 rs1_val).toNat).tdiv
                (Int.ofNat (BitVec.extractLsb 31 0 rs2_val).toNat)).toNat)))

def DIV_pure64_signed (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt 33
        (max
          (if
              2147483647 <
                if (BitVec.extractLsb 31 0 rs2_val).toInt = 0 then -1
                else (BitVec.extractLsb 31 0 rs1_val).toInt.tdiv (BitVec.extractLsb 31 0 rs2_val).toInt then
            -2147483648
          else
            if (BitVec.extractLsb 31 0 rs2_val).toInt = 0 then -1
            else (BitVec.extractLsb 31 0 rs1_val).toInt.tdiv (BitVec.extractLsb 31 0 rs2_val).toInt)
          0)))

def DIV_pure64_unsigned (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt 33
        (Int.ofNat
          (if Int.ofNat (BitVec.extractLsb 31 0 rs2_val).toNat = 0 then -1
            else
              (Int.ofNat (BitVec.extractLsb 31 0 rs1_val).toNat).tdiv
                (Int.ofNat (BitVec.extractLsb 31 0 rs2_val).toNat)).toNat)))

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
  BitVec.and rs1_val (BitVec.not (BitVec.shiftLeft (BitVec.zeroExtend 64 1#1) (BitVec.extractLsb  5 0 rs2_val).toNat))


def ZBB_EXTOP_pure64_RISCV_SEXTB (rs1_val : BitVec 64) :=
  BitVec.signExtend 64 (BitVec.extractLsb 7 0 rs1_val)

def ZBB_EXTOP_pure64_RISCV_SEXTH  (rs1_val : BitVec 64) :=
  BitVec.signExtend 64 (BitVec.extractLsb 15 0 rs1_val)

def ZBB_EXTOP_pure64_RISCV_ZEXTH  (rs1_val : BitVec 64) :=
  BitVec.zeroExtend 64 (BitVec.extractLsb 15 0 rs1_val)

def ZBS_RTYPE_pure64_RISCV_BEXT (rs2_val : BitVec 64) (rs1_val : BitVec 64)  :=
  BitVec.setWidth 64
    (match
      BitVec.and rs1_val (BitVec.shiftLeft (BitVec.setWidth 64 1#1) (BitVec.extractLsb 5 0 rs2_val).toNat) !=
        0#64 with
    | true => 1#1
    | false => 0#1)

 def ZBS_RTYPE_pure64_BINV (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.xor rs1_val  (BitVec.shiftLeft (BitVec.zeroExtend 64 1#1) (BitVec.extractLsb 5 0 rs2_val).toNat)

def ZBS_RTYPE_pure64_RISCV_BSET (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.or rs1_val (BitVec.shiftLeft (BitVec.zeroExtend 64 1#1) (BitVec.extractLsb 5 0 rs2_val).toNat)

def ZBS_IOP_pure64_RISCV_BCLRI (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.and rs1_val (BitVec.not (BitVec.shiftLeft (BitVec.setWidth 64 1#1) (shamt.toNat)))

def ZBS_IOP_pure64_RISCV_BEXTI (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.setWidth 64
      (match (BitVec.and (rs1_val) (BitVec.shiftLeft (BitVec.setWidth 64 1#1) shamt.toNat)) != 0#64 with
      | true => 1#1
      | false => 0#1)

def ZBS_IOP_pure64_RISCV_BINVI (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.xor rs1_val  (BitVec.shiftLeft (BitVec.zeroExtend 64 1#1) shamt.toNat)

def ZBS_IOP_pure64_RISCV_BSETI (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.or rs1_val (BitVec.shiftLeft (BitVec.zeroExtend 64 1#1) shamt.toNat)

def ZBB_RTYPEW_pure64_RISCV_RORW (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.signExtend (64)
      (BitVec.or (BitVec.ushiftRight (BitVec.setWidth 32 rs1_val) (rs2_val.toNat % 32))
        (BitVec.shiftLeft (BitVec.setWidth 32 rs1_val)
          ((2 ^ 5 - rs2_val.toNat % 32 +
              32 % 2 ^ (5 + 1)) %
            2 ^ 5)))

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
    (BitVec.ushiftRight rs1_val  (BitVec.extractLsb' 0 6 (BitVec.ofInt (7) (64)) - BitVec.extractLsb 5 0 rs2_val).toNat)

 def ZBB_RTYPE_pure64_RISCV_ROR (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
      BitVec.or (BitVec.ushiftRight rs1_val (BitVec.extractLsb 5 0 rs2_val).toNat)
    (BitVec.shiftLeft rs1_val ((BitVec.extractLsb' 0 6 (BitVec.ofInt (7) (64)) - BitVec.extractLsb 5 0 rs2_val)).toNat)


def const_func (val : BitVec 64) := val
/-



-/

/-
|binv
|bset
|bclri
|bexti
|binvi
|bseti


|sext.b
|sext.h
|zext.h
|rolw
|rorw




-/

end RV64
--finished defining the semantics

namespace toRISCV
-- describing the mapping from MLIR syntax to the Comb semantics

section Dialect

--defining operations of my dialect
--encoding the operations such that my input arguements are only the registers
inductive Op
|const (val: BitVec 64)
|addiw (imm : BitVec 12) --not sure if I should encode immediates but I dont think so
|lui (imm : BitVec 20)
|auipc (imm : BitVec 20)
|slliw (shamt : BitVec 5)
|srliw (shamt : BitVec 5)
|sraiw (shamt : BitVec 5)
|slli (shamt : BitVec 6)
|srli (shamt : BitVec 6)
|srai (shamt : BitVec 6)
|addw
|subw
|sllw
|srlw
|sraw
|add
|slt
|sltu
|and
|or
|xor
|sll
|srl
|sub
|sra
|remw
|rem
|mul
|mulu
|mulw
|mulh
|mulhu
|mulhsu
|divu
|rol
|ror
|remwu
|remu
 --the sign or unsigned when calling the function -> pattern match on to mul op to get the correct cases
|divw
|divwu
|div
|addi (imm : BitVec 12)
|slti (imm : BitVec 12)
|sltiu (imm : BitVec 12)
|andi (imm : BitVec 12)
|ori (imm : BitVec 12)
|xori (imm : BitVec 12)
|czero.eqz
|czero.nez
|bclr
|bext
|binv
|bset
|bclri (shamt : BitVec 6)
|bexti (shamt : BitVec 6)
|binvi (shamt : BitVec 6)
|bseti (shamt : BitVec 6)
|sext.b
|sext.h
|zext.h
|rolw
|rorw
/-
|pack
|packh
-- TO DO zbb_rytpe full
|add.uw
|sh1add.uw
|sh2add.uw
|sh3add.uw
|sh1add
|sh2add
|sh3add -/
deriving Inhabited, DecidableEq, Repr --ASK: DecidableEq, Repr --to be able to print as string, cmp and have default value

--defining the MLIR types
inductive Ty -- here belongs what my operations operate on
  | bv : Ty
  -- maybe add more in the future
  deriving Inhabited, DecidableEq, Repr

-- connecting the MLIR operations and types to their semantics

--def HVector.denote : {d : Dialect} → TyDenote (Dialect.Ty d) → ...
-- TyDenote (Dialect.Ty d) give me the way to interpret the types into actual semantics and Ty is the type of types in the lanugae
-- how Lean should interpet these types of dialects d
open TyDenote (toType) in
instance RV64TyDenote : TyDenote Ty where
toType := fun
| Ty.bv => BitVec 64


abbrev RV64 : Dialect where
  Op := Op -- define the avaiable operations
  Ty := Ty -- define the avaiable types

open TyDenote (toType)

@[simp, reducible]
def Op.sig : Op → List Ty -- did the signature accroding to the execution functions above
  |.const (val : BitVec 64) =>  []
  |.mulu  => [Ty.bv, Ty.bv]
  |mulh  => [Ty.bv, Ty.bv]
  |mulhu  => [Ty.bv, Ty.bv]
  |mulhsu  => [Ty.bv, Ty.bv]
  |divu =>  [Ty.bv, Ty.bv]
  |rol => [Ty.bv, Ty.bv]
  |ror => [Ty.bv, Ty.bv]
  |.remwu  => [Ty.bv, Ty.bv] -- to indicate if signed or not
  |.remu  =>  [Ty.bv, Ty.bv]

  |.addiw (imm : BitVec 12) => [Ty.bv] -- specifying the input argument types
  |.lui (imm : BitVec 20) => [Ty.bv] -- Ty.bv 20 as the immediate
  |.auipc (imm : BitVec 20)  => [Ty.bv] --Ty.bv 20,as the immediate
  |.slliw (shamt : BitVec 5)  => [Ty.bv] --Ty.bv 5 shift amount
  |.srliw (shamt : BitVec 5) => [Ty.bv] -- Ty.bv 5,
  |.sraiw (shamt : BitVec 5) => [Ty.bv] --Ty.bv 5,
  |.slli (shamt : BitVec 6) => [Ty.bv] --Ty.bv 6
  |.srli (shamt : BitVec 6) => [Ty.bv] --Ty.bv 6,
  |srai (shamt : BitVec 6) => [Ty.bv]
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
  |.remw  => [Ty.bv, Ty.bv] -- to indicate if signed or not
  |.rem  =>  [Ty.bv, Ty.bv]
  |.mul => [Ty.bv, Ty.bv]
  |.mulw => [Ty.bv, Ty.bv]
  |.div  =>  [Ty.bv, Ty.bv]
  |.divw  =>  [Ty.bv, Ty.bv]
  |.divwu  =>  [Ty.bv, Ty.bv]
  |.addi (imm : BitVec 12) => [Ty.bv]
  |.slti (imm : BitVec 12) => [Ty.bv]
  |.sltiu (imm : BitVec 12) => [Ty.bv]
  |.andi (imm : BitVec 12) => [Ty.bv]
  |.ori (imm : BitVec 12) => [Ty.bv]
  |.xori (imm : BitVec 12) => [Ty.bv]
  |.czero.eqz =>  [Ty.bv, Ty.bv]
  |.czero.nez =>  [Ty.bv, Ty.bv]
  |.sext.b => [Ty.bv]
  |.sext.h => [Ty.bv]
  |.zext.h => [Ty.bv]
  |bclr => [Ty.bv, Ty.bv]
  |bext => [Ty.bv, Ty.bv]
  |binv => [Ty.bv, Ty.bv]
  |bset  => [Ty.bv, Ty.bv]
  |bclri (shamt : BitVec 6) => [Ty.bv]
  |bexti (shamt : BitVec 6) => [Ty.bv]
  |binvi (shamt : BitVec 6) => [Ty.bv]
  |bseti (shamt : BitVec 6) => [Ty.bv]
  |rolw => [Ty.bv, Ty.bv]
  |rorw => [Ty.bv, Ty.bv]

@[simp, reducible] -- reduceable means this expression can always be expanded by the type checker when type checking
def Op.outTy : Op  → Ty --- dervied from the ouput of the execution function
  |.const (val: BitVec 64) => Ty.bv
  |.mulu  => Ty.bv
  |.mulh  => Ty.bv
  |.mulhu  => Ty.bv
  |.mulhsu  => Ty.bv
  |.divu =>  Ty.bv
  |.rol => Ty.bv
  |.ror => Ty.bv
  |.remwu  => Ty.bv-- to indicate if signed or not
  |.remu  =>  Ty.bv
  |.addiw (imm : BitVec 12) => Ty.bv -- specifying the input argument types
  |.lui (imm : BitVec 20) => Ty.bv
  |.auipc (imm : BitVec 20) => Ty.bv
  |.slliw (shamt : BitVec 5) => Ty.bv
  |.srliw (shamt : BitVec 5) => Ty.bv
  |.sraiw (shamt : BitVec 5) => Ty.bv
  |.slli (shamt : BitVec 6) => Ty.bv
  |.srli (shamt : BitVec 6) => Ty.bv
  |srai (shamt : BitVec 6) => Ty.bv
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
  |.remw  => Ty.bv-- to indicate if signed or not
  |.rem =>  Ty.bv
  |.mul => Ty.bv
  |.mulw => Ty.bv
  |.div=>  Ty.bv
  |.divw  =>  Ty.bv
  |.divwu  =>  Ty.bv
  |.addi (imm : BitVec 12) => Ty.bv
  |.slti (imm : BitVec 12) => Ty.bv
  |.sltiu (imm : BitVec 12) => Ty.bv
  |.andi (imm : BitVec 12) => Ty.bv
  |.ori (imm : BitVec 12) => Ty.bv
  |.xori (imm : BitVec 12) => Ty.bv
  |.czero.eqz =>   Ty.bv
  |.czero.nez =>  Ty.bv
  |.sext.b => Ty.bv
  |.sext.h => Ty.bv
  |.zext.h => Ty.bv
  |bclr => Ty.bv
  |bext => Ty.bv
  |binv => Ty.bv
  |bset  => Ty.bv
  |bclri (shamt : BitVec 6) => Ty.bv
  |bexti (shamt : BitVec 6) => Ty.bv
  |binvi (shamt : BitVec 6) => Ty.bv
  |bseti (shamt : BitVec 6) => Ty.bv
  |rolw => Ty.bv
  |rorw => Ty.bv
/---def ADDIW_pure64_BitVec (imm : BitVec 12) (rs1_val : BitVec 64) :  BitVec 64 :=
     --BitVec.signExtend 64 (BitVec.setWidth 32 (BitVec.add (BitVec.signExtend 64 imm) rs1_val))-/



--ASK what exatlcy does this ? does it just create an Op signature ?
@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []} --ASK what is meant by regSig ?

-- signsture requeired by the DialectSignature typeclass is provided via <Op.signature>
instance : DialectSignature RV64 := ⟨Op.signature⟩



-- I assume the layout is add (then all the args in the op code) (then args in the signature) ret_val
@[simp]
instance : DialectDenote (RV64) where
  denote
  |.const val,_,  _  => RV64.const_func val
  |.addiw imm, regs, _   => RV64.ADDIW_pure64 imm (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  |.lui imm,  regs , _   => RV64.UTYPE_pure64_lui imm (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  |.auipc imm, regs, _  => RV64.UTYPE_pure64_AUIPC imm (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  |.slliw shamt, regs, _  => RV64.SHIFTIWOP_pure64_RISCV_SLLIW shamt (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  |.srliw shamt, regs, _  => RV64.SHIFTIWOP_pure64_RISCV_SRLIW shamt (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  |.sraiw shamt, regs, _  => RV64.SHIFTIWOP_pure64_RISCV_SRAIW shamt (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  |.slli shamt, regs, _  => RV64.SHIFTIOP_pure64_RISCV_SLLI shamt (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  |.srli shamt, regs, _  => RV64.SHIFTIOP_pure64_RISCV_SRLI shamt (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  |.srai shamt, regs, _  => RV64.SHIFTIOP_pure64_RISCV_SRAI shamt  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
  |.addw, regs, _  =>  RV64.RTYPEW_pure64_RISCV_ADDW (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.subw, regs, _  => RV64.RTYPEW_pure64_RISCV_SUBW (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.sllw, regs, _  => RV64.RTYPEW_pure64_RISCV_SLLW (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.srlw, regs, _  => RV64.RTYPEW_pure64_RISCV_SRLW (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.sraw, regs, _ => RV64.RTYPEW_pure64_RISCV_SRAW (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.add, regs, _ => RV64.RTYPE_pure64_RISCV_ADD (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.slt, regs, _ => RV64.RTYPE_pure64_RISCV_SLT (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.sltu, regs, _ => RV64.RTYPE_pure64_RISCV_SLTU (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.and, regs, _ => RV64.RTYPE_pure64_RISCV_AND (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.or, regs, _ => RV64.RTYPE_pure64_RISCV_OR (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.xor, regs, _ => RV64.RTYPE_pure64_RISCV_XOR (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.sll, regs, _ => RV64.RTYPE_pure64_RISCV_SLL (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.srl, regs, _ => RV64.RTYPE_pure64_RISCV_SRL (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.sub, regs, _  => RV64.RTYPE_pure64_RISCV_SUB (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.sra, regs, _  => RV64.RTYPE_pure64_RISCV_SRA (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.remw, regs, _  => RV64.REMW_pure64_signed (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))-- double-check
  |.remwu, regs, _  => RV64.REMW_pure64_unsigned (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))-- double-check
  |.rem, regs, _  =>  RV64.REM_pure64_signed (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.remu, regs, _ =>  RV64.REM_pure64_unsigned (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.mulu, regs, _ => RV64.MUL_pure64_fff (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature])) -- double check
  --|.mul false false true , regs, _ => RV64.MUL_pure64_fft (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  --|.mul  false true false , regs, _ => RV64.MUL_pure64_ftf (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.mulhu,regs, _ => RV64.MUL_pure64_tff (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.mul ,regs, _ => RV64.MUL_pure64_ftt (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  --|.mul  true false true,regs, _ => RV64.MUL_pure64_tft (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.mulhsu ,regs, _ => RV64.MUL_pure64_ttf (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.mulh,regs, _ => RV64.MUL_pure64_ttt (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.mulw,  regs, _ => RV64.MULW_pure64 (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature])) -- double check
  |.div, regs, _  =>  RV64.DIV_pure64_signed (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.divu,  regs, _ =>  RV64.DIV_pure64_unsigned (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.divw, regs, _  =>  RV64.DIVW_pure64_signed (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.divwu, regs, _ =>  RV64.DIVW_pure64_unsigned (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.addi imm, reg, _  => RV64.ITYPE_pure64_RISCV_ADDI  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.slti imm, reg, _  => RV64.ITYPE_pure64_RISCV_SLTI  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.sltiu imm, reg, _ => RV64.ITYPE_pure64_RISCV_SLTIU  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.andi imm, reg, _=> RV64.ITYPE_pure64_RISCV_ANDI  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.ori imm, reg, _ => RV64.ITYPE_pure64_RISCV_ORI  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.xori imm, reg, _=> RV64.ITYPE_pure64_RISCV_XORI  imm (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.czero.eqz, regs, _ =>  RV64.ZICOND_RTYPE_pure64_RISCV_CZERO_EQZ (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.czero.nez, regs, _ => RV64.ZICOND_RTYPE_pure64_RISCV_RISCV_CZERO_NEZ (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.sext.b, reg, _ => RV64.ZBB_EXTOP_pure64_RISCV_SEXTB (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.sext.h, reg, _ => RV64.ZBB_EXTOP_pure64_RISCV_SEXTH (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.zext.h, reg, _ => RV64.ZBB_EXTOP_pure64_RISCV_ZEXTH (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.bclr, regs, _  => RV64.ZBS_RTYPE_pure64_RISCV_BCLR (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.bext, regs, _  => RV64.ZBS_RTYPE_pure64_RISCV_BEXT (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.binv, regs, _  => RV64.ZBS_RTYPE_pure64_BINV (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.bset, regs, _   => RV64.ZBS_RTYPE_pure64_RISCV_BSET (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.bclri shamt , reg, _  => RV64.ZBS_IOP_pure64_RISCV_BCLRI (shamt) (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.bexti shamt, reg, _  => RV64.ZBS_IOP_pure64_RISCV_BEXTI (shamt) (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.binvi shamt, reg, _ => RV64.ZBS_IOP_pure64_RISCV_BINVI (shamt) (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.bseti shamt, reg, _ => RV64.ZBS_IOP_pure64_RISCV_BSETI (shamt) (reg.getN 0 (by simp [DialectSignature.sig, signature]))
  |.rolw, regs, _ => RV64.ZBB_RTYPEW_pure64_RISCV_ROLW (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.rorw, regs, _ => RV64.ZBB_RTYPEW_pure64_RISCV_RORW (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.rol, regs, _ => RV64.ZBB_RTYPE_pure64_RISCV_ROL (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.ror, regs, _ => RV64.ZBB_RTYPE_pure64_RISCV_ROR (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
end Dialect

/-
  |.sra, regs, _  => RV64.RTYPE_pure64_RISCV_SRA (regs.getN 0 (by simp [DialectSignature.sig, signature]))  (regs.getN 1 (by simp [DialectSignature.sig, signature]))
  |.srai shamt, regs, _  => RV64.SHIFTIOP_pure64_RISCV_SRAI shamt  (regs.getN 0 (by simp [DialectSignature.sig, signature]))
-/
-- string representation of MLIR type into corresponding RISCV type
def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM RV64 RV64.Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s with
    | "i64" => return .bv
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

--#eval mkTy (MLIR.AST.MLIRType.undefined "BitVec_64")

instance instTransformTy : MLIR.AST.TransformTy RV64 0 where
  mkTy := mkTy

#check Expr.mk
#check mkTy

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
  MLIR.AST.ReaderM (RV64) (Σ eff ty, Expr (RV64) Γ eff ty) := do
    match opStx.args with
    | []  => do
        let some att := opStx.attrs.getAttr "val"
          | throw <| .unsupportedOp s!"no attirbute in const {repr opStx}"
        match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .const (BitVec.ofInt 64 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
    | v₁Stx::[] =>
       let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        match ty₁, opStx.name with
        | .bv, "RV64.srai" => do
          let some att := opStx.attrs.getAttr "shamt"
             | throw <| .unsupportedOp s!"no attirbute in srai {repr opStx}"
          match att with
          | .int val ty => -- ides modell it as a list of 3 bools
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .srai (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.bclri" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in bclri {repr opStx}"
          match att with
          | .int val ty => -- ides modell it as a list of 3 bools
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .bclri (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.bexti" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in bexti {repr opStx}"
          match att with
          | .int val ty => -- ides modell it as a list of 3 bools
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .bexti (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.bseti" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in bseti {repr opStx}"
          match att with
          | .int val ty => -- ides modell it as a list of 3 bools
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .bseti (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.binvi" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in binvi {repr opStx}"
          match att with
          | .int val ty => -- ides modell it as a list of 3 bools
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .binvi (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.addiw" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in addiw {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .addiw (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
             -- .cons v₁ ::ₕ .nil,-- ask for what is this
              .nil --
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.lui" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in lui {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .lui (BitVec.ofInt 20 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
             -- .cons v₁ ::ₕ .nil,-- ask for what is this
              .nil --
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.auipc" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in auipc {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .auipc (BitVec.ofInt 20 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.slliw" => do
          let some att := opStx.attrs.getAttr "shamt"
            | throw <| .unsupportedOp s!"no attirbute in slliw {repr opStx}"
          match att with
          | .int val ty => -- ides modell it as a list of 3 bools
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .slliw (BitVec.ofInt 5 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.srliw" => do
          let some att := opStx.attrs.getAttr "shamt"
            | throw <| .unsupportedOp s!"no attirbute in slliw {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .srliw (BitVec.ofInt 5 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.sraiw" => do
          let some att := opStx.attrs.getAttr "shamt"
            | throw <| .unsupportedOp s!"no attirbute in sraiw {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .sraiw (BitVec.ofInt 5 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.slli" => do
          let some att := opStx.attrs.getAttr "shamt"
            | throw <| .unsupportedOp s!"no attirbute in slli{repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .slli (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.srli" => do
          let some att := opStx.attrs.getAttr "shamt"
            | throw <| .unsupportedOp s!"no attirbute in srli {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .srli (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.addi" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in addi {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .addi (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
             -- .cons v₁ ::ₕ .nil,-- ask for what is this
              .nil --
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.slti" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in slti {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .slti (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
             -- .cons v₁ ::ₕ .nil,-- ask for what is this
              .nil --
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.sltiu" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in sltiu {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .sltiu (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
             -- .cons v₁ ::ₕ .nil,-- ask for what is this
              .nil --
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.andi" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in andi {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .andi (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
             -- .cons v₁ ::ₕ .nil,-- ask for what is this
              .nil --
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.ori" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in ori {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .ori (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
             -- .cons v₁ ::ₕ .nil,-- ask for what is this
              .nil --
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.xori" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attirbute in ori {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty -- ty.mkTy
            return ⟨.pure, opTy, ⟨
              .xori (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
             -- .cons v₁ ::ₕ .nil,-- ask for what is this
              .nil --
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "RV64.sext.b" =>
            return ⟨ .pure, .bv ,⟨ .sext.b, by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
        | .bv, "RV64.sext.h" =>
            return ⟨ .pure, .bv ,⟨ .sext.h, by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
        | .bv, "RV64.zext.h" =>
            return ⟨ .pure, .bv ,⟨ .zext.h, by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
        |_ , _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
    | v₁Stx::v₂Stx:: [] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
        match ty₁, ty₂, opStx.name with
        | .bv, .bv, "RV64.rem" =>
          return ⟨.pure, .bv ,⟨ .rem, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv, .bv, "RV64.ror" =>
          return ⟨.pure, .bv ,⟨ .ror, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv, .bv, "RV64.rol" =>
          return ⟨.pure, .bv ,⟨ .rol, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv, .bv, "RV64.remu" =>
          return ⟨.pure, .bv ,⟨ .remu, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv, .bv, "RV64.sra" =>
          return ⟨.pure, .bv ,⟨ .sra, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv, .bv, "RV64.addw" =>
          return ⟨.pure, .bv ,⟨ .addw, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv , .bv , "RV64.subw" =>
              return ⟨ .pure, .bv ,⟨ .subw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.sllw" =>
              return ⟨ .pure, .bv ,⟨ .sllw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.srlw" =>
              return ⟨ .pure, .bv ,⟨ .srlw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.sraw" =>
              return ⟨ .pure, .bv ,⟨ .sraw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.add" =>
              return ⟨ .pure, .bv ,⟨ .add, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.or" =>
              return ⟨ .pure, .bv ,⟨ .or, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.xor" =>
              return ⟨ .pure, .bv ,⟨ .xor, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.sll" =>
              return ⟨ .pure, .bv ,⟨ .sll, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.srl" =>
              return ⟨ .pure, .bv ,⟨ .srl, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.sub" =>
              return ⟨ .pure, .bv ,⟨ .sub, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.slt" =>
              return ⟨ .pure, .bv ,⟨ .slt, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.sltu" =>
              return ⟨ .pure, .bv ,⟨ .sltu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.and" =>
              return ⟨ .pure, .bv ,⟨ .and, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.czero.eqz" =>
              return ⟨ .pure, .bv ,⟨ .czero.eqz, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.czero.nez" =>
              return ⟨ .pure, .bv ,⟨ .czero.nez, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.bclr" =>
              return ⟨ .pure, .bv ,⟨ .bclr, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.bext" =>
              return ⟨ .pure, .bv ,⟨ .bext, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.binv" =>
              return ⟨ .pure, .bv ,⟨ .binv, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.bset" =>
              return ⟨ .pure, .bv ,⟨ .bset, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.rolw" =>
              return ⟨ .pure, .bv ,⟨ .rolw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.rorw" =>
              return ⟨ .pure, .bv ,⟨ .rorw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.mul" =>
            return ⟨ .pure, .bv ,⟨ .mul, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.mulu" =>
            return ⟨ .pure, .bv ,⟨ .mulu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.mulh" =>
            return ⟨ .pure, .bv ,⟨ .mulh, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.mulhu" =>
            return ⟨ .pure, .bv ,⟨ .mulhu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "RV64.mulhsu" =>
            return ⟨ .pure, .bv ,⟨ .mulhsu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩

        | .bv , .bv , "RV64.mulw" => do -- (s : Bool)
          return ⟨ .pure, .bv ,⟨ .mulw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "RV64.divw" =>
          return ⟨ .pure, .bv ,⟨ .divw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "RV64.divwu" =>
            return ⟨ .pure, .bv ,⟨ .divwu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "RV64.div" =>
            return ⟨ .pure, .bv ,⟨ .div, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "RV64.divu" =>
            return ⟨ .pure, .bv ,⟨ .divu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "RV64.remw" =>
            return ⟨ .pure, .bv ,⟨ .remw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "RV64.remwu" =>
            return ⟨ .pure, .bv ,⟨ .remw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩


        | _, _ , _ => throw <| .unsupportedOp s!"type mismatch  for 2 reg operation  {repr opStx}"
    | _ => throw <| .unsupportedOp s!"wrong number of arguemnts, more than 2 arguemnts  {repr opStx}"

instance : MLIR.AST.TransformExpr (RV64) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (RV64)
    (Σ eff ty, Com RV64 Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (RV64) 0 where
  mkReturn := mkReturn


open Qq MLIR AST Lean Elab Term Meta in
elab "[RV64_com| " reg:mlir_region "]" : term => do
  SSA.elabIntoCom reg q(RV64)

end toRISCV
