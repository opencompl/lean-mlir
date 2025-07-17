import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.RISCV64.Tactic.SimpRiscVAttr
set_option maxHeartbeats 1000000000000000000

open BitVec
/-!
  ## Dialect semantics
  This file contains the semantics for each modelled `RISCV-64` dialect instruction
  as defined by : https://github.com/riscv/sail-riscv
  This give us the guarantee that the dialect semantics faithfully implements the intended
  Risc-V semantics.
  The semantic defintions do not contain toInt and toNat when possible. For this
  we rewrote the Sail semantics into pure bit vector only operations including a proof
  of correctness.
  This rewrite should allow to gain in automation using the bv_decide.

  The instruction semantics suffixed by "bv" indicates that it is
  the purely bit vector defintion where we removed
  toInt/toNat calls.
-/

namespace RV64Semantics

@[simp_riscv]
def UTYPE_pure64_RISCV_ADDIW (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64 (BitVec.setWidth 32 (BitVec.add (BitVec.signExtend 64 imm) rs1_val))

-- loads immediate into upper 20 bits and then fills the rest up with 0 and returns it as the result
@[simp_riscv]
def UTYPE_pure64_RISCV_LUI (imm : BitVec 20) : BitVec 64 :=
  BitVec.signExtend 64 (imm ++ (0x000 : (BitVec 12)))

@[simp_riscv]
def UTYPE_pure64_RISCV_AUIPC (imm : BitVec 20) (pc : BitVec 64) : BitVec 64 :=
  BitVec.add (BitVec.signExtend 64 (BitVec.append imm (0x000 : BitVec 12))) pc

@[simp_riscv]
def SHIFTIWOP_pure64_RISCV_SLLIW (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64 (BitVec.shiftLeft (BitVec.extractLsb' 0 32 rs1_val) (shamt).toNat)

@[simp_riscv]
def SHIFTIWOP_pure64_RISCV_SLLIW_bv (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64 ((BitVec.extractLsb' 0 32 rs1_val)  <<< shamt)

theorem SHIFTIWOP_pure64_RISCV_SLLIW_eq_SHIFTIWOP_pure64_RISCV_SLLIW_bv (shamt : BitVec 5) (rs1_val : BitVec 64) :
    SHIFTIWOP_pure64_RISCV_SLLIW shamt rs1_val = SHIFTIWOP_pure64_RISCV_SLLIW_bv shamt rs1_val := by
  unfold SHIFTIWOP_pure64_RISCV_SLLIW SHIFTIWOP_pure64_RISCV_SLLIW_bv
  rfl

@[simp_riscv]
def SHIFTIWOP_pure64_RISCV_SRLIW (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64 (BitVec.ushiftRight (BitVec.extractLsb' 0 32 rs1_val) (shamt).toNat)

@[simp_riscv]
def SHIFTIWOP_pure64_RISCV_SRLIW_bv (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64 ((BitVec.extractLsb' 0 32 rs1_val) >>> shamt)

theorem  SHIFTIWOP_pure64_RISCV_SRLIW_eq_SHIFTIWOP_pure64_RISCV_SRLIW_bv (shamt : BitVec 5) (rs1_val : BitVec 64) :
    SHIFTIWOP_pure64_RISCV_SRLIW shamt rs1_val =  SHIFTIWOP_pure64_RISCV_SRLIW_bv shamt rs1_val := by
  unfold SHIFTIWOP_pure64_RISCV_SRLIW SHIFTIWOP_pure64_RISCV_SRLIW_bv
  rfl

@[simp_riscv]
def SHIFTIWOP_pure64_RISCV_SRAIW (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.setWidth 32
      (BitVec.extractLsb
        (31 + shamt.toNat)
        shamt.toNat
        (BitVec.signExtend (32 + shamt.toNat) (BitVec.extractLsb 31 0 rs1_val))))

@[simp_riscv]
def SHIFTIWOP_pure64_RISCV_SRAIW_bv (shamt : BitVec 5) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64 (BitVec.sshiftRight' (BitVec.extractLsb 31 0 rs1_val) shamt)

theorem SHIFTIWOP_pure64_RISCV_SRAIW_eq_SHIFTIWOP_pure64_RISCV_SRAIW_bv (shamt : BitVec 5) (rs1_val : BitVec 64) :
    SHIFTIWOP_pure64_RISCV_SRAIW shamt rs1_val = SHIFTIWOP_pure64_RISCV_SRAIW_bv shamt rs1_val := by
  unfold SHIFTIWOP_pure64_RISCV_SRAIW SHIFTIWOP_pure64_RISCV_SRAIW_bv
  rw [← sshiftRight_eq_setWidth_extractLsb_signExtend]
  rfl

@[simp_riscv]
def SHIFTIOP_pure64_RISCV_SLLI (shamt : BitVec 6) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.shiftLeft rs1_val shamt.toNat

@[simp_riscv]
def  SHIFTIOP_pure64_RISCV_SLLI_bv (shamt : BitVec 6) (rs1_val : BitVec 64) : BitVec 64 :=
  rs1_val <<< shamt

theorem SHIFTIOP_pure64_RISCV_SLLI_eq_SHIFTIOP_pure64_RISCV_SLLI_bv :
    SHIFTIOP_pure64_RISCV_SLLI shamt rs1_val = SHIFTIOP_pure64_RISCV_SLLI_bv shamt rs1_val := by
  unfold SHIFTIOP_pure64_RISCV_SLLI SHIFTIOP_pure64_RISCV_SLLI_bv
  simp only [BitVec.shiftLeft_eq, BitVec.shiftLeft_eq']

@[simp_riscv]
def SHIFTIOP_pure64_RISCV_SRLI (shamt : BitVec 6) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.ushiftRight rs1_val shamt.toNat

@[simp_riscv]
def SHIFTIOP_pure64_RISCV_SRLI_bv (shamt : BitVec 6) (rs1_val : BitVec 64) : BitVec 64 :=
    rs1_val >>> shamt

theorem SHIFTIOP_pure64_RISCV_SRLI_eq_SHIFTIOP_pure64_RISCV_SRLI_bv (shamt : BitVec 6) (rs1_val : BitVec 64) :
    SHIFTIOP_pure64_RISCV_SRLI shamt rs1_val = SHIFTIOP_pure64_RISCV_SRLI_bv shamt rs1_val := by
  unfold SHIFTIOP_pure64_RISCV_SRLI SHIFTIOP_pure64_RISCV_SRLI_bv
  simp

@[simp_riscv]
def SHIFTIOP_pure64_RISCV_SRAI (shamt : BitVec 6) (rs1_val : BitVec 64): BitVec 64 :=
  let value := rs1_val ;
  let shift := shamt.toNat;
  BitVec.setWidth 64 (BitVec.extractLsb (63 + shift) shift (BitVec.signExtend (64 + shift) value))

@[simp_riscv]
def SHIFTIOP_pure64_RISCV_SRAI_bv (shamt : BitVec 6) (rs1_val : BitVec 64): BitVec 64 :=
  BitVec.sshiftRight' rs1_val  shamt

theorem SHIFTIOP_pure64_RISCV_SRAI_eq_SHIFTIOP_pure64_RISCV_SRAI_bv
  (shamt : BitVec 6) (rs1_val : BitVec 64) :
    SHIFTIOP_pure64_RISCV_SRAI shamt rs1_val =
    SHIFTIOP_pure64_RISCV_SRAI_bv shamt rs1_val := by
  unfold SHIFTIOP_pure64_RISCV_SRAI SHIFTIOP_pure64_RISCV_SRAI_bv
  simp only [BitVec.sshiftRight_eq']
  rw [sshiftRight_eq_setWidth_extractLsb_signExtend]

@[simp_riscv]
def RTYPEW_pure64_RISCV_ADDW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
  let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
  BitVec.signExtend 64 (BitVec.add rs1_val32 rs2_val32)

@[simp_riscv]
def RTYPEW_pure64_RISCV_SUBW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
  let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
  BitVec.signExtend 64 (BitVec.sub rs1_val32 rs2_val32)

@[simp_riscv]
def RTYPEW_pure64_RISCV_SLLW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
  let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
  let shamt := BitVec.extractLsb' 0 5 rs2_val32;
  BitVec.signExtend 64 (BitVec.shiftLeft rs1_val32 shamt.toNat)

@[simp_riscv]
def RTYPEW_pure64_RISCV_SLLW_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
  let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
  let shamt := BitVec.extractLsb' 0 5 rs2_val32;
  BitVec.signExtend 64 (rs1_val32 <<< shamt)

theorem RTYPEW_pure64_RISCV_SLLW_eq_RTYPEW_pure64_RISCV_SLLW_bv
  (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    RTYPEW_pure64_RISCV_SLLW rs2_val rs1_val
  = RTYPEW_pure64_RISCV_SLLW_bv rs2_val rs1_val := by
  unfold RTYPEW_pure64_RISCV_SLLW RTYPEW_pure64_RISCV_SLLW_bv
  simp only [extractLsb'_eq_setWidth, Nat.reduceLeDiff, BitVec.setWidth_setWidth_of_le,
    BitVec.toNat_setWidth, Nat.reducePow, BitVec.shiftLeft_eq, BitVec.shiftLeft_eq']

@[simp_riscv]
def RTYPEW_pure64_RISCV_SRLW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
  let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
  let shamt := BitVec.extractLsb' 0 5 rs2_val32;
  BitVec.signExtend 64 (BitVec.ushiftRight rs1_val32 shamt.toNat)

@[simp_riscv]
def RTYPEW_pure64_RISCV_SRLW_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let rs1_val32 := BitVec.extractLsb' 0 32 rs1_val;
  let rs2_val32 := BitVec.extractLsb' 0 32 rs2_val;
  let shamt := BitVec.extractLsb' 0 5 rs2_val32;
  BitVec.signExtend 64 (rs1_val32 >>> shamt)

theorem RTYPEW_pure64_RISCV_SLLW_eq_RTYPEW_pure64_RISCV_SRLW_bv
  (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    RTYPEW_pure64_RISCV_SRLW rs2_val rs1_val
  = RTYPEW_pure64_RISCV_SRLW_bv rs2_val rs1_val := by
  unfold RTYPEW_pure64_RISCV_SRLW RTYPEW_pure64_RISCV_SRLW_bv
  simp

@[simp_riscv]
def RTYPEW_pure64_RISCV_SRAW (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.signExtend 64
        (BitVec.setWidth 32
          (BitVec.extractLsb
              (31 + rs2_val.toNat % 4294967296 % 32)
                  (rs2_val.toNat % 4294967296 % 32)
                      (BitVec.signExtend (32 + rs2_val.toNat % 4294967296 % 32)
                          (BitVec.extractLsb 31 0 rs1_val))))

@[simp_riscv]
def RTYPEW_pure64_RISCV_SRAW_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.signExtend 64
  (BitVec.sshiftRight' (BitVec.extractLsb 31 0 rs1_val) (BitVec.extractLsb 4 0 rs2_val))

theorem RTYPEW_pure64_RISCV_SRAW_eq_RTYPEW_pure64_RISCV_SRAW_bv
  (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    RTYPEW_pure64_RISCV_SRAW rs2_val rs1_val
  = RTYPEW_pure64_RISCV_SRAW_bv rs2_val rs1_val := by
  unfold RTYPEW_pure64_RISCV_SRAW RTYPEW_pure64_RISCV_SRAW_bv
  rw [← sshiftRight_eq_setWidth_extractLsb_signExtend]
  simp

@[simp_riscv]
def RTYPE_pure64_RISCV_ADD (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.add rs1_val rs2_val

@[simp_riscv]
def RTYPE_pure64_RISCV_SLT (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let b := BitVec.slt rs1_val rs2_val;
  BitVec.setWidth 64 (BitVec.ofBool b)

@[simp_riscv]
def RTYPE_pure64_RISCV_SLTU (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let b := BitVec.ult rs1_val rs2_val;
  BitVec.setWidth 64 (BitVec.ofBool b)

@[simp_riscv]
def RTYPE_pure64_RISCV_AND (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.and rs2_val rs1_val

@[simp_riscv]
def RTYPE_pure64_RISCV_OR (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.or rs2_val rs1_val

@[simp_riscv]
def RTYPE_pure64_RISCV_XOR (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.xor rs2_val rs1_val

@[simp_riscv]
def RTYPE_pure64_RISCV_SLL (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let shamt := (BitVec.extractLsb 5 0 rs2_val).toNat;
  BitVec.shiftLeft rs1_val shamt

@[simp_riscv]
def RTYPE_pure64_RISCV_SLL_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let shamt := (BitVec.extractLsb 5 0 rs2_val);
  rs1_val <<< shamt

theorem RTYPE_pure64_RISCV_SLL_eq_RTYPE_pure64_RISCV_SLL_bv
  (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    RTYPE_pure64_RISCV_SLL rs2_val rs1_val =
  RTYPE_pure64_RISCV_SLL_bv rs2_val rs1_val := by
  unfold RTYPE_pure64_RISCV_SLL  RTYPE_pure64_RISCV_SLL_bv
  simp

@[simp_riscv]
def RTYPE_pure64_RISCV_SRL (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let shamt := (BitVec.extractLsb 5 0 rs2_val).toNat;
  BitVec.ushiftRight rs1_val shamt

@[simp_riscv]
def RTYPE_pure64_RISCV_SRL_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  let shamt := BitVec.extractLsb 5 0 rs2_val
  rs1_val >>> shamt

theorem RTYPE_pure64_RISCV_SRL_eq_RTYPE_pure64_RISCV_SRL_bv
  (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    RTYPE_pure64_RISCV_SRL rs2_val rs1_val =
  RTYPE_pure64_RISCV_SRL_bv rs2_val rs1_val :=
  by
  unfold RTYPE_pure64_RISCV_SRL RTYPE_pure64_RISCV_SRL_bv
  simp

@[simp_riscv]
def RTYPE_pure64_RISCV_SUB (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.sub rs1_val rs2_val

@[simp_riscv]
def RTYPE_pure64_RISCV_SRA (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.setWidth 64
    (BitVec.extractLsb
      (63 + (BitVec.extractLsb 5 0 rs2_val).toNat)
      (BitVec.extractLsb 5 0 rs2_val).toNat
        (BitVec.signExtend
         (64 + (BitVec.extractLsb 5 0 rs2_val).toNat) rs1_val))

@[simp_riscv]
def RTYPE_pure64_RISCV_SRA_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.sshiftRight' rs1_val (BitVec.extractLsb 5 0 rs2_val)

theorem RTYPE_pure64_RISCV_SRA_eqRTYPE_pure64_RISCV_SRA_bv
  (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    RTYPE_pure64_RISCV_SRA  rs2_val rs1_val =
  RTYPE_pure64_RISCV_SRA_bv rs2_val rs1_val := by
  unfold RTYPE_pure64_RISCV_SRA RTYPE_pure64_RISCV_SRA_bv
  rw [BitVec.sshiftRight', sshiftRight_eq_setWidth_extractLsb_signExtend]

/- wip : working on removing toNats and toInts in this definiton, therefore waiting for a
 bit vec lemma to be upstreamed. -/
 @[simp_riscv]
def UNSIGNED_pure64_REMW (rs2_val : BitVec 64) (rs1_val : BitVec 64): BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt 33
        (if ((BitVec.extractLsb 31 0 rs2_val).toNat : Int) = 0 then ↑(BitVec.extractLsb 31 0 rs1_val).toNat
        else ((BitVec.extractLsb 31 0 rs1_val).toNat : Int).tmod ↑(BitVec.extractLsb 31 0 rs2_val).toNat)))

@[simp_riscv]
def UNSIGNED_pure64_REMW_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64
    ((BitVec.extractLsb 31 0 rs1_val).umod (BitVec.extractLsb 31 0 rs2_val))

theorem UNSIGNED_pure64_REMW_eq_UNSIGNED_pure64_REMW_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    UNSIGNED_pure64_REMW rs2_val rs1_val
   = UNSIGNED_pure64_REMW_bv rs2_val rs1_val := by
  unfold  UNSIGNED_pure64_REMW UNSIGNED_pure64_REMW_bv
  rw [extractLsb'_ofInt_eq_ofInt (h:= by simp)]
  split
  case isTrue ht =>
      congr
      rw [BitVec.extractLsb,BitVec.extractLsb]
      simp only [Nat.sub_zero, Nat.reduceAdd]
      rw [BitVec.extractLsb] at ht
      simp only [extractLsb'_eq_setWidth]
      simp only [Nat.sub_zero, Nat.reduceAdd] at ht
      norm_cast at ht
      obtain h : (BitVec.extractLsb' 0 32 rs2_val) = 0#_ :=
        BitVec.eq_of_toNat_eq ht
      obtain h1 : (0#32).toNat = 0 := by bv_decide
      simp only [BitVec.toNat_setWidth, Int.natCast_emod, Int.natCast_pow, Nat.cast_ofNat,
        BitVec.umod_eq]
      rw [show 0 = (0#32).toNat by omega, ← BitVec.toNat_eq] at ht
      conv at ht =>
        lhs
        rw [show (0#32).toNat = 0 by omega]
      rw [← BitVec.setWidth_eq_extractLsb' (by simp)] at ht
      rw [ht, BitVec.umod_zero, ← BitVec.toInt_inj]
      simp only [Int.reducePow, BitVec.toInt_ofInt, Nat.reducePow, BitVec.toInt_setWidth]
      have helper : ((4294967296 : Nat) : Int) = (4294967296 : Int) := rfl
      rw [← helper, Int.emod_bmod (x := (rs1_val.toNat : Int)) (n := (4294967296))]
  case isFalse hf =>
      congr
      simp only [Nat.sub_zero, Nat.reduceAdd, BitVec.extractLsb_toNat, Nat.shiftRight_zero,
        Nat.reducePow, Int.natCast_emod, Nat.cast_ofNat, BitVec.umod_eq]
      simp at hf
      apply BitVec.eq_of_toInt_eq
      simp only [BitVec.toInt_ofInt, Nat.reducePow, BitVec.toInt_umod, BitVec.extractLsb_toNat,
        Nat.shiftRight_zero, Nat.sub_zero, Nat.reduceAdd, Int.natCast_emod, Nat.cast_ofNat]
      rfl

@[simp_riscv]
def SIGNED_pure64_REMW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.signExtend 64
      (BitVec.extractLsb' 0 32
        (BitVec.ofInt (33)
          (if (BitVec.extractLsb 31 0 rs2_val).toInt = 0 then (BitVec.extractLsb 31 0 rs1_val).toInt
          else (BitVec.extractLsb 31 0 rs1_val).toInt.tmod (BitVec.extractLsb 31 0 rs2_val).toInt)))
@[simp_riscv]
def SIGNED_pure64_REMW_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.signExtend 64
    ((BitVec.extractLsb 31 0 rs1_val).srem (BitVec.extractLsb 31 0 rs2_val))

theorem SIGNED_pure64_REMWd_eq_SIGNED_pure64_REMW (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    SIGNED_pure64_REMW rs2_val rs1_val = SIGNED_pure64_REMW_bv rs2_val rs1_val := by
  unfold SIGNED_pure64_REMW SIGNED_pure64_REMW_bv
  rw [extractLsb'_ofInt_eq_ofInt (h:= by simp)]
  congr
  split
  case e_x.isTrue ht  =>
    obtain h': (BitVec.extractLsb 31 0 rs2_val) = 0#_ :=
      BitVec.eq_of_toInt_eq ht
    simp only [Nat.sub_zero, Nat.reduceAdd] at h'
    simp only [h']
    rw [BitVec.ofInt_toInt]
    simp only [Nat.sub_zero, Nat.reduceAdd, BitVec.srem_zero]
  case e_x.isFalse hf =>
    rw [← BitVec.toInt_srem, BitVec.ofInt_toInt]

@[simp_riscv]
def UNSIGNED_pure64_REM (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb' 0 64
    (BitVec.ofInt 65 (if (rs2_val.toNat: Int) = 0 then (rs1_val.toNat: Int)  else (rs1_val.toNat :Int).tmod (rs2_val.toNat : Int)))

@[simp_riscv]
def UNSIGNED_pure64_REM_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  if rs2_val = 0 then rs1_val else ((rs1_val).umod (rs2_val))

theorem  REM_pure64_unsigned_eq_REM_pure64_unsigned_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    UNSIGNED_pure64_REM rs2_val rs1_val = UNSIGNED_pure64_REM_bv rs2_val rs1_val := by
  unfold UNSIGNED_pure64_REM UNSIGNED_pure64_REM_bv
  rw [extractLsb'_ofInt_eq_ofInt (h:= by simp )]
  split
  case isTrue isZero =>
      simp only [Int.natCast_eq_zero] at isZero
      obtain rfl : rs2_val = 0#_ :=
        BitVec.eq_of_toNat_eq isZero
      simp
  case isFalse nonZero =>
      simp only [Int.natCast_eq_zero] at nonZero
      simp only [BitVec.ofNat_eq_ofNat, BitVec.umod_eq]
      have h:= (BitVec.toNat_ne_iff_ne (x:=rs2_val) (y:= 0)).mp nonZero
      have h2:= (BitVec.toNat_ne_iff_ne (x:=rs2_val) (y:= 0)).mpr h
      split
      case isTrue => contradiction
      case isFalse =>
        apply BitVec.eq_of_toInt_eq
        simp only [BitVec.toInt_ofInt, Nat.reducePow, BitVec.toInt_umod]
        rfl

@[simp_riscv]
def SIGNED_pure64_REM (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb' 0 64
  (BitVec.ofInt 65 (if rs2_val.toInt = 0 then rs1_val.toInt else rs1_val.toInt.tmod rs2_val.toInt))

@[simp_riscv]
def SIGNED_pure64_REM_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  rs1_val.srem rs2_val

theorem REM_pure64_signed_eq_REM_pure64_signed_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    SIGNED_pure64_REM rs2_val rs1_val = SIGNED_pure64_REM_bv rs2_val rs1_val := by
  unfold SIGNED_pure64_REM SIGNED_pure64_REM_bv
  rw [extractLsb'_ofInt_eq_ofInt (h:= by simp)]
  split
  case isTrue ht  =>
    simp only [BitVec.ofInt_toInt, BitVec.srem, BitVec.umod_eq, BitVec.neg_eq]
    obtain rfl : rs2_val = 0#_ :=
      BitVec.eq_of_toInt_eq ht
    split <;> simp
  case isFalse hf =>
    rw [← BitVec.toInt_srem, BitVec.ofInt_toInt]

@[simp_riscv]
def pure64_MULW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.extractLsb 31 0
      (BitVec.extractLsb' 0 64
        (BitVec.ofInt 65 ((BitVec.extractLsb 31 0 rs1_val).toInt * (BitVec.extractLsb 31 0 rs2_val).toInt))))

@[simp_riscv]
def pure64_MULW_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64
    (((BitVec.extractLsb 31 0 rs1_val) * (BitVec.extractLsb 31 0 rs2_val)))

theorem pure64_MULW_eq_pure64_MULW_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    pure64_MULW rs2_val rs1_val = pure64_MULW_bv rs2_val rs1_val := by
  unfold pure64_MULW pure64_MULW_bv
  rw [extractLsb'_ofInt_eq_ofInt (h:= by simp), BitVec.extractLsb]
  simp only [Nat.sub_zero, Nat.reduceAdd]
  rw [extractLsb'_ofInt_eq_ofInt (h:= by simp)]
  congr
  apply BitVec.eq_of_toInt_eq
  simp
/-!
## mul operations flags
 the suffix indicates how the flags are assumed to be set.
{ high := _, signed_rs1:= _, signed_rs2 := _  }
-/
@[simp_riscv]
def pure64_MUL_fff (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 63 0 (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (rs1_val.toNat * rs2_val.toNat)))

@[simp_riscv]
def pure64_MUL_bv_fff (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=  rs2_val * rs1_val

theorem pure64_MUL_fff_eq_pure64_MUL_bv_fff (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    pure64_MUL_fff  rs2_val rs1_val = pure64_MUL_bv_fff rs2_val rs1_val := by
  simp only  [pure64_MUL_fff,  pure64_MUL_bv_fff]
  apply BitVec.eq_of_toNat_eq
  simp [Nat.sub_zero, Nat.reduceAdd, BitVec.extractLsb_toNat, BitVec.toNat_ofInt, Nat.reducePow,
    Nat.cast_ofNat, Nat.shiftRight_zero, Nat.reduceDvd, Nat.mod_mod_of_dvd, BitVec.toNat_mul]
  congr
  norm_cast
  rw [Int.toNat_natCast, Nat.mod_eq_of_lt]
  ac_rfl
  have aa := BitVec.isLt rs1_val
  have bb := BitVec.isLt rs2_val
  have := @Nat.mul_lt_mul'' _ _ _ _ aa bb
  simp at this
  omega

@[simp_riscv]
def pure64_MUL_fft (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 63 0
    (BitVec.extractLsb' 0 128
      (BitVec.ofInt 129 (Int.ofNat (Int.mul (Int.ofNat rs1_val.toNat)  (rs2_val.toInt)).toNat)))

@[simp_riscv]
def pure64_MUL_ftf (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 63 0 (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (rs1_val.toInt * rs2_val.toNat)))

@[simp_riscv]
def pure64_MUL_tff (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 127 64 (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (rs1_val.toNat * rs2_val.toNat)))

@[simp_riscv]
def pure64_MUL_bv_tff  (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
   BitVec.extractLsb 127 64 (BitVec.extractLsb' 0 128 ((BitVec.zeroExtend 128 rs1_val)  * (BitVec.zeroExtend 128 rs2_val)))

theorem pure64_MUL_tff_eq_pure64_MUL_tff_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    pure64_MUL_tff rs2_val rs1_val = pure64_MUL_bv_tff rs2_val rs1_val := by
  unfold  pure64_MUL_tff pure64_MUL_bv_tff
  suffices (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (↑rs1_val.toNat * ↑rs2_val.toNat))) =
                 (BitVec.extractLsb' 0 128 (BitVec.zeroExtend 128 rs1_val * BitVec.zeroExtend 128 rs2_val))
    by
    congr
  apply BitVec.eq_of_toNat_eq
  simp only [HMul.hMul, Mul.mul]
  simp only [Int.mul_def, extractLsb'_eq_setWidth, BitVec.toNat_setWidth, BitVec.toNat_ofInt,
    Nat.reducePow, Nat.cast_ofNat, BitVec.truncate_eq_setWidth, BitVec.mul_eq, BitVec.toNat_mul,
    Nat.mul_mod_mod, Nat.mod_mul_mod]
  congr
  norm_cast
  rw [Int.toNat_natCast]
  have aa := BitVec.isLt rs1_val
  have bb := BitVec.isLt rs2_val
  have cc : 680564733841876926926749214863536422912 = 2^129 := by native_decide
  have aaa : rs1_val.toNat >= 0 := by simp
  have bbb : rs2_val.toNat >= 0 := by simp
  rw [Nat.mod_eq_of_lt (h:=
      by
      rw [cc]
      have := Nat.mul_lt_mul''
        (a := rs1_val.toNat) (b := rs2_val.toNat) (c := 2 ^ 64) (d := 2 ^ 64) aa bb
      omega )]
  have := @Nat.mul_lt_mul'' _ _ _ _ aa bb
  omega

@[simp_riscv]
def pure64_MUL_ttf (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 127 64 (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (rs1_val.toInt * rs2_val.toNat)))

@[simp_riscv]
def pure64_MUL_bv_ttf (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 127 64 (((BitVec.signExtend 129 rs1_val ) * (BitVec.zeroExtend 129 rs2_val )))

theorem pure64_MUL_ttf_eq_pure64_MUL_ttf_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    pure64_MUL_ttf rs2_val rs1_val = pure64_MUL_bv_ttf rs2_val rs1_val := by
  unfold pure64_MUL_ttf pure64_MUL_bv_ttf
  simp only [extractLsb'_eq_setWidth, BitVec.truncate_eq_setWidth]
  have h1 : rs1_val.toInt = (rs1_val.signExtend 129).toInt := by
      simp only [Nat.reduceLeDiff, BitVec.toInt_signExtend_of_le]
  simp only [h1]
  have h2 : rs2_val.toNat = (rs2_val.zeroExtend 129).toInt := by
      simp only [BitVec.truncate_eq_setWidth, BitVec.toInt_setWidth]
      have : rs2_val.toNat < 2 ^64 := by omega
      have := Nat.pow_lt_pow_of_lt (a := 2) (n := 64) (m := 129) (by omega) (by omega)
      rw [Int.bmod_eq_of_le (n := (rs2_val.toNat : Int)) (by omega) (by omega)]
  rw [h2]
  simp only [BitVec.truncate_eq_setWidth, BitVec.toInt_setWidth, Nat.reducePow, BitVec.ofInt_mul,
    BitVec.ofInt_toInt]
  rw [Int.bmod_eq_of_le (n := (rs2_val.toNat : Int)) (by omega) (by omega)]
  simp only [BitVec.ofInt_natCast, BitVec.ofNat_toNat]
  rw [extractLsb_setWidth_of_lt (hi := 127) (lo := 64) (v := 128) (x := BitVec.signExtend 129 rs1_val * BitVec.setWidth 129 rs2_val) (by omega) (by omega)]

@[simp_riscv]
def pure64_MUL_ftt (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  rs2_val * rs1_val

@[simp_riscv]
def pure64_MUL_ttt (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 127 64 (BitVec.extractLsb' 0 128 (BitVec.ofInt 129 (rs1_val.toInt * rs2_val.toInt)))

@[simp_riscv]
def pure64_MUL_bv_ttt  (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb 127 64 ((BitVec.signExtend 129 rs1_val) * (BitVec.signExtend 129 rs2_val))

theorem pure64_MUL_ttt_eq_pure64_MUL_ttt_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    pure64_MUL_ttt rs2_val rs1_val = pure64_MUL_bv_ttt rs2_val rs1_val := by
  unfold pure64_MUL_bv_ttt pure64_MUL_ttt
  have : rs1_val.toInt = (rs1_val.signExtend 129).toInt := by
    simp only [Nat.reduceLeDiff, BitVec.toInt_signExtend_of_le]
  simp only [this]
  have : rs2_val.toInt = (rs2_val.signExtend 129).toInt := by
    simp only [Nat.reduceLeDiff, BitVec.toInt_signExtend_of_le]
  simp only [this]
  rw [BitVec.ofInt_mul]
  simp only [BitVec.ofInt_toInt, extractLsb'_eq_setWidth]
  rw [extractLsb_setWidth_of_lt (hi := 127) (lo := 64) (v := 128) (x := BitVec.signExtend 129 rs1_val * BitVec.signExtend 129 rs2_val) (by omega)]
  simp

/- Work in Progress: For the two division operations that operate on a word,
 the translation into the bit vector domain—excluding the use of toInts and toNats—will
  be added in the future. These specific operations were skipped for now, as they
  are not required for the current project (instruction selection).
-/
@[simp_riscv]
def SIGNED_pure64_DIVW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
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

@[simp_riscv]
def UNSIGNED_pure64_DIVW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.extractLsb' 0 32
      (BitVec.ofInt 33
      (if (rs2_val.toNat: Int)  % 4294967296 = 0 then -1
        else ((rs1_val.toNat : Int) % 4294967296).tdiv
          ((rs2_val.toNat : Int) % 4294967296))))

@[simp_riscv]
def SIGNED_pure64_DIV (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb' 0 64
    (BitVec.ofInt 65
      (if ((2^63)-1) < if rs2_val.toInt = 0 then -1 else rs1_val.toInt.tdiv rs2_val.toInt then
         -(2^63)
      else if rs2_val.toInt = 0 then -1 else rs1_val.toInt.tdiv rs2_val.toInt))

@[simp_riscv]
def SIGNED_pure64_DIV_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  if rs2_val = 0#64 then
    -1#64
  else
    rs1_val.sdiv rs2_val

theorem SIGNED_pure64_DIV_eq_SIGNED_pure64_DIV_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
  SIGNED_pure64_DIV rs2_val rs1_val = SIGNED_pure64_DIV_bv rs2_val rs1_val := by
    unfold SIGNED_pure64_DIV SIGNED_pure64_DIV_bv
    rw [extractLsb'_ofInt_eq_ofInt (h:= by simp)]
    by_cases h1 : rs2_val = 0#64
    case pos => simp [h1]
    case neg =>
      have h' : rs2_val.toInt ≠ 0 := by
        have h1 := (BitVec.toInt_ne).mpr h1
        exact h1
      apply BitVec.eq_of_toInt_eq
      simp only [Int.reduceSub, h', ↓reduceIte, Int.reduceNeg, BitVec.toInt_ofInt,
        h1, Int.reducePow, Int.reduceSub, Int.reduceNeg, Nat.reducePow, BitVec.toInt_sdiv]
      by_cases h : rs1_val = .intMin _ ∧ rs2_val = -1#64
      case pos =>
          obtain ⟨rfl, rfl⟩ := h
          simp only [BitVec.toInt_intMin, Nat.add_one_sub_one, Nat.reducePow, Nat.reduceMod,
            Nat.cast_ofNat, Int.reduceNeg, BitVec.reduceNeg, BitVec.reduceToInt, Int.tdiv_neg,
            Int.tdiv_one, Int.reduceLT, ↓reduceIte, Int.reduceBmod]
      case neg =>
          have := BitVec.toInt_sdiv_of_ne_or_ne rs1_val rs2_val <| by
              rw [← Decidable.not_and_iff_not_or_not]
              exact h
          rw[← this]
          split
          case isTrue iT =>
            have intMax : (BitVec.intMax 64).toInt =  9223372036854775807 := by native_decide
            have h3 : (rs1_val.sdiv rs2_val).toInt ≤2 ^ 63  - 1 := by
                apply  BitVec.toInt_le
            simp only [Int.reducePow, Int.reduceSub] at h3
            exact (not_le_of_gt iT h3).elim
          case isFalse iF =>
          rfl

@[simp_riscv]
def UNSIGNED_pure64_DIV (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb' 0 64
    (BitVec.ofInt 65
    (if ((rs2_val.toNat):Int) = 0 then -1 else (rs1_val.toNat : Int).tdiv (rs2_val.toNat: Int)))

@[simp_riscv]
def UNSIGNED_pure64_DIV_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  if rs2_val = 0#64 then -1 else rs1_val.udiv rs2_val

theorem UNSIGNED_pure64_DIV_eq_UNSIGNED_pure64_DIV_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    UNSIGNED_pure64_DIV rs2_val rs1_val  = UNSIGNED_pure64_DIV_bv rs2_val rs1_val := by
  unfold UNSIGNED_pure64_DIV UNSIGNED_pure64_DIV_bv
  split
  case isTrue ht =>
      simp only [Int.reduceNeg, BitVec.reduceOfInt, extractLsb'_eq_setWidth, Nat.reduceLeDiff,
        BitVec.setWidth_ofNat_of_le, BitVec.reduceOfNat, BitVec.ofNat_eq_ofNat, BitVec.reduceNeg,
        BitVec.udiv_eq]
      simp only [Int.natCast_eq_zero] at ht
      have h3 := BitVec.eq_of_toNat_eq (x := rs2_val) (y:= 0) ht
      simp only [h3, BitVec.ofNat_eq_ofNat, ↓reduceIte]
  case isFalse hf =>
      simp only [extractLsb'_eq_setWidth, BitVec.ofNat_eq_ofNat, BitVec.reduceNeg]
      split
      case isTrue htt =>
          simp at hf
          bv_omega
      · rw [BitVec.setWidth_eq_extractLsb' (by simp)]
        rw [extractLsb'_ofInt_eq_ofInt (h:= by simp)]
        apply BitVec.eq_of_toInt_eq
        simp only [BitVec.toInt_ofInt]
        have aa := BitVec.isLt (rs1_val.udiv rs2_val)
        rw [BitVec.udiv.eq_1 ]
        rw[← Int.ofNat_tdiv]
        rw [BitVec.toInt_eq_toNat_bmod]
        simp

@[simp_riscv]
def ITYPE_pure64_RISCV_ADDI (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
  let immext : BitVec 64 := (BitVec.signExtend 64 imm) ;
  BitVec.add rs1_val immext

@[simp_riscv]
def ITYPE_pure64_RISCV_SLTI (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
  let immext : BitVec 64 := (BitVec.signExtend 64 imm);
  let b := BitVec.slt rs1_val immext;
  BitVec.zeroExtend 64 (BitVec.ofBool b)

@[simp_riscv]
def ITYPE_pure64_RISCV_SLTIU (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
  let immext : BitVec 64 := (BitVec.signExtend 64 imm);
  let b := BitVec.ult rs1_val immext;
  BitVec.setWidth 64 (BitVec.ofBool b)

@[simp_riscv]
def ITYPE_pure64_RISCV_ANDI (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
  let immext : BitVec 64 := (BitVec.signExtend 64 imm);
  BitVec.and rs1_val immext

@[simp_riscv]
def ITYPE_pure64_RISCV_ORI (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
  let immext : BitVec 64 := (BitVec.signExtend 64 imm) ;
  BitVec.or rs1_val immext

@[simp_riscv]
def ITYPE_pure64_RISCV_XORI (imm : BitVec 12) (rs1_val : BitVec 64) : BitVec 64 :=
  let immext : BitVec 64 := (BitVec.signExtend 64 imm) ;
  BitVec.xor rs1_val immext

@[simp_riscv]
def ZICOND_RTYPE_pure64_RISCV_CZERO_EQZ (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  if rs2_val = BitVec.zero 64 then BitVec.zero 64 else rs1_val

@[simp_riscv]
def ZICOND_RTYPE_pure64_RISCV_CZERO_NEZ (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  if rs2_val = BitVec.zero 64 then rs1_val else BitVec.zero 64

@[simp_riscv]
def ZBS_RTYPE_pure64_RISCV_BCLR (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.and rs1_val (BitVec.not ((BitVec.zeroExtend 64 1#1) <<< (BitVec.extractLsb 5 0 rs2_val)))

@[simp_riscv]
def ZBS_RTYPE_pure64_RISCV_BCLR_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.and rs1_val (BitVec.not ((BitVec.zeroExtend 64 1#1) <<< (BitVec.extractLsb 5 0 rs2_val)))

theorem ZBS_RTYPE_pure64_RISCV_BCLR_eq_ZBS_RTYPE_pure64_RISCV_BCLR_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    ZBS_RTYPE_pure64_RISCV_BCLR rs2_val rs1_val = ZBS_RTYPE_pure64_RISCV_BCLR_bv rs2_val rs1_val := by
  unfold ZBS_RTYPE_pure64_RISCV_BCLR ZBS_RTYPE_pure64_RISCV_BCLR_bv
  bv_normalize

@[simp_riscv]
def ZBB_EXTOP_pure64_RISCV_SEXTB (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64 (BitVec.extractLsb 7 0 rs1_val)

@[simp_riscv]
def ZBB_EXTOP_pure64_RISCV_SEXTH (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64 (BitVec.extractLsb 15 0 rs1_val)

@[simp_riscv]
def ZBB_EXTOP_pure64_RISCV_ZEXTH (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.zeroExtend 64 (BitVec.extractLsb 15 0 rs1_val)

@[simp_riscv]
def ZBS_RTYPE_pure64_RISCV_BEXT (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.setWidth 64
    (match
      BitVec.and rs1_val ((BitVec.setWidth 64 1#1) <<< (BitVec.extractLsb 5 0 rs2_val)) !=
         0#64 with
    | true => 1#1
    | false => 0#1)

@[simp_riscv]
def ZBS_RTYPE_pure64_RISCV_BEXT_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.setWidth 64
    (match
      BitVec.and rs1_val ( (BitVec.setWidth 64 1#1) <<< (BitVec.extractLsb 5 0 rs2_val)) !=
        0#64 with
    | true => 1#1
    | false => 0#1)

theorem ZBS_RTYPE_pure64_RISCV_BEXT_eq_ZBS_RTYPE_pure64_RISCV_BEXT_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    ZBS_RTYPE_pure64_RISCV_BEXT rs2_val rs1_val = ZBS_RTYPE_pure64_RISCV_BEXT_bv rs2_val rs1_val := by
  unfold ZBS_RTYPE_pure64_RISCV_BEXT  ZBS_RTYPE_pure64_RISCV_BEXT_bv
  simp

@[simp_riscv]
 def ZBS_RTYPE_pure64_BINV (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.xor rs1_val
    (BitVec.shiftLeft
      (BitVec.zeroExtend 64 1#1) (BitVec.extractLsb 5 0 rs2_val).toNat)

@[simp_riscv]
 def ZBS_RTYPE_pure64_BINV_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.xor rs1_val ((BitVec.zeroExtend 64 1#1) <<< (BitVec.extractLsb 5 0 rs2_val))

theorem ZBS_RTYPE_pure64_BINV_eq_ZBS_RTYPE_pure64_BINV_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    ZBS_RTYPE_pure64_BINV rs2_val rs1_val = ZBS_RTYPE_pure64_BINV_bv rs2_val rs1_val := by
  unfold ZBS_RTYPE_pure64_BINV ZBS_RTYPE_pure64_BINV_bv
  bv_decide

@[simp_riscv]
def ZBS_RTYPE_pure64_RISCV_BSET (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.or rs1_val (BitVec.shiftLeft
    (BitVec.zeroExtend 64 1#1) (BitVec.extractLsb 5 0 rs2_val).toNat)

@[simp_riscv]
def ZBS_RTYPE_pure64_RISCV_BSET_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.or rs1_val ((BitVec.zeroExtend 64 1#1) <<< (BitVec.extractLsb 5 0 rs2_val))

theorem ZBS_RTYPE_pure64_RISCV_BSET_eq_ZBS_RTYPE_pure64_RISCV_BSET_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    ZBS_RTYPE_pure64_RISCV_BSET rs2_val rs1_val = ZBS_RTYPE_pure64_RISCV_BSET_bv rs2_val rs1_val := by
  unfold ZBS_RTYPE_pure64_RISCV_BSET ZBS_RTYPE_pure64_RISCV_BSET_bv
  simp

@[simp_riscv]
def ZBS_IOP_pure64_RISCV_BCLRI (shamt : BitVec 6) (rs1_val : BitVec 64) : BitVec 64 :=
    BitVec.and rs1_val (BitVec.not ((BitVec.setWidth 64 1#1) <<< shamt))

@[simp_riscv]
def ZBS_IOP_pure64_RISCV_BCLRI_bv (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.and rs1_val (BitVec.not ((BitVec.setWidth 64 1#1) <<< shamt))

theorem ZBS_IOP_pure64_RISCV_BCLRI_eq_ZBS_IOP_pure64_RISCV_BCLRI_bv (shamt : BitVec 6) (rs1_val : BitVec 64) :
    ZBS_IOP_pure64_RISCV_BCLRI shamt rs1_val = ZBS_IOP_pure64_RISCV_BCLRI_bv shamt rs1_val := by
  unfold ZBS_IOP_pure64_RISCV_BCLRI ZBS_IOP_pure64_RISCV_BCLRI_bv
  simp

@[simp_riscv]
def ZBS_IOP_pure64_RISCV_BEXTI (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.setWidth 64
      (match (BitVec.and rs1_val (BitVec.shiftLeft (BitVec.setWidth 64 1#1) shamt.toNat)) != 0#64 with
      | true => 1#1
      | false => 0#1)

@[simp_riscv]
def ZBS_IOP_pure64_RISCV_BEXTI_bv (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.setWidth 64
      (match (BitVec.and rs1_val ( (BitVec.setWidth 64 1#1) <<< shamt)) != 0#64 with
      | true => 1#1
      | false => 0#1)

theorem ZBS_IOP_pure64_RISCV_BEXTI_eq_ZBS_IOP_pure64_RISCV_BEXTI_bv (shamt : BitVec 6) (rs1_val : BitVec 64) :
    ZBS_IOP_pure64_RISCV_BEXTI shamt rs1_val = ZBS_IOP_pure64_RISCV_BEXTI_bv shamt rs1_val := by
  unfold ZBS_IOP_pure64_RISCV_BEXTI  ZBS_IOP_pure64_RISCV_BEXTI_bv
  simp

@[simp_riscv]
def ZBS_IOP_pure64_RISCV_BINVI (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.xor rs1_val  (BitVec.shiftLeft (BitVec.zeroExtend 64 1#1) shamt.toNat)

@[simp_riscv]
def ZBS_IOP_pure64_RISCV_BINVI_bv (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.xor rs1_val  ((BitVec.zeroExtend 64 1#1) <<< shamt)

theorem ZBS_IOP_pure64_RISCV_BINVI_eq_ZBS_IOP_pure64_RISCV_BINVI_bv (shamt : BitVec 6) (rs1_val : BitVec 64) :
    ZBS_IOP_pure64_RISCV_BINVI shamt rs1_val = ZBS_IOP_pure64_RISCV_BINVI_bv shamt rs1_val := by
  unfold ZBS_IOP_pure64_RISCV_BINVI ZBS_IOP_pure64_RISCV_BINVI_bv
  rfl

@[simp_riscv]
def ZBS_IOP_pure64_RISCV_BSETI (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.or rs1_val (BitVec.shiftLeft (BitVec.zeroExtend 64 1#1) shamt.toNat)

@[simp_riscv]
def ZBS_IOP_pure64_RISCV_BSETI_bv (shamt : BitVec 6) (rs1_val : BitVec 64) :=
  BitVec.or rs1_val ((BitVec.zeroExtend 64 1#1) <<< shamt)

theorem ZBS_IOP_pure64_RISCV_BSETI_eq_ZBS_IOP_pure64_RISCV_BSETI_bv (shamt : BitVec 6) (rs1_val : BitVec 64) :
    ZBS_IOP_pure64_RISCV_BSETI shamt rs1_val = ZBS_IOP_pure64_RISCV_BSETI_bv shamt rs1_val := by
  unfold ZBS_IOP_pure64_RISCV_BSETI  ZBS_IOP_pure64_RISCV_BSETI_bv
  simp

/- Work in Progress: For the two instructions RORW and ROLW, there is no corresponding
bit vector operation semantics. This is because it is not yet clear how such a translation
into the bit vector domain without toNat and toInts would look like. Additionally there are
not crucial for our current project. -/
@[simp_riscv]
def ZBB_RTYPEW_pure64_RISCV_RORW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend (64)
      (BitVec.or (BitVec.ushiftRight (BitVec.setWidth 32 rs1_val) (rs2_val.toNat % 32))
        (BitVec.shiftLeft (BitVec.setWidth 32 rs1_val)
          ((2 ^ 5 - rs2_val.toNat % 32 +
              32 % 2 ^ (5 + 1)) %
            2 ^ 5)))

@[simp_riscv]
def ZBB_RTYPEW_pure64_RISCV_ROLW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.signExtend 64
    (BitVec.or (BitVec.shiftLeft (BitVec.setWidth 32 rs1_val) (BitVec.extractLsb 4 0 rs2_val).toNat)
      (BitVec.ushiftRight (BitVec.setWidth 32 rs1_val)
        (((BitVec.sub ((BitVec.extractLsb' 0 5
            (BitVec.ofInt 6 32)))
          (BitVec.extractLsb 4 0 rs2_val)))).toNat))

@[simp_riscv]
  def ZBB_RTYPE_pure64_RISCV_ROL (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.or (BitVec.shiftLeft rs1_val (BitVec.extractLsb 5 0 rs2_val).toNat)
    (BitVec.ushiftRight rs1_val (BitVec.extractLsb' 0 6 (BitVec.ofInt 7 64) - BitVec.extractLsb 5 0 rs2_val).toNat)

@[simp_riscv]
 def ZBB_RTYPE_pure64_RISCV_ROL_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.or (BitVec.shiftLeft rs1_val (BitVec.extractLsb 5 0 rs2_val).toNat)
    (rs1_val >>> (BitVec.extractLsb' 0 6 (64#7) - BitVec.extractLsb 5 0 rs2_val))

theorem ZBB_RTYPE_pure64_RISCV_ROL_eq_ZBB_RTYPE_pure64_RISCV_ROL_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    ZBB_RTYPE_pure64_RISCV_ROL rs2_val rs1_val =  ZBB_RTYPE_pure64_RISCV_ROL_bv rs2_val rs1_val := by
  unfold ZBB_RTYPE_pure64_RISCV_ROL ZBB_RTYPE_pure64_RISCV_ROL_bv
  simp

@[simp_riscv]
def ZBB_RTYPE_pure64_RISCV_ROR (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.or (BitVec.ushiftRight rs1_val (BitVec.extractLsb 5 0 rs2_val).toNat)
    (BitVec.shiftLeft rs1_val ((BitVec.extractLsb' 0 6 (BitVec.ofInt 7 64) - BitVec.extractLsb 5 0 rs2_val)).toNat)

@[simp_riscv]
 def ZBB_RTYPE_pure64_RISCV_ROR_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :=
  BitVec.or ( rs1_val >>> (BitVec.extractLsb 5 0 rs2_val))
    (rs1_val <<< ((BitVec.extractLsb' 0 6 (BitVec.ofInt 7 64) - BitVec.extractLsb 5 0 rs2_val)))

theorem ZBB_RTYPE_pure64_RISCV_ROR_eq_ZBB_RTYPE_pure64_RISCV_ROR_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) :
    ZBB_RTYPE_pure64_RISCV_ROR rs2_val rs1_val = ZBB_RTYPE_pure64_RISCV_ROR_bv rs2_val rs1_val := by
  unfold ZBB_RTYPE_pure64_RISCV_ROR  ZBB_RTYPE_pure64_RISCV_ROR_bv
  simp

@[simp_riscv]
 def ZBA_RTYPEUW_pure64_RISCV_ADDUW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.zeroExtend 64 (BitVec.extractLsb 31 0 rs1_val) <<< 0#2 + rs2_val

@[simp_riscv]
def ZBA_RTYPEUW_pure64_RISCV_SH1ADDUW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.add (BitVec.zeroExtend 64 (BitVec.extractLsb 31 0 rs1_val) <<< 1#2)  rs2_val

@[simp_riscv]
def ZBA_RTYPEUW_pure64_RISCV_SH2ADDUW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.add (BitVec.zeroExtend 64 (BitVec.extractLsb 31 0 rs1_val) <<< 2#2) rs2_val

@[simp_riscv]
def  ZBA_RTYPEUW_pure64_RISCV_SH3ADDUW (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.add (BitVec.zeroExtend 64 (BitVec.extractLsb 31 0 rs1_val) <<< 3#2)  rs2_val

@[simp_riscv]
def ZBA_RTYPE_pure64_RISCV_SH1ADD (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.add (rs1_val <<< 1#2) rs2_val

@[simp_riscv]
def ZBA_RTYPE_pure64_RISCV_SH2ADD (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.add (rs1_val <<< 2#2) rs2_val

@[simp_riscv]
def ZBA_RTYPE_pure64_RISCV_SH3ADD(rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.add (rs1_val <<< 3#2) rs2_val

end RV64Semantics
