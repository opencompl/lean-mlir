import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gep-custom-dl
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i8) -> !llvm.ptr, i32
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i16) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32)>
    llvm.return %1 : !llvm.ptr
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i8) {
    %0 = llvm.mlir.addressof @Global : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.getelementptr %0[%1, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i8>
    llvm.store %arg0, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test_evaluate_gep_nested_as_ptrs_before := [llvmfunc|
  llvm.func @test_evaluate_gep_nested_as_ptrs(%arg0: !llvm.ptr<2>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @global_as2 : !llvm.ptr<2>
    %2 = llvm.mlir.undef : !llvm.struct<"as2_ptr_struct", (ptr<2>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"as2_ptr_struct", (ptr<2>)> 
    %4 = llvm.mlir.addressof @global_as1_as2_ptr : !llvm.ptr<1>
    llvm.store %arg0, %4 {alignment = 8 : i64} : !llvm.ptr<2>, !llvm.ptr<1>]

    llvm.return
  }]

def test_evaluate_gep_as_ptrs_array_before := [llvmfunc|
  llvm.func @test_evaluate_gep_as_ptrs_array(%arg0: !llvm.ptr<2>) {
    %0 = llvm.mlir.zero : !llvm.ptr<2>
    %1 = llvm.mlir.undef : !llvm.array<4 x ptr<2>>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.array<4 x ptr<2>> 
    %3 = llvm.insertvalue %0, %2[1] : !llvm.array<4 x ptr<2>> 
    %4 = llvm.insertvalue %0, %3[2] : !llvm.array<4 x ptr<2>> 
    %5 = llvm.insertvalue %0, %4[3] : !llvm.array<4 x ptr<2>> 
    %6 = llvm.mlir.addressof @arst : !llvm.ptr<1>
    %7 = llvm.mlir.constant(0 : i16) : i16
    %8 = llvm.mlir.constant(2 : i16) : i16
    %9 = llvm.getelementptr %6[%7, %8] : (!llvm.ptr<1>, i16, i16) -> !llvm.ptr<1>, !llvm.array<4 x ptr<2>>
    llvm.store %arg0, %9 {alignment = 8 : i64} : !llvm.ptr<2>, !llvm.ptr<1>]

    llvm.return
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %1 = llvm.getelementptr %0[%arg2] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    %3 = llvm.getelementptr %arg1[%0, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: vector<2xi32>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.getelementptr inbounds %arg1[%1, 1, %arg0] : (!llvm.vec<2 x ptr>, vector<2xi32>, vector<2xi32>) -> !llvm.vec<2 x ptr>, !llvm.struct<"S", (i32, array<100 x i32>)>
    %4 = llvm.getelementptr inbounds %arg1[%1, 0] : (!llvm.vec<2 x ptr>, vector<2xi32>) -> !llvm.vec<2 x ptr>, !llvm.struct<"S", (i32, array<100 x i32>)>
    %5 = llvm.icmp "eq" %3, %4 : !llvm.vec<2 x ptr>
    llvm.return %5 : vector<2xi1>
  }]

def test6b_before := [llvmfunc|
  llvm.func @test6b(%arg0: vector<2xi32>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg1[%0, 1, %arg0] : (!llvm.vec<2 x ptr>, i32, vector<2xi32>) -> !llvm.vec<2 x ptr>, !llvm.struct<"S", (i32, array<100 x i32>)>
    %3 = llvm.getelementptr inbounds %arg1[%0, 0] : (!llvm.vec<2 x ptr>, i32) -> !llvm.vec<2 x ptr>, !llvm.struct<"S", (i32, array<100 x i32>)>
    %4 = llvm.icmp "eq" %2, %3 : !llvm.vec<2 x ptr>
    llvm.return %4 : vector<2xi1>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i16) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.return %2 : !llvm.ptr
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @Array : !llvm.ptr
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.ptr, %arg1: i8) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i8) -> !llvm.ptr, i32
    llvm.return %0 : !llvm.ptr
  }]

def test10_before := [llvmfunc|
  llvm.func @test10() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.getelementptr %0[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, f64)>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i32
    llvm.return %4 : i32
  }]

