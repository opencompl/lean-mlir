import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  set
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @X : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %arg0 : i32
    %3 = llvm.icmp "eq" %0, %1 : !llvm.ptr
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test1_logical_before := [llvmfunc|
  llvm.func @test1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @X : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "eq" %arg0, %arg0 : i32
    %4 = llvm.icmp "eq" %0, %1 : !llvm.ptr
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @X : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %arg0 : i32
    %3 = llvm.icmp "ne" %0, %1 : !llvm.ptr
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def test2_logical_before := [llvmfunc|
  llvm.func @test2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @X : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ne" %arg0, %arg0 : i32
    %4 = llvm.icmp "ne" %0, %1 : !llvm.ptr
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i32
    llvm.return %0 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i32
    llvm.return %0 : i1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i32
    llvm.return %0 : i1
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i32
    llvm.return %0 : i1
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "uge" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ult" %arg0, %0 : i1
    llvm.return %1 : i1
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %0 : i1
    llvm.return %1 : i1
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ule" %arg0, %0 : i1
    llvm.return %1 : i1
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "uge" %arg0, %0 : i1
    llvm.return %1 : i1
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i1
    llvm.return %0 : i1
  }]

def test13vec_before := [llvmfunc|
  llvm.func @test13vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.icmp "uge" %arg0, %arg1 : vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i1
    llvm.return %0 : i1
  }]

def test14vec_before := [llvmfunc|
  llvm.func @test14vec(%arg0: vector<3xi1>, %arg1: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.icmp "eq" %arg0, %arg1 : vector<3xi1>
    llvm.return %0 : vector<3xi1>
  }]

