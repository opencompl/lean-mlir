import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic

open MLIR AST
open Std (BitVec)
open Ctxt (Var)

-- set_option pp.proofs false
-- set_option pp.proofs.withType false


/-
Name: SimplifyDivRemOfSelect

%sel = select %c, %Y, 0
%r = udiv %X, %sel
  =>
%r = udiv %X, %Y

-/

/-
def alive_simplifyDivRemOfSelect (w : Nat) :
[mlir_icom( w )| {
^bb0(%c : i1, %X : _, %Y : _):
  %v0  = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
  %sel = "llvm.select" (%c,%Y,%v0) : (i1, _, _) -> (_)
  %r   = "llvm.udiv" (%X,%sel) : (_, _) -> (_)
  "llvm.return" (%r) : (_) -> ()
}] ⊑ [mlir_icom ( w )| {
^bb0(%c : i1, %X : _, %Y : _):
  %r = "llvm.udiv" (%X,%Y) : (_, _) -> (_)
  "llvm.return" (%r) : (_) -> ()
}] := by
  simp_alive_peephole
  -- goal: ⊢ BitVec.udiv? x1✝ (BitVec.select x2✝ x0✝ (BitVec.ofInt w 0)) ⊑ BitVec.udiv? x1✝ x0✝
  sorry
-/

/-
Name: MulDivRem:805
%r = sdiv 1, %X
  =>
%inc = add %X, 1
%c = icmp ult %inc, 3
%r = select %c, %X, 0

Proof:
======
  Values of LHS:
    - 1/x where x >= 2: 0
    - 1/1 = 1
    - 1/0 = UB
    - 1/ -1 = -1
    - 1/x where x <= -2: 0
  Values of RHS:
    RHS: (x + 2) <u 3 ? x : 0
    - x >= 2: (x + 1) <u 3 ? x : 0
              =  false ? x : 0 = false
    - x = 1: (1 + 1) <u 3 ? x : 0
              = 2 <u 3 ? x : 0
              = true ? x : 0
              = x = 1
    - x = 0: (0 + 1) <u 3 ? x : 0
              = 1 <u 3 ? 0 : 0
              = true ? 0 : 0
              = 0
    - x = -1: (-1 + 1) <u 3 ? x : 0
              = 0 <u 3 ? x : 0
              = true ? x : 0
              = x = -1
    - x <= -2 : (-2 + 1) <u 3 ? x : 0
              = -1 <u 3 ? x : 0
              = INT_MAX < 3 ? x : 0
              = false ? x : 0
              = 0
 Thus, LHS and RHS agree on values.
-/
def alive_simplifyMulDivRem805 (w : Nat) :
    [alive_icom ( w )| {
    ^bb0(%X : _):
      %v1  = "llvm.mlir.constant" () { value = 1 : _ } :() -> (_)
      %r   = "llvm.sdiv" (%v1,%X) : (_, _) -> (_)
      "llvm.return" (%r) : (_) -> ()
    }] ⊑ [alive_icom ( w )| {
    ^bb0(%X : _):
      %v1  = "llvm.mlir.constant" () { value = 1 : _ } :() -> (_)
      %inc = "llvm.add" (%v1,%X) : (_, _) -> (_)
      %v3  = "llvm.mlir.constant" () { value = 3 : _ } :() -> (_)
      %c   = "llvm.icmp.ult" (%inc, %v3) : (_, _) -> (i1)
      %v0  = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
      %r = "llvm.select" (%c, %X, %v0) : (i1, _, _) -> (_)
      "llvm.return" (%r) : (_) -> ()
    }] := by
  simp_alive_peephole
  sorry

/-
Name: MulDivRem:290

%Op0 = shl 1, %Y
%r = mul %Op0, %Op1
  =>
%r = shl %Op1, %Y

Proof
======
  1. Without taking UB into account
    ⟦LHS₁⟧: (1 << Y) . Op1 = (1 . 2^Y) X = 2^Y . Op1
    ⟦RHS₁⟧: Op1 << Y = Op1 . 2^Y
    equal by ring.

  2. With UB into account
    ⟦LHS₂⟧: (1 << Y) . Op1 = Y >= n ? UB : ⟦LHS₁⟧
    ⟦RHS₂⟧: Op1 << Y = Y >= n ? UB : ⟦RHS₁⟧
    but ⟦LHS₁⟧ = ⟦ RHS₁⟧ and thus we are done.

-/
def alive_simplifyMulDivRem290 (w : Nat) :
    [alive_icom ( w )| {
    ^bb0(%Op1 : _ , %Y : _):
      %v1  = "llvm.mlir.constant" () { value = 1 : _ } :() -> (_)
      %Op0   = "llvm.shl" (%v1, %Y) : (_, _) -> (_)
      %r = "llvm.mul"(%Op0, %Op1) : (_, _) -> (_)
      "llvm.return" (%r) : (_) -> ()
    }] ⊑ [alive_icom ( w )| {
    ^bb0(%Op1 : _, %Y : _):
      %r = "llvm.mul" (%Op1, %Y) : (_, _) -> (_)
      "llvm.return" (%r) : (_) -> ()
    }] := by
  simp_alive_peephole
  sorry

