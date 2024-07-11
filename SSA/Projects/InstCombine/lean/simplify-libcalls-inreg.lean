import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  simplify-libcalls-inreg
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def baz_before := [llvmfunc|
  llvm.func @baz(%arg0: !llvm.ptr {llvm.inreg, llvm.noundef}, %arg1: i32 {llvm.inreg, llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @foo() : () -> !llvm.ptr
    %2 = llvm.call @memcmp(%1, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

def test_fewer_params_than_num_register_parameters_before := [llvmfunc|
  llvm.func @test_fewer_params_than_num_register_parameters() {
    %0 = llvm.mlir.constant("h\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @h : !llvm.ptr
    %2 = llvm.call @printf(%1) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    llvm.return
  }]

def test_non_int_params_before := [llvmfunc|
  llvm.func @test_non_int_params(%arg0: i16 {llvm.signext}) -> f64 {
    %0 = llvm.sitofp %arg0 : i16 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_variadic_before := [llvmfunc|
  llvm.func @test_variadic() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-1 : i32) : i32
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.call @__sprintf_chk(%2, %3, %4, %5) vararg(!llvm.func<i32 (ptr, i32, i32, ptr, ...)>) : (!llvm.ptr, i32, i32, !llvm.ptr) -> i32
    llvm.return %6 : i32
  }]

def baz_combined := [llvmfunc|
  llvm.func @baz(%arg0: !llvm.ptr {llvm.inreg, llvm.noundef}, %arg1: i32 {llvm.inreg, llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @foo() : () -> !llvm.ptr
    %2 = llvm.call @bcmp(%1, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_baz   : baz_before  ⊑  baz_combined := by
  unfold baz_before baz_combined
  simp_alive_peephole
  sorry
def test_fewer_params_than_num_register_parameters_combined := [llvmfunc|
  llvm.func @test_fewer_params_than_num_register_parameters() {
    %0 = llvm.mlir.constant(104 : i32) : i32
    %1 = llvm.call @putchar(%0) : (i32) -> i32
    llvm.return
  }]

theorem inst_combine_test_fewer_params_than_num_register_parameters   : test_fewer_params_than_num_register_parameters_before  ⊑  test_fewer_params_than_num_register_parameters_combined := by
  unfold test_fewer_params_than_num_register_parameters_before test_fewer_params_than_num_register_parameters_combined
  simp_alive_peephole
  sorry
def test_non_int_params_combined := [llvmfunc|
  llvm.func @test_non_int_params(%arg0: i16 {llvm.signext}) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.call @ldexp(%0, %1) : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_non_int_params   : test_non_int_params_before  ⊑  test_non_int_params_combined := by
  unfold test_non_int_params_before test_non_int_params_combined
  simp_alive_peephole
  sorry
def test_variadic_combined := [llvmfunc|
  llvm.func @test_variadic() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.call @sprintf(%2, %3) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_variadic   : test_variadic_before  ⊑  test_variadic_combined := by
  unfold test_variadic_before test_variadic_combined
  simp_alive_peephole
  sorry
