import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  tmp-alloca-bypass
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @g0 : !llvm.ptr
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.mlir.constant(16 : i64) : i64
    %4 = llvm.alloca %0 x !llvm.struct<"t0", (ptr, i64)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.call @get_cond() : () -> i1
    %6 = llvm.select %5, %1, %2 : i1, !llvm.ptr
    "llvm.intr.memcpy"(%4, %6, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    "llvm.intr.memcpy"(%arg0, %4, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    %2 = llvm.mlir.constant(2503 : i32) : i32
    %3 = llvm.mlir.addressof @g0 : !llvm.ptr
    %4 = llvm.mlir.addressof @g1 : !llvm.ptr
    %5 = llvm.mlir.constant(16 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.struct<"t0", (ptr, i64)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.call @func(%1) : (!llvm.ptr) -> i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    %9 = llvm.select %8, %3, %4 : i1, !llvm.ptr
    "llvm.intr.memcpy"(%6, %9, %5) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    %10 = llvm.call @func(%6) : (!llvm.ptr) -> i32
    llvm.unreachable
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @g0 : !llvm.ptr
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.mlir.constant(16 : i64) : i64
    %4 = llvm.alloca %0 x !llvm.struct<"t0", (ptr, i64)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.call @get_cond() : () -> i1
    %6 = llvm.select %5, %1, %2 : i1, !llvm.ptr
    "llvm.intr.memcpy"(%4, %6, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%arg0, %4, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    %2 = llvm.mlir.constant(2503 : i32) : i32
    %3 = llvm.mlir.addressof @g0 : !llvm.ptr
    %4 = llvm.mlir.addressof @g1 : !llvm.ptr
    %5 = llvm.mlir.constant(16 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.struct<"t0", (ptr, i64)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.call @func(%1) : (!llvm.ptr) -> i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    %9 = llvm.select %8, %3, %4 : i1, !llvm.ptr
    "llvm.intr.memcpy"(%6, %9, %5) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %10 = llvm.call @func(%6) : (!llvm.ptr) -> i32
    llvm.unreachable
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
