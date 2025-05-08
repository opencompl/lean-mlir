/- Int theory to be upstreamed to Lean. -/

-- theorem Int.ofNat_ediv_ofNat -- sorry
-- theorem Int.ofNat_ediv_negSucc -- sorry
-- theorem Int.ofNat_ediv_ofNat -- sorry
-- theorem Int.ofNat_ediv_ofNat -- sorry

#check Int.bmod
#check Int.ediv_nonneg_of_nonpos_of_nonpos
theorem Int.bmod_eq_of_natAbs_lt (x : Int) (n : Nat) (hn : 2 * x.natAbs < n) : 
    x.bmod n = x := by 
  rcases x with x | x 
  case ofNat => 
   simp at *; 
   rw [Int.bmod_def]
   norm_cast
   have : x % n = x := by 
    apply Nat.mod_eq_of_lt
    omega
   rw [this]
   have : x < (n + 1) / 2 := by 
     rw [Nat.lt_div_iff_mul_lt (by decide)]
     omega
   simp [this]
  case negSucc => 
    simp at *
    norm_cast
    rw [Int.bmod_def]
    -- This is true because 'emod' will flip it over, making it larger that (n + 1) / 2
    have : ¬ (Int.negSucc x % (n : Int) < ((n : Int) + 1) / 2) := by 
      rw [Int.emod_negSucc]
      simp
      sorry
    simp [this]
    have h := Int.ediv_add_emod (Int.negSucc x) n
    -- see that (Int.negSucc x / n) = -1, giving us the intended statement..
    -- This is true because 'Int.negSucc x < 0' and '(Int.negSucc x).natAbs < n'
    have hMinusOne : (Int.negSucc x / ↑n) = -1 := by 
     rw [Int.div_def]
     sorry
    simp [hMinusOne] at h
    omega


