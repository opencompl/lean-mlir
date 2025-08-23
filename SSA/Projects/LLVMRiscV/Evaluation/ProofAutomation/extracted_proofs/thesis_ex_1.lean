  correct := by
    unfold original_sdiv_srem combined_sdiv_srem
    simp_peephole
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    intro x x1
    split
    case value.value.isTrue ht =>
      simp [ht]
    case value.value.isFalse hf =>
      simp
      split
      case isTrue ht =>
        simp [ht, hf]
        simp at hf
        obtain ⟨hf₁, hf₂⟩ := hf
        replace hf₂ : x ≠ intMin _ ∨ x1 ≠ -1#64 := by
          by_cases h : x = intMin _
          · exact .inr <| hf₂ h
          · exact .inl h
        simp only [mul_sdiv_cancel_of_dvd_of_ne ht hf₂, BitVec.sub_self]
        apply srem_eq_zero_of_smod ht
      case isFalse hf =>
        sorry
       -- sorry -- this case shows how the pattern is wrong in the case of an exact flag.

