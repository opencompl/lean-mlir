import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  extract-select-agg
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_select_agg_constant_agg_before := [llvmfunc|
  llvm.func @test_select_agg_constant_agg(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i64, i64)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i64, i64)> 
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(i64, i64)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<(i64, i64)> 
    %10 = llvm.select %arg1, %4, %9 : i1, !llvm.struct<(i64, i64)>
    %11 = llvm.extractvalue %10[0] : !llvm.struct<(i64, i64)> 
    llvm.return %11 : i64
  }]

def test_select_agg_constant_agg_multiuse_before := [llvmfunc|
  llvm.func @test_select_agg_constant_agg_multiuse(%arg0: i64, %arg1: i1) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i64, i64)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i64, i64)> 
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(i64, i64)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<(i64, i64)> 
    %10 = llvm.select %arg1, %4, %9 : i1, !llvm.struct<(i64, i64)>
    %11 = llvm.extractvalue %10[0] : !llvm.struct<(i64, i64)> 
    llvm.call @use(%11) : (i64) -> ()
    %12 = llvm.extractvalue %10[1] : !llvm.struct<(i64, i64)> 
    llvm.call @use(%12) : (i64) -> ()
    llvm.return
  }]

def test_select_agg_constant_before := [llvmfunc|
  llvm.func @test_select_agg_constant(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i64, i64)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i64, i64)> 
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(i64, i64)> 
    %8 = llvm.insertvalue %0, %7[1] : !llvm.struct<(i64, i64)> 
    %9 = llvm.insertvalue %arg0, %4[1] : !llvm.struct<(i64, i64)> 
    %10 = llvm.insertvalue %arg0, %8[1] : !llvm.struct<(i64, i64)> 
    %11 = llvm.select %arg1, %9, %10 : i1, !llvm.struct<(i64, i64)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(i64, i64)> 
    llvm.return %12 : i64
  }]

def test_select_agg_multiuse_before := [llvmfunc|
  llvm.func @test_select_agg_multiuse(%arg0: i1, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64) {
    %0 = llvm.mlir.poison : !llvm.struct<(i64, i64)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(i64, i64)> 
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(i64, i64)> 
    %3 = llvm.insertvalue %arg3, %0[0] : !llvm.struct<(i64, i64)> 
    %4 = llvm.insertvalue %arg4, %3[1] : !llvm.struct<(i64, i64)> 
    %5 = llvm.select %arg0, %2, %4 : i1, !llvm.struct<(i64, i64)>
    %6 = llvm.extractvalue %5[0] : !llvm.struct<(i64, i64)> 
    llvm.call @use(%6) : (i64) -> ()
    %7 = llvm.extractvalue %5[1] : !llvm.struct<(i64, i64)> 
    llvm.call @use(%7) : (i64) -> ()
    llvm.return
  }]

def test_select_agg_constant_agg_combined := [llvmfunc|
  llvm.func @test_select_agg_constant_agg(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i64, i64)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i64, i64)> 
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(i64, i64)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<(i64, i64)> 
    %10 = llvm.select %arg1, %4, %9 : i1, !llvm.struct<(i64, i64)>
    %11 = llvm.extractvalue %10[0] : !llvm.struct<(i64, i64)> 
    llvm.return %11 : i64
  }]

theorem inst_combine_test_select_agg_constant_agg   : test_select_agg_constant_agg_before  ⊑  test_select_agg_constant_agg_combined := by
  unfold test_select_agg_constant_agg_before test_select_agg_constant_agg_combined
  simp_alive_peephole
  sorry
def test_select_agg_constant_agg_multiuse_combined := [llvmfunc|
  llvm.func @test_select_agg_constant_agg_multiuse(%arg0: i64, %arg1: i1) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i64, i64)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i64, i64)> 
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(i64, i64)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<(i64, i64)> 
    %10 = llvm.select %arg1, %4, %9 : i1, !llvm.struct<(i64, i64)>
    %11 = llvm.extractvalue %10[0] : !llvm.struct<(i64, i64)> 
    llvm.call @use(%11) : (i64) -> ()
    %12 = llvm.extractvalue %10[1] : !llvm.struct<(i64, i64)> 
    llvm.call @use(%12) : (i64) -> ()
    llvm.return
  }]

theorem inst_combine_test_select_agg_constant_agg_multiuse   : test_select_agg_constant_agg_multiuse_before  ⊑  test_select_agg_constant_agg_multiuse_combined := by
  unfold test_select_agg_constant_agg_multiuse_before test_select_agg_constant_agg_multiuse_combined
  simp_alive_peephole
  sorry
def test_select_agg_constant_combined := [llvmfunc|
  llvm.func @test_select_agg_constant(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i64, i64)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i64, i64)> 
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(i64, i64)> 
    %8 = llvm.insertvalue %0, %7[1] : !llvm.struct<(i64, i64)> 
    %9 = llvm.insertvalue %arg0, %4[1] : !llvm.struct<(i64, i64)> 
    %10 = llvm.insertvalue %arg0, %8[1] : !llvm.struct<(i64, i64)> 
    %11 = llvm.select %arg1, %9, %10 : i1, !llvm.struct<(i64, i64)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(i64, i64)> 
    llvm.return %12 : i64
  }]

theorem inst_combine_test_select_agg_constant   : test_select_agg_constant_before  ⊑  test_select_agg_constant_combined := by
  unfold test_select_agg_constant_before test_select_agg_constant_combined
  simp_alive_peephole
  sorry
def test_select_agg_multiuse_combined := [llvmfunc|
  llvm.func @test_select_agg_multiuse(%arg0: i1, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64) {
    %0 = llvm.mlir.poison : !llvm.struct<(i64, i64)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(i64, i64)> 
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(i64, i64)> 
    %3 = llvm.insertvalue %arg3, %0[0] : !llvm.struct<(i64, i64)> 
    %4 = llvm.insertvalue %arg4, %3[1] : !llvm.struct<(i64, i64)> 
    %5 = llvm.select %arg0, %2, %4 : i1, !llvm.struct<(i64, i64)>
    %6 = llvm.extractvalue %5[0] : !llvm.struct<(i64, i64)> 
    llvm.call @use(%6) : (i64) -> ()
    %7 = llvm.extractvalue %5[1] : !llvm.struct<(i64, i64)> 
    llvm.call @use(%7) : (i64) -> ()
    llvm.return
  }]

theorem inst_combine_test_select_agg_multiuse   : test_select_agg_multiuse_before  ⊑  test_select_agg_multiuse_combined := by
  unfold test_select_agg_multiuse_before test_select_agg_multiuse_combined
  simp_alive_peephole
  sorry
