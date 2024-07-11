import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  or-xor
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    llvm.return %3 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg1, %2  : i32
    llvm.return %3 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    llvm.return %3 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg1, %2  : i32
    llvm.return %3 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }]

def test5_commuted_before := [llvmfunc|
  llvm.func @test5_commuted(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.xor %arg0, %1  : vector<2xi4>
    %4 = llvm.or %3, %2  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

def test5_commuted_x_y_before := [llvmfunc|
  llvm.func @test5_commuted_x_y(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.xor %arg1, %arg0  : i64
    %2 = llvm.xor %arg0, %0  : i64
    %3 = llvm.or %1, %2  : i64
    llvm.return %3 : i64
  }]

def test5_extra_use_not_before := [llvmfunc|
  llvm.func @test5_extra_use_not(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.store %2, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

def test5_extra_use_xor_before := [llvmfunc|
  llvm.func @test5_extra_use_xor(%arg0: i65, %arg1: i65, %arg2: !llvm.ptr) -> i65 {
    %0 = llvm.mlir.constant(-1 : i65) : i65
    %1 = llvm.xor %arg0, %arg1  : i65
    llvm.store %1, %arg2 {alignment = 4 : i64} : i65, !llvm.ptr]

    %2 = llvm.xor %arg0, %0  : i65
    %3 = llvm.or %2, %1  : i65
    llvm.return %3 : i65
  }]

def test5_extra_use_not_xor_before := [llvmfunc|
  llvm.func @test5_extra_use_not_xor(%arg0: i16, %arg1: i16, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.xor %arg0, %arg1  : i16
    llvm.store %1, %arg3 {alignment = 2 : i64} : i16, !llvm.ptr]

    %2 = llvm.xor %arg0, %0  : i16
    llvm.store %2, %arg2 {alignment = 2 : i64} : i16, !llvm.ptr]

    %3 = llvm.or %2, %1  : i16
    llvm.return %3 : i16
  }]

def xor_common_op_commute0_before := [llvmfunc|
  llvm.func @xor_common_op_commute0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.xor %arg0, %arg1  : i8
    %1 = llvm.or %0, %arg0  : i8
    llvm.return %1 : i8
  }]

def xor_common_op_commute1_before := [llvmfunc|
  llvm.func @xor_common_op_commute1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.xor %arg1, %arg0  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.or %0, %arg0  : i8
    llvm.return %1 : i8
  }]

def xor_common_op_commute2_before := [llvmfunc|
  llvm.func @xor_common_op_commute2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %1, %arg1  : i8
    %3 = llvm.or %1, %2  : i8
    llvm.return %3 : i8
  }]

