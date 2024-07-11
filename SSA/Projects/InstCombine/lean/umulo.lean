import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  umulo
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_generic_before := [llvmfunc|
  llvm.func @test_generic(%arg0: i64, %arg1: i64) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, i1)> 
    llvm.return %1 : i1
  }]

def test_constant0_before := [llvmfunc|
  llvm.func @test_constant0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant1_before := [llvmfunc|
  llvm.func @test_constant1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant2_before := [llvmfunc|
  llvm.func @test_constant2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant3_before := [llvmfunc|
  llvm.func @test_constant3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant4_before := [llvmfunc|
  llvm.func @test_constant4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant127_before := [llvmfunc|
  llvm.func @test_constant127(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant128_before := [llvmfunc|
  llvm.func @test_constant128(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def test_constant255_before := [llvmfunc|
  llvm.func @test_constant255(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def i1_res_before := [llvmfunc|
  llvm.func @i1_res(%arg0: i1, %arg1: i1) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i1, i1) -> !llvm.struct<(i1, i1)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i1, i1)> 
    llvm.return %1 : i1
  }]

def v2i1_res_before := [llvmfunc|
  llvm.func @v2i1_res(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (vector<2xi1>, vector<2xi1>) -> !llvm.struct<(vector<2xi1>, vector<2xi1>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(vector<2xi1>, vector<2xi1>)> 
    llvm.return %1 : vector<2xi1>
  }]

def i1_res_by_one_before := [llvmfunc|
  llvm.func @i1_res_by_one(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i1, i1) -> !llvm.struct<(i1, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i1, i1)> 
    llvm.return %2 : i1
  }]

def v2i1_res_by_one_before := [llvmfunc|
  llvm.func @v2i1_res_by_one(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %1) : (vector<2xi1>, vector<2xi1>) -> !llvm.struct<(vector<2xi1>, vector<2xi1>)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(vector<2xi1>, vector<2xi1>)> 
    llvm.return %3 : vector<2xi1>
  }]

def i1_ov_before := [llvmfunc|
  llvm.func @i1_ov(%arg0: i1, %arg1: i1) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i1, i1) -> !llvm.struct<(i1, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i1, i1)> 
    llvm.return %1 : i1
  }]

def v2i1_ov_before := [llvmfunc|
  llvm.func @v2i1_ov(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (vector<2xi1>, vector<2xi1>) -> !llvm.struct<(vector<2xi1>, vector<2xi1>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(vector<2xi1>, vector<2xi1>)> 
    llvm.return %1 : vector<2xi1>
  }]

def i1_ov_by_one_before := [llvmfunc|
  llvm.func @i1_ov_by_one(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i1, i1) -> !llvm.struct<(i1, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i1, i1)> 
    llvm.return %2 : i1
  }]

def v2i1_ov_by_one_before := [llvmfunc|
  llvm.func @v2i1_ov_by_one(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %1) : (vector<2xi1>, vector<2xi1>) -> !llvm.struct<(vector<2xi1>, vector<2xi1>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(vector<2xi1>, vector<2xi1>)> 
    llvm.return %3 : vector<2xi1>
  }]

def test_generic_combined := [llvmfunc|
  llvm.func @test_generic(%arg0: i64, %arg1: i64) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
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
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant1   : test_constant1_before  ⊑  test_constant1_combined := by
  unfold test_constant1_before test_constant1_combined
  simp_alive_peephole
  sorry
def test_constant2_combined := [llvmfunc|
  llvm.func @test_constant2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant2   : test_constant2_before  ⊑  test_constant2_combined := by
  unfold test_constant2_before test_constant2_combined
  simp_alive_peephole
  sorry
def test_constant3_combined := [llvmfunc|
  llvm.func @test_constant3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(85 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant3   : test_constant3_before  ⊑  test_constant3_combined := by
  unfold test_constant3_before test_constant3_combined
  simp_alive_peephole
  sorry
def test_constant4_combined := [llvmfunc|
  llvm.func @test_constant4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant4   : test_constant4_before  ⊑  test_constant4_combined := by
  unfold test_constant4_before test_constant4_combined
  simp_alive_peephole
  sorry
def test_constant127_combined := [llvmfunc|
  llvm.func @test_constant127(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant127   : test_constant127_before  ⊑  test_constant127_combined := by
  unfold test_constant127_before test_constant127_combined
  simp_alive_peephole
  sorry
def test_constant128_combined := [llvmfunc|
  llvm.func @test_constant128(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant128   : test_constant128_before  ⊑  test_constant128_combined := by
  unfold test_constant128_before test_constant128_combined
  simp_alive_peephole
  sorry
def test_constant255_combined := [llvmfunc|
  llvm.func @test_constant255(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_constant255   : test_constant255_before  ⊑  test_constant255_combined := by
  unfold test_constant255_before test_constant255_combined
  simp_alive_peephole
  sorry
def i1_res_combined := [llvmfunc|
  llvm.func @i1_res(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i1_res   : i1_res_before  ⊑  i1_res_combined := by
  unfold i1_res_before i1_res_combined
  simp_alive_peephole
  sorry
def v2i1_res_combined := [llvmfunc|
  llvm.func @v2i1_res(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.and %arg0, %arg1  : vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_v2i1_res   : v2i1_res_before  ⊑  v2i1_res_combined := by
  unfold v2i1_res_before v2i1_res_combined
  simp_alive_peephole
  sorry
def i1_res_by_one_combined := [llvmfunc|
  llvm.func @i1_res_by_one(%arg0: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_i1_res_by_one   : i1_res_by_one_before  ⊑  i1_res_by_one_combined := by
  unfold i1_res_by_one_before i1_res_by_one_combined
  simp_alive_peephole
  sorry
def v2i1_res_by_one_combined := [llvmfunc|
  llvm.func @v2i1_res_by_one(%arg0: vector<2xi1>) -> vector<2xi1> {
    llvm.return %arg0 : vector<2xi1>
  }]

theorem inst_combine_v2i1_res_by_one   : v2i1_res_by_one_before  ⊑  v2i1_res_by_one_combined := by
  unfold v2i1_res_by_one_before v2i1_res_by_one_combined
  simp_alive_peephole
  sorry
def i1_ov_combined := [llvmfunc|
  llvm.func @i1_ov(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i1_ov   : i1_ov_before  ⊑  i1_ov_combined := by
  unfold i1_ov_before i1_ov_combined
  simp_alive_peephole
  sorry
def v2i1_ov_combined := [llvmfunc|
  llvm.func @v2i1_ov(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_v2i1_ov   : v2i1_ov_before  ⊑  v2i1_ov_combined := by
  unfold v2i1_ov_before v2i1_ov_combined
  simp_alive_peephole
  sorry
def i1_ov_by_one_combined := [llvmfunc|
  llvm.func @i1_ov_by_one(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i1_ov_by_one   : i1_ov_by_one_before  ⊑  i1_ov_by_one_combined := by
  unfold i1_ov_by_one_before i1_ov_by_one_combined
  simp_alive_peephole
  sorry
def v2i1_ov_by_one_combined := [llvmfunc|
  llvm.func @v2i1_ov_by_one(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_v2i1_ov_by_one   : v2i1_ov_by_one_before  ⊑  v2i1_ov_by_one_combined := by
  unfold v2i1_ov_by_one_before v2i1_ov_by_one_combined
  simp_alive_peephole
  sorry
