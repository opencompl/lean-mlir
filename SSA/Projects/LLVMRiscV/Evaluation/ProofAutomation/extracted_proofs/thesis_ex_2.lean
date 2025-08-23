  correct := by
    unfold original_sdiv_srem_correct combined_sdiv_srem_correct
    simp_peephole
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    intro x x1
    split
    case value.value.isFalse hf =>
      simp at hf
      obtain ⟨hf₁, hf₂⟩ := hf
      replace hf₂ : x ≠ intMin _ ∨ x1 ≠ -1#64 := by
          by_cases h : x = intMin _
          · exact .inr <| hf₂ h
          · exact .inl h
      simp only [PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
      --bv_decide
      sorry
      --simp [hf₁, hf₂]
    case value.value.isTrue ht =>
      simp only [PoisonOr.isRefinedBy_self]

