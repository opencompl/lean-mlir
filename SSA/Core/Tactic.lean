import SSA.Core.WellTypedFramework

open SSA 

macro "simp_mlir": tactic => 
  `(tactic| 
      (simp [TSSA.eval, Function.comp, id.def, TypedUserSemantics,
        TypedUserSemantics.eval, Context.Var,
        TypedUserSemantics.outUserType, TypedUserSemantics.argUserType,
        UserType.mkPair] ; 
       simp [bind_assoc, Option.bind_eq_some', Option.some_bind', 
             Option.bind_eq_bind, pure])
   )