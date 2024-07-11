import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr39908
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg0[%0, %arg1, 0, %0] : (!llvm.ptr, i32, i32, i32) -> !llvm.ptr, !llvm.array<0 x struct<"S", (array<2 x i32>)>>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"S", (array<2 x i32>)>
    %4 = llvm.icmp "eq" %3, %arg0 : !llvm.ptr
    llvm.return %4 : i1
  }]

def test64_before := [llvmfunc|
  llvm.func @test64(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.getelementptr inbounds %arg0[%0, %arg1, 0, %0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<0 x struct<"S", (array<2 x i32>)>>
    %4 = llvm.getelementptr inbounds %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"S", (array<2 x i32>)>
    %5 = llvm.icmp "eq" %4, %arg0 : !llvm.ptr
    llvm.return %5 : i1
  }]

def test64_overflow_before := [llvmfunc|
  llvm.func @test64_overflow(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8589934592 : i64) : i64
    %3 = llvm.mlir.constant(-1 : i64) : i64
    %4 = llvm.getelementptr inbounds %arg0[%0, %arg1, 0, %2] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<0 x struct<"S", (array<2 x i32>)>>
    %5 = llvm.getelementptr inbounds %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"S", (array<2 x i32>)>
    %6 = llvm.icmp "eq" %5, %arg0 : !llvm.ptr
    llvm.return %6 : i1
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg0[%0, %arg1, 0, %0] : (!llvm.ptr, i32, i32, i32) -> !llvm.ptr, !llvm.array<0 x struct<"S", (array<2 x i32>)>>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"S", (array<2 x i32>)>
    %4 = llvm.icmp "eq" %3, %arg0 : !llvm.ptr
    llvm.return %4 : i1
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test64_combined := [llvmfunc|
  llvm.func @test64(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.trunc %arg1 : i64 to i32
    %3 = llvm.getelementptr inbounds %arg0[%0, %2, 0, %0] : (!llvm.ptr, i32, i32, i32) -> !llvm.ptr, !llvm.array<0 x struct<"S", (array<2 x i32>)>>
    %4 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"S", (array<2 x i32>)>
    %5 = llvm.icmp "eq" %4, %arg0 : !llvm.ptr
    llvm.return %5 : i1
  }]

theorem inst_combine_test64   : test64_before  ⊑  test64_combined := by
  unfold test64_before test64_combined
  simp_alive_peephole
  sorry
def test64_overflow_combined := [llvmfunc|
  llvm.func @test64_overflow(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.trunc %arg1 : i64 to i32
    %3 = llvm.getelementptr inbounds %arg0[%0, %2, 0, %0] : (!llvm.ptr, i32, i32, i32) -> !llvm.ptr, !llvm.array<0 x struct<"S", (array<2 x i32>)>>
    %4 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"S", (array<2 x i32>)>
    %5 = llvm.icmp "eq" %4, %arg0 : !llvm.ptr
    llvm.return %5 : i1
  }]

theorem inst_combine_test64_overflow   : test64_overflow_before  ⊑  test64_overflow_combined := by
  unfold test64_overflow_before test64_overflow_combined
  simp_alive_peephole
  sorry
