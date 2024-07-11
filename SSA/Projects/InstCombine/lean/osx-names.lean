import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  osx-names
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("Hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1, %arg1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("Hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.call @fwrite$UNIX2003(%1, %2, %3, %arg0) : (!llvm.ptr, i32, i32, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.call @fputs$UNIX2003(%arg1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
