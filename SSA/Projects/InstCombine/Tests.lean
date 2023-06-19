import SSA.Projects.InstCombine.InstCombineBase

namespace InstCombine
open SSA EDSL in
def test1 (params : Nat × Nat × Nat) : IO Bool := do 
  let (w, A, B) := params
  let E : EnvC ∅ := EnvC.empty 
  let out : Option (Bitvec w) := TSSA.eval
    [dsl_bb|
    ^bb
    %v9999 := unit: ;
    %v1 := op:const (Bitvec.ofInt' w A) %v9999;
    %v2 := op:const (Bitvec.ofInt' w B) %v9999;
    %v3 := pair:%v1 %v2;
    %v4 := op:xor w %v3;
    %v5 := op:const (Bitvec.ofInt' w (-1)) %v9999;
    %v6 := pair:%v4 %v5;
    %v7 := op:xor w %v6;
    %v8 := pair:%v1 %v7;
    %v9 := op:or w %v8
    dsl_ret %v9
    ] E 
  IO.println (repr out)
  return true
