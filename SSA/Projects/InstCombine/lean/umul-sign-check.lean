import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  umul-sign-check
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    llvm.store %3, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return %5 : i1
  }]

def test1_logical_before := [llvmfunc|
  llvm.func @test1_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    llvm.store %4, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return %6 : i1
  }]

def test1_or_ops_swapped_before := [llvmfunc|
  llvm.func @test1_or_ops_swapped(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %4, %2  : i1
    llvm.store %3, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return %5 : i1
  }]

def test1_or_ops_swapped_logical_before := [llvmfunc|
  llvm.func @test1_or_ops_swapped_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %5, %1, %3 : i1, i1
    llvm.store %4, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return %6 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return %5 : i1
  }]

def test2_logical_before := [llvmfunc|
  llvm.func @test2_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.sub %0, %4  : i64
    llvm.store %7, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return %6 : i1
  }]

def test3_multiple_overflow_users_before := [llvmfunc|
  llvm.func @test3_multiple_overflow_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %5 : i1
  }]

def test3_multiple_overflow_users_logical_before := [llvmfunc|
  llvm.func @test3_multiple_overflow_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %6 : i1
  }]

def test3_multiple_overflow_and_mul_users_before := [llvmfunc|
  llvm.func @test3_multiple_overflow_and_mul_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.call @use(%2) : (i1) -> ()
    llvm.return %5 : i1
  }]

def test3_multiple_overflow_and_mul_users_logical_before := [llvmfunc|
  llvm.func @test3_multiple_overflow_and_mul_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.sub %0, %4  : i64
    llvm.store %7, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.call @use(%3) : (i1) -> ()
    llvm.return %6 : i1
  }]

def test3_multiple_res_users_before := [llvmfunc|
  llvm.func @test3_multiple_res_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.call @use.2(%1) : (!llvm.struct<(i64, i1)>) -> ()
    llvm.return %5 : i1
  }]

def test3_multiple_res_users_logical_before := [llvmfunc|
  llvm.func @test3_multiple_res_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.sub %0, %4  : i64
    llvm.store %7, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.call @use.2(%2) : (!llvm.struct<(i64, i1)>) -> ()
    llvm.return %6 : i1
  }]

def test3_multiple_mul_users_before := [llvmfunc|
  llvm.func @test3_multiple_mul_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.call @use.3(%3) : (i64) -> ()
    llvm.return %5 : i1
  }]

def test3_multiple_mul_users_logical_before := [llvmfunc|
  llvm.func @test3_multiple_mul_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.sub %0, %4  : i64
    llvm.store %7, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.call @use.3(%4) : (i64) -> ()
    llvm.return %6 : i1
  }]

def test4_no_icmp_ne_before := [llvmfunc|
  llvm.func @test4_no_icmp_ne(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "sgt" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return %5 : i1
  }]

def test4_no_icmp_ne_logical_before := [llvmfunc|
  llvm.func @test4_no_icmp_ne_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "sgt" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.sub %0, %4  : i64
    llvm.store %7, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return %6 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mul %arg0, %arg1  : i64
    %2 = llvm.icmp "ne" %arg0, %0 : i64
    %3 = llvm.icmp "ne" %arg1, %0 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.store %1, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_logical_combined := [llvmfunc|
  llvm.func @test1_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mul %arg0, %arg1  : i64
    %2 = llvm.icmp "ne" %arg0, %0 : i64
    %3 = llvm.icmp "ne" %arg1, %0 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.store %1, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test1_logical   : test1_logical_before  ⊑  test1_logical_combined := by
  unfold test1_logical_before test1_logical_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i1
  }]

theorem inst_combine_test1_logical   : test1_logical_before  ⊑  test1_logical_combined := by
  unfold test1_logical_before test1_logical_combined
  simp_alive_peephole
  sorry
def test1_or_ops_swapped_combined := [llvmfunc|
  llvm.func @test1_or_ops_swapped(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mul %arg0, %arg1  : i64
    %2 = llvm.icmp "ne" %arg0, %0 : i64
    %3 = llvm.icmp "ne" %arg1, %0 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.store %1, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test1_or_ops_swapped   : test1_or_ops_swapped_before  ⊑  test1_or_ops_swapped_combined := by
  unfold test1_or_ops_swapped_before test1_or_ops_swapped_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i1
  }]

theorem inst_combine_test1_or_ops_swapped   : test1_or_ops_swapped_before  ⊑  test1_or_ops_swapped_combined := by
  unfold test1_or_ops_swapped_before test1_or_ops_swapped_combined
  simp_alive_peephole
  sorry
