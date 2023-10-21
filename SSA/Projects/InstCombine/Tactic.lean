import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.ForMathlib

macro "simp_alive": tactic =>
  `(tactic|
      (
        simp (config := {decide := false}) only [InstCombine.Op.denote, pairMapM,
          tripleMapM, pairMapM, pairBind, bind_assoc, pure, Option.map, Option.bind_eq_some',
          Option.some_bind', Option.bind_eq_bind, Bitvec.Refinement.some_some]
      )
   )