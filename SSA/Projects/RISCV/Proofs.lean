-- myy collection of helper lemmas
prelude
import Init.Data.BitVec.Lemmas
import Init.Data.BitVec.Bitblast

-- helper lemmas
@[simp]
theorem extractLsb'_eq_setWidth {x : BitVec w} : x.extractLsb' 0 n = x.setWidth n := by
  ext i hi
  simp?


theorem extractLsb'_ofInt_eq_ofInt {x : Int } {w w' : Nat}  {h : w ≤ w'} :
    (BitVec.extractLsb' 0 w (BitVec.ofInt w' x)) = (BitVec.ofInt w x) := by
  rw [extractLsb'_eq_setWidth]
  rw [← BitVec.signExtend_eq_setWidth_of_le _ (by omega)]
  apply BitVec.eq_of_toInt_eq
  simp  [BitVec.toInt_signExtend]
  simp [h]
  rw [Int.bmod_bmod_of_dvd]
  apply Nat.pow_dvd_pow
  exact h

-- sail semantics
def DIV_pure64_signed (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  BitVec.extractLsb' 0 64
    (BitVec.ofInt 65
      (if ((2^63)-1) < if rs2_val.toInt = 0 then -1 else rs1_val.toInt.tdiv rs2_val.toInt then
         -(2^63)
      else if rs2_val.toInt = 0 then -1 else rs1_val.toInt.tdiv rs2_val.toInt))


/-I removed the bounds check in the bit vector operation version because
it will be truncated to 64 bits by defintion of sdiv -/

-- version avoidng toInt and toNats
def DIV_pure64_signed_bv (rs2_val : BitVec 64) (rs1_val : BitVec 64) : BitVec 64 :=
  if rs2_val = 0#64 then
    -1#64
  else
    rs1_val.sdiv rs2_val

-- old proof strategy
theorem DIV_pure64_signed_eq_DIV_pure64_signed_bv  (rs2_val : BitVec 64) (rs1_val : BitVec 64)  :
  DIV_pure64_signed (rs2_val) (rs1_val ) = DIV_pure64_signed_bv (rs2_val) (rs1_val ) := by
    unfold DIV_pure64_signed DIV_pure64_signed_bv
    rw [extractLsb'_ofInt_eq_ofInt (h:= by simp)]
    by_cases h : rs2_val = 0#64
    · simp [h]
    case neg =>
      have h' : rs2_val.toInt ≠ 0 := by
        have h1 := (BitVec.toInt_ne).mpr h
        exact h1
      apply BitVec.eq_of_toInt_eq
      simp only [Int.reduceSub, h', ↓reduceIte, Int.reduceNeg, BitVec.toInt_ofInt, h]
      simp [BitVec.toInt_sdiv]
      sorry


-- new proof strategy
example
    (rs2_val rs1_val : BitVec 64)
    (h : ¬rs2_val = 0#64) :
    (if 9223372036854775807 < rs1_val.toInt.tdiv rs2_val.toInt then -9223372036854775808
        else rs1_val.toInt.tdiv rs2_val.toInt).bmod 18446744073709551616 =
    (rs1_val.toInt.tdiv rs2_val.toInt).bmod 18446744073709551616 := by
  by_cases h : rs1_val = .intMin _ ∧ rs2_val = -1#64
  · obtain ⟨rs1, rs2⟩ := h
    subst rs1 rs2
    simp [BitVec.toInt_intMin]
  · have := BitVec.toInt_sdiv_of_ne_or_ne rs1_val rs2_val <| by
      rw [← Decidable.not_and_iff_not_or_not]
      exact h
    rw[← this]
    split
    case neg.isTrue iT =>
      have intMax : (BitVec.intMax 64).toInt =  9223372036854775807 := by native_decide
      rw [← intMax] at iT
      sorry -- HERE TO DO
    case neg.isFalse iF =>
      rfl