def xor_common_op_commute3_before := [llvmfunc|
  llvm.func @xor_common_op_commute3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.mul %arg1, %arg1  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.or %arg1, %2  : i32
    llvm.return %3 : i32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.or %arg0, %2  : i32
    llvm.return %3 : i32
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

def test10_commuted_before := [llvmfunc|
  llvm.func @test10_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

def test10_extrause_before := [llvmfunc|
  llvm.func @test10_extrause(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

def test10_commuted_extrause_before := [llvmfunc|
  llvm.func @test10_commuted_extrause(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

def test10_canonical_before := [llvmfunc|
  llvm.func @test10_canonical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def test12_commuted_before := [llvmfunc|
  llvm.func @test12_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.or %arg1, %arg0  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg1, %arg0  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %arg0, %1  : i32
    %4 = llvm.or %2, %arg1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }]

def test14_commuted_before := [llvmfunc|
  llvm.func @test14_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %1, %arg0  : i32
    %4 = llvm.or %2, %arg1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.and %2, %arg1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }]

def test15_commuted_before := [llvmfunc|
  llvm.func @test15_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %1, %arg0  : i32
    %4 = llvm.and %2, %arg1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }]

def or_and_xor_not_constant_commute0_before := [llvmfunc|
  llvm.func @or_and_xor_not_constant_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }]

def or_and_xor_not_constant_commute1_before := [llvmfunc|
  llvm.func @or_and_xor_not_constant_commute1(%arg0: i9, %arg1: i9) -> i9 {
    %0 = llvm.mlir.constant(42 : i9) : i9
    %1 = llvm.mlir.constant(-43 : i9) : i9
    %2 = llvm.xor %arg1, %arg0  : i9
    %3 = llvm.and %2, %0  : i9
    %4 = llvm.and %arg1, %1  : i9
    %5 = llvm.or %3, %4  : i9
    llvm.return %5 : i9
  }]

def or_and_xor_not_constant_commute2_splat_before := [llvmfunc|
  llvm.func @or_and_xor_not_constant_commute2_splat(%arg0: vector<2xi9>, %arg1: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(42 : i9) : i9
    %1 = llvm.mlir.constant(dense<42> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(-43 : i9) : i9
    %3 = llvm.mlir.constant(dense<-43> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.xor %arg1, %arg0  : vector<2xi9>
    %5 = llvm.and %4, %1  : vector<2xi9>
    %6 = llvm.and %arg1, %3  : vector<2xi9>
    %7 = llvm.or %6, %5  : vector<2xi9>
    llvm.return %7 : vector<2xi9>
  }]

def or_and_xor_not_constant_commute3_splat_before := [llvmfunc|
  llvm.func @or_and_xor_not_constant_commute3_splat(%arg0: vector<2xi9>, %arg1: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(42 : i9) : i9
    %1 = llvm.mlir.constant(dense<42> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(-43 : i9) : i9
    %3 = llvm.mlir.constant(dense<-43> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.xor %arg0, %arg1  : vector<2xi9>
    %5 = llvm.and %4, %1  : vector<2xi9>
    %6 = llvm.and %arg1, %3  : vector<2xi9>
    %7 = llvm.or %6, %5  : vector<2xi9>
    llvm.return %7 : vector<2xi9>
  }]

def not_or_before := [llvmfunc|
  llvm.func @not_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_or_xor_before := [llvmfunc|
  llvm.func @not_or_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }]

def xor_or_before := [llvmfunc|
  llvm.func @xor_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

def xor_or2_before := [llvmfunc|
  llvm.func @xor_or2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

def xor_or_xor_before := [llvmfunc|
  llvm.func @xor_or_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }]

def or_xor_or_before := [llvmfunc|
  llvm.func @or_xor_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.or %arg0, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.or %1, %3  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.or %2, %1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }]

def test20_before := [llvmfunc|
  llvm.func @test20(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.or %1, %2  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }]

def test21_before := [llvmfunc|
  llvm.func @test21(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }]

def test22_before := [llvmfunc|
  llvm.func @test22(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.or %arg1, %arg0  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }]

def test23_before := [llvmfunc|
  llvm.func @test23(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(13 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(12 : i8) : i8
    %4 = llvm.or %arg0, %0  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.or %5, %2  : i8
    %7 = llvm.xor %6, %3  : i8
    llvm.return %7 : i8
  }]

def test23v_before := [llvmfunc|
  llvm.func @test23v(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[-2, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<13> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.constant(12 : i8) : i8
    %5 = llvm.or %arg0, %0  : vector<2xi8>
    %6 = llvm.xor %5, %1  : vector<2xi8>
    %7 = llvm.extractelement %6[%2 : i32] : vector<2xi8>
    %8 = llvm.or %7, %3  : i8
    %9 = llvm.xor %8, %4  : i8
    llvm.return %9 : i8
  }]

def PR45977_f1_before := [llvmfunc|
  llvm.func @PR45977_f1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }]

def PR45977_f2_before := [llvmfunc|
  llvm.func @PR45977_f2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.xor %1, %3  : i32
    llvm.return %4 : i32
  }]

def or_xor_common_op_commute0_before := [llvmfunc|
  llvm.func @or_xor_common_op_commute0(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.xor %arg0, %arg2  : i8
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }]

def or_xor_common_op_commute1_before := [llvmfunc|
  llvm.func @or_xor_common_op_commute1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.xor %arg0, %arg2  : i8
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }]

def or_xor_common_op_commute2_before := [llvmfunc|
  llvm.func @or_xor_common_op_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.xor %arg2, %arg0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }]

def or_xor_common_op_commute3_before := [llvmfunc|
  llvm.func @or_xor_common_op_commute3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.xor %arg2, %arg0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }]

def or_xor_common_op_commute4_before := [llvmfunc|
  llvm.func @or_xor_common_op_commute4(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %2 = llvm.or %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def or_xor_common_op_commute5_before := [llvmfunc|
  llvm.func @or_xor_common_op_commute5(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    %1 = llvm.xor %arg0, %arg2  : i8
    %2 = llvm.or %1, %0  : i8
    llvm.return %2 : i8
  }]

def or_xor_common_op_commute6_before := [llvmfunc|
  llvm.func @or_xor_common_op_commute6(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.xor %arg2, %arg0  : i8
    %2 = llvm.or %1, %0  : i8
    llvm.return %2 : i8
  }]

def or_xor_common_op_commute7_before := [llvmfunc|
  llvm.func @or_xor_common_op_commute7(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    %1 = llvm.xor %arg2, %arg0  : i8
    %2 = llvm.or %1, %0  : i8
    llvm.return %2 : i8
  }]

def or_xor_notcommon_op_before := [llvmfunc|
  llvm.func @or_xor_notcommon_op(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.xor %arg3, %arg2  : i8
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }]

def or_not_xor_common_op_commute0_before := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.or %1, %arg2  : i4
    %4 = llvm.or %3, %2  : i4
    llvm.return %4 : i4
  }]

def or_not_xor_common_op_commute1_before := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.or %1, %arg2  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

def or_not_xor_common_op_commute2_before := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.xor %arg0, %arg1  : i8
    %5 = llvm.or %2, %3  : i8
    %6 = llvm.or %4, %5  : i8
    llvm.return %6 : i8
  }]

def or_not_xor_common_op_commute3_before := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.xor %arg0, %arg1  : i8
    %5 = llvm.or %2, %3  : i8
    %6 = llvm.or %5, %4  : i8
    llvm.return %6 : i8
  }]

def or_not_xor_common_op_commute4_before := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute4(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %1  : vector<2xi4>
    %3 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %4 = llvm.or %2, %arg2  : vector<2xi4>
    %5 = llvm.or %4, %3  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def or_not_xor_common_op_commute5_before := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute5(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %arg0  : i8
    %3 = llvm.or %1, %arg2  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

def or_not_xor_common_op_commute6_before := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute6(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.xor %arg1, %arg0  : i8
    %5 = llvm.or %2, %3  : i8
    %6 = llvm.or %4, %5  : i8
    llvm.return %6 : i8
  }]

def or_not_xor_common_op_commute7_before := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute7(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.xor %arg1, %arg0  : i8
    %5 = llvm.or %2, %3  : i8
    %6 = llvm.or %5, %4  : i8
    llvm.return %6 : i8
  }]

def or_not_xor_common_op_use1_before := [llvmfunc|
  llvm.func @or_not_xor_common_op_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.or %1, %arg2  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

def or_not_xor_common_op_use2_before := [llvmfunc|
  llvm.func @or_not_xor_common_op_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.or %1, %arg2  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

def or_nand_xor_common_op_commute0_before := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg0, %arg2  : i4
    %2 = llvm.xor %1, %0  : i4
    %3 = llvm.xor %arg0, %arg1  : i4
    %4 = llvm.or %2, %3  : i4
    llvm.return %4 : i4
  }]

