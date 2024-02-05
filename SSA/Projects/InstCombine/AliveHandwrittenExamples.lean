import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
--import SSA.Projects.InstCombine.LLVM.CLITests
import SSA.Projects.InstCombine.Base
import SSA.Core.ErasedContext

open MLIR AST
open Std (BitVec)
open Ctxt (Var DerivedCtxt)
open InstCombine (MOp)

namespace AliveHandwritten
set_option pp.proofs false
set_option pp.proofs.withType false
open Qq Lean

variable (w : Nat)


/-
Name: SimplifyDivRemOfSelect
precondition: true
%sel = select %c, %Y, 0
%r = udiv %X, %sel
  =>
%r = udiv %X, %Y

-/
def alive_DivRemOfSelect_src (w : Nat) :=
  [alive_icom (w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %c0 = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
    %v1 = "llvm.select" (%c,%y, %c0) : (i1, _, _) -> (_)
    %v2 = "llvm.udiv"(%x, %v1) : (_, _) -> (_)
    "llvm.return" (%v2) : (_) -> ()
  }]

<<<<<<< HEAD
deftest alive_simplifyDivRemOfSelect_lhs :=
{
^bb0(%c : i1, %X : _, %Y : _):
  %v0  = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
  %sel = "llvm.select" (%c,%Y,%v0) : (i1, _, _) -> (_)
  %r   = "llvm.udiv" (%X,%sel) : (_, _) -> (_)
  "llvm.return" (%r) : (_) -> ()
}

deftest alive_simplifyDivRemOfSelect_rhs  :=
{
^bb0(%c : i1, %X : _, %Y : _):
  %r = "llvm.udiv" (%X,%Y) : (_, _) -> (_)
  "llvm.return" (%r) : (_) -> ()
}

deftest alive_simplifyDivRemOfSelect_rhs_constbw :=
{
^bb0(%c : i1, %X : i8, %Y : i8):
  %r = "llvm.udiv" (%X,%Y) : (i8, i8) -> (i8)
  "llvm.return" (%r) : (i8) -> ()
}

/-
 This is not so nice, having to have the `|>.code`
 snippet to extract the actual code. Maybe the macro
 should instantiate the name directly with the code
 and generate a second name `_test` with the full test?
-/
theorem alive_simplifyDivRemOfSelect  :
  (alive_simplifyDivRemOfSelect_lhs w |>.code) ⊑
  (alive_simplifyDivRemOfSelect_rhs w |>.code) := by
  unfold alive_simplifyDivRemOfSelect_lhs alive_simplifyDivRemOfSelect_rhs
  simp_alive_peephole
  -- goal: ⊢ BitVec.udiv? x1✝ (BitVec.select x2✝ x0✝ (BitVec.ofInt w 0)) ⊑ BitVec.udiv? x1✝ x0✝
  <;> sorry

deftest alive_unsound_lhs :=
{
^bb0():
  %v0  = "llvm.mlir.constant" () { value = 9 : i8 } :() -> (i8)
  %v1  = "llvm.mlir.constant" () { value = 1 : i8 } :() -> (i8)
  %undef  = "llvm.shl" (%v1,%v0) : (i8, i8) -> (i8)
  %r = "llvm.or" (%v1,%undef) : (i8, i8) -> (i8)
  "llvm.return" (%r) : (i8) -> ()
}

deftest alive_unsound_rhs :=
{
^bb0():
  %v0  = "llvm.mlir.constant" () { value = 2 : i8 } :() -> (i8)
  "llvm.return" (%v0) : (i8) -> ()
}

theorem alive_unsound :
 (alive_unsound_lhs w |>.code) ⊑
 (alive_unsound_lhs w |>.code) := by
  simp_alive_peephole
  simp [BitVec.toNat, BitVec.ofInt, BitVec.toFin, Fin.val]

def allTests := llvmTests!
#reduce allTests

def myTest := alive_simplifyDivRemOfSelect_rhs 42 |>.code
#printSignature myTest
#reduce getSignature! (alive_simplifyDivRemOfSelect_rhs 42).code

def myTestSignature := getSignature! myTest
def test2 := {alive_simplifyDivRemOfSelect_rhs 42 with signature := getSignature! myTest}

#reduce test2
#reduce alive_simplifyDivRemOfSelect_rhs_constbw
=======
def alive_DivRemOfSelect_tgt (w : Nat) :=
  [alive_icom (w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %v1 = "llvm.udiv" (%x,%y) : (_, _) -> (_)
    "llvm.return" (%v1) : (_) -> ()
  }]

@[simp]
theorem BitVec.ofNat_toNat_zero :
BitVec.toNat (BitVec.ofInt w 0) = 0 := by
  simp[BitVec.toNat, BitVec.ofInt, BitVec.toFin, BitVec.ofNat, OfNat.ofNat]
  norm_cast

theorem alive_DivRemOfSelect (w : Nat) :
    alive_DivRemOfSelect_src w ⊑ alive_DivRemOfSelect_tgt w := by
  unfold alive_DivRemOfSelect_src alive_DivRemOfSelect_tgt
  intros Γv
  simp_peephole at Γv
  simp (config := {decide := false}) only [OpDenote.denote,
    InstCombine.Op.denote, HVector.toPair, HVector.toTriple, pairMapM, BitVec.Refinement,
    bind, Option.bind, pure, DerivedCtxt.ofCtxt, DerivedCtxt.snoc,
    Ctxt.snoc, ConcreteOrMVar.instantiate, Vector.get, HVector.toSingle,
    LLVM.and?, LLVM.or?, LLVM.xor?, LLVM.add?, LLVM.sub?,
    LLVM.mul?, LLVM.udiv?, LLVM.sdiv?, LLVM.urem?, LLVM.srem?,
    LLVM.sshr, LLVM.lshr?, LLVM.ashr?, LLVM.shl?, LLVM.select?,
    LLVM.const?, LLVM.icmp?, LLVM.udiv?,
    HVector.toTuple, List.nthLe, bitvec_minus_one]
  intro y x c
  simp only [List.length_singleton, Fin.zero_eta, List.get_cons_zero, List.map_eq_map, List.map_cons,
    List.map_nil, CharP.cast_eq_zero, Ctxt.Valuation.snoc_last, pairBind, bind, Option.bind, Int.ofNat_eq_coe]
  clear Γv
  cases c
  -- | select condition is itself `none`, nothing more to be done. propagate the `none`.
  case none => cases x <;> cases y <;> simp
  case some cond =>
     obtain ⟨vcond, hcond⟩ := cond
     obtain (h | h) : vcond = 1 ∨ vcond = 0 := by
       norm_num at hcond
       rcases vcond with zero | vcond <;> simp;
       rcases vcond with zero | vcond <;> simp;
       linarith
     . subst h
       simp
     . subst h; simp
       cases' x with vx <;>
       cases' y with vy <;> simp [LLVM.udiv?]

end AliveHandwritten
>>>>>>> origin/main
