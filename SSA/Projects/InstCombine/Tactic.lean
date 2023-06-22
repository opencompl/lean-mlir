import SSA.Core.WellTypedFramework
import SSA.Projects.InstCombine.InstCombineBase

open SSA 

macro "simp_alive": tactic =>
  `(tactic|
      (
        simp only [InstCombine.eval, pairMapM, pairBind, bind_assoc, pure];
        simp only [Option.map, Option.bind_eq_some', Option.some_bind', Option.bind_eq_bind, Refinement.some_some]
      )
   )

