import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sub-gep
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_inbounds_before := [llvmfunc|
  llvm.func @test_inbounds(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2  : i64
    llvm.return %4 : i64
  }]

def test_partial_inbounds1_before := [llvmfunc|
  llvm.func @test_partial_inbounds1(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2  : i64
    llvm.return %4 : i64
  }]

def test_partial_inbounds2_before := [llvmfunc|
  llvm.func @test_partial_inbounds2(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2  : i64
    llvm.return %4 : i64
  }]

def test_inbounds_nuw_before := [llvmfunc|
  llvm.func @test_inbounds_nuw(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }]

def test_nuw_before := [llvmfunc|
  llvm.func @test_nuw(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }]

def test_inbounds_nuw_trunc_before := [llvmfunc|
  llvm.func @test_inbounds_nuw_trunc(%arg0: !llvm.ptr, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.trunc %2 : i64 to i32
    %5 = llvm.trunc %3 : i64 to i32
    %6 = llvm.sub %5, %4 overflow<nuw>  : i32
    llvm.return %6 : i32
  }]

def test_inbounds_nuw_swapped_before := [llvmfunc|
  llvm.func @test_inbounds_nuw_swapped(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }]

def test_inbounds1_nuw_swapped_before := [llvmfunc|
  llvm.func @test_inbounds1_nuw_swapped(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }]

def test_inbounds2_nuw_swapped_before := [llvmfunc|
  llvm.func @test_inbounds2_nuw_swapped(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }]

def test_inbounds_two_gep_before := [llvmfunc|
  llvm.func @test_inbounds_two_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.getelementptr inbounds %arg0[%0, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %5 = llvm.sub %4, %3  : i64
    llvm.return %5 : i64
  }]

def test_inbounds_nsw_two_gep_before := [llvmfunc|
  llvm.func @test_inbounds_nsw_two_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.getelementptr inbounds %arg0[%0, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %5 = llvm.sub %4, %3 overflow<nsw>  : i64
    llvm.return %5 : i64
  }]

def test_inbounds_nuw_two_gep_before := [llvmfunc|
  llvm.func @test_inbounds_nuw_two_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %2 = llvm.getelementptr inbounds %arg0[%0, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %5 = llvm.sub %4, %3 overflow<nuw>  : i64
    llvm.return %5 : i64
  }]

def test_inbounds_nuw_multi_index_before := [llvmfunc|
  llvm.func @test_inbounds_nuw_multi_index(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0, %arg1, %arg2] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<0 x array<2 x i32>>
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %3, %2 overflow<nuw>  : i64
    llvm.return %4 : i64
  }]

def test23_before := [llvmfunc|
  llvm.func @test23(%arg0: !llvm.ptr, %arg1: i64) -> i32 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sub %2, %4  : i32
    llvm.return %5 : i32
  }]

def test23_as1_before := [llvmfunc|
  llvm.func @test23_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> i8 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr<1> to i16
    %2 = llvm.trunc %1 : i16 to i8
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr<1> to i16
    %4 = llvm.trunc %3 : i16 to i8
    %5 = llvm.sub %2, %4  : i8
    llvm.return %5 : i8
  }]

def test24_before := [llvmfunc|
  llvm.func @test24(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.sub %1, %2  : i64
    llvm.return %3 : i64
  }]

def test24_as1_before := [llvmfunc|
  llvm.func @test24_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> i16 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr<1> to i16
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr<1> to i16
    %3 = llvm.sub %1, %2  : i16
    llvm.return %3 : i16
  }]

def test24a_before := [llvmfunc|
  llvm.func @test24a(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %3 = llvm.sub %2, %1  : i64
    llvm.return %3 : i64
  }]

def test24a_as1_before := [llvmfunc|
  llvm.func @test24a_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> i16 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %1 = llvm.ptrtoint %0 : !llvm.ptr<1> to i16
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr<1> to i16
    %3 = llvm.sub %2, %1  : i16
    llvm.return %3 : i16
  }]