def test1_or_ops_swapped_logical_combined := [llvmfunc|
  llvm.func @test1_or_ops_swapped_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mul %arg0, %arg1  : i64
    %2 = llvm.icmp "ne" %arg0, %0 : i64
    %3 = llvm.icmp "ne" %arg1, %0 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.store %1, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test1_or_ops_swapped_logical   : test1_or_ops_swapped_logical_before  ⊑  test1_or_ops_swapped_logical_combined := by
  unfold test1_or_ops_swapped_logical_before test1_or_ops_swapped_logical_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i1
  }]

theorem inst_combine_test1_or_ops_swapped_logical   : test1_or_ops_swapped_logical_before  ⊑  test1_or_ops_swapped_logical_combined := by
  unfold test1_or_ops_swapped_logical_before test1_or_ops_swapped_logical_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mul %arg0, %arg1  : i64
    %2 = llvm.icmp "ne" %arg0, %0 : i64
    %3 = llvm.icmp "ne" %arg1, %0 : i64
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.sub %0, %1  : i64
    llvm.store %5, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2_logical_combined := [llvmfunc|
  llvm.func @test2_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mul %arg0, %arg1  : i64
    %2 = llvm.icmp "ne" %arg0, %0 : i64
    %3 = llvm.icmp "ne" %arg1, %0 : i64
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.sub %0, %1  : i64
    llvm.store %5, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test2_logical   : test2_logical_before  ⊑  test2_logical_combined := by
  unfold test2_logical_before test2_logical_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i1
  }]

theorem inst_combine_test2_logical   : test2_logical_before  ⊑  test2_logical_combined := by
  unfold test2_logical_before test2_logical_combined
  simp_alive_peephole
  sorry
def test3_multiple_overflow_users_combined := [llvmfunc|
  llvm.func @test3_multiple_overflow_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.icmp "ne" %arg0, %0 : i64
    %4 = llvm.icmp "ne" %arg1, %0 : i64
    %5 = llvm.and %3, %4  : i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %5 : i1
  }]

theorem inst_combine_test3_multiple_overflow_users   : test3_multiple_overflow_users_before  ⊑  test3_multiple_overflow_users_combined := by
  unfold test3_multiple_overflow_users_before test3_multiple_overflow_users_combined
  simp_alive_peephole
  sorry
def test3_multiple_overflow_users_logical_combined := [llvmfunc|
  llvm.func @test3_multiple_overflow_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.icmp "ne" %arg0, %0 : i64
    %4 = llvm.icmp "ne" %arg1, %0 : i64
    %5 = llvm.and %3, %4  : i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %5 : i1
  }]

theorem inst_combine_test3_multiple_overflow_users_logical   : test3_multiple_overflow_users_logical_before  ⊑  test3_multiple_overflow_users_logical_combined := by
  unfold test3_multiple_overflow_users_logical_before test3_multiple_overflow_users_logical_combined
  simp_alive_peephole
  sorry
def test3_multiple_overflow_and_mul_users_combined := [llvmfunc|
  llvm.func @test3_multiple_overflow_and_mul_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test3_multiple_overflow_and_mul_users   : test3_multiple_overflow_and_mul_users_before  ⊑  test3_multiple_overflow_and_mul_users_combined := by
  unfold test3_multiple_overflow_and_mul_users_before test3_multiple_overflow_and_mul_users_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %5 : i1
  }]

theorem inst_combine_test3_multiple_overflow_and_mul_users   : test3_multiple_overflow_and_mul_users_before  ⊑  test3_multiple_overflow_and_mul_users_combined := by
  unfold test3_multiple_overflow_and_mul_users_before test3_multiple_overflow_and_mul_users_combined
  simp_alive_peephole
  sorry
def test3_multiple_overflow_and_mul_users_logical_combined := [llvmfunc|
  llvm.func @test3_multiple_overflow_and_mul_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test3_multiple_overflow_and_mul_users_logical   : test3_multiple_overflow_and_mul_users_logical_before  ⊑  test3_multiple_overflow_and_mul_users_logical_combined := by
  unfold test3_multiple_overflow_and_mul_users_logical_before test3_multiple_overflow_and_mul_users_logical_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %5 : i1
  }]

theorem inst_combine_test3_multiple_overflow_and_mul_users_logical   : test3_multiple_overflow_and_mul_users_logical_before  ⊑  test3_multiple_overflow_and_mul_users_logical_combined := by
  unfold test3_multiple_overflow_and_mul_users_logical_before test3_multiple_overflow_and_mul_users_logical_combined
  simp_alive_peephole
  sorry
def test3_multiple_res_users_combined := [llvmfunc|
  llvm.func @test3_multiple_res_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %3 = llvm.icmp "ne" %arg0, %0 : i64
    %4 = llvm.icmp "ne" %arg1, %0 : i64
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.sub %0, %2  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test3_multiple_res_users   : test3_multiple_res_users_before  ⊑  test3_multiple_res_users_combined := by
  unfold test3_multiple_res_users_before test3_multiple_res_users_combined
  simp_alive_peephole
  sorry
    llvm.call @use.2(%1) : (!llvm.struct<(i64, i1)>) -> ()
    llvm.return %5 : i1
  }]

