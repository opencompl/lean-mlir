import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strcpy-nonzero-as
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_strcpy_to_memcpy_before := [llvmfunc|
  llvm.func @test_strcpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.call @strcpy(%arg0, %1) : (!llvm.ptr<200>, !llvm.ptr<200>) -> !llvm.ptr<200>
    llvm.return
  }]

def test_stpcpy_to_memcpy_before := [llvmfunc|
  llvm.func @test_stpcpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.call @stpcpy(%arg0, %1) : (!llvm.ptr<200>, !llvm.ptr<200>) -> !llvm.ptr<200>
    llvm.return
  }]

def test_stpcpy_to_strcpy_before := [llvmfunc|
  llvm.func @test_stpcpy_to_strcpy(%arg0: !llvm.ptr<200>, %arg1: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.call @stpcpy(%arg0, %arg1) : (!llvm.ptr<200>, !llvm.ptr<200>) -> !llvm.ptr<200>
    llvm.return
  }]

def test_strncpy_to_memcpy_before := [llvmfunc|
  llvm.func @test_strncpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.mlir.constant(17 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr<200>, !llvm.ptr<200>, i64) -> !llvm.ptr<200>
    llvm.return
  }]

def test_stpncpy_to_memcpy_before := [llvmfunc|
  llvm.func @test_stpncpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.mlir.constant(17 : i64) : i64
    %3 = llvm.call @stpncpy(%arg0, %1, %2) : (!llvm.ptr<200>, !llvm.ptr<200>, i64) -> !llvm.ptr<200>
    llvm.return
  }]

def test_strcpy_to_memcpy_combined := [llvmfunc|
  llvm.func @test_strcpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.mlir.constant(17 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr<200>, !llvm.ptr<200>, i64) -> ()
    llvm.return
  }]

theorem inst_combine_test_strcpy_to_memcpy   : test_strcpy_to_memcpy_before  ⊑  test_strcpy_to_memcpy_combined := by
  unfold test_strcpy_to_memcpy_before test_strcpy_to_memcpy_combined
  simp_alive_peephole
  sorry
def test_stpcpy_to_memcpy_combined := [llvmfunc|
  llvm.func @test_stpcpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.mlir.constant(17 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr<200>, !llvm.ptr<200>, i64) -> ()
    llvm.return
  }]

theorem inst_combine_test_stpcpy_to_memcpy   : test_stpcpy_to_memcpy_before  ⊑  test_stpcpy_to_memcpy_combined := by
  unfold test_stpcpy_to_memcpy_before test_stpcpy_to_memcpy_combined
  simp_alive_peephole
  sorry
def test_stpcpy_to_strcpy_combined := [llvmfunc|
  llvm.func @test_stpcpy_to_strcpy(%arg0: !llvm.ptr<200>, %arg1: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.call @strcpy(%arg0, %arg1) : (!llvm.ptr<200>, !llvm.ptr<200>) -> !llvm.ptr<200>
    llvm.return
  }]

theorem inst_combine_test_stpcpy_to_strcpy   : test_stpcpy_to_strcpy_before  ⊑  test_stpcpy_to_strcpy_combined := by
  unfold test_stpcpy_to_strcpy_before test_stpcpy_to_strcpy_combined
  simp_alive_peephole
  sorry
def test_strncpy_to_memcpy_combined := [llvmfunc|
  llvm.func @test_strncpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.mlir.constant(17 : i128) : i128
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr<200>, !llvm.ptr<200>, i128) -> ()
    llvm.return
  }]

theorem inst_combine_test_strncpy_to_memcpy   : test_strncpy_to_memcpy_before  ⊑  test_strncpy_to_memcpy_combined := by
  unfold test_strncpy_to_memcpy_before test_strncpy_to_memcpy_combined
  simp_alive_peephole
  sorry
def test_stpncpy_to_memcpy_combined := [llvmfunc|
  llvm.func @test_stpncpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.mlir.constant(17 : i128) : i128
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr<200>, !llvm.ptr<200>, i128) -> ()
    llvm.return
  }]

theorem inst_combine_test_stpncpy_to_memcpy   : test_stpncpy_to_memcpy_before  ⊑  test_stpncpy_to_memcpy_combined := by
  unfold test_stpncpy_to_memcpy_before test_stpncpy_to_memcpy_combined
  simp_alive_peephole
  sorry
