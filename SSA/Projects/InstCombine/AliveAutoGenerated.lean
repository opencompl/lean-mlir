import SSA.Projects.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.LLVM.Transform
import SSA.Projects.InstCombine.LLVM.EDSL
open MLIR AST
open MLIR AST


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
def AddSub_1043_src :=
[mlir_region| {
^bb0(%C1 : i32, %Z : i32, %RHS : i32):
  %v1 = "llvm.and" (%Z,%C1) : (i32, i32) -> (i32)
  %v2 = "llvm.xor" (%v1,%C1) : (i32, i32) -> (i32)
  %v3 = "llvm.constant" () { value = $(.int 1 (.i w)) }:() -> (i32)
  %v4 = "llvm.add" (%v2,%v3) : (i32, i32) -> (i32)
  %v5 = "llvm.add" (%v4,%RHS) : (i32, i32) -> (i32)
  "llvm.return" (%v5) : () -> (i32)
}]

/- It does not like the generic `w`. -/
def com := 
  mkCom (AddSub_1043_src) |>.toOption |>.get (by rfl)



set_option maxHeartbeats 99999999999 in
def AddSub_1043_tgt (w : Nat):=
[mlir_icom| {
^bb0(%C1 : i32, %Z : i32, %RHS : i32):
  %v1 = "llvm.not" (%C1) : (i32) -> (i32)
  %v2 = "llvm.or" (%Z,%v1) : (i32, i32) -> (i32)
  %v3 = "llvm.and" (%Z,%C1) : (i32, i32) -> (i32)
  %v4 = "llvm.xor" (%v3,%C1) : (i32, i32) -> (i32)
  %v5 = "llvm.mlir.constant" () { value = $(.int 1 (.i w)) }:() -> (i32)
  %v6 = "llvm.add" (%v4,%v5) : (i32, i32) -> (i32)
  %v7 = "llvm.sub" (%RHS,%v2) : (i32, i32) -> (i32)
  "llvm.return" (%v7) : () -> (i32)
}]

