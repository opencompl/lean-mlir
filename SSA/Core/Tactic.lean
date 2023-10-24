import SSA.Core.WellTypedFramework

open SSA

macro "simp_mlir": tactic =>
  `(tactic|
      (
       simp (config := {decide := false}) only [TSSA.eval, Function.comp,
         id.def, TypedUserSemantics, TypedUserSemantics.eval, Context.Var,
         TypedUserSemantics.outUserType, TypedUserSemantics.argUserType,
         UserType.mkPair, UserType.mkTriple]
      )
   )