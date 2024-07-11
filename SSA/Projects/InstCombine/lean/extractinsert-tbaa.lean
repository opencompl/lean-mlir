import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  extractinsert-tbaa
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def teststructextract_before := [llvmfunc|
  llvm.func @teststructextract(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> !llvm.struct<"Complex", (f64, f64)>]

    %1 = llvm.extractvalue %0[0] : !llvm.struct<"Complex", (f64, f64)> 
    llvm.return %1 : f64
  }]

def testarrayextract_before := [llvmfunc|
  llvm.func @testarrayextract(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> !llvm.array<2 x f64>]

    %1 = llvm.extractvalue %0[0] : !llvm.array<2 x f64> 
    llvm.return %1 : f64
  }]

def teststructinsert_before := [llvmfunc|
  llvm.func @teststructinsert(%arg0: !llvm.ptr, %arg1: f64, %arg2: f64) {
    %0 = llvm.mlir.undef : !llvm.struct<"Complex", (f64, f64)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<"Complex", (f64, f64)> 
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<"Complex", (f64, f64)> 
    llvm.store %2, %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.struct<"Complex", (f64, f64)>, !llvm.ptr]

    llvm.return
  }]

def testarrayinsert_before := [llvmfunc|
  llvm.func @testarrayinsert(%arg0: !llvm.ptr, %arg1: f64, %arg2: f64) {
    %0 = llvm.mlir.undef : !llvm.array<2 x f64>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.array<2 x f64> 
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.array<2 x f64> 
    llvm.store %2, %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.array<2 x f64>, !llvm.ptr]

    llvm.return
  }]

def teststructextract_combined := [llvmfunc|
  llvm.func @teststructextract(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> f64]

theorem inst_combine_teststructextract   : teststructextract_before  ⊑  teststructextract_combined := by
  unfold teststructextract_before teststructextract_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f64
  }]

theorem inst_combine_teststructextract   : teststructextract_before  ⊑  teststructextract_combined := by
  unfold teststructextract_before teststructextract_combined
  simp_alive_peephole
  sorry
def testarrayextract_combined := [llvmfunc|
  llvm.func @testarrayextract(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> f64]

theorem inst_combine_testarrayextract   : testarrayextract_before  ⊑  testarrayextract_combined := by
  unfold testarrayextract_before testarrayextract_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f64
  }]

theorem inst_combine_testarrayextract   : testarrayextract_before  ⊑  testarrayextract_combined := by
  unfold testarrayextract_before testarrayextract_combined
  simp_alive_peephole
  sorry
def teststructinsert_combined := [llvmfunc|
  llvm.func @teststructinsert(%arg0: !llvm.ptr, %arg1: f64, %arg2: f64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.store %arg1, %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : f64, !llvm.ptr]

theorem inst_combine_teststructinsert   : teststructinsert_before  ⊑  teststructinsert_combined := by
  unfold teststructinsert_before teststructinsert_combined
  simp_alive_peephole
  sorry
    %2 = llvm.getelementptr inbounds %arg0[%0, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"Complex", (f64, f64)>
    llvm.store %arg2, %2 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : f64, !llvm.ptr]

theorem inst_combine_teststructinsert   : teststructinsert_before  ⊑  teststructinsert_combined := by
  unfold teststructinsert_before teststructinsert_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_teststructinsert   : teststructinsert_before  ⊑  teststructinsert_combined := by
  unfold teststructinsert_before teststructinsert_combined
  simp_alive_peephole
  sorry
def testarrayinsert_combined := [llvmfunc|
  llvm.func @testarrayinsert(%arg0: !llvm.ptr, %arg1: f64, %arg2: f64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    llvm.store %arg1, %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : f64, !llvm.ptr]

theorem inst_combine_testarrayinsert   : testarrayinsert_before  ⊑  testarrayinsert_combined := by
  unfold testarrayinsert_before testarrayinsert_combined
  simp_alive_peephole
  sorry
    %2 = llvm.getelementptr inbounds %arg0[%0, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x f64>
    llvm.store %arg2, %2 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : f64, !llvm.ptr]

theorem inst_combine_testarrayinsert   : testarrayinsert_before  ⊑  testarrayinsert_combined := by
  unfold testarrayinsert_before testarrayinsert_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_testarrayinsert   : testarrayinsert_before  ⊑  testarrayinsert_combined := by
  unfold testarrayinsert_before testarrayinsert_combined
  simp_alive_peephole
  sorry
