import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2011-10-07-AlignPromotion
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t_before := [llvmfunc|
  llvm.func @t(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"struct.CGPoint", (f32, f32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64]

    llvm.store %2, %1 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def t_combined := [llvmfunc|
  llvm.func @t(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"struct.CGPoint", (f32, f32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_t   : t_before  ⊑  t_combined := by
  unfold t_before t_combined
  simp_alive_peephole
  sorry
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64]

theorem inst_combine_t   : t_before  ⊑  t_combined := by
  unfold t_before t_combined
  simp_alive_peephole
  sorry
    llvm.store %2, %1 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_t   : t_before  ⊑  t_combined := by
  unfold t_before t_combined
  simp_alive_peephole
  sorry
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_t   : t_before  ⊑  t_combined := by
  unfold t_before t_combined
  simp_alive_peephole
  sorry
