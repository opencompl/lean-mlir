import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  xor2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0_before := [llvmfunc|
  llvm.func @test0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test0vec_before := [llvmfunc|
  llvm.func @test0vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.xor %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12345 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(145 : i32) : i32
    %2 = llvm.mlir.constant(153 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.xor %4, %2  : i32
    llvm.return %5 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(145 : i32) : i32
    %1 = llvm.mlir.constant(177 : i32) : i32
    %2 = llvm.mlir.constant(153 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.xor %4, %2  : i32
    llvm.return %5 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1234 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.add %5, %3  : i32
    llvm.return %6 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1234 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %1, %2  : i32
    llvm.return %3 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %1, %2  : i32
    llvm.return %3 : i32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def test9b_before := [llvmfunc|
  llvm.func @test9b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def test10b_before := [llvmfunc|
  llvm.func @test10b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

def test11b_before := [llvmfunc|
  llvm.func @test11b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def test11c_before := [llvmfunc|
  llvm.func @test11c(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

def test11d_before := [llvmfunc|
  llvm.func @test11d(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def test11e_before := [llvmfunc|
  llvm.func @test11e(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg2  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %1, %3  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

def test11f_before := [llvmfunc|
  llvm.func @test11f(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg2  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %1, %3  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def test12commuted_before := [llvmfunc|
  llvm.func @test12commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.xor %1, %3  : i32
    llvm.return %4 : i32
  }]

def test13commuted_before := [llvmfunc|
  llvm.func @test13commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %1, %3  : i32
    llvm.return %4 : i32
  }]

def xor_or_xor_common_op_commute1_before := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def xor_or_xor_common_op_commute2_before := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg2, %arg0  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def xor_or_xor_common_op_commute3_before := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def xor_or_xor_common_op_commute4_before := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg2, %arg0  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def xor_or_xor_common_op_commute5_before := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

def xor_or_xor_common_op_commute6_before := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg2, %arg0  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

def xor_or_xor_common_op_commute7_before := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

def xor_or_xor_common_op_commute8_before := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg2, %arg0  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

def xor_or_xor_common_op_extra_use1_before := [llvmfunc|
  llvm.func @xor_or_xor_common_op_extra_use1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def xor_or_xor_common_op_extra_use2_before := [llvmfunc|
  llvm.func @xor_or_xor_common_op_extra_use2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    llvm.store %1, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def xor_or_xor_common_op_extra_use3_before := [llvmfunc|
  llvm.func @xor_or_xor_common_op_extra_use3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %1 = llvm.or %arg0, %arg1  : i32
    llvm.store %1, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.and %1, %3  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }]

def not_xor_to_or_not1_before := [llvmfunc|
  llvm.func @not_xor_to_or_not1(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %2, %1  : i3
    %4 = llvm.xor %3, %0  : i3
    llvm.return %4 : i3
  }]

def not_xor_to_or_not2_before := [llvmfunc|
  llvm.func @not_xor_to_or_not2(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg2, %arg1  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %2, %1  : i3
    %4 = llvm.xor %3, %0  : i3
    llvm.return %4 : i3
  }]

def not_xor_to_or_not3_before := [llvmfunc|
  llvm.func @not_xor_to_or_not3(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg2, %arg1  : i3
    %2 = llvm.and %arg2, %arg0  : i3
    %3 = llvm.xor %2, %1  : i3
    %4 = llvm.xor %3, %0  : i3
    llvm.return %4 : i3
  }]

def not_xor_to_or_not4_before := [llvmfunc|
  llvm.func @not_xor_to_or_not4(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg2, %arg0  : i3
    %3 = llvm.xor %2, %1  : i3
    %4 = llvm.xor %3, %0  : i3
    llvm.return %4 : i3
  }]

def not_xor_to_or_not_vector_before := [llvmfunc|
  llvm.func @not_xor_to_or_not_vector(%arg0: vector<3xi5>, %arg1: vector<3xi5>, %arg2: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi5>) : vector<3xi5>
    %2 = llvm.or %arg1, %arg2  : vector<3xi5>
    %3 = llvm.and %arg0, %arg2  : vector<3xi5>
    %4 = llvm.xor %2, %3  : vector<3xi5>
    %5 = llvm.xor %4, %1  : vector<3xi5>
    llvm.return %5 : vector<3xi5>
  }]

def not_xor_to_or_not_vector_poison_before := [llvmfunc|
  llvm.func @not_xor_to_or_not_vector_poison(%arg0: vector<3xi5>, %arg1: vector<3xi5>, %arg2: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.poison : i5
    %2 = llvm.mlir.undef : vector<3xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi5>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi5>
    %9 = llvm.or %arg1, %arg2  : vector<3xi5>
    %10 = llvm.and %arg0, %arg2  : vector<3xi5>
    %11 = llvm.xor %9, %10  : vector<3xi5>
    %12 = llvm.xor %11, %8  : vector<3xi5>
    llvm.return %12 : vector<3xi5>
  }]

def not_xor_to_or_not_2use_before := [llvmfunc|
  llvm.func @not_xor_to_or_not_2use(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %2, %1  : i3
    %4 = llvm.xor %3, %0  : i3
    llvm.call @use3(%3) : (i3) -> ()
    llvm.return %4 : i3
  }]

def xor_notand_to_or_not1_before := [llvmfunc|
  llvm.func @xor_notand_to_or_not1(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %2, %0  : i3
    %4 = llvm.xor %3, %1  : i3
    llvm.return %4 : i3
  }]

def xor_notand_to_or_not2_before := [llvmfunc|
  llvm.func @xor_notand_to_or_not2(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg2, %arg1  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %2, %0  : i3
    %4 = llvm.xor %3, %1  : i3
    llvm.return %4 : i3
  }]

def xor_notand_to_or_not3_before := [llvmfunc|
  llvm.func @xor_notand_to_or_not3(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg2, %arg1  : i3
    %2 = llvm.and %arg2, %arg0  : i3
    %3 = llvm.xor %2, %0  : i3
    %4 = llvm.xor %3, %1  : i3
    llvm.return %4 : i3
  }]

def xor_notand_to_or_not4_before := [llvmfunc|
  llvm.func @xor_notand_to_or_not4(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg2, %arg0  : i3
    %3 = llvm.xor %2, %0  : i3
    %4 = llvm.xor %3, %1  : i3
    llvm.return %4 : i3
  }]

def xor_notand_to_or_not_vector_before := [llvmfunc|
  llvm.func @xor_notand_to_or_not_vector(%arg0: vector<3xi5>, %arg1: vector<3xi5>, %arg2: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi5>) : vector<3xi5>
    %2 = llvm.or %arg1, %arg2  : vector<3xi5>
    %3 = llvm.and %arg0, %arg2  : vector<3xi5>
    %4 = llvm.xor %3, %1  : vector<3xi5>
    %5 = llvm.xor %4, %2  : vector<3xi5>
    llvm.return %5 : vector<3xi5>
  }]

def xor_notand_to_or_not_vector_poison_before := [llvmfunc|
  llvm.func @xor_notand_to_or_not_vector_poison(%arg0: vector<3xi5>, %arg1: vector<3xi5>, %arg2: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.poison : i5
    %2 = llvm.mlir.undef : vector<3xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi5>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi5>
    %9 = llvm.or %arg1, %arg2  : vector<3xi5>
    %10 = llvm.and %arg0, %arg2  : vector<3xi5>
    %11 = llvm.xor %10, %8  : vector<3xi5>
    %12 = llvm.xor %11, %9  : vector<3xi5>
    llvm.return %12 : vector<3xi5>
  }]

def xor_notand_to_or_not_2use_before := [llvmfunc|
  llvm.func @xor_notand_to_or_not_2use(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %2, %0  : i3
    %4 = llvm.xor %3, %1  : i3
    llvm.call @use3(%3) : (i3) -> ()
    llvm.return %4 : i3
  }]

def test0_combined := [llvmfunc|
  llvm.func @test0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test0   : test0_before  ⊑  test0_combined := by
  unfold test0_before test0_combined
  simp_alive_peephole
  sorry
def test0vec_combined := [llvmfunc|
  llvm.func @test0vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test0vec   : test0vec_before  ⊑  test0vec_combined := by
  unfold test0vec_before test0vec_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1234 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.add %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1234 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9b_combined := [llvmfunc|
  llvm.func @test9b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test9b   : test9b_before  ⊑  test9b_combined := by
  unfold test9b_before test9b_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10b_combined := [llvmfunc|
  llvm.func @test10b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test10b   : test10b_before  ⊑  test10b_combined := by
  unfold test10b_before test10b_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test11b_combined := [llvmfunc|
  llvm.func @test11b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test11b   : test11b_before  ⊑  test11b_combined := by
  unfold test11b_before test11b_combined
  simp_alive_peephole
  sorry
def test11c_combined := [llvmfunc|
  llvm.func @test11c(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test11c   : test11c_before  ⊑  test11c_combined := by
  unfold test11c_before test11c_combined
  simp_alive_peephole
  sorry
def test11d_combined := [llvmfunc|
  llvm.func @test11d(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test11d   : test11d_before  ⊑  test11d_combined := by
  unfold test11d_before test11d_combined
  simp_alive_peephole
  sorry
def test11e_combined := [llvmfunc|
  llvm.func @test11e(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg2  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.xor %1, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test11e   : test11e_before  ⊑  test11e_combined := by
  unfold test11e_before test11e_combined
  simp_alive_peephole
  sorry
def test11f_combined := [llvmfunc|
  llvm.func @test11f(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg2  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.xor %1, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test11f   : test11f_before  ⊑  test11f_combined := by
  unfold test11f_before test11f_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test12commuted_combined := [llvmfunc|
  llvm.func @test12commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test12commuted   : test12commuted_before  ⊑  test12commuted_combined := by
  unfold test12commuted_before test12commuted_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test13commuted_combined := [llvmfunc|
  llvm.func @test13commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test13commuted   : test13commuted_before  ⊑  test13commuted_combined := by
  unfold test13commuted_before test13commuted_combined
  simp_alive_peephole
  sorry
def xor_or_xor_common_op_commute1_combined := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_or_xor_common_op_commute1   : xor_or_xor_common_op_commute1_before  ⊑  xor_or_xor_common_op_commute1_combined := by
  unfold xor_or_xor_common_op_commute1_before xor_or_xor_common_op_commute1_combined
  simp_alive_peephole
  sorry
def xor_or_xor_common_op_commute2_combined := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_or_xor_common_op_commute2   : xor_or_xor_common_op_commute2_before  ⊑  xor_or_xor_common_op_commute2_combined := by
  unfold xor_or_xor_common_op_commute2_before xor_or_xor_common_op_commute2_combined
  simp_alive_peephole
  sorry
def xor_or_xor_common_op_commute3_combined := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_or_xor_common_op_commute3   : xor_or_xor_common_op_commute3_before  ⊑  xor_or_xor_common_op_commute3_combined := by
  unfold xor_or_xor_common_op_commute3_before xor_or_xor_common_op_commute3_combined
  simp_alive_peephole
  sorry
def xor_or_xor_common_op_commute4_combined := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_or_xor_common_op_commute4   : xor_or_xor_common_op_commute4_before  ⊑  xor_or_xor_common_op_commute4_combined := by
  unfold xor_or_xor_common_op_commute4_before xor_or_xor_common_op_commute4_combined
  simp_alive_peephole
  sorry
def xor_or_xor_common_op_commute5_combined := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_or_xor_common_op_commute5   : xor_or_xor_common_op_commute5_before  ⊑  xor_or_xor_common_op_commute5_combined := by
  unfold xor_or_xor_common_op_commute5_before xor_or_xor_common_op_commute5_combined
  simp_alive_peephole
  sorry
def xor_or_xor_common_op_commute6_combined := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_or_xor_common_op_commute6   : xor_or_xor_common_op_commute6_before  ⊑  xor_or_xor_common_op_commute6_combined := by
  unfold xor_or_xor_common_op_commute6_before xor_or_xor_common_op_commute6_combined
  simp_alive_peephole
  sorry
def xor_or_xor_common_op_commute7_combined := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_or_xor_common_op_commute7   : xor_or_xor_common_op_commute7_before  ⊑  xor_or_xor_common_op_commute7_combined := by
  unfold xor_or_xor_common_op_commute7_before xor_or_xor_common_op_commute7_combined
  simp_alive_peephole
  sorry
def xor_or_xor_common_op_commute8_combined := [llvmfunc|
  llvm.func @xor_or_xor_common_op_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_xor_or_xor_common_op_commute8   : xor_or_xor_common_op_commute8_before  ⊑  xor_or_xor_common_op_commute8_combined := by
  unfold xor_or_xor_common_op_commute8_before xor_or_xor_common_op_commute8_combined
  simp_alive_peephole
  sorry
def xor_or_xor_common_op_extra_use1_combined := [llvmfunc|
  llvm.func @xor_or_xor_common_op_extra_use1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_or_xor_common_op_extra_use1   : xor_or_xor_common_op_extra_use1_before  ⊑  xor_or_xor_common_op_extra_use1_combined := by
  unfold xor_or_xor_common_op_extra_use1_before xor_or_xor_common_op_extra_use1_combined
  simp_alive_peephole
  sorry
def xor_or_xor_common_op_extra_use2_combined := [llvmfunc|
  llvm.func @xor_or_xor_common_op_extra_use2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    llvm.store %1, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_or_xor_common_op_extra_use2   : xor_or_xor_common_op_extra_use2_before  ⊑  xor_or_xor_common_op_extra_use2_combined := by
  unfold xor_or_xor_common_op_extra_use2_before xor_or_xor_common_op_extra_use2_combined
  simp_alive_peephole
  sorry
def xor_or_xor_common_op_extra_use3_combined := [llvmfunc|
  llvm.func @xor_or_xor_common_op_extra_use3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %1 = llvm.or %arg0, %arg1  : i32
    llvm.store %1, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_or_xor_common_op_extra_use3   : xor_or_xor_common_op_extra_use3_before  ⊑  xor_or_xor_common_op_extra_use3_combined := by
  unfold xor_or_xor_common_op_extra_use3_before xor_or_xor_common_op_extra_use3_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def not_xor_to_or_not1_combined := [llvmfunc|
  llvm.func @not_xor_to_or_not1(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %1, %0  : i3
    %4 = llvm.or %2, %3  : i3
    llvm.return %4 : i3
  }]

theorem inst_combine_not_xor_to_or_not1   : not_xor_to_or_not1_before  ⊑  not_xor_to_or_not1_combined := by
  unfold not_xor_to_or_not1_before not_xor_to_or_not1_combined
  simp_alive_peephole
  sorry
def not_xor_to_or_not2_combined := [llvmfunc|
  llvm.func @not_xor_to_or_not2(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg2, %arg1  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %1, %0  : i3
    %4 = llvm.or %2, %3  : i3
    llvm.return %4 : i3
  }]

theorem inst_combine_not_xor_to_or_not2   : not_xor_to_or_not2_before  ⊑  not_xor_to_or_not2_combined := by
  unfold not_xor_to_or_not2_before not_xor_to_or_not2_combined
  simp_alive_peephole
  sorry
def not_xor_to_or_not3_combined := [llvmfunc|
  llvm.func @not_xor_to_or_not3(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg2, %arg1  : i3
    %2 = llvm.and %arg2, %arg0  : i3
    %3 = llvm.xor %1, %0  : i3
    %4 = llvm.or %2, %3  : i3
    llvm.return %4 : i3
  }]

theorem inst_combine_not_xor_to_or_not3   : not_xor_to_or_not3_before  ⊑  not_xor_to_or_not3_combined := by
  unfold not_xor_to_or_not3_before not_xor_to_or_not3_combined
  simp_alive_peephole
  sorry
def not_xor_to_or_not4_combined := [llvmfunc|
  llvm.func @not_xor_to_or_not4(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg2, %arg0  : i3
    %3 = llvm.xor %1, %0  : i3
    %4 = llvm.or %2, %3  : i3
    llvm.return %4 : i3
  }]

theorem inst_combine_not_xor_to_or_not4   : not_xor_to_or_not4_before  ⊑  not_xor_to_or_not4_combined := by
  unfold not_xor_to_or_not4_before not_xor_to_or_not4_combined
  simp_alive_peephole
  sorry
def not_xor_to_or_not_vector_combined := [llvmfunc|
  llvm.func @not_xor_to_or_not_vector(%arg0: vector<3xi5>, %arg1: vector<3xi5>, %arg2: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi5>) : vector<3xi5>
    %2 = llvm.or %arg1, %arg2  : vector<3xi5>
    %3 = llvm.and %arg0, %arg2  : vector<3xi5>
    %4 = llvm.xor %2, %1  : vector<3xi5>
    %5 = llvm.or %3, %4  : vector<3xi5>
    llvm.return %5 : vector<3xi5>
  }]

theorem inst_combine_not_xor_to_or_not_vector   : not_xor_to_or_not_vector_before  ⊑  not_xor_to_or_not_vector_combined := by
  unfold not_xor_to_or_not_vector_before not_xor_to_or_not_vector_combined
  simp_alive_peephole
  sorry
def not_xor_to_or_not_vector_poison_combined := [llvmfunc|
  llvm.func @not_xor_to_or_not_vector_poison(%arg0: vector<3xi5>, %arg1: vector<3xi5>, %arg2: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi5>) : vector<3xi5>
    %2 = llvm.or %arg1, %arg2  : vector<3xi5>
    %3 = llvm.and %arg0, %arg2  : vector<3xi5>
    %4 = llvm.xor %2, %1  : vector<3xi5>
    %5 = llvm.or %3, %4  : vector<3xi5>
    llvm.return %5 : vector<3xi5>
  }]

theorem inst_combine_not_xor_to_or_not_vector_poison   : not_xor_to_or_not_vector_poison_before  ⊑  not_xor_to_or_not_vector_poison_combined := by
  unfold not_xor_to_or_not_vector_poison_before not_xor_to_or_not_vector_poison_combined
  simp_alive_peephole
  sorry
def not_xor_to_or_not_2use_combined := [llvmfunc|
  llvm.func @not_xor_to_or_not_2use(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %2, %1  : i3
    %4 = llvm.xor %3, %0  : i3
    llvm.call @use3(%3) : (i3) -> ()
    llvm.return %4 : i3
  }]

theorem inst_combine_not_xor_to_or_not_2use   : not_xor_to_or_not_2use_before  ⊑  not_xor_to_or_not_2use_combined := by
  unfold not_xor_to_or_not_2use_before not_xor_to_or_not_2use_combined
  simp_alive_peephole
  sorry
def xor_notand_to_or_not1_combined := [llvmfunc|
  llvm.func @xor_notand_to_or_not1(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %1, %0  : i3
    %4 = llvm.or %2, %3  : i3
    llvm.return %4 : i3
  }]

theorem inst_combine_xor_notand_to_or_not1   : xor_notand_to_or_not1_before  ⊑  xor_notand_to_or_not1_combined := by
  unfold xor_notand_to_or_not1_before xor_notand_to_or_not1_combined
  simp_alive_peephole
  sorry
def xor_notand_to_or_not2_combined := [llvmfunc|
  llvm.func @xor_notand_to_or_not2(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg2, %arg1  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %1, %0  : i3
    %4 = llvm.or %2, %3  : i3
    llvm.return %4 : i3
  }]

theorem inst_combine_xor_notand_to_or_not2   : xor_notand_to_or_not2_before  ⊑  xor_notand_to_or_not2_combined := by
  unfold xor_notand_to_or_not2_before xor_notand_to_or_not2_combined
  simp_alive_peephole
  sorry
def xor_notand_to_or_not3_combined := [llvmfunc|
  llvm.func @xor_notand_to_or_not3(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg2, %arg1  : i3
    %2 = llvm.and %arg2, %arg0  : i3
    %3 = llvm.xor %1, %0  : i3
    %4 = llvm.or %2, %3  : i3
    llvm.return %4 : i3
  }]

theorem inst_combine_xor_notand_to_or_not3   : xor_notand_to_or_not3_before  ⊑  xor_notand_to_or_not3_combined := by
  unfold xor_notand_to_or_not3_before xor_notand_to_or_not3_combined
  simp_alive_peephole
  sorry
def xor_notand_to_or_not4_combined := [llvmfunc|
  llvm.func @xor_notand_to_or_not4(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg2, %arg0  : i3
    %3 = llvm.xor %1, %0  : i3
    %4 = llvm.or %2, %3  : i3
    llvm.return %4 : i3
  }]

theorem inst_combine_xor_notand_to_or_not4   : xor_notand_to_or_not4_before  ⊑  xor_notand_to_or_not4_combined := by
  unfold xor_notand_to_or_not4_before xor_notand_to_or_not4_combined
  simp_alive_peephole
  sorry
def xor_notand_to_or_not_vector_combined := [llvmfunc|
  llvm.func @xor_notand_to_or_not_vector(%arg0: vector<3xi5>, %arg1: vector<3xi5>, %arg2: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi5>) : vector<3xi5>
    %2 = llvm.or %arg1, %arg2  : vector<3xi5>
    %3 = llvm.and %arg0, %arg2  : vector<3xi5>
    %4 = llvm.xor %2, %1  : vector<3xi5>
    %5 = llvm.or %3, %4  : vector<3xi5>
    llvm.return %5 : vector<3xi5>
  }]

theorem inst_combine_xor_notand_to_or_not_vector   : xor_notand_to_or_not_vector_before  ⊑  xor_notand_to_or_not_vector_combined := by
  unfold xor_notand_to_or_not_vector_before xor_notand_to_or_not_vector_combined
  simp_alive_peephole
  sorry
def xor_notand_to_or_not_vector_poison_combined := [llvmfunc|
  llvm.func @xor_notand_to_or_not_vector_poison(%arg0: vector<3xi5>, %arg1: vector<3xi5>, %arg2: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi5>) : vector<3xi5>
    %2 = llvm.or %arg1, %arg2  : vector<3xi5>
    %3 = llvm.and %arg0, %arg2  : vector<3xi5>
    %4 = llvm.xor %2, %1  : vector<3xi5>
    %5 = llvm.or %3, %4  : vector<3xi5>
    llvm.return %5 : vector<3xi5>
  }]

theorem inst_combine_xor_notand_to_or_not_vector_poison   : xor_notand_to_or_not_vector_poison_before  ⊑  xor_notand_to_or_not_vector_poison_combined := by
  unfold xor_notand_to_or_not_vector_poison_before xor_notand_to_or_not_vector_poison_combined
  simp_alive_peephole
  sorry
def xor_notand_to_or_not_2use_combined := [llvmfunc|
  llvm.func @xor_notand_to_or_not_2use(%arg0: i3, %arg1: i3, %arg2: i3) -> i3 {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.or %arg1, %arg2  : i3
    %2 = llvm.and %arg0, %arg2  : i3
    %3 = llvm.xor %2, %0  : i3
    %4 = llvm.xor %1, %3  : i3
    llvm.call @use3(%3) : (i3) -> ()
    llvm.return %4 : i3
  }]

theorem inst_combine_xor_notand_to_or_not_2use   : xor_notand_to_or_not_2use_before  ⊑  xor_notand_to_or_not_2use_combined := by
  unfold xor_notand_to_or_not_2use_before xor_notand_to_or_not_2use_combined
  simp_alive_peephole
  sorry
