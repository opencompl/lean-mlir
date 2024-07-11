import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast_ptr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

def test2_as2_same_int_before := [llvmfunc|
  llvm.func @test2_as2_same_int(%arg0: !llvm.ptr<2>, %arg1: !llvm.ptr<2>) -> i1 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<2> to i16
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr<2> to i16
    %2 = llvm.icmp "eq" %0, %1 : i16
    llvm.return %2 : i1
  }]

def test2_as2_larger_before := [llvmfunc|
  llvm.func @test2_as2_larger(%arg0: !llvm.ptr<2>, %arg1: !llvm.ptr<2>) -> i1 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<2> to i32
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr<2> to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

def test2_diff_as_before := [llvmfunc|
  llvm.func @test2_diff_as(%arg0: !llvm.ptr, %arg1: !llvm.ptr<1>) -> i1 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr<1> to i32
    %2 = llvm.icmp "sge" %0, %1 : i32
    llvm.return %2 : i1
  }]

def test2_diff_as_global_before := [llvmfunc|
  llvm.func @test2_diff_as_global(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @global : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr<1> to i32
    %4 = llvm.icmp "sge" %3, %2 : i32
    llvm.return %4 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @global : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    llvm.return %4 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def test4_as2_before := [llvmfunc|
  llvm.func @test4_as2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr<2>
    %1 = llvm.inttoptr %arg0 : i16 to !llvm.ptr<2>
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr<2>
    llvm.return %2 : i1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @foo : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.array<1 x ptr> 
    %3 = llvm.mlir.addressof @Array : !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.call %4(%arg0) : !llvm.ptr, (!llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr<1>) -> i8 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    %1 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %1 : i8
  }]

def insertelt_before := [llvmfunc|
  llvm.func @insertelt(%arg0: vector<2xi32>, %arg1: !llvm.ptr, %arg2: i133) -> vector<2xi32> {
    %0 = llvm.inttoptr %arg0 : vector<2xi32> to !llvm.vec<2 x ptr>
    %1 = llvm.insertelement %arg1, %0[%arg2 : i133] : !llvm.vec<2 x ptr>
    %2 = llvm.ptrtoint %1 : !llvm.vec<2 x ptr> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def insertelt_intptr_trunc_before := [llvmfunc|
  llvm.func @insertelt_intptr_trunc(%arg0: vector<2xi64>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.inttoptr %arg0 : vector<2xi64> to !llvm.vec<2 x ptr>
    %2 = llvm.insertelement %arg1, %1[%0 : i32] : !llvm.vec<2 x ptr>
    %3 = llvm.ptrtoint %2 : !llvm.vec<2 x ptr> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def insertelt_intptr_zext_before := [llvmfunc|
  llvm.func @insertelt_intptr_zext(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %arg0 : vector<2xi8> to !llvm.vec<2 x ptr>
    %2 = llvm.insertelement %arg1, %1[%0 : i32] : !llvm.vec<2 x ptr>
    %3 = llvm.ptrtoint %2 : !llvm.vec<2 x ptr> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def insertelt_intptr_zext_zext_before := [llvmfunc|
  llvm.func @insertelt_intptr_zext_zext(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.inttoptr %arg0 : vector<2xi8> to !llvm.vec<2 x ptr>
    %2 = llvm.insertelement %arg1, %1[%0 : i32] : !llvm.vec<2 x ptr>
    %3 = llvm.ptrtoint %2 : !llvm.vec<2 x ptr> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def insertelt_extra_use1_before := [llvmfunc|
  llvm.func @insertelt_extra_use1(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.inttoptr %arg0 : vector<2xi32> to !llvm.vec<2 x ptr>
    llvm.call @use(%1) : (!llvm.vec<2 x ptr>) -> ()
    %2 = llvm.insertelement %arg1, %1[%0 : i32] : !llvm.vec<2 x ptr>
    %3 = llvm.ptrtoint %2 : !llvm.vec<2 x ptr> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def insertelt_extra_use2_before := [llvmfunc|
  llvm.func @insertelt_extra_use2(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.inttoptr %arg0 : vector<2xi32> to !llvm.vec<2 x ptr>
    %2 = llvm.insertelement %arg1, %1[%0 : i32] : !llvm.vec<2 x ptr>
    llvm.call @use(%2) : (!llvm.vec<2 x ptr>) -> ()
    %3 = llvm.ptrtoint %2 : !llvm.vec<2 x ptr> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def ptr_add_in_int_before := [llvmfunc|
  llvm.func @ptr_add_in_int(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }]

def ptr_add_in_int_2_before := [llvmfunc|
  llvm.func @ptr_add_in_int_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }]

def ptr_add_in_int_nneg_before := [llvmfunc|
  llvm.func @ptr_add_in_int_nneg(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = true}> : (i32) -> i32]

    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

def ptr_add_in_int_different_type_1_before := [llvmfunc|
  llvm.func @ptr_add_in_int_different_type_1(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    llvm.return %2 : i64
  }]

def ptr_add_in_int_different_type_2_before := [llvmfunc|
  llvm.func @ptr_add_in_int_different_type_2(%arg0: i32, %arg1: i32) -> i16 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i16
    llvm.return %2 : i16
  }]

def ptr_add_in_int_different_type_3_before := [llvmfunc|
  llvm.func @ptr_add_in_int_different_type_3(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.inttoptr %arg0 : i16 to !llvm.ptr
    %1 = llvm.getelementptr %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }]

def ptr_add_in_int_different_type_4_before := [llvmfunc|
  llvm.func @ptr_add_in_int_different_type_4(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.inttoptr %arg0 : i64 to !llvm.ptr
    %1 = llvm.getelementptr %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }]

def ptr_add_in_int_not_inbounds_before := [llvmfunc|
  llvm.func @ptr_add_in_int_not_inbounds(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = true}> : (i32) -> i32]

    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

def ptr_add_in_int_const_before := [llvmfunc|
  llvm.func @ptr_add_in_int_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

def ptr_add_in_int_const_negative_before := [llvmfunc|
  llvm.func @ptr_add_in_int_const_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

def ptr_add_in_int_extra_use1_before := [llvmfunc|
  llvm.func @ptr_add_in_int_extra_use1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    llvm.call @use_ptr(%1) : (!llvm.ptr) -> ()
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

def ptr_add_in_int_extra_use2_before := [llvmfunc|
  llvm.func @ptr_add_in_int_extra_use2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.call @use_ptr(%2) : (!llvm.ptr) -> ()
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2_as2_same_int_combined := [llvmfunc|
  llvm.func @test2_as2_same_int(%arg0: !llvm.ptr<2>, %arg1: !llvm.ptr<2>) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : !llvm.ptr<2>
    llvm.return %0 : i1
  }]

theorem inst_combine_test2_as2_same_int   : test2_as2_same_int_before  ⊑  test2_as2_same_int_combined := by
  unfold test2_as2_same_int_before test2_as2_same_int_combined
  simp_alive_peephole
  sorry
def test2_as2_larger_combined := [llvmfunc|
  llvm.func @test2_as2_larger(%arg0: !llvm.ptr<2>, %arg1: !llvm.ptr<2>) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : !llvm.ptr<2>
    llvm.return %0 : i1
  }]

theorem inst_combine_test2_as2_larger   : test2_as2_larger_before  ⊑  test2_as2_larger_combined := by
  unfold test2_as2_larger_before test2_as2_larger_combined
  simp_alive_peephole
  sorry
def test2_diff_as_combined := [llvmfunc|
  llvm.func @test2_diff_as(%arg0: !llvm.ptr, %arg1: !llvm.ptr<1>) -> i1 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr<1> to i32
    %2 = llvm.icmp "sge" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test2_diff_as   : test2_diff_as_before  ⊑  test2_diff_as_combined := by
  unfold test2_diff_as_before test2_diff_as_combined
  simp_alive_peephole
  sorry
def test2_diff_as_global_combined := [llvmfunc|
  llvm.func @test2_diff_as_global(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @global : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr<1> to i32
    %4 = llvm.icmp "sge" %3, %2 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_test2_diff_as_global   : test2_diff_as_global_before  ⊑  test2_diff_as_global_combined := by
  unfold test2_diff_as_global_before test2_diff_as_global_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @global : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %1 : !llvm.ptr
    llvm.return %2 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test4_as2_combined := [llvmfunc|
  llvm.func @test4_as2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_test4_as2   : test4_as2_before  ⊑  test4_as2_combined := by
  unfold test4_as2_before test4_as2_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @foo(%arg0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr<1>) -> i8 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    %1 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def insertelt_combined := [llvmfunc|
  llvm.func @insertelt(%arg0: vector<2xi32>, %arg1: !llvm.ptr, %arg2: i133) -> vector<2xi32> {
    %0 = llvm.ptrtoint %arg1 : !llvm.ptr to i32
    %1 = llvm.insertelement %0, %arg0[%arg2 : i133] : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_insertelt   : insertelt_before  ⊑  insertelt_combined := by
  unfold insertelt_before insertelt_combined
  simp_alive_peephole
  sorry
def insertelt_intptr_trunc_combined := [llvmfunc|
  llvm.func @insertelt_intptr_trunc(%arg0: vector<2xi64>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i32
    %3 = llvm.insertelement %2, %1[%0 : i64] : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_insertelt_intptr_trunc   : insertelt_intptr_trunc_before  ⊑  insertelt_intptr_trunc_combined := by
  unfold insertelt_intptr_trunc_before insertelt_intptr_trunc_combined
  simp_alive_peephole
  sorry
def insertelt_intptr_zext_combined := [llvmfunc|
  llvm.func @insertelt_intptr_zext(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i32
    %3 = llvm.insertelement %2, %1[%0 : i64] : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_insertelt_intptr_zext   : insertelt_intptr_zext_before  ⊑  insertelt_intptr_zext_combined := by
  unfold insertelt_intptr_zext_before insertelt_intptr_zext_combined
  simp_alive_peephole
  sorry
def insertelt_intptr_zext_zext_combined := [llvmfunc|
  llvm.func @insertelt_intptr_zext_zext(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i32
    %3 = llvm.insertelement %2, %1[%0 : i64] : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_insertelt_intptr_zext_zext   : insertelt_intptr_zext_zext_before  ⊑  insertelt_intptr_zext_zext_combined := by
  unfold insertelt_intptr_zext_zext_before insertelt_intptr_zext_zext_combined
  simp_alive_peephole
  sorry
def insertelt_extra_use1_combined := [llvmfunc|
  llvm.func @insertelt_extra_use1(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.inttoptr %arg0 : vector<2xi32> to !llvm.vec<2 x ptr>
    llvm.call @use(%1) : (!llvm.vec<2 x ptr>) -> ()
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i32
    %3 = llvm.insertelement %2, %arg0[%0 : i64] : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_insertelt_extra_use1   : insertelt_extra_use1_before  ⊑  insertelt_extra_use1_combined := by
  unfold insertelt_extra_use1_before insertelt_extra_use1_combined
  simp_alive_peephole
  sorry
def insertelt_extra_use2_combined := [llvmfunc|
  llvm.func @insertelt_extra_use2(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.inttoptr %arg0 : vector<2xi32> to !llvm.vec<2 x ptr>
    %2 = llvm.insertelement %arg1, %1[%0 : i64] : !llvm.vec<2 x ptr>
    llvm.call @use(%2) : (!llvm.vec<2 x ptr>) -> ()
    %3 = llvm.ptrtoint %2 : !llvm.vec<2 x ptr> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_insertelt_extra_use2   : insertelt_extra_use2_before  ⊑  insertelt_extra_use2_combined := by
  unfold insertelt_extra_use2_before insertelt_extra_use2_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_combined := [llvmfunc|
  llvm.func @ptr_add_in_int(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ptr_add_in_int   : ptr_add_in_int_before  ⊑  ptr_add_in_int_combined := by
  unfold ptr_add_in_int_before ptr_add_in_int_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_2_combined := [llvmfunc|
  llvm.func @ptr_add_in_int_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ptr_add_in_int_2   : ptr_add_in_int_2_before  ⊑  ptr_add_in_int_2_combined := by
  unfold ptr_add_in_int_2_before ptr_add_in_int_2_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_nneg_combined := [llvmfunc|
  llvm.func @ptr_add_in_int_nneg(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_ptr_add_in_int_nneg   : ptr_add_in_int_nneg_before  ⊑  ptr_add_in_int_nneg_combined := by
  unfold ptr_add_in_int_nneg_before ptr_add_in_int_nneg_combined
  simp_alive_peephole
  sorry
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ptr_add_in_int_nneg   : ptr_add_in_int_nneg_before  ⊑  ptr_add_in_int_nneg_combined := by
  unfold ptr_add_in_int_nneg_before ptr_add_in_int_nneg_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_different_type_1_combined := [llvmfunc|
  llvm.func @ptr_add_in_int_different_type_1(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_ptr_add_in_int_different_type_1   : ptr_add_in_int_different_type_1_before  ⊑  ptr_add_in_int_different_type_1_combined := by
  unfold ptr_add_in_int_different_type_1_before ptr_add_in_int_different_type_1_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_different_type_2_combined := [llvmfunc|
  llvm.func @ptr_add_in_int_different_type_2(%arg0: i32, %arg1: i32) -> i16 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_ptr_add_in_int_different_type_2   : ptr_add_in_int_different_type_2_before  ⊑  ptr_add_in_int_different_type_2_combined := by
  unfold ptr_add_in_int_different_type_2_before ptr_add_in_int_different_type_2_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_different_type_3_combined := [llvmfunc|
  llvm.func @ptr_add_in_int_different_type_3(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr %1[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ptr_add_in_int_different_type_3   : ptr_add_in_int_different_type_3_before  ⊑  ptr_add_in_int_different_type_3_combined := by
  unfold ptr_add_in_int_different_type_3_before ptr_add_in_int_different_type_3_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_different_type_4_combined := [llvmfunc|
  llvm.func @ptr_add_in_int_different_type_4(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr %1[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ptr_add_in_int_different_type_4   : ptr_add_in_int_different_type_4_before  ⊑  ptr_add_in_int_different_type_4_combined := by
  unfold ptr_add_in_int_different_type_4_before ptr_add_in_int_different_type_4_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_not_inbounds_combined := [llvmfunc|
  llvm.func @ptr_add_in_int_not_inbounds(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_ptr_add_in_int_not_inbounds   : ptr_add_in_int_not_inbounds_before  ⊑  ptr_add_in_int_not_inbounds_combined := by
  unfold ptr_add_in_int_not_inbounds_before ptr_add_in_int_not_inbounds_combined
  simp_alive_peephole
  sorry
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ptr_add_in_int_not_inbounds   : ptr_add_in_int_not_inbounds_before  ⊑  ptr_add_in_int_not_inbounds_combined := by
  unfold ptr_add_in_int_not_inbounds_before ptr_add_in_int_not_inbounds_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_const_combined := [llvmfunc|
  llvm.func @ptr_add_in_int_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ptr_add_in_int_const   : ptr_add_in_int_const_before  ⊑  ptr_add_in_int_const_combined := by
  unfold ptr_add_in_int_const_before ptr_add_in_int_const_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_const_negative_combined := [llvmfunc|
  llvm.func @ptr_add_in_int_const_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ptr_add_in_int_const_negative   : ptr_add_in_int_const_negative_before  ⊑  ptr_add_in_int_const_negative_combined := by
  unfold ptr_add_in_int_const_negative_before ptr_add_in_int_const_negative_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_extra_use1_combined := [llvmfunc|
  llvm.func @ptr_add_in_int_extra_use1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    llvm.call @use_ptr(%1) : (!llvm.ptr) -> ()
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ptr_add_in_int_extra_use1   : ptr_add_in_int_extra_use1_before  ⊑  ptr_add_in_int_extra_use1_combined := by
  unfold ptr_add_in_int_extra_use1_before ptr_add_in_int_extra_use1_combined
  simp_alive_peephole
  sorry
def ptr_add_in_int_extra_use2_combined := [llvmfunc|
  llvm.func @ptr_add_in_int_extra_use2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.call @use_ptr(%2) : (!llvm.ptr) -> ()
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ptr_add_in_int_extra_use2   : ptr_add_in_int_extra_use2_before  ⊑  ptr_add_in_int_extra_use2_combined := by
  unfold ptr_add_in_int_extra_use2_before ptr_add_in_int_extra_use2_combined
  simp_alive_peephole
  sorry