theorem inst_combine_test3_multiple_res_users   : test3_multiple_res_users_before  ⊑  test3_multiple_res_users_combined := by
  unfold test3_multiple_res_users_before test3_multiple_res_users_combined
  simp_alive_peephole
  sorry
def test3_multiple_res_users_logical_combined := [llvmfunc|
  llvm.func @test3_multiple_res_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %3 = llvm.icmp "ne" %arg0, %0 : i64
    %4 = llvm.icmp "ne" %arg1, %0 : i64
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.sub %0, %2  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test3_multiple_res_users_logical   : test3_multiple_res_users_logical_before  ⊑  test3_multiple_res_users_logical_combined := by
  unfold test3_multiple_res_users_logical_before test3_multiple_res_users_logical_combined
  simp_alive_peephole
  sorry
    llvm.call @use.2(%1) : (!llvm.struct<(i64, i1)>) -> ()
    llvm.return %5 : i1
  }]

theorem inst_combine_test3_multiple_res_users_logical   : test3_multiple_res_users_logical_before  ⊑  test3_multiple_res_users_logical_combined := by
  unfold test3_multiple_res_users_logical_before test3_multiple_res_users_logical_combined
  simp_alive_peephole
  sorry
def test3_multiple_mul_users_combined := [llvmfunc|
  llvm.func @test3_multiple_mul_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mul %arg0, %arg1  : i64
    %2 = llvm.icmp "ne" %arg0, %0 : i64
    %3 = llvm.icmp "ne" %arg1, %0 : i64
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.sub %0, %1  : i64
    llvm.store %5, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test3_multiple_mul_users   : test3_multiple_mul_users_before  ⊑  test3_multiple_mul_users_combined := by
  unfold test3_multiple_mul_users_before test3_multiple_mul_users_combined
  simp_alive_peephole
  sorry
    llvm.call @use.3(%1) : (i64) -> ()
    llvm.return %4 : i1
  }]

theorem inst_combine_test3_multiple_mul_users   : test3_multiple_mul_users_before  ⊑  test3_multiple_mul_users_combined := by
  unfold test3_multiple_mul_users_before test3_multiple_mul_users_combined
  simp_alive_peephole
  sorry
def test3_multiple_mul_users_logical_combined := [llvmfunc|
  llvm.func @test3_multiple_mul_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mul %arg0, %arg1  : i64
    %2 = llvm.icmp "ne" %arg0, %0 : i64
    %3 = llvm.icmp "ne" %arg1, %0 : i64
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.sub %0, %1  : i64
    llvm.store %5, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test3_multiple_mul_users_logical   : test3_multiple_mul_users_logical_before  ⊑  test3_multiple_mul_users_logical_combined := by
  unfold test3_multiple_mul_users_logical_before test3_multiple_mul_users_logical_combined
  simp_alive_peephole
  sorry
    llvm.call @use.3(%1) : (i64) -> ()
    llvm.return %4 : i1
  }]

theorem inst_combine_test3_multiple_mul_users_logical   : test3_multiple_mul_users_logical_before  ⊑  test3_multiple_mul_users_logical_combined := by
  unfold test3_multiple_mul_users_logical_before test3_multiple_mul_users_logical_combined
  simp_alive_peephole
  sorry
def test4_no_icmp_ne_combined := [llvmfunc|
  llvm.func @test4_no_icmp_ne(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "sgt" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test4_no_icmp_ne   : test4_no_icmp_ne_before  ⊑  test4_no_icmp_ne_combined := by
  unfold test4_no_icmp_ne_before test4_no_icmp_ne_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i1
  }]

theorem inst_combine_test4_no_icmp_ne   : test4_no_icmp_ne_before  ⊑  test4_no_icmp_ne_combined := by
  unfold test4_no_icmp_ne_before test4_no_icmp_ne_combined
  simp_alive_peephole
  sorry
def test4_no_icmp_ne_logical_combined := [llvmfunc|
  llvm.func @test4_no_icmp_ne_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "sgt" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test4_no_icmp_ne_logical   : test4_no_icmp_ne_logical_before  ⊑  test4_no_icmp_ne_logical_combined := by
  unfold test4_no_icmp_ne_logical_before test4_no_icmp_ne_logical_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i1
  }]

theorem inst_combine_test4_no_icmp_ne_logical   : test4_no_icmp_ne_logical_before  ⊑  test4_no_icmp_ne_logical_combined := by
  unfold test4_no_icmp_ne_logical_before test4_no_icmp_ne_logical_combined
  simp_alive_peephole
  sorry