def constant_fold_custom_dl_before := [llvmfunc|
  llvm.func @constant_fold_custom_dl() -> i16 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1000xi8>) : !llvm.array<1000 x i8>
    %4 = llvm.mlir.addressof @X_as1 : !llvm.ptr<1>
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<1000 x i8>
    %6 = llvm.mlir.constant(0 : i16) : i16
    %7 = llvm.bitcast %5 : !llvm.ptr<1> to !llvm.ptr<1>
    %8 = llvm.ptrtoint %4 : !llvm.ptr<1> to i16
    %9 = llvm.sub %6, %8  : i16
    %10 = llvm.getelementptr %7[%9] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %11 = llvm.ptrtoint %10 : !llvm.ptr<1> to i16
    llvm.return %11 : i16
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32)>
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i8) {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @Global : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i8>
    llvm.store %arg0, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test_evaluate_gep_nested_as_ptrs_combined := [llvmfunc|
  llvm.func @test_evaluate_gep_nested_as_ptrs(%arg0: !llvm.ptr<2>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @global_as2 : !llvm.ptr<2>
    %2 = llvm.mlir.undef : !llvm.struct<"as2_ptr_struct", (ptr<2>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"as2_ptr_struct", (ptr<2>)> 
    %4 = llvm.mlir.addressof @global_as1_as2_ptr : !llvm.ptr<1>
    llvm.store %arg0, %4 {alignment = 8 : i64} : !llvm.ptr<2>, !llvm.ptr<1>]

theorem inst_combine_test_evaluate_gep_nested_as_ptrs   : test_evaluate_gep_nested_as_ptrs_before  ⊑  test_evaluate_gep_nested_as_ptrs_combined := by
  unfold test_evaluate_gep_nested_as_ptrs_before test_evaluate_gep_nested_as_ptrs_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_evaluate_gep_nested_as_ptrs   : test_evaluate_gep_nested_as_ptrs_before  ⊑  test_evaluate_gep_nested_as_ptrs_combined := by
  unfold test_evaluate_gep_nested_as_ptrs_before test_evaluate_gep_nested_as_ptrs_combined
  simp_alive_peephole
  sorry
def test_evaluate_gep_as_ptrs_array_combined := [llvmfunc|
  llvm.func @test_evaluate_gep_as_ptrs_array(%arg0: !llvm.ptr<2>) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.zero : !llvm.ptr<2>
    %3 = llvm.mlir.undef : !llvm.array<4 x ptr<2>>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.array<4 x ptr<2>> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.array<4 x ptr<2>> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.array<4 x ptr<2>> 
    %7 = llvm.insertvalue %2, %6[3] : !llvm.array<4 x ptr<2>> 
    %8 = llvm.mlir.addressof @arst : !llvm.ptr<1>
    %9 = llvm.getelementptr inbounds %8[%1, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<4 x ptr<2>>
    llvm.store %arg0, %9 {alignment = 8 : i64} : !llvm.ptr<2>, !llvm.ptr<1>]

theorem inst_combine_test_evaluate_gep_as_ptrs_array   : test_evaluate_gep_as_ptrs_array_before  ⊑  test_evaluate_gep_as_ptrs_array_combined := by
  unfold test_evaluate_gep_as_ptrs_array_before test_evaluate_gep_as_ptrs_array_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_evaluate_gep_as_ptrs_array   : test_evaluate_gep_as_ptrs_array_before  ⊑  test_evaluate_gep_as_ptrs_array_combined := by
  unfold test_evaluate_gep_as_ptrs_array_before test_evaluate_gep_as_ptrs_array_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %1 = llvm.getelementptr %0[%arg2] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: vector<2xi32>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test6b_combined := [llvmfunc|
  llvm.func @test6b(%arg0: vector<2xi32>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test6b   : test6b_before  ⊑  test6b_combined := by
  unfold test6b_before test6b_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i16) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.getelementptr %0[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @Array : !llvm.ptr
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.ptr, %arg1: i8) -> !llvm.ptr {
    %0 = llvm.sext %arg1 : i8 to i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10() -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def constant_fold_custom_dl_combined := [llvmfunc|
  llvm.func @constant_fold_custom_dl() -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1000xi8>) : !llvm.array<1000 x i8>
    %2 = llvm.mlir.addressof @X_as1 : !llvm.ptr<1>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i16
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.sub %4, %3  : i16
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.getelementptr inbounds %2[%7, %6] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<1000 x i8>
    %9 = llvm.getelementptr %8[%5] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %10 = llvm.ptrtoint %9 : !llvm.ptr<1> to i16
    llvm.return %10 : i16
  }]

theorem inst_combine_constant_fold_custom_dl   : constant_fold_custom_dl_before  ⊑  constant_fold_custom_dl_combined := by
  unfold constant_fold_custom_dl_before constant_fold_custom_dl_combined
  simp_alive_peephole
  sorry