def or_nand_xor_common_op_commute1_before := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute1(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.poison : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.and %arg2, %arg0  : vector<2xi4>
    %8 = llvm.xor %7, %6  : vector<2xi4>
    %9 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %10 = llvm.or %9, %8  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }]

def or_nand_xor_common_op_commute2_before := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg0, %arg2  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.xor %arg1, %arg0  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

def or_nand_xor_common_op_commute3_before := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg1, %arg0  : i8
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }]

def or_nand_xor_common_op_commute3_use2_before := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute3_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.xor %arg1, %arg0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }]

def or_nand_xor_common_op_commute3_use3_before := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute3_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg1, %arg0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }]

def PR75692_1_before := [llvmfunc|
  llvm.func @PR75692_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

def PR75692_2_before := [llvmfunc|
  llvm.func @PR75692_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

def PR75692_3_before := [llvmfunc|
  llvm.func @PR75692_3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

def or_xor_not_before := [llvmfunc|
  llvm.func @or_xor_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.or %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def or_xor_not_uses1_before := [llvmfunc|
  llvm.func @or_xor_not_uses1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.xor %arg1, %0  : i32
    llvm.call %1(%2) : !llvm.ptr, (i32) -> ()
    %3 = llvm.xor %arg0, %2  : i32
    %4 = llvm.or %3, %arg1  : i32
    llvm.return %4 : i32
  }]

def or_xor_not_uses2_before := [llvmfunc|
  llvm.func @or_xor_not_uses2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.xor %arg0, %2  : i32
    llvm.call %1(%3) : !llvm.ptr, (i32) -> ()
    %4 = llvm.or %3, %arg1  : i32
    llvm.return %4 : i32
  }]

def or_xor_and_commuted1_before := [llvmfunc|
  llvm.func @or_xor_and_commuted1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %2, %arg0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

def or_xor_and_commuted2_before := [llvmfunc|
  llvm.func @or_xor_and_commuted2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.mul %arg0, %arg0  : i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %3  : i32
    %5 = llvm.or %4, %1  : i32
    llvm.return %5 : i32
  }]

def or_xor_tree_0000_before := [llvmfunc|
  llvm.func @or_xor_tree_0000(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_0001_before := [llvmfunc|
  llvm.func @or_xor_tree_0001(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_0010_before := [llvmfunc|
  llvm.func @or_xor_tree_0010(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_0011_before := [llvmfunc|
  llvm.func @or_xor_tree_0011(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_0100_before := [llvmfunc|
  llvm.func @or_xor_tree_0100(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_0101_before := [llvmfunc|
  llvm.func @or_xor_tree_0101(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_0110_before := [llvmfunc|
  llvm.func @or_xor_tree_0110(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_0111_before := [llvmfunc|
  llvm.func @or_xor_tree_0111(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_1000_before := [llvmfunc|
  llvm.func @or_xor_tree_1000(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_1001_before := [llvmfunc|
  llvm.func @or_xor_tree_1001(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_1010_before := [llvmfunc|
  llvm.func @or_xor_tree_1010(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_1011_before := [llvmfunc|
  llvm.func @or_xor_tree_1011(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_1100_before := [llvmfunc|
  llvm.func @or_xor_tree_1100(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_1101_before := [llvmfunc|
  llvm.func @or_xor_tree_1101(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_1110_before := [llvmfunc|
  llvm.func @or_xor_tree_1110(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

def or_xor_tree_1111_before := [llvmfunc|
  llvm.func @or_xor_tree_1111(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test5_commuted_combined := [llvmfunc|
  llvm.func @test5_commuted(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.and %arg0, %arg1  : vector<2xi4>
    %3 = llvm.xor %2, %1  : vector<2xi4>
    llvm.return %3 : vector<2xi4>
  }]

theorem inst_combine_test5_commuted   : test5_commuted_before  ⊑  test5_commuted_combined := by
  unfold test5_commuted_before test5_commuted_combined
  simp_alive_peephole
  sorry
def test5_commuted_x_y_combined := [llvmfunc|
  llvm.func @test5_commuted_x_y(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.and %arg1, %arg0  : i64
    %2 = llvm.xor %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test5_commuted_x_y   : test5_commuted_x_y_before  ⊑  test5_commuted_x_y_combined := by
  unfold test5_commuted_x_y_before test5_commuted_x_y_combined
  simp_alive_peephole
  sorry
def test5_extra_use_not_combined := [llvmfunc|
  llvm.func @test5_extra_use_not(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.store %1, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test5_extra_use_not   : test5_extra_use_not_before  ⊑  test5_extra_use_not_combined := by
  unfold test5_extra_use_not_before test5_extra_use_not_combined
  simp_alive_peephole
  sorry
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test5_extra_use_not   : test5_extra_use_not_before  ⊑  test5_extra_use_not_combined := by
  unfold test5_extra_use_not_before test5_extra_use_not_combined
  simp_alive_peephole
  sorry
def test5_extra_use_xor_combined := [llvmfunc|
  llvm.func @test5_extra_use_xor(%arg0: i65, %arg1: i65, %arg2: !llvm.ptr) -> i65 {
    %0 = llvm.mlir.constant(-1 : i65) : i65
    %1 = llvm.xor %arg0, %arg1  : i65
    llvm.store %1, %arg2 {alignment = 4 : i64} : i65, !llvm.ptr]

theorem inst_combine_test5_extra_use_xor   : test5_extra_use_xor_before  ⊑  test5_extra_use_xor_combined := by
  unfold test5_extra_use_xor_before test5_extra_use_xor_combined
  simp_alive_peephole
  sorry
    %2 = llvm.and %arg0, %arg1  : i65
    %3 = llvm.xor %2, %0  : i65
    llvm.return %3 : i65
  }]

theorem inst_combine_test5_extra_use_xor   : test5_extra_use_xor_before  ⊑  test5_extra_use_xor_combined := by
  unfold test5_extra_use_xor_before test5_extra_use_xor_combined
  simp_alive_peephole
  sorry
def test5_extra_use_not_xor_combined := [llvmfunc|
  llvm.func @test5_extra_use_not_xor(%arg0: i16, %arg1: i16, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.xor %arg0, %arg1  : i16
    llvm.store %1, %arg3 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine_test5_extra_use_not_xor   : test5_extra_use_not_xor_before  ⊑  test5_extra_use_not_xor_combined := by
  unfold test5_extra_use_not_xor_before test5_extra_use_not_xor_combined
  simp_alive_peephole
  sorry
    %2 = llvm.xor %arg0, %0  : i16
    llvm.store %2, %arg2 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine_test5_extra_use_not_xor   : test5_extra_use_not_xor_before  ⊑  test5_extra_use_not_xor_combined := by
  unfold test5_extra_use_not_xor_before test5_extra_use_not_xor_combined
  simp_alive_peephole
  sorry
    %3 = llvm.or %1, %2  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_test5_extra_use_not_xor   : test5_extra_use_not_xor_before  ⊑  test5_extra_use_not_xor_combined := by
  unfold test5_extra_use_not_xor_before test5_extra_use_not_xor_combined
  simp_alive_peephole
  sorry
def xor_common_op_commute0_combined := [llvmfunc|
  llvm.func @xor_common_op_commute0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_xor_common_op_commute0   : xor_common_op_commute0_before  ⊑  xor_common_op_commute0_combined := by
  unfold xor_common_op_commute0_before xor_common_op_commute0_combined
  simp_alive_peephole
  sorry
def xor_common_op_commute1_combined := [llvmfunc|
  llvm.func @xor_common_op_commute1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.xor %arg1, %arg0  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.or %arg0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_xor_common_op_commute1   : xor_common_op_commute1_before  ⊑  xor_common_op_commute1_combined := by
  unfold xor_common_op_commute1_before xor_common_op_commute1_combined
  simp_alive_peephole
  sorry
def xor_common_op_commute2_combined := [llvmfunc|
  llvm.func @xor_common_op_commute2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.or %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_xor_common_op_commute2   : xor_common_op_commute2_before  ⊑  xor_common_op_commute2_combined := by
  unfold xor_common_op_commute2_before xor_common_op_commute2_combined
  simp_alive_peephole
  sorry
def xor_common_op_commute3_combined := [llvmfunc|
  llvm.func @xor_common_op_commute3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.mul %arg1, %arg1  : i8
    %3 = llvm.or %1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_xor_common_op_commute3   : xor_common_op_commute3_before  ⊑  xor_common_op_commute3_combined := by
  unfold xor_common_op_commute3_before xor_common_op_commute3_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10_commuted_combined := [llvmfunc|
  llvm.func @test10_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test10_commuted   : test10_commuted_before  ⊑  test10_commuted_combined := by
  unfold test10_commuted_before test10_commuted_combined
  simp_alive_peephole
  sorry
def test10_extrause_combined := [llvmfunc|
  llvm.func @test10_extrause(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test10_extrause   : test10_extrause_before  ⊑  test10_extrause_combined := by
  unfold test10_extrause_before test10_extrause_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_test10_extrause   : test10_extrause_before  ⊑  test10_extrause_combined := by
  unfold test10_extrause_before test10_extrause_combined
  simp_alive_peephole
  sorry
def test10_commuted_extrause_combined := [llvmfunc|
  llvm.func @test10_commuted_extrause(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test10_commuted_extrause   : test10_commuted_extrause_before  ⊑  test10_commuted_extrause_combined := by
  unfold test10_commuted_extrause_before test10_commuted_extrause_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_test10_commuted_extrause   : test10_commuted_extrause_before  ⊑  test10_commuted_extrause_combined := by
  unfold test10_commuted_extrause_before test10_commuted_extrause_combined
  simp_alive_peephole
  sorry
def test10_canonical_combined := [llvmfunc|
  llvm.func @test10_canonical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test10_canonical   : test10_canonical_before  ⊑  test10_canonical_combined := by
  unfold test10_canonical_before test10_canonical_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test12_commuted_combined := [llvmfunc|
  llvm.func @test12_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test12_commuted   : test12_commuted_before  ⊑  test12_commuted_combined := by
  unfold test12_commuted_before test12_commuted_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg1, %arg0  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test14_commuted_combined := [llvmfunc|
  llvm.func @test14_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test14_commuted   : test14_commuted_before  ⊑  test14_commuted_combined := by
  unfold test14_commuted_before test14_commuted_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test15_commuted_combined := [llvmfunc|
  llvm.func @test15_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test15_commuted   : test15_commuted_before  ⊑  test15_commuted_combined := by
  unfold test15_commuted_before test15_commuted_combined
  simp_alive_peephole
  sorry
def or_and_xor_not_constant_commute0_combined := [llvmfunc|
  llvm.func @or_and_xor_not_constant_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_and_xor_not_constant_commute0   : or_and_xor_not_constant_commute0_before  ⊑  or_and_xor_not_constant_commute0_combined := by
  unfold or_and_xor_not_constant_commute0_before or_and_xor_not_constant_commute0_combined
  simp_alive_peephole
  sorry
def or_and_xor_not_constant_commute1_combined := [llvmfunc|
  llvm.func @or_and_xor_not_constant_commute1(%arg0: i9, %arg1: i9) -> i9 {
    %0 = llvm.mlir.constant(42 : i9) : i9
    %1 = llvm.and %arg0, %0  : i9
    %2 = llvm.xor %1, %arg1  : i9
    llvm.return %2 : i9
  }]

theorem inst_combine_or_and_xor_not_constant_commute1   : or_and_xor_not_constant_commute1_before  ⊑  or_and_xor_not_constant_commute1_combined := by
  unfold or_and_xor_not_constant_commute1_before or_and_xor_not_constant_commute1_combined
  simp_alive_peephole
  sorry
def or_and_xor_not_constant_commute2_splat_combined := [llvmfunc|
  llvm.func @or_and_xor_not_constant_commute2_splat(%arg0: vector<2xi9>, %arg1: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(42 : i9) : i9
    %1 = llvm.mlir.constant(dense<42> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.and %arg0, %1  : vector<2xi9>
    %3 = llvm.xor %2, %arg1  : vector<2xi9>
    llvm.return %3 : vector<2xi9>
  }]

theorem inst_combine_or_and_xor_not_constant_commute2_splat   : or_and_xor_not_constant_commute2_splat_before  ⊑  or_and_xor_not_constant_commute2_splat_combined := by
  unfold or_and_xor_not_constant_commute2_splat_before or_and_xor_not_constant_commute2_splat_combined
  simp_alive_peephole
  sorry
def or_and_xor_not_constant_commute3_splat_combined := [llvmfunc|
  llvm.func @or_and_xor_not_constant_commute3_splat(%arg0: vector<2xi9>, %arg1: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(42 : i9) : i9
    %1 = llvm.mlir.constant(dense<42> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.and %arg0, %1  : vector<2xi9>
    %3 = llvm.xor %2, %arg1  : vector<2xi9>
    llvm.return %3 : vector<2xi9>
  }]

theorem inst_combine_or_and_xor_not_constant_commute3_splat   : or_and_xor_not_constant_commute3_splat_before  ⊑  or_and_xor_not_constant_commute3_splat_combined := by
  unfold or_and_xor_not_constant_commute3_splat_before or_and_xor_not_constant_commute3_splat_combined
  simp_alive_peephole
  sorry
def not_or_combined := [llvmfunc|
  llvm.func @not_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_or   : not_or_before  ⊑  not_or_combined := by
  unfold not_or_before not_or_combined
  simp_alive_peephole
  sorry
def not_or_xor_combined := [llvmfunc|
  llvm.func @not_or_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.mlir.constant(-13 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_or_xor   : not_or_xor_before  ⊑  not_or_xor_combined := by
  unfold not_or_xor_before not_or_xor_combined
  simp_alive_peephole
  sorry
def xor_or_combined := [llvmfunc|
  llvm.func @xor_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.mlir.constant(39 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_xor_or   : xor_or_before  ⊑  xor_or_combined := by
  unfold xor_or_before xor_or_combined
  simp_alive_peephole
  sorry
def xor_or2_combined := [llvmfunc|
  llvm.func @xor_or2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.mlir.constant(39 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_xor_or2   : xor_or2_before  ⊑  xor_or2_combined := by
  unfold xor_or2_before xor_or2_combined
  simp_alive_peephole
  sorry
def xor_or_xor_combined := [llvmfunc|
  llvm.func @xor_or_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_xor_or_xor   : xor_or_xor_before  ⊑  xor_or_xor_combined := by
  unfold xor_or_xor_before xor_or_xor_combined
  simp_alive_peephole
  sorry
def or_xor_or_combined := [llvmfunc|
  llvm.func @or_xor_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-40 : i8) : i8
    %1 = llvm.mlir.constant(47 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_or_xor_or   : or_xor_or_before  ⊑  or_xor_or_combined := by
  unfold or_xor_or_before or_xor_or_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def test20_combined := [llvmfunc|
  llvm.func @test20(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test20   : test20_before  ⊑  test20_combined := by
  unfold test20_before test20_combined
  simp_alive_peephole
  sorry
def test21_combined := [llvmfunc|
  llvm.func @test21(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test21   : test21_before  ⊑  test21_combined := by
  unfold test21_before test21_combined
  simp_alive_peephole
  sorry
def test22_combined := [llvmfunc|
  llvm.func @test22(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test22   : test22_before  ⊑  test22_combined := by
  unfold test22_before test22_combined
  simp_alive_peephole
  sorry
def test23_combined := [llvmfunc|
  llvm.func @test23(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test23   : test23_before  ⊑  test23_combined := by
  unfold test23_before test23_combined
  simp_alive_peephole
  sorry
def test23v_combined := [llvmfunc|
  llvm.func @test23v(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test23v   : test23v_before  ⊑  test23v_combined := by
  unfold test23v_before test23v_combined
  simp_alive_peephole
  sorry
def PR45977_f1_combined := [llvmfunc|
  llvm.func @PR45977_f1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_PR45977_f1   : PR45977_f1_before  ⊑  PR45977_f1_combined := by
  unfold PR45977_f1_before PR45977_f1_combined
  simp_alive_peephole
  sorry
def PR45977_f2_combined := [llvmfunc|
  llvm.func @PR45977_f2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_PR45977_f2   : PR45977_f2_before  ⊑  PR45977_f2_combined := by
  unfold PR45977_f2_before PR45977_f2_combined
  simp_alive_peephole
  sorry
def or_xor_common_op_commute0_combined := [llvmfunc|
  llvm.func @or_xor_common_op_commute0(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.or %0, %arg2  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_or_xor_common_op_commute0   : or_xor_common_op_commute0_before  ⊑  or_xor_common_op_commute0_combined := by
  unfold or_xor_common_op_commute0_before or_xor_common_op_commute0_combined
  simp_alive_peephole
  sorry
def or_xor_common_op_commute1_combined := [llvmfunc|
  llvm.func @or_xor_common_op_commute1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.or %0, %arg2  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_or_xor_common_op_commute1   : or_xor_common_op_commute1_before  ⊑  or_xor_common_op_commute1_combined := by
  unfold or_xor_common_op_commute1_before or_xor_common_op_commute1_combined
  simp_alive_peephole
  sorry
def or_xor_common_op_commute2_combined := [llvmfunc|
  llvm.func @or_xor_common_op_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.xor %arg2, %arg0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.or %0, %arg2  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_or_xor_common_op_commute2   : or_xor_common_op_commute2_before  ⊑  or_xor_common_op_commute2_combined := by
  unfold or_xor_common_op_commute2_before or_xor_common_op_commute2_combined
  simp_alive_peephole
  sorry
def or_xor_common_op_commute3_combined := [llvmfunc|
  llvm.func @or_xor_common_op_commute3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.xor %arg2, %arg0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.or %0, %arg2  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_or_xor_common_op_commute3   : or_xor_common_op_commute3_before  ⊑  or_xor_common_op_commute3_combined := by
  unfold or_xor_common_op_commute3_before or_xor_common_op_commute3_combined
  simp_alive_peephole
  sorry
def or_xor_common_op_commute4_combined := [llvmfunc|
  llvm.func @or_xor_common_op_commute4(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.or %0, %arg2  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_or_xor_common_op_commute4   : or_xor_common_op_commute4_before  ⊑  or_xor_common_op_commute4_combined := by
  unfold or_xor_common_op_commute4_before or_xor_common_op_commute4_combined
  simp_alive_peephole
  sorry
def or_xor_common_op_commute5_combined := [llvmfunc|
  llvm.func @or_xor_common_op_commute5(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    %1 = llvm.or %0, %arg2  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_or_xor_common_op_commute5   : or_xor_common_op_commute5_before  ⊑  or_xor_common_op_commute5_combined := by
  unfold or_xor_common_op_commute5_before or_xor_common_op_commute5_combined
  simp_alive_peephole
  sorry
def or_xor_common_op_commute6_combined := [llvmfunc|
  llvm.func @or_xor_common_op_commute6(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.or %0, %arg2  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_or_xor_common_op_commute6   : or_xor_common_op_commute6_before  ⊑  or_xor_common_op_commute6_combined := by
  unfold or_xor_common_op_commute6_before or_xor_common_op_commute6_combined
  simp_alive_peephole
  sorry
def or_xor_common_op_commute7_combined := [llvmfunc|
  llvm.func @or_xor_common_op_commute7(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    %1 = llvm.or %0, %arg2  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_or_xor_common_op_commute7   : or_xor_common_op_commute7_before  ⊑  or_xor_common_op_commute7_combined := by
  unfold or_xor_common_op_commute7_before or_xor_common_op_commute7_combined
  simp_alive_peephole
  sorry
def or_xor_notcommon_op_combined := [llvmfunc|
  llvm.func @or_xor_notcommon_op(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.xor %arg3, %arg2  : i8
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_or_xor_notcommon_op   : or_xor_notcommon_op_before  ⊑  or_xor_notcommon_op_combined := by
  unfold or_xor_notcommon_op_before or_xor_notcommon_op_combined
  simp_alive_peephole
  sorry
def or_not_xor_common_op_commute0_combined := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg0, %arg1  : i4
    %2 = llvm.xor %1, %0  : i4
    %3 = llvm.or %2, %arg2  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_or_not_xor_common_op_commute0   : or_not_xor_common_op_commute0_before  ⊑  or_not_xor_common_op_commute0_combined := by
  unfold or_not_xor_common_op_commute0_before or_not_xor_common_op_commute0_combined
  simp_alive_peephole
  sorry
def or_not_xor_common_op_commute1_combined := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %3, %arg2  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_or_not_xor_common_op_commute1   : or_not_xor_common_op_commute1_before  ⊑  or_not_xor_common_op_commute1_combined := by
  unfold or_not_xor_common_op_commute1_before or_not_xor_common_op_commute1_combined
  simp_alive_peephole
  sorry
def or_not_xor_common_op_commute2_combined := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.and %arg0, %arg1  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_or_not_xor_common_op_commute2   : or_not_xor_common_op_commute2_before  ⊑  or_not_xor_common_op_commute2_combined := by
  unfold or_not_xor_common_op_commute2_before or_not_xor_common_op_commute2_combined
  simp_alive_peephole
  sorry
def or_not_xor_common_op_commute3_combined := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.and %arg0, %arg1  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_or_not_xor_common_op_commute3   : or_not_xor_common_op_commute3_before  ⊑  or_not_xor_common_op_commute3_combined := by
  unfold or_not_xor_common_op_commute3_before or_not_xor_common_op_commute3_combined
  simp_alive_peephole
  sorry
def or_not_xor_common_op_commute4_combined := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute4(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.and %arg1, %arg0  : vector<2xi4>
    %3 = llvm.xor %2, %1  : vector<2xi4>
    %4 = llvm.or %3, %arg2  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_or_not_xor_common_op_commute4   : or_not_xor_common_op_commute4_before  ⊑  or_not_xor_common_op_commute4_combined := by
  unfold or_not_xor_common_op_commute4_before or_not_xor_common_op_commute4_combined
  simp_alive_peephole
  sorry
def or_not_xor_common_op_commute5_combined := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute5(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg1, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.or %2, %arg2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_or_not_xor_common_op_commute5   : or_not_xor_common_op_commute5_before  ⊑  or_not_xor_common_op_commute5_combined := by
  unfold or_not_xor_common_op_commute5_before or_not_xor_common_op_commute5_combined
  simp_alive_peephole
  sorry
def or_not_xor_common_op_commute6_combined := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute6(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.and %arg1, %arg0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_or_not_xor_common_op_commute6   : or_not_xor_common_op_commute6_before  ⊑  or_not_xor_common_op_commute6_combined := by
  unfold or_not_xor_common_op_commute6_before or_not_xor_common_op_commute6_combined
  simp_alive_peephole
  sorry
def or_not_xor_common_op_commute7_combined := [llvmfunc|
  llvm.func @or_not_xor_common_op_commute7(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.and %arg1, %arg0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_or_not_xor_common_op_commute7   : or_not_xor_common_op_commute7_before  ⊑  or_not_xor_common_op_commute7_combined := by
  unfold or_not_xor_common_op_commute7_before or_not_xor_common_op_commute7_combined
  simp_alive_peephole
  sorry
def or_not_xor_common_op_use1_combined := [llvmfunc|
  llvm.func @or_not_xor_common_op_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.or %1, %arg2  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_or_not_xor_common_op_use1   : or_not_xor_common_op_use1_before  ⊑  or_not_xor_common_op_use1_combined := by
  unfold or_not_xor_common_op_use1_before or_not_xor_common_op_use1_combined
  simp_alive_peephole
  sorry
def or_not_xor_common_op_use2_combined := [llvmfunc|
  llvm.func @or_not_xor_common_op_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.or %1, %arg2  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_or_not_xor_common_op_use2   : or_not_xor_common_op_use2_before  ⊑  or_not_xor_common_op_use2_combined := by
  unfold or_not_xor_common_op_use2_before or_not_xor_common_op_use2_combined
  simp_alive_peephole
  sorry
def or_nand_xor_common_op_commute0_combined := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg0, %arg2  : i4
    %2 = llvm.and %1, %arg1  : i4
    %3 = llvm.xor %2, %0  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_or_nand_xor_common_op_commute0   : or_nand_xor_common_op_commute0_before  ⊑  or_nand_xor_common_op_commute0_combined := by
  unfold or_nand_xor_common_op_commute0_before or_nand_xor_common_op_commute0_combined
  simp_alive_peephole
  sorry
def or_nand_xor_common_op_commute1_combined := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute1(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.and %arg2, %arg0  : vector<2xi4>
    %3 = llvm.and %2, %arg1  : vector<2xi4>
    %4 = llvm.xor %3, %1  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_or_nand_xor_common_op_commute1   : or_nand_xor_common_op_commute1_before  ⊑  or_nand_xor_common_op_commute1_combined := by
  unfold or_nand_xor_common_op_commute1_before or_nand_xor_common_op_commute1_combined
  simp_alive_peephole
  sorry
def or_nand_xor_common_op_commute2_combined := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg0, %arg2  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_or_nand_xor_common_op_commute2   : or_nand_xor_common_op_commute2_before  ⊑  or_nand_xor_common_op_commute2_combined := by
  unfold or_nand_xor_common_op_commute2_before or_nand_xor_common_op_commute2_combined
  simp_alive_peephole
  sorry
def or_nand_xor_common_op_commute3_combined := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %1, %arg1  : i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_or_nand_xor_common_op_commute3   : or_nand_xor_common_op_commute3_before  ⊑  or_nand_xor_common_op_commute3_combined := by
  unfold or_nand_xor_common_op_commute3_before or_nand_xor_common_op_commute3_combined
  simp_alive_peephole
  sorry
def or_nand_xor_common_op_commute3_use2_combined := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute3_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.xor %arg1, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %1, %arg1  : i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_or_nand_xor_common_op_commute3_use2   : or_nand_xor_common_op_commute3_use2_before  ⊑  or_nand_xor_common_op_commute3_use2_combined := by
  unfold or_nand_xor_common_op_commute3_use2_before or_nand_xor_common_op_commute3_use2_combined
  simp_alive_peephole
  sorry
def or_nand_xor_common_op_commute3_use3_combined := [llvmfunc|
  llvm.func @or_nand_xor_common_op_commute3_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg1, %arg0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_or_nand_xor_common_op_commute3_use3   : or_nand_xor_common_op_commute3_use3_before  ⊑  or_nand_xor_common_op_commute3_use3_combined := by
  unfold or_nand_xor_common_op_commute3_use3_before or_nand_xor_common_op_commute3_use3_combined
  simp_alive_peephole
  sorry
def PR75692_1_combined := [llvmfunc|
  llvm.func @PR75692_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_PR75692_1   : PR75692_1_before  ⊑  PR75692_1_combined := by
  unfold PR75692_1_before PR75692_1_combined
  simp_alive_peephole
  sorry
def PR75692_2_combined := [llvmfunc|
  llvm.func @PR75692_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_PR75692_2   : PR75692_2_before  ⊑  PR75692_2_combined := by
  unfold PR75692_2_before PR75692_2_combined
  simp_alive_peephole
  sorry
def PR75692_3_combined := [llvmfunc|
  llvm.func @PR75692_3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_PR75692_3   : PR75692_3_before  ⊑  PR75692_3_combined := by
  unfold PR75692_3_before PR75692_3_combined
  simp_alive_peephole
  sorry
def or_xor_not_combined := [llvmfunc|
  llvm.func @or_xor_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_xor_not   : or_xor_not_before  ⊑  or_xor_not_combined := by
  unfold or_xor_not_before or_xor_not_combined
  simp_alive_peephole
  sorry
def or_xor_not_uses1_combined := [llvmfunc|
  llvm.func @or_xor_not_uses1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.xor %arg1, %0  : i32
    llvm.call %1(%2) : !llvm.ptr, (i32) -> ()
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_or_xor_not_uses1   : or_xor_not_uses1_before  ⊑  or_xor_not_uses1_combined := by
  unfold or_xor_not_uses1_before or_xor_not_uses1_combined
  simp_alive_peephole
  sorry
def or_xor_not_uses2_combined := [llvmfunc|
  llvm.func @or_xor_not_uses2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.xor %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.call %1(%3) : !llvm.ptr, (i32) -> ()
    %4 = llvm.or %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_or_xor_not_uses2   : or_xor_not_uses2_before  ⊑  or_xor_not_uses2_combined := by
  unfold or_xor_not_uses2_before or_xor_not_uses2_combined
  simp_alive_peephole
  sorry
def or_xor_and_commuted1_combined := [llvmfunc|
  llvm.func @or_xor_and_commuted1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_xor_and_commuted1   : or_xor_and_commuted1_before  ⊑  or_xor_and_commuted1_combined := by
  unfold or_xor_and_commuted1_before or_xor_and_commuted1_combined
  simp_alive_peephole
  sorry
def or_xor_and_commuted2_combined := [llvmfunc|
  llvm.func @or_xor_and_commuted2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.mul %arg0, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_or_xor_and_commuted2   : or_xor_and_commuted2_before  ⊑  or_xor_and_commuted2_combined := by
  unfold or_xor_and_commuted2_before or_xor_and_commuted2_combined
  simp_alive_peephole
  sorry
def or_xor_tree_0000_combined := [llvmfunc|
  llvm.func @or_xor_tree_0000(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_or_xor_tree_0000   : or_xor_tree_0000_before  ⊑  or_xor_tree_0000_combined := by
  unfold or_xor_tree_0000_before or_xor_tree_0000_combined
  simp_alive_peephole
  sorry
def or_xor_tree_0001_combined := [llvmfunc|
  llvm.func @or_xor_tree_0001(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_0001   : or_xor_tree_0001_before  ⊑  or_xor_tree_0001_combined := by
  unfold or_xor_tree_0001_before or_xor_tree_0001_combined
  simp_alive_peephole
  sorry
def or_xor_tree_0010_combined := [llvmfunc|
  llvm.func @or_xor_tree_0010(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_0010   : or_xor_tree_0010_before  ⊑  or_xor_tree_0010_combined := by
  unfold or_xor_tree_0010_before or_xor_tree_0010_combined
  simp_alive_peephole
  sorry
def or_xor_tree_0011_combined := [llvmfunc|
  llvm.func @or_xor_tree_0011(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_0011   : or_xor_tree_0011_before  ⊑  or_xor_tree_0011_combined := by
  unfold or_xor_tree_0011_before or_xor_tree_0011_combined
  simp_alive_peephole
  sorry
def or_xor_tree_0100_combined := [llvmfunc|
  llvm.func @or_xor_tree_0100(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_0100   : or_xor_tree_0100_before  ⊑  or_xor_tree_0100_combined := by
  unfold or_xor_tree_0100_before or_xor_tree_0100_combined
  simp_alive_peephole
  sorry
def or_xor_tree_0101_combined := [llvmfunc|
  llvm.func @or_xor_tree_0101(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_0101   : or_xor_tree_0101_before  ⊑  or_xor_tree_0101_combined := by
  unfold or_xor_tree_0101_before or_xor_tree_0101_combined
  simp_alive_peephole
  sorry
def or_xor_tree_0110_combined := [llvmfunc|
  llvm.func @or_xor_tree_0110(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_0110   : or_xor_tree_0110_before  ⊑  or_xor_tree_0110_combined := by
  unfold or_xor_tree_0110_before or_xor_tree_0110_combined
  simp_alive_peephole
  sorry
def or_xor_tree_0111_combined := [llvmfunc|
  llvm.func @or_xor_tree_0111(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_0111   : or_xor_tree_0111_before  ⊑  or_xor_tree_0111_combined := by
  unfold or_xor_tree_0111_before or_xor_tree_0111_combined
  simp_alive_peephole
  sorry
def or_xor_tree_1000_combined := [llvmfunc|
  llvm.func @or_xor_tree_1000(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_or_xor_tree_1000   : or_xor_tree_1000_before  ⊑  or_xor_tree_1000_combined := by
  unfold or_xor_tree_1000_before or_xor_tree_1000_combined
  simp_alive_peephole
  sorry
def or_xor_tree_1001_combined := [llvmfunc|
  llvm.func @or_xor_tree_1001(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_1001   : or_xor_tree_1001_before  ⊑  or_xor_tree_1001_combined := by
  unfold or_xor_tree_1001_before or_xor_tree_1001_combined
  simp_alive_peephole
  sorry
def or_xor_tree_1010_combined := [llvmfunc|
  llvm.func @or_xor_tree_1010(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_1010   : or_xor_tree_1010_before  ⊑  or_xor_tree_1010_combined := by
  unfold or_xor_tree_1010_before or_xor_tree_1010_combined
  simp_alive_peephole
  sorry
def or_xor_tree_1011_combined := [llvmfunc|
  llvm.func @or_xor_tree_1011(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_1011   : or_xor_tree_1011_before  ⊑  or_xor_tree_1011_combined := by
  unfold or_xor_tree_1011_before or_xor_tree_1011_combined
  simp_alive_peephole
  sorry
def or_xor_tree_1100_combined := [llvmfunc|
  llvm.func @or_xor_tree_1100(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_1100   : or_xor_tree_1100_before  ⊑  or_xor_tree_1100_combined := by
  unfold or_xor_tree_1100_before or_xor_tree_1100_combined
  simp_alive_peephole
  sorry
def or_xor_tree_1101_combined := [llvmfunc|
  llvm.func @or_xor_tree_1101(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_1101   : or_xor_tree_1101_before  ⊑  or_xor_tree_1101_combined := by
  unfold or_xor_tree_1101_before or_xor_tree_1101_combined
  simp_alive_peephole
  sorry
def or_xor_tree_1110_combined := [llvmfunc|
  llvm.func @or_xor_tree_1110(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_1110   : or_xor_tree_1110_before  ⊑  or_xor_tree_1110_combined := by
  unfold or_xor_tree_1110_before or_xor_tree_1110_combined
  simp_alive_peephole
  sorry
def or_xor_tree_1111_combined := [llvmfunc|
  llvm.func @or_xor_tree_1111(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_or_xor_tree_1111   : or_xor_tree_1111_before  ⊑  or_xor_tree_1111_combined := by
  unfold or_xor_tree_1111_before or_xor_tree_1111_combined
  simp_alive_peephole
  sorry
