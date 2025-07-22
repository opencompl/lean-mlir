
namespace BitVec

theorem toInt_dvd_toInt_of_smod {w : Nat} {x y : BitVec w} :
    y.smod x = 0#w → x.toInt ∣ y.toInt := by
  rw [← BitVec.toInt_inj, BitVec.toInt_smod, BitVec.toInt_zero]
  exact Int.dvd_of_fmod_eq_zero

theorem mul_sdiv_cancel_of_dvd_of_ne {w : Nat} {x y : BitVec w}
    (h₁ : y.smod x = 0#_)
    (h₂ : y ≠ intMin w ∨ x ≠ -1#w) :
    x * y.sdiv x = y := by
  replace h₁ : x.toInt ∣ y.toInt := toInt_dvd_toInt_of_smod h₁
  apply eq_of_toInt_eq
  simp [BitVec.toInt_sdiv_of_ne_or_ne _ _ h₂, Int.mul_tdiv_cancel' h₁]

theorem srem_eq_zero_iff_smod_eq_zero {w : Nat} {x y : BitVec w} :
    x.srem y = 0#_ ↔ x.smod y = 0#_ := by
  simp only [← toInt_inj, toInt_smod, toInt_zero, toInt_srem]
  constructor <;> intro h
  · simp [Int.fmod_eq_tmod, Int.dvd_of_tmod_eq_zero h, h]
  · simp [Int.tmod_eq_fmod, Int.dvd_of_fmod_eq_zero h, h]

example
    (x x1 : BitVec 64)
    (ht : x.smod x1 = 0#64)
    (hf : ¬x1 = 0#64 ∧ (x = BitVec.intMin 64 → ¬x1 = 18446744073709551615#64)) :
    x.srem x1 = x - x1 * x.sdiv x1 := by
  obtain ⟨hf₁, hf₂⟩ := hf
  replace hf₂ : x ≠ intMin _ ∨ x1 ≠ -1#64 := Decidable.not_or_of_imp hf₂
  simp [mul_sdiv_cancel_of_dvd_of_ne ht hf₂, srem_eq_zero_iff_smod_eq_zero, ht]
