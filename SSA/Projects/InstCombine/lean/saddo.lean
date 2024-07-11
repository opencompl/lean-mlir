import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  saddo
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_generic_before := [llvmfunc|
  llvm.func @test_generic(%arg0: i64, %arg1: i64) -> i1 {
    %0 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, i1)> 
    llvm.return %1 : i1
  }]

def test_constant0_before := [llvmfunc|
  llvm.func @test_constant0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant1_before := [llvmfunc|
  llvm.func @test_constant1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant2_before := [llvmfunc|
  llvm.func @test_constant2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant3_before := [llvmfunc|
  llvm.func @test_constant3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant4_before := [llvmfunc|
  llvm.func @test_constant4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant127_before := [llvmfunc|
  llvm.func @test_constant127(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant128_before := [llvmfunc|
  llvm.func @test_constant128(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant255_before := [llvmfunc|
  llvm.func @test_constant255(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_generic_combined := [llvmfunc|
  llvm.func @test_generic(%arg0: i64, %arg1: i64) -> i1 {
    %0 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, i1)> 
    llvm.return %1 : i1
  }]

theorem inst_combine_test_generic   : test_generic_before  ⊑  test_generic_combined := by
  unfold test_generic_before test_generic_combined
  simp_alive_peephole
  sorry
def test_constant0_combined := [llvmfunc|
  llvm.func @test_constant0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant0   : test_constant0_before  ⊑  test_constant0_combined := by
  unfold test_constant0_before test_constant0_combined
  simp_alive_peephole
  sorry
def test_constant1_combined := [llvmfunc|
  llvm.func @test_constant1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant1   : test_constant1_before  ⊑  test_constant1_combined := by
  unfold test_constant1_before test_constant1_combined
  simp_alive_peephole
  sorry
def test_constant2_combined := [llvmfunc|
  llvm.func @test_constant2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(125 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant2   : test_constant2_before  ⊑  test_constant2_combined := by
  unfold test_constant2_before test_constant2_combined
  simp_alive_peephole
  sorry
def test_constant3_combined := [llvmfunc|
  llvm.func @test_constant3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(124 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant3   : test_constant3_before  ⊑  test_constant3_combined := by
  unfold test_constant3_before test_constant3_combined
  simp_alive_peephole
  sorry
def test_constant4_combined := [llvmfunc|
  llvm.func @test_constant4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant4   : test_constant4_before  ⊑  test_constant4_combined := by
  unfold test_constant4_before test_constant4_combined
  simp_alive_peephole
  sorry
def test_constant127_combined := [llvmfunc|
  llvm.func @test_constant127(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant127   : test_constant127_before  ⊑  test_constant127_combined := by
  unfold test_constant127_before test_constant127_combined
  simp_alive_peephole
  sorry
def test_constant128_combined := [llvmfunc|
  llvm.func @test_constant128(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant128   : test_constant128_before  ⊑  test_constant128_combined := by
  unfold test_constant128_before test_constant128_combined
  simp_alive_peephole
  sorry
def test_constant255_combined := [llvmfunc|
  llvm.func @test_constant255(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant255   : test_constant255_before  ⊑  test_constant255_combined := by
  unfold test_constant255_before test_constant255_combined
  simp_alive_peephole
  sorry
