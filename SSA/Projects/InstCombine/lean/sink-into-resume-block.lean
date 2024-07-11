import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sink-into-resume-block
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_noop_before := [llvmfunc|
  llvm.func @t0_noop(%arg0: i32) attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.call @cond() : () -> i1
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.add %arg0, %1  : i32
    llvm.cond_br %2, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.invoke @simple_throw() to ^bb2 unwind ^bb3 : () -> ()
  ^bb2:  // pred: ^bb1
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %5 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.call @consume(%3) : (i32) -> ()
    llvm.call @destructor() : () -> ()
    llvm.resume %5 : !llvm.struct<(ptr, i32)>
  ^bb4:  // pred: ^bb0
    llvm.call @consume(%4) : (i32) -> ()
    llvm.call @sideeffect() : () -> ()
    llvm.return
  }]

def t0_noop_combined := [llvmfunc|
  llvm.func @t0_noop(%arg0: i32) attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.call @cond() : () -> i1
    llvm.cond_br %2, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.invoke @simple_throw() to ^bb2 unwind ^bb3 : () -> ()
  ^bb2:  // pred: ^bb1
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %3 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    %4 = llvm.add %arg0, %1  : i32
    llvm.call @consume(%4) : (i32) -> ()
    llvm.call @destructor() : () -> ()
    llvm.resume %3 : !llvm.struct<(ptr, i32)>
  ^bb4:  // pred: ^bb0
    %5 = llvm.add %arg0, %0  : i32
    llvm.call @consume(%5) : (i32) -> ()
    llvm.call @sideeffect() : () -> ()
    llvm.return
  }]

theorem inst_combine_t0_noop   : t0_noop_before  ⊑  t0_noop_combined := by
  unfold t0_noop_before t0_noop_combined
  simp_alive_peephole
  sorry
