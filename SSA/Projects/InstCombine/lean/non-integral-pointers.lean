import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  non-integral-pointers
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_0_before := [llvmfunc|
  llvm.func @f_0() -> !llvm.ptr<4> {
    %0 = llvm.mlir.zero : !llvm.ptr<4>
    %1 = llvm.mlir.constant(50 : i64) : i64
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, i8
    llvm.return %2 : !llvm.ptr<4>
  }]

def f_1_before := [llvmfunc|
  llvm.func @f_1() -> !llvm.ptr<3> {
    %0 = llvm.mlir.zero : !llvm.ptr<3>
    %1 = llvm.mlir.constant(50 : i64) : i64
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i8
    llvm.return %2 : !llvm.ptr<3>
  }]

def f_2_before := [llvmfunc|
  llvm.func @f_2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr<4>]

    llvm.store %0, %arg1 {alignment = 8 : i64} : !llvm.ptr<4>, !llvm.ptr]

    llvm.return
  }]

def f_3_before := [llvmfunc|
  llvm.func @f_3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr<3>]

    llvm.store %0, %arg1 {alignment = 8 : i64} : !llvm.ptr<3>, !llvm.ptr]

    llvm.return
  }]

def g_before := [llvmfunc|
  llvm.func @g(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr<4>]

    %2 = llvm.call @alloc() : () -> !llvm.ptr<4>
    %3 = llvm.addrspacecast %2 : !llvm.ptr<4> to !llvm.ptr
    %4 = llvm.getelementptr %3[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr<4>
    llvm.store %1, %4 {alignment = 8 : i64} : !llvm.ptr<4>, !llvm.ptr]

    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> i64]

    llvm.return %5 : i64
  }]

def g2_before := [llvmfunc|
  llvm.func @g2(%arg0: !llvm.ptr<4>) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr<4> -> !llvm.ptr]

    %2 = llvm.call @alloc() : () -> !llvm.ptr<4>
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, !llvm.ptr
    llvm.store %1, %3 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr<4>]

    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr<4> -> i64]

    llvm.return %4 : i64
  }]

def f_4_before := [llvmfunc|
  llvm.func @f_4(%arg0: !llvm.ptr<4>) -> i64 {
    %0 = llvm.mlir.addressof @f_5 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr<4>) -> i64
    llvm.return %1 : i64
  }]

def f_0_combined := [llvmfunc|
  llvm.func @f_0() -> !llvm.ptr<4> {
    %0 = llvm.mlir.constant(50 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<4>
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, i8
    llvm.return %2 : !llvm.ptr<4>
  }]

theorem inst_combine_f_0   : f_0_before  ⊑  f_0_combined := by
  unfold f_0_before f_0_combined
  simp_alive_peephole
  sorry
def f_1_combined := [llvmfunc|
  llvm.func @f_1() -> !llvm.ptr<3> {
    %0 = llvm.mlir.constant(50 : i64) : i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr<3>
    llvm.return %1 : !llvm.ptr<3>
  }]

theorem inst_combine_f_1   : f_1_before  ⊑  f_1_combined := by
  unfold f_1_before f_1_combined
  simp_alive_peephole
  sorry
def f_2_combined := [llvmfunc|
  llvm.func @f_2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr<4>
    llvm.store %0, %arg1 {alignment = 8 : i64} : !llvm.ptr<4>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_f_2   : f_2_before  ⊑  f_2_combined := by
  unfold f_2_before f_2_combined
  simp_alive_peephole
  sorry
def f_3_combined := [llvmfunc|
  llvm.func @f_3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr<3>
    llvm.store %0, %arg1 {alignment = 8 : i64} : !llvm.ptr<3>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_f_3   : f_3_before  ⊑  f_3_combined := by
  unfold f_3_before f_3_combined
  simp_alive_peephole
  sorry
def g_combined := [llvmfunc|
  llvm.func @g(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr<4>
    %2 = llvm.call @alloc() : () -> !llvm.ptr<4>
    %3 = llvm.addrspacecast %2 : !llvm.ptr<4> to !llvm.ptr
    %4 = llvm.getelementptr %3[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr<4>
    llvm.store %1, %4 {alignment = 8 : i64} : !llvm.ptr<4>, !llvm.ptr
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_g   : g_before  ⊑  g_combined := by
  unfold g_before g_combined
  simp_alive_peephole
  sorry
def g2_combined := [llvmfunc|
  llvm.func @g2(%arg0: !llvm.ptr<4>) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr<4> -> !llvm.ptr
    %2 = llvm.call @alloc() : () -> !llvm.ptr<4>
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, !llvm.ptr
    llvm.store %1, %3 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr<4>
    %4 = llvm.ptrtoint %1 : !llvm.ptr to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_g2   : g2_before  ⊑  g2_combined := by
  unfold g2_before g2_combined
  simp_alive_peephole
  sorry
def f_4_combined := [llvmfunc|
  llvm.func @f_4(%arg0: !llvm.ptr<4>) -> i64 {
    %0 = llvm.mlir.addressof @f_5 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr<4>) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_f_4   : f_4_before  ⊑  f_4_combined := by
  unfold f_4_before f_4_combined
  simp_alive_peephole
  sorry
