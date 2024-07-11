import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sprintf-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @sprintf(%arg0, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("\00hello\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_c : !llvm.ptr
    %2 = llvm.mlir.constant(104 : i8) : i8
    %3 = llvm.call @sprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i8) -> i32
    llvm.return
  }]

def test_simplify5_before := [llvmfunc|
  llvm.func @test_simplify5(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_s : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1, %arg1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify6_before := [llvmfunc|
  llvm.func @test_simplify6(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%d\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_d : !llvm.ptr
    %2 = llvm.mlir.constant(187 : i32) : i32
    %3 = llvm.call @sprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return
  }]

def test_simplify7_before := [llvmfunc|
  llvm.func @test_simplify7(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_s : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1, %arg1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def test_simplify8_before := [llvmfunc|
  llvm.func @test_simplify8(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_s : !llvm.ptr
    %2 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %3 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %4 = llvm.call @sprintf(%arg0, %1, %3) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

def test_simplify9_before := [llvmfunc|
  llvm.func @test_simplify9(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_s : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1, %arg1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%f\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_f : !llvm.ptr
    %2 = llvm.mlir.constant(1.870000e+00 : f64) : f64
    %3 = llvm.call @sprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    llvm.return
  }]

def test_no_simplify2_before := [llvmfunc|
  llvm.func @test_no_simplify2(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: f64) {
    %0 = llvm.call @sprintf(%arg0, %arg1, %arg2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    llvm.return
  }]

def test_no_simplify3_before := [llvmfunc|
  llvm.func @test_no_simplify3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 attributes {passthrough = ["minsize"]} {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_s : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1, %arg1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.mlir.constant(13 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(104 : i8) : i8
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
    %3 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.store %2, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_simplify5_combined := [llvmfunc|
  llvm.func @test_simplify5(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.call @strcpy(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_simplify5   : test_simplify5_before  ⊑  test_simplify5_combined := by
  unfold test_simplify5_before test_simplify5_combined
  simp_alive_peephole
  sorry
def test_simplify6_combined := [llvmfunc|
  llvm.func @test_simplify6(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%d\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_d : !llvm.ptr
    %2 = llvm.mlir.constant(187 : i32) : i32
    %3 = llvm.call @sprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify6   : test_simplify6_before  ⊑  test_simplify6_combined := by
  unfold test_simplify6_before test_simplify6_combined
  simp_alive_peephole
  sorry
def test_simplify7_combined := [llvmfunc|
  llvm.func @test_simplify7(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.call @stpcpy(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_simplify7   : test_simplify7_before  ⊑  test_simplify7_combined := by
  unfold test_simplify7_before test_simplify7_combined
  simp_alive_peephole
  sorry
def test_simplify8_combined := [llvmfunc|
  llvm.func @test_simplify8(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.mlir.constant(13 : i32) : i32
    %3 = llvm.mlir.constant(12 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_test_simplify8   : test_simplify8_before  ⊑  test_simplify8_combined := by
  unfold test_simplify8_before test_simplify8_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i32
  }]

theorem inst_combine_test_simplify8   : test_simplify8_before  ⊑  test_simplify8_combined := by
  unfold test_simplify8_before test_simplify8_combined
  simp_alive_peephole
  sorry
def test_simplify9_combined := [llvmfunc|
  llvm.func @test_simplify9(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.call @stpcpy(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_simplify9   : test_simplify9_before  ⊑  test_simplify9_combined := by
  unfold test_simplify9_before test_simplify9_combined
  simp_alive_peephole
  sorry
def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%f\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_f : !llvm.ptr
    %2 = llvm.mlir.constant(1.870000e+00 : f64) : f64
    %3 = llvm.call @sprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
def test_no_simplify2_combined := [llvmfunc|
  llvm.func @test_no_simplify2(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: f64) {
    %0 = llvm.call @sprintf(%arg0, %arg1, %arg2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_test_no_simplify2   : test_no_simplify2_before  ⊑  test_no_simplify2_combined := by
  unfold test_no_simplify2_before test_no_simplify2_combined
  simp_alive_peephole
  sorry
def test_no_simplify3_combined := [llvmfunc|
  llvm.func @test_no_simplify3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 attributes {passthrough = ["minsize"]} {
    %0 = llvm.call @stpcpy(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_no_simplify3   : test_no_simplify3_before  ⊑  test_no_simplify3_combined := by
  unfold test_no_simplify3_before test_no_simplify3_combined
  simp_alive_peephole
  sorry
