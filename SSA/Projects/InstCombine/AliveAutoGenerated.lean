import SSA.Projects.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.Transform
import SSA.Projects.InstCombine.LLVM.EDSL
open MLIR AST
open MLIR AST


/- Notes on generation:
  - MLIR generic syntax for llvm constants is `llvm.mlir.constant`, 
    not `llvm.constant`.
 - Return statement arity seems to be wrong
 -/

-- Name:AddSub:1043
-- precondition: true
/-
  %Y = and %Z, C1
  %X = xor %Y, C1
  %LHS = add %X, 1
  %r = add %LHS, %RHS

=>
  %or = or %Z, ~C1
  %Y = and %Z, C1
  %X = xor %Y, C1
  %LHS = add %X, 1
  %r = sub %RHS, %or

-/
def AddSub_1043_src (w : Nat) :=
[mlir_region| {
^bb0(%C1 : i32, %Z : i32, %RHS : i32):
  %v1 = "llvm.and" (%Z,%C1) : (i32, i32) -> (i32)
  %v2 = "llvm.xor" (%v1,%C1) : (i32, i32) -> (i32)
  %v3 = "llvm.mlir.constant" () { value = $(.int 1 (.i w)) }:() -> (i32)
  %v4 = "llvm.add" (%v2,%v3) : (i32, i32) -> (i32)
  %v5 = "llvm.add" (%v4,%RHS) : (i32, i32) -> (i32)
  "llvm.return" (%v5) : (i32) -> (i32)
}]

def AddSub_1043 (w : Nat ):= 
  mkCom (AddSub_1043_src w) |>.toOption |>.get 
    (by unfold AddSub_1043_src 
        simp [mkCom, Region.ops, BuilderM.runWithNewMapping, Except.toOption, 
              Option.isSome, StateT.run] 
        rfl)
-- Not sure how rfl sholud work here, it needs to execute the whole thing.


def AddSub_1043' (w : Nat ) := 
  mkCom (AddSub_1043_src w)

#eval AddSub_1043' 32 

-- set_option maxHeartbeats 99999999999 in
-- set_option maxHeartbeats 900000 in
def AddSub_1043_tgt (w : Nat):=
[mlir_icom| {
^bb0(%C1 : i32, %Z : i32, %RHS : i32):
  %v1 = "llvm.and" (%Z,%C1) : (i32, i32) -> (i32)
  %v2 = "llvm.xor" (%v1,%C1) : (i32, i32) -> (i32)
  %v3 = "llvm.mlir.constant" () { value = $(.int 1 (.i w)) }:() -> (i32)
  %v4 = "llvm.add" (%v2,%v3) : (i32, i32) -> (i32)
  %v5 = "llvm.add" (%v4,%RHS) : (i32, i32) -> (i32)
  "llvm.return" (%v5) : (i32) -> (i32)
}]
-- maximum recursion depth has been reached (use `set_option maxRecDepth <num>` to increase limit)

-- 
-- 