import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-custom-dl
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test59_before := [llvmfunc|
  llvm.func @test59(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.icmp "ult" %2, %3 : !llvm.ptr
    %5 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %6 = llvm.call @test58_d(%5) : (i64) -> i32
    llvm.return %4 : i1
  }]

def test59_as1_before := [llvmfunc|
  llvm.func @test59_as1(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %3 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.icmp "ult" %2, %3 : !llvm.ptr<1>
    %5 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    %6 = llvm.call @test58_d(%5) : (i64) -> i32
    llvm.return %4 : i1
  }]

def test60_before := [llvmfunc|
  llvm.func @test60(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.icmp "ult" %0, %1 : !llvm.ptr
    llvm.return %2 : i1
  }]

def test60_as1_before := [llvmfunc|
  llvm.func @test60_as1(%arg0: !llvm.ptr<1>, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %1 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.icmp "ult" %0, %1 : !llvm.ptr<1>
    llvm.return %2 : i1
  }]

def test60_addrspacecast_before := [llvmfunc|
  llvm.func @test60_addrspacecast(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i32
    %2 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.addrspacecast %1 : !llvm.ptr<3> to !llvm.ptr
    %4 = llvm.icmp "ult" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }]

def test60_addrspacecast_smaller_before := [llvmfunc|
  llvm.func @test60_addrspacecast_smaller(%arg0: !llvm.ptr, %arg1: i16, %arg2: i64) -> i1 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<1>
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i32
    %2 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.addrspacecast %1 : !llvm.ptr<1> to !llvm.ptr
    %4 = llvm.icmp "ult" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }]

def test60_addrspacecast_larger_before := [llvmfunc|
  llvm.func @test60_addrspacecast_larger(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i16) -> i1 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr<2>, i32) -> !llvm.ptr<2>, i32
    %2 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %3 = llvm.addrspacecast %1 : !llvm.ptr<2> to !llvm.ptr<1>
    %4 = llvm.icmp "ult" %3, %2 : !llvm.ptr<1>
    llvm.return %4 : i1
  }]

def test61_before := [llvmfunc|
  llvm.func @test61(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.icmp "ult" %0, %1 : !llvm.ptr
    llvm.return %2 : i1
  }]

def test61_as1_before := [llvmfunc|
  llvm.func @test61_as1(%arg0: !llvm.ptr<1>, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i32
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %2 = llvm.icmp "ult" %0, %1 : !llvm.ptr<1>
    llvm.return %2 : i1
  }]

def test62_before := [llvmfunc|
  llvm.func @test62(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.icmp "slt" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

def test62_as1_before := [llvmfunc|
  llvm.func @test62_as1(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %3 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.icmp "slt" %2, %3 : !llvm.ptr<1>
    llvm.return %4 : i1
  }]

def icmp_and_ashr_multiuse_before := [llvmfunc|
  llvm.func @icmp_and_ashr_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.constant(27 : i32) : i32
    %5 = llvm.ashr %arg0, %0  : i32
    %6 = llvm.and %5, %1  : i32
    %7 = llvm.and %5, %2  : i32
    %8 = llvm.icmp "ne" %6, %3 : i32
    %9 = llvm.icmp "ne" %7, %4 : i32
    %10 = llvm.and %8, %9  : i1
    llvm.return %10 : i1
  }]

def icmp_and_ashr_multiuse_logical_before := [llvmfunc|
  llvm.func @icmp_and_ashr_multiuse_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.constant(27 : i32) : i32
    %5 = llvm.mlir.constant(false) : i1
    %6 = llvm.ashr %arg0, %0  : i32
    %7 = llvm.and %6, %1  : i32
    %8 = llvm.and %6, %2  : i32
    %9 = llvm.icmp "ne" %7, %3 : i32
    %10 = llvm.icmp "ne" %8, %4 : i32
    %11 = llvm.select %9, %10, %5 : i1, i1
    llvm.return %11 : i1
  }]

