import Mathlib.Tactic.Ring

macro "alive_auto": tactic =>
  `(tactic|
      (
        skip; --placeholder, as `simp` will currently timeout sometimes
        try (intros; ring_nf)
        try simp (config := {decide := false})
      )
   )
