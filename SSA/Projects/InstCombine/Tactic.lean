import SSA.Core.WellTypedFramework
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.ForMathlib
import SSA.Projects.InstCombine.CommRing

open SSA 

macro "simp_alive": tactic =>
  `(tactic|
      (
        simp (config := {decide := false}) only [InstCombine.eval, pairMapM,
          tripleMapM, pairMapM, pairBind, bind_assoc, pure, Option.map, Option.bind_eq_some',
          Option.some_bind', Option.bind_eq_bind, Bitvec.Refinement.some_some]
      )
   )

macro "alive_auto": tactic =>
  `(tactic|
      (
        ring_nf 
        try simp (config := {decide := false})--placeholder, as `simp` will currently timeout sometimes
      )
   )