def icmp_lshr_and_overshift_before := [llvmfunc|
  llvm.func @icmp_lshr_and_overshift(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "ne" %4, %2 : i8
    llvm.return %5 : i1
  }]

def icmp_ashr_and_overshift_before := [llvmfunc|
  llvm.func @icmp_ashr_and_overshift(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.ashr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "ne" %4, %2 : i8
    llvm.return %5 : i1
  }]

def test71_before := [llvmfunc|
  llvm.func @test71(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.icmp "ugt" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }]

def test71_as1_before := [llvmfunc|
  llvm.func @test71_as1(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %3 = llvm.icmp "ugt" %1, %2 : !llvm.ptr<1>
    llvm.return %3 : i1
  }]

def test59_combined := [llvmfunc|
  llvm.func @test59(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i40
    %4 = llvm.zext %3 : i40 to i64
    %5 = llvm.call @test58_d(%4) : (i64) -> i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test59   : test59_before  ⊑  test59_combined := by
  unfold test59_before test59_combined
  simp_alive_peephole
  sorry
def test59_as1_combined := [llvmfunc|
  llvm.func @test59_as1(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i16
    %4 = llvm.zext %3 : i16 to i64
    %5 = llvm.call @test58_d(%4) : (i64) -> i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test59_as1   : test59_as1_before  ⊑  test59_as1_combined := by
  unfold test59_as1_before test59_as1_combined
  simp_alive_peephole
  sorry
def test60_combined := [llvmfunc|
  llvm.func @test60(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.trunc %arg1 : i64 to i32
    %2 = llvm.trunc %arg2 : i64 to i32
    %3 = llvm.shl %1, %0 overflow<nsw>  : i32
    %4 = llvm.icmp "slt" %3, %2 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_test60   : test60_before  ⊑  test60_combined := by
  unfold test60_before test60_combined
  simp_alive_peephole
  sorry
def test60_as1_combined := [llvmfunc|
  llvm.func @test60_as1(%arg0: !llvm.ptr<1>, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.trunc %arg1 : i64 to i16
    %2 = llvm.trunc %arg2 : i64 to i16
    %3 = llvm.shl %1, %0 overflow<nsw>  : i16
    %4 = llvm.icmp "slt" %3, %2 : i16
    llvm.return %4 : i1
  }]

theorem inst_combine_test60_as1   : test60_as1_before  ⊑  test60_as1_combined := by
  unfold test60_as1_before test60_as1_combined
  simp_alive_peephole
  sorry
def test60_addrspacecast_combined := [llvmfunc|
  llvm.func @test60_addrspacecast(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.trunc %arg2 : i64 to i32
    %2 = llvm.trunc %arg1 : i64 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_test60_addrspacecast   : test60_addrspacecast_before  ⊑  test60_addrspacecast_combined := by
  unfold test60_addrspacecast_before test60_addrspacecast_combined
  simp_alive_peephole
  sorry
def test60_addrspacecast_smaller_combined := [llvmfunc|
  llvm.func @test60_addrspacecast_smaller(%arg0: !llvm.ptr, %arg1: i16, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i16
    %2 = llvm.trunc %arg2 : i64 to i16
    %3 = llvm.icmp "slt" %1, %2 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_test60_addrspacecast_smaller   : test60_addrspacecast_smaller_before  ⊑  test60_addrspacecast_smaller_combined := by
  unfold test60_addrspacecast_smaller_before test60_addrspacecast_smaller_combined
  simp_alive_peephole
  sorry
def test60_addrspacecast_larger_combined := [llvmfunc|
  llvm.func @test60_addrspacecast_larger(%arg0: !llvm.ptr<1>, %arg1: i32, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.trunc %arg1 : i32 to i16
    %2 = llvm.shl %1, %0  : i16
    %3 = llvm.icmp "slt" %2, %arg2 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_test60_addrspacecast_larger   : test60_addrspacecast_larger_before  ⊑  test60_addrspacecast_larger_combined := by
  unfold test60_addrspacecast_larger_before test60_addrspacecast_larger_combined
  simp_alive_peephole
  sorry
def test61_combined := [llvmfunc|
  llvm.func @test61(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i64 to i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %2 = llvm.trunc %arg2 : i64 to i32
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %4 = llvm.icmp "ult" %1, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

theorem inst_combine_test61   : test61_before  ⊑  test61_combined := by
  unfold test61_before test61_combined
  simp_alive_peephole
  sorry
def test61_as1_combined := [llvmfunc|
  llvm.func @test61_as1(%arg0: !llvm.ptr<1>, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i32
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %2 = llvm.icmp "ult" %0, %1 : !llvm.ptr<1>
    llvm.return %2 : i1
  }]

theorem inst_combine_test61_as1   : test61_as1_before  ⊑  test61_as1_combined := by
  unfold test61_as1_before test61_as1_combined
  simp_alive_peephole
  sorry
def test62_combined := [llvmfunc|
  llvm.func @test62(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %4 = llvm.icmp "slt" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

theorem inst_combine_test62   : test62_before  ⊑  test62_combined := by
  unfold test62_before test62_combined
  simp_alive_peephole
  sorry
def test62_as1_combined := [llvmfunc|
  llvm.func @test62_as1(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(10 : i16) : i16
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %3 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %4 = llvm.icmp "slt" %2, %3 : !llvm.ptr<1>
    llvm.return %4 : i1
  }]

theorem inst_combine_test62_as1   : test62_as1_before  ⊑  test62_as1_combined := by
  unfold test62_as1_before test62_as1_combined
  simp_alive_peephole
  sorry
def icmp_and_ashr_multiuse_combined := [llvmfunc|
  llvm.func @icmp_and_ashr_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(240 : i32) : i32
    %1 = llvm.mlir.constant(224 : i32) : i32
    %2 = llvm.mlir.constant(496 : i32) : i32
    %3 = llvm.mlir.constant(432 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_icmp_and_ashr_multiuse   : icmp_and_ashr_multiuse_before  ⊑  icmp_and_ashr_multiuse_combined := by
  unfold icmp_and_ashr_multiuse_before icmp_and_ashr_multiuse_combined
  simp_alive_peephole
  sorry
def icmp_and_ashr_multiuse_logical_combined := [llvmfunc|
  llvm.func @icmp_and_ashr_multiuse_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(240 : i32) : i32
    %1 = llvm.mlir.constant(224 : i32) : i32
    %2 = llvm.mlir.constant(496 : i32) : i32
    %3 = llvm.mlir.constant(432 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_icmp_and_ashr_multiuse_logical   : icmp_and_ashr_multiuse_logical_before  ⊑  icmp_and_ashr_multiuse_logical_combined := by
  unfold icmp_and_ashr_multiuse_logical_before icmp_and_ashr_multiuse_logical_combined
  simp_alive_peephole
  sorry
def icmp_lshr_and_overshift_combined := [llvmfunc|
  llvm.func @icmp_lshr_and_overshift(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_lshr_and_overshift   : icmp_lshr_and_overshift_before  ⊑  icmp_lshr_and_overshift_combined := by
  unfold icmp_lshr_and_overshift_before icmp_lshr_and_overshift_combined
  simp_alive_peephole
  sorry
def icmp_ashr_and_overshift_combined := [llvmfunc|
  llvm.func @icmp_ashr_and_overshift(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.ashr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "ne" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_icmp_ashr_and_overshift   : icmp_ashr_and_overshift_before  ⊑  icmp_ashr_and_overshift_combined := by
  unfold icmp_ashr_and_overshift_before icmp_ashr_and_overshift_combined
  simp_alive_peephole
  sorry
def test71_combined := [llvmfunc|
  llvm.func @test71(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test71   : test71_before  ⊑  test71_combined := by
  unfold test71_before test71_combined
  simp_alive_peephole
  sorry
def test71_as1_combined := [llvmfunc|
  llvm.func @test71_as1(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test71_as1   : test71_as1_before  ⊑  test71_as1_combined := by
  unfold test71_as1_before test71_as1_combined
  simp_alive_peephole
  sorry