def bool_eq0_before := [llvmfunc|
  llvm.func @bool_eq0(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i64
    %4 = llvm.icmp "eq" %arg0, %1 : i64
    %5 = llvm.icmp "eq" %4, %2 : i1
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def bool_eq0_logical_before := [llvmfunc|
  llvm.func @bool_eq0_logical(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i64
    %4 = llvm.icmp "eq" %arg0, %1 : i64
    %5 = llvm.icmp "eq" %4, %2 : i1
    %6 = llvm.select %3, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def xor_of_icmps_before := [llvmfunc|
  llvm.func @xor_of_icmps(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "eq" %arg0, %1 : i64
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }]

def xor_of_icmps_commute_before := [llvmfunc|
  llvm.func @xor_of_icmps_commute(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "eq" %arg0, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_of_icmps_to_ne_before := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_of_icmps_to_ne_commute_before := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne_commute(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }]

def xor_of_icmps_neg_to_ne_before := [llvmfunc|
  llvm.func @xor_of_icmps_neg_to_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-6 : i64) : i64
    %1 = llvm.mlir.constant(-4 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_of_icmps_to_ne_vector_before := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne_vector(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi64>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<2xi64>
    %4 = llvm.xor %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def xor_of_icmps_to_ne_no_common_operand_before := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne_no_common_operand(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg1, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_of_icmps_to_ne_extra_use_one_before := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne_extra_use_one(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    llvm.call @use(%2) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_of_icmps_to_ne_extra_use_two_before := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne_extra_use_two(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_of_icmps_to_eq_before := [llvmfunc|
  llvm.func @xor_of_icmps_to_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.icmp "slt" %arg0, %1 : i8
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }]

def PR2844_before := [llvmfunc|
  llvm.func @PR2844(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-638208501 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.select %5, %0, %2 : i1, i32
    llvm.return %6 : i32
  }]

def PR2844_logical_before := [llvmfunc|
  llvm.func @PR2844_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-638208501 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    %7 = llvm.select %6, %0, %3 : i1, i32
    llvm.return %7 : i32
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.icmp "slt" %3, %2 : i32
    llvm.return %4 : i1
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

def test20_before := [llvmfunc|
  llvm.func @test20(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

def test20vec_before := [llvmfunc|
  llvm.func @test20vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test21_before := [llvmfunc|
  llvm.func @test21(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

def test21vec_before := [llvmfunc|
  llvm.func @test21vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test22_before := [llvmfunc|
  llvm.func @test22(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(100663295 : i32) : i32
    %1 = llvm.mlir.constant(268435456 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.and %arg1, %2  : i32
    %7 = llvm.icmp "sgt" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def test22_logical_before := [llvmfunc|
  llvm.func @test22_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(100663295 : i32) : i32
    %1 = llvm.mlir.constant(268435456 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ult" %5, %1 : i32
    %7 = llvm.and %arg1, %2  : i32
    %8 = llvm.icmp "sgt" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }]

def test23_before := [llvmfunc|
  llvm.func @test23(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

def test23vec_before := [llvmfunc|
  llvm.func @test23vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test24_before := [llvmfunc|
  llvm.func @test24(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def test24vec_before := [llvmfunc|
  llvm.func @test24vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.lshr %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test25_before := [llvmfunc|
  llvm.func @test25(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_logical_combined := [llvmfunc|
  llvm.func @test1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test1_logical   : test1_logical_before  ⊑  test1_logical_combined := by
  unfold test1_logical_before test1_logical_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2_logical_combined := [llvmfunc|
  llvm.func @test2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test2_logical   : test2_logical_before  ⊑  test2_logical_combined := by
  unfold test2_logical_before test2_logical_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test13vec_combined := [llvmfunc|
  llvm.func @test13vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg1, %1  : vector<2xi1>
    %3 = llvm.or %2, %arg0  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_test13vec   : test13vec_before  ⊑  test13vec_combined := by
  unfold test13vec_before test13vec_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test14vec_combined := [llvmfunc|
  llvm.func @test14vec(%arg0: vector<3xi1>, %arg1: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.xor %arg0, %arg1  : vector<3xi1>
    %3 = llvm.xor %2, %1  : vector<3xi1>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_test14vec   : test14vec_before  ⊑  test14vec_combined := by
  unfold test14vec_before test14vec_combined
  simp_alive_peephole
  sorry
def bool_eq0_combined := [llvmfunc|
  llvm.func @bool_eq0(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_bool_eq0   : bool_eq0_before  ⊑  bool_eq0_combined := by
  unfold bool_eq0_before bool_eq0_combined
  simp_alive_peephole
  sorry
def bool_eq0_logical_combined := [llvmfunc|
  llvm.func @bool_eq0_logical(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_bool_eq0_logical   : bool_eq0_logical_before  ⊑  bool_eq0_logical_combined := by
  unfold bool_eq0_logical_before bool_eq0_logical_combined
  simp_alive_peephole
  sorry
def xor_of_icmps_combined := [llvmfunc|
  llvm.func @xor_of_icmps(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_xor_of_icmps   : xor_of_icmps_before  ⊑  xor_of_icmps_combined := by
  unfold xor_of_icmps_before xor_of_icmps_combined
  simp_alive_peephole
  sorry
def xor_of_icmps_commute_combined := [llvmfunc|
  llvm.func @xor_of_icmps_commute(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_xor_of_icmps_commute   : xor_of_icmps_commute_before  ⊑  xor_of_icmps_commute_combined := by
  unfold xor_of_icmps_commute_before xor_of_icmps_commute_combined
  simp_alive_peephole
  sorry
def xor_of_icmps_to_ne_combined := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_xor_of_icmps_to_ne   : xor_of_icmps_to_ne_before  ⊑  xor_of_icmps_to_ne_combined := by
  unfold xor_of_icmps_to_ne_before xor_of_icmps_to_ne_combined
  simp_alive_peephole
  sorry
def xor_of_icmps_to_ne_commute_combined := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne_commute(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_xor_of_icmps_to_ne_commute   : xor_of_icmps_to_ne_commute_before  ⊑  xor_of_icmps_to_ne_commute_combined := by
  unfold xor_of_icmps_to_ne_commute_before xor_of_icmps_to_ne_commute_combined
  simp_alive_peephole
  sorry
def xor_of_icmps_neg_to_ne_combined := [llvmfunc|
  llvm.func @xor_of_icmps_neg_to_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-5 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_xor_of_icmps_neg_to_ne   : xor_of_icmps_neg_to_ne_before  ⊑  xor_of_icmps_neg_to_ne_combined := by
  unfold xor_of_icmps_neg_to_ne_before xor_of_icmps_neg_to_ne_combined
  simp_alive_peephole
  sorry
def xor_of_icmps_to_ne_vector_combined := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne_vector(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi64>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_xor_of_icmps_to_ne_vector   : xor_of_icmps_to_ne_vector_before  ⊑  xor_of_icmps_to_ne_vector_combined := by
  unfold xor_of_icmps_to_ne_vector_before xor_of_icmps_to_ne_vector_combined
  simp_alive_peephole
  sorry
def xor_of_icmps_to_ne_no_common_operand_combined := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne_no_common_operand(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg1, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_xor_of_icmps_to_ne_no_common_operand   : xor_of_icmps_to_ne_no_common_operand_before  ⊑  xor_of_icmps_to_ne_no_common_operand_combined := by
  unfold xor_of_icmps_to_ne_no_common_operand_before xor_of_icmps_to_ne_no_common_operand_combined
  simp_alive_peephole
  sorry
def xor_of_icmps_to_ne_extra_use_one_combined := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne_extra_use_one(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %arg0, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_xor_of_icmps_to_ne_extra_use_one   : xor_of_icmps_to_ne_extra_use_one_before  ⊑  xor_of_icmps_to_ne_extra_use_one_combined := by
  unfold xor_of_icmps_to_ne_extra_use_one_before xor_of_icmps_to_ne_extra_use_one_combined
  simp_alive_peephole
  sorry
def xor_of_icmps_to_ne_extra_use_two_combined := [llvmfunc|
  llvm.func @xor_of_icmps_to_ne_extra_use_two(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_xor_of_icmps_to_ne_extra_use_two   : xor_of_icmps_to_ne_extra_use_two_before  ⊑  xor_of_icmps_to_ne_extra_use_two_combined := by
  unfold xor_of_icmps_to_ne_extra_use_two_before xor_of_icmps_to_ne_extra_use_two_combined
  simp_alive_peephole
  sorry
def xor_of_icmps_to_eq_combined := [llvmfunc|
  llvm.func @xor_of_icmps_to_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_xor_of_icmps_to_eq   : xor_of_icmps_to_eq_before  ⊑  xor_of_icmps_to_eq_combined := by
  unfold xor_of_icmps_to_eq_before xor_of_icmps_to_eq_combined
  simp_alive_peephole
  sorry
def PR2844_combined := [llvmfunc|
  llvm.func @PR2844(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-638208502 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_PR2844   : PR2844_before  ⊑  PR2844_combined := by
  unfold PR2844_before PR2844_combined
  simp_alive_peephole
  sorry
def PR2844_logical_combined := [llvmfunc|
  llvm.func @PR2844_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-638208502 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_PR2844_logical   : PR2844_logical_before  ⊑  PR2844_logical_combined := by
  unfold PR2844_logical_before PR2844_logical_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i1
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def test20_combined := [llvmfunc|
  llvm.func @test20(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test20   : test20_before  ⊑  test20_combined := by
  unfold test20_before test20_combined
  simp_alive_peephole
  sorry
def test20vec_combined := [llvmfunc|
  llvm.func @test20vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_test20vec   : test20vec_before  ⊑  test20vec_combined := by
  unfold test20vec_before test20vec_combined
  simp_alive_peephole
  sorry
def test21_combined := [llvmfunc|
  llvm.func @test21(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test21   : test21_before  ⊑  test21_combined := by
  unfold test21_before test21_combined
  simp_alive_peephole
  sorry
def test21vec_combined := [llvmfunc|
  llvm.func @test21vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test21vec   : test21vec_before  ⊑  test21vec_combined := by
  unfold test21vec_before test21vec_combined
  simp_alive_peephole
  sorry
def test22_combined := [llvmfunc|
  llvm.func @test22(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test22   : test22_before  ⊑  test22_combined := by
  unfold test22_before test22_combined
  simp_alive_peephole
  sorry
def test22_logical_combined := [llvmfunc|
  llvm.func @test22_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test22_logical   : test22_logical_before  ⊑  test22_logical_combined := by
  unfold test22_logical_before test22_logical_combined
  simp_alive_peephole
  sorry
def test23_combined := [llvmfunc|
  llvm.func @test23(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test23   : test23_before  ⊑  test23_combined := by
  unfold test23_before test23_combined
  simp_alive_peephole
  sorry
def test23vec_combined := [llvmfunc|
  llvm.func @test23vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_test23vec   : test23vec_before  ⊑  test23vec_combined := by
  unfold test23vec_before test23vec_combined
  simp_alive_peephole
  sorry
def test24_combined := [llvmfunc|
  llvm.func @test24(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test24   : test24_before  ⊑  test24_combined := by
  unfold test24_before test24_combined
  simp_alive_peephole
  sorry
def test24vec_combined := [llvmfunc|
  llvm.func @test24vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.xor %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_test24vec   : test24vec_before  ⊑  test24vec_combined := by
  unfold test24vec_before test24vec_combined
  simp_alive_peephole
  sorry
def test25_combined := [llvmfunc|
  llvm.func @test25(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test25   : test25_before  ⊑  test25_combined := by
  unfold test25_before test25_combined
  simp_alive_peephole
  sorry
