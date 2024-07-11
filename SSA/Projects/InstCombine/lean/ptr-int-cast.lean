import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ptr-int-cast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i1
    llvm.return %0 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i128) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.inttoptr %arg0 : i128 to !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def f0_before := [llvmfunc|
  llvm.func @f0(%arg0: i32) -> i64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    llvm.return %1 : i64
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.vec<4 x ptr>) -> vector<4xi32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<4 x ptr> to vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

def testvscale4_before := [llvmfunc|
  llvm.func @testvscale4(%arg0: !llvm.vec<? x 4 x  ptr>) -> !llvm.vec<? x 4 x  i32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<? x 4 x  ptr> to !llvm.vec<? x 4 x  i32>
    llvm.return %0 : !llvm.vec<? x 4 x  i32>
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.vec<4 x ptr>) -> vector<4xi128> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<4 x ptr> to vector<4xi128>
    llvm.return %0 : vector<4xi128>
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: vector<4xi32>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.inttoptr %arg0 : vector<4xi32> to !llvm.vec<4 x ptr>
    llvm.return %0 : !llvm.vec<4 x ptr>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: vector<4xi128>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.inttoptr %arg0 : vector<4xi128> to !llvm.vec<4 x ptr>
    llvm.return %0 : !llvm.vec<4 x ptr>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.and %2, %0  : i64
    %4 = llvm.icmp "ne" %3, %1 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i128) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.trunc %arg0 : i128 to i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def f0_combined := [llvmfunc|
  llvm.func @f0(%arg0: i32) -> i64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.zext %arg0 : i32 to i64
    llvm.return %0 : i64
  }]

theorem inst_combine_f0   : f0_before  ⊑  f0_combined := by
  unfold f0_before f0_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.vec<4 x ptr>) -> vector<4xi32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<4 x ptr> to vector<4xi64>
    %1 = llvm.trunc %0 : vector<4xi64> to vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def testvscale4_combined := [llvmfunc|
  llvm.func @testvscale4(%arg0: !llvm.vec<? x 4 x  ptr>) -> !llvm.vec<? x 4 x  i32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<? x 4 x  ptr> to !llvm.vec<? x 4 x  i64>
    %1 = llvm.trunc %0 : !llvm.vec<? x 4 x  i64> to !llvm.vec<? x 4 x  i32>
    llvm.return %1 : !llvm.vec<? x 4 x  i32>
  }]

theorem inst_combine_testvscale4   : testvscale4_before  ⊑  testvscale4_combined := by
  unfold testvscale4_before testvscale4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.vec<4 x ptr>) -> vector<4xi128> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<4 x ptr> to vector<4xi64>
    %1 = llvm.zext %0 : vector<4xi64> to vector<4xi128>
    llvm.return %1 : vector<4xi128>
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: vector<4xi32>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.zext %arg0 : vector<4xi32> to vector<4xi64>
    %1 = llvm.inttoptr %0 : vector<4xi64> to !llvm.vec<4 x ptr>
    llvm.return %1 : !llvm.vec<4 x ptr>
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: vector<4xi128>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.trunc %arg0 : vector<4xi128> to vector<4xi64>
    %1 = llvm.inttoptr %0 : vector<4xi64> to !llvm.vec<4 x ptr>
    llvm.return %1 : !llvm.vec<4 x ptr>
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
