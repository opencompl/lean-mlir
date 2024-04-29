import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.Tactic

open BitVec
open MLIR AST

namespace AliveHandwritten

namespace DivRemOfSelect

/--
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

def alive_DivRemOfSelect_tgt (w : Nat) :=
  [alive_icom (w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %v1 = "llvm.udiv" (%x,%y) : (_, _) -> (_)
    "llvm.return" (%v1) : (_) -> ()
  }]

theorem alive_DivRemOfSelect (w : Nat) :
    alive_DivRemOfSelect_src w ⊑ alive_DivRemOfSelect_tgt w := by
  unfold alive_DivRemOfSelect_src alive_DivRemOfSelect_tgt
  simp_alive_ssa
  simp_alive_undef
  simp [simp_llvm]
  intro y c x
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

/--info: 'AliveHandwritten.DivRemOfSelect.alive_DivRemOfSelect' depends on
axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms alive_DivRemOfSelect

end DivRemOfSelect

end AliveHandwritten
