macro "alive_auto": tactic =>
  `(tactic|
      (
        skip; --placeholder, as `simp` will currently timeout sometimes
        try simp (config := {decide := false})
      )
   )