def test24b_before := [llvmfunc|
  llvm.func @test24b(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.addressof @Arr : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.getelementptr inbounds %0[%1, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<42 x i16>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.sub %4, %2  : i64
    llvm.return %5 : i64
  }]

def test25_before := [llvmfunc|
  llvm.func @test25(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.addressof @Arr : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.getelementptr inbounds %0[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<42 x i16>
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.getelementptr inbounds %0[%1, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<42 x i16>
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.sub %6, %4  : i64
    llvm.return %7 : i64
  }]

def test25_as1_before := [llvmfunc|
  llvm.func @test25_as1(%arg0: !llvm.ptr<1>, %arg1: i64) -> i16 {
    %0 = llvm.mlir.addressof @Arr_as1 : !llvm.ptr<1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.getelementptr inbounds %0[%2, %1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<42 x i16>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i16
    %5 = llvm.getelementptr inbounds %0[%1, %arg1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<42 x i16>
    %6 = llvm.ptrtoint %5 : !llvm.ptr<1> to i16
    %7 = llvm.sub %6, %4  : i16
    llvm.return %7 : i16
  }]

def test30_before := [llvmfunc|
  llvm.func @test30(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }]

def test30_as1_before := [llvmfunc|
  llvm.func @test30_as1(%arg0: !llvm.ptr<1>, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i32
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %2 = llvm.ptrtoint %0 : !llvm.ptr<1> to i16
    %3 = llvm.ptrtoint %1 : !llvm.ptr<1> to i16
    %4 = llvm.sub %2, %3  : i16
    llvm.return %4 : i16
  }]

def gep_diff_both_inbounds_before := [llvmfunc|
  llvm.func @gep_diff_both_inbounds(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }]

def gep_diff_first_inbounds_before := [llvmfunc|
  llvm.func @gep_diff_first_inbounds(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }]

def gep_diff_second_inbounds_before := [llvmfunc|
  llvm.func @gep_diff_second_inbounds(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }]

def gep_diff_with_bitcast_before := [llvmfunc|
  llvm.func @gep_diff_with_bitcast(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<4 x i64>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3 overflow<nuw>  : i64
    %5 = llvm.lshr %4, %0  : i64
    llvm.return %5 : i64
  }]

def sub_scalable_before := [llvmfunc|
  llvm.func @sub_scalable(%arg0: !llvm.ptr {llvm.noundef}) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }]

def sub_scalable2_before := [llvmfunc|
  llvm.func @sub_scalable2(%arg0: !llvm.ptr {llvm.noundef}) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i64
    %6 = llvm.sub %3, %5  : i64
    llvm.return %6 : i64
  }]

def nullptrtoint_scalable_c_before := [llvmfunc|
  llvm.func @nullptrtoint_scalable_c() -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.getelementptr inbounds %0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    llvm.return %3 : i64
  }]

def nullptrtoint_scalable_x_before := [llvmfunc|
  llvm.func @nullptrtoint_scalable_x(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr inbounds %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    llvm.return %2 : i64
  }]

def _gep_phi1_before := [llvmfunc|
  llvm.func @_gep_phi1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %4, ^bb4(%1 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.cond_br %6, ^bb4(%1 : i64), ^bb2(%arg0 : !llvm.ptr)
  ^bb2(%7: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %8 = llvm.getelementptr inbounds %7[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %9 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %10 = llvm.icmp "eq" %9, %2 : i8
    llvm.cond_br %10, ^bb3, ^bb2(%8 : !llvm.ptr)
  ^bb3:  // pred: ^bb2
    %11 = llvm.ptrtoint %8 : !llvm.ptr to i64
    %12 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %13 = llvm.sub %11, %12  : i64
    llvm.br ^bb4(%13 : i64)
  ^bb4(%14: i64):  // 3 preds: ^bb0, ^bb1, ^bb3
    %15 = llvm.icmp "ne" %14, %1 : i64
    llvm.return %15 : i1
  }]

def _gep_phi2_before := [llvmfunc|
  llvm.func @_gep_phi2(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %4, ^bb4(%1 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.cond_br %6, ^bb4(%1 : i64), ^bb2(%arg0 : !llvm.ptr)
  ^bb2(%7: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %8 = llvm.getelementptr inbounds %7[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %9 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %10 = llvm.icmp "eq" %9, %2 : i8
    llvm.cond_br %10, ^bb3, ^bb2(%8 : !llvm.ptr)
  ^bb3:  // pred: ^bb2
    %11 = llvm.ptrtoint %8 : !llvm.ptr to i64
    %12 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %13 = llvm.sub %11, %12  : i64
    llvm.br ^bb4(%13 : i64)
  ^bb4(%14: i64):  // 3 preds: ^bb0, ^bb1, ^bb3
    %15 = llvm.or %14, %arg1  : i64
    %16 = llvm.icmp "eq" %15, %1 : i64
    llvm.return %16 : i1
  }]

def test_inbounds_combined := [llvmfunc|
  llvm.func @test_inbounds(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test_inbounds   : test_inbounds_before  ⊑  test_inbounds_combined := by
  unfold test_inbounds_before test_inbounds_combined
  simp_alive_peephole
  sorry
def test_partial_inbounds1_combined := [llvmfunc|
  llvm.func @test_partial_inbounds1(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.shl %arg1, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test_partial_inbounds1   : test_partial_inbounds1_before  ⊑  test_partial_inbounds1_combined := by
  unfold test_partial_inbounds1_before test_partial_inbounds1_combined
  simp_alive_peephole
  sorry
def test_partial_inbounds2_combined := [llvmfunc|
  llvm.func @test_partial_inbounds2(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test_partial_inbounds2   : test_partial_inbounds2_before  ⊑  test_partial_inbounds2_combined := by
  unfold test_partial_inbounds2_before test_partial_inbounds2_combined
  simp_alive_peephole
  sorry
def test_inbounds_nuw_combined := [llvmfunc|
  llvm.func @test_inbounds_nuw(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.shl %arg1, %0 overflow<nsw, nuw>  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test_inbounds_nuw   : test_inbounds_nuw_before  ⊑  test_inbounds_nuw_combined := by
  unfold test_inbounds_nuw_before test_inbounds_nuw_combined
  simp_alive_peephole
  sorry
def test_nuw_combined := [llvmfunc|
  llvm.func @test_nuw(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.shl %arg1, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test_nuw   : test_nuw_before  ⊑  test_nuw_combined := by
  unfold test_nuw_before test_nuw_combined
  simp_alive_peephole
  sorry
def test_inbounds_nuw_trunc_combined := [llvmfunc|
  llvm.func @test_inbounds_nuw_trunc(%arg0: !llvm.ptr, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.trunc %arg1 : i64 to i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_inbounds_nuw_trunc   : test_inbounds_nuw_trunc_before  ⊑  test_inbounds_nuw_trunc_combined := by
  unfold test_inbounds_nuw_trunc_before test_inbounds_nuw_trunc_combined
  simp_alive_peephole
  sorry
def test_inbounds_nuw_swapped_combined := [llvmfunc|
  llvm.func @test_inbounds_nuw_swapped(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test_inbounds_nuw_swapped   : test_inbounds_nuw_swapped_before  ⊑  test_inbounds_nuw_swapped_combined := by
  unfold test_inbounds_nuw_swapped_before test_inbounds_nuw_swapped_combined
  simp_alive_peephole
  sorry
def test_inbounds1_nuw_swapped_combined := [llvmfunc|
  llvm.func @test_inbounds1_nuw_swapped(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test_inbounds1_nuw_swapped   : test_inbounds1_nuw_swapped_before  ⊑  test_inbounds1_nuw_swapped_combined := by
  unfold test_inbounds1_nuw_swapped_before test_inbounds1_nuw_swapped_combined
  simp_alive_peephole
  sorry
def test_inbounds2_nuw_swapped_combined := [llvmfunc|
  llvm.func @test_inbounds2_nuw_swapped(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test_inbounds2_nuw_swapped   : test_inbounds2_nuw_swapped_before  ⊑  test_inbounds2_nuw_swapped_combined := by
  unfold test_inbounds2_nuw_swapped_before test_inbounds2_nuw_swapped_combined
  simp_alive_peephole
  sorry
def test_inbounds_two_gep_combined := [llvmfunc|
  llvm.func @test_inbounds_two_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.sub %arg2, %arg1 overflow<nsw>  : i64
    %2 = llvm.shl %1, %0 overflow<nsw>  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test_inbounds_two_gep   : test_inbounds_two_gep_before  ⊑  test_inbounds_two_gep_combined := by
  unfold test_inbounds_two_gep_before test_inbounds_two_gep_combined
  simp_alive_peephole
  sorry
def test_inbounds_nsw_two_gep_combined := [llvmfunc|
  llvm.func @test_inbounds_nsw_two_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.sub %arg2, %arg1 overflow<nsw>  : i64
    %2 = llvm.shl %1, %0 overflow<nsw>  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test_inbounds_nsw_two_gep   : test_inbounds_nsw_two_gep_before  ⊑  test_inbounds_nsw_two_gep_combined := by
  unfold test_inbounds_nsw_two_gep_before test_inbounds_nsw_two_gep_combined
  simp_alive_peephole
  sorry
def test_inbounds_nuw_two_gep_combined := [llvmfunc|
  llvm.func @test_inbounds_nuw_two_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.sub %arg2, %arg1 overflow<nsw>  : i64
    %2 = llvm.shl %1, %0 overflow<nsw>  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test_inbounds_nuw_two_gep   : test_inbounds_nuw_two_gep_before  ⊑  test_inbounds_nuw_two_gep_combined := by
  unfold test_inbounds_nuw_two_gep_before test_inbounds_nuw_two_gep_combined
  simp_alive_peephole
  sorry
def test_inbounds_nuw_multi_index_combined := [llvmfunc|
  llvm.func @test_inbounds_nuw_multi_index(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.shl %arg1, %0 overflow<nsw>  : i64
    %3 = llvm.shl %arg2, %1 overflow<nsw>  : i64
    %4 = llvm.add %2, %3 overflow<nsw>  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test_inbounds_nuw_multi_index   : test_inbounds_nuw_multi_index_before  ⊑  test_inbounds_nuw_multi_index_combined := by
  unfold test_inbounds_nuw_multi_index_before test_inbounds_nuw_multi_index_combined
  simp_alive_peephole
  sorry
def test23_combined := [llvmfunc|
  llvm.func @test23(%arg0: !llvm.ptr, %arg1: i64) -> i32 {
    %0 = llvm.trunc %arg1 : i64 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test23   : test23_before  ⊑  test23_combined := by
  unfold test23_before test23_combined
  simp_alive_peephole
  sorry
def test23_as1_combined := [llvmfunc|
  llvm.func @test23_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> i8 {
    %0 = llvm.trunc %arg1 : i16 to i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test23_as1   : test23_as1_before  ⊑  test23_as1_combined := by
  unfold test23_as1_before test23_as1_combined
  simp_alive_peephole
  sorry
def test24_combined := [llvmfunc|
  llvm.func @test24(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    llvm.return %arg1 : i64
  }]

theorem inst_combine_test24   : test24_before  ⊑  test24_combined := by
  unfold test24_before test24_combined
  simp_alive_peephole
  sorry
def test24_as1_combined := [llvmfunc|
  llvm.func @test24_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> i16 {
    llvm.return %arg1 : i16
  }]

theorem inst_combine_test24_as1   : test24_as1_before  ⊑  test24_as1_combined := by
  unfold test24_as1_before test24_as1_combined
  simp_alive_peephole
  sorry
def test24a_combined := [llvmfunc|
  llvm.func @test24a(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %0, %arg1  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test24a   : test24a_before  ⊑  test24a_combined := by
  unfold test24a_before test24a_combined
  simp_alive_peephole
  sorry
def test24a_as1_combined := [llvmfunc|
  llvm.func @test24a_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sub %0, %arg1  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_test24a_as1   : test24a_as1_before  ⊑  test24a_as1_combined := by
  unfold test24a_as1_before test24a_as1_combined
  simp_alive_peephole
  sorry
def test24b_combined := [llvmfunc|
  llvm.func @test24b(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test24b   : test24b_before  ⊑  test24b_combined := by
  unfold test24b_before test24b_combined
  simp_alive_peephole
  sorry
def test25_combined := [llvmfunc|
  llvm.func @test25(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(-84 : i64) : i64
    %2 = llvm.shl %arg1, %0 overflow<nsw>  : i64
    %3 = llvm.add %2, %1 overflow<nsw>  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test25   : test25_before  ⊑  test25_combined := by
  unfold test25_before test25_combined
  simp_alive_peephole
  sorry
def test25_as1_combined := [llvmfunc|
  llvm.func @test25_as1(%arg0: !llvm.ptr<1>, %arg1: i64) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-84 : i16) : i16
    %2 = llvm.trunc %arg1 : i64 to i16
    %3 = llvm.shl %2, %0 overflow<nsw>  : i16
    %4 = llvm.add %3, %1 overflow<nsw>  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_test25_as1   : test25_as1_before  ⊑  test25_as1_combined := by
  unfold test25_as1_before test25_as1_combined
  simp_alive_peephole
  sorry
def test30_combined := [llvmfunc|
  llvm.func @test30(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.sub %1, %arg2 overflow<nsw>  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test30   : test30_before  ⊑  test30_combined := by
  unfold test30_before test30_combined
  simp_alive_peephole
  sorry
def test30_as1_combined := [llvmfunc|
  llvm.func @test30_as1(%arg0: !llvm.ptr<1>, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i16
    %2 = llvm.sub %1, %arg2 overflow<nsw>  : i16
    llvm.return %2 : i16
  }]

theorem inst_combine_test30_as1   : test30_as1_before  ⊑  test30_as1_combined := by
  unfold test30_as1_before test30_as1_combined
  simp_alive_peephole
  sorry
def gep_diff_both_inbounds_combined := [llvmfunc|
  llvm.func @gep_diff_both_inbounds(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sub %arg1, %arg2 overflow<nsw>  : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_gep_diff_both_inbounds   : gep_diff_both_inbounds_before  ⊑  gep_diff_both_inbounds_combined := by
  unfold gep_diff_both_inbounds_before gep_diff_both_inbounds_combined
  simp_alive_peephole
  sorry
def gep_diff_first_inbounds_combined := [llvmfunc|
  llvm.func @gep_diff_first_inbounds(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sub %arg1, %arg2  : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_gep_diff_first_inbounds   : gep_diff_first_inbounds_before  ⊑  gep_diff_first_inbounds_combined := by
  unfold gep_diff_first_inbounds_before gep_diff_first_inbounds_combined
  simp_alive_peephole
  sorry
def gep_diff_second_inbounds_combined := [llvmfunc|
  llvm.func @gep_diff_second_inbounds(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sub %arg1, %arg2  : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_gep_diff_second_inbounds   : gep_diff_second_inbounds_before  ⊑  gep_diff_second_inbounds_combined := by
  unfold gep_diff_second_inbounds_before gep_diff_second_inbounds_combined
  simp_alive_peephole
  sorry
def gep_diff_with_bitcast_combined := [llvmfunc|
  llvm.func @gep_diff_with_bitcast(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    llvm.return %arg1 : i64
  }]

theorem inst_combine_gep_diff_with_bitcast   : gep_diff_with_bitcast_before  ⊑  gep_diff_with_bitcast_combined := by
  unfold gep_diff_with_bitcast_before gep_diff_with_bitcast_combined
  simp_alive_peephole
  sorry
def sub_scalable_combined := [llvmfunc|
  llvm.func @sub_scalable(%arg0: !llvm.ptr {llvm.noundef}) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = "llvm.intr.vscale"() : () -> i64
    %2 = llvm.shl %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sub_scalable   : sub_scalable_before  ⊑  sub_scalable_combined := by
  unfold sub_scalable_before sub_scalable_combined
  simp_alive_peephole
  sorry
def sub_scalable2_combined := [llvmfunc|
  llvm.func @sub_scalable2(%arg0: !llvm.ptr {llvm.noundef}) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = llvm.shl %2, %0  : i64
    %4 = "llvm.intr.vscale"() : () -> i64
    %5 = llvm.shl %4, %1  : i64
    %6 = llvm.sub %3, %5  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_sub_scalable2   : sub_scalable2_before  ⊑  sub_scalable2_combined := by
  unfold sub_scalable2_before sub_scalable2_combined
  simp_alive_peephole
  sorry
def nullptrtoint_scalable_c_combined := [llvmfunc|
  llvm.func @nullptrtoint_scalable_c() -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = "llvm.intr.vscale"() : () -> i64
    %2 = llvm.shl %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_nullptrtoint_scalable_c   : nullptrtoint_scalable_c_before  ⊑  nullptrtoint_scalable_c_combined := by
  unfold nullptrtoint_scalable_c_before nullptrtoint_scalable_c_combined
  simp_alive_peephole
  sorry
def nullptrtoint_scalable_x_combined := [llvmfunc|
  llvm.func @nullptrtoint_scalable_x(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = "llvm.intr.vscale"() : () -> i64
    %2 = llvm.shl %1, %0  : i64
    %3 = llvm.mul %2, %arg0 overflow<nsw>  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_nullptrtoint_scalable_x   : nullptrtoint_scalable_x_before  ⊑  nullptrtoint_scalable_x_combined := by
  unfold nullptrtoint_scalable_x_before nullptrtoint_scalable_x_combined
  simp_alive_peephole
  sorry
def _gep_phi1_combined := [llvmfunc|
  llvm.func @_gep_phi1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %5, ^bb4(%1 : i1), ^bb1
  ^bb1:  // pred: ^bb0
    %6 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine__gep_phi1   : _gep_phi1_before  ⊑  _gep_phi1_combined := by
  unfold _gep_phi1_before _gep_phi1_combined
  simp_alive_peephole
  sorry
    %7 = llvm.icmp "eq" %6, %2 : i8
    llvm.cond_br %7, ^bb4(%1 : i1), ^bb2(%arg0 : !llvm.ptr)
  ^bb2(%8: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %9 = llvm.getelementptr inbounds %8[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %10 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine__gep_phi1   : _gep_phi1_before  ⊑  _gep_phi1_combined := by
  unfold _gep_phi1_before _gep_phi1_combined
  simp_alive_peephole
  sorry
    %11 = llvm.icmp "eq" %10, %2 : i8
    llvm.cond_br %11, ^bb3, ^bb2(%9 : !llvm.ptr)
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4(%4 : i1)
  ^bb4(%12: i1):  // 3 preds: ^bb0, ^bb1, ^bb3
    llvm.return %12 : i1
  }]

theorem inst_combine__gep_phi1   : _gep_phi1_before  ⊑  _gep_phi1_combined := by
  unfold _gep_phi1_before _gep_phi1_combined
  simp_alive_peephole
  sorry
def _gep_phi2_combined := [llvmfunc|
  llvm.func @_gep_phi2(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %4, ^bb4(%1 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine__gep_phi2   : _gep_phi2_before  ⊑  _gep_phi2_combined := by
  unfold _gep_phi2_before _gep_phi2_combined
  simp_alive_peephole
  sorry
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.cond_br %6, ^bb4(%1 : i64), ^bb2(%arg0 : !llvm.ptr)
  ^bb2(%7: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %8 = llvm.getelementptr inbounds %7[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %9 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine__gep_phi2   : _gep_phi2_before  ⊑  _gep_phi2_combined := by
  unfold _gep_phi2_before _gep_phi2_combined
  simp_alive_peephole
  sorry
    %10 = llvm.icmp "eq" %9, %2 : i8
    llvm.cond_br %10, ^bb3, ^bb2(%8 : !llvm.ptr)
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4(%3 : i64)
  ^bb4(%11: i64):  // 3 preds: ^bb0, ^bb1, ^bb3
    %12 = llvm.or %11, %arg1  : i64
    %13 = llvm.icmp "eq" %12, %1 : i64
    llvm.return %13 : i1
  }]

theorem inst_combine__gep_phi2   : _gep_phi2_before  ⊑  _gep_phi2_combined := by
  unfold _gep_phi2_before _gep_phi2_combined
  simp_alive_peephole
  sorry
