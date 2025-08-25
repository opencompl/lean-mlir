
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem match_signed_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬((299#64 == 0 || 64 != 1 && x == intMin 64 && 299#64 == -1) = true ∨
        (299#64 == 0 || 64 != 1 && x == intMin 64 && 299#64 == -1) = true ∨
          (64#64 == 0 || 64 != 1 && x.sdiv 299#64 == intMin 64 && 64#64 == -1) = true ∨
            (19136#64 == 0 || 64 != 1 && x == intMin 64 && 19136#64 == -1) = true ∨
              (9#64 == 0 || 64 != 1 && x.sdiv 19136#64 == intMin 64 && 9#64 == -1) = true) →
    (172224#64 == 0 || 64 != 1 && x == intMin 64 && 172224#64 == -1) = true → False :=
sorry