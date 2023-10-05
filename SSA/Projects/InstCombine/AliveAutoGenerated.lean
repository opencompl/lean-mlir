
import SSA.Projects.InstCombine.LLVM.EDSL
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
def AddSub_1043_src (w : Nat) :=
[mlir_icom (w)| {
^bb0(%C1 : _, %Z : _, %RHS : _):
  %v1 = "llvm.and" (%Z,%C1) : (_, _) -> (_)
  %v2 = "llvm.xor" (%v1,%C1) : (_, _) -> (_)
  %v3 = "llvm.constant" () { value = $(.int 1 (.i w)) }:() -> (_)
  %v4 = "llvm.add" (%v2,%v3) : (_, _) -> (_)
  %v5 = "llvm.add" (%v4,%RHS) : (_, _) -> (_)
  "llvm.return" (%v5) : () -> (_)
}]

def AddSub_1043_tgt (w : Nat):=
[mlir_icom (w)| {
^bb0(%C1 : _, %Z : _, %RHS : _):
  %v1 = "llvm.not" (%C1) : (_) -> (_)
  %v2 = "llvm.or" (%Z,%v1) : (_, _) -> (_)
  %v3 = "llvm.and" (%Z,%C1) : (_, _) -> (_)
  %v4 = "llvm.xor" (%v3,%C1) : (_, _) -> (_)
  %v5 = "llvm.constant" () { value = $(.int 1 (.i w)) }:() -> (_)
  %v6 = "llvm.add" (%v4,%v5) : (_, _) -> (_)
  %v7 = "llvm.sub" (%RHS,%v2) : (_, _) -> (_)
  "llvm.return" (%v7) : () -> (_)
}]
