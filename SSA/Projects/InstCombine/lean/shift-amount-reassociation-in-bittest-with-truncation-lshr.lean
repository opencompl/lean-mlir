import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-amount-reassociation-in-bittest-with-truncation-lshr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def n0_before := [llvmfunc|
  llvm.func @n0(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %1, %4  : i32
    %6 = llvm.add %arg1, %2  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %arg0, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

def t1_single_bit_before := [llvmfunc|
  llvm.func @t1_single_bit(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(32768 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %1, %4  : i32
    %6 = llvm.add %arg1, %2  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %arg0, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(131071 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %1, %4  : i32
    %6 = llvm.add %arg1, %2  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %arg0, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

def t3_before := [llvmfunc|
  llvm.func @t3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(131071 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %arg0, %4  : i32
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %2, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

def t3_singlebit_before := [llvmfunc|
  llvm.func @t3_singlebit(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(65536 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %arg0, %4  : i32
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %2, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

def n4_before := [llvmfunc|
  llvm.func @n4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(262143 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %arg0, %4  : i32
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %2, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

def t5_vec_before := [llvmfunc|
  llvm.func @t5_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 32767]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %1, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %2  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %arg0, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }]

def n6_vec_before := [llvmfunc|
  llvm.func @n6_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 131071]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %1, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %2  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %arg0, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }]

def t7_vec_before := [llvmfunc|
  llvm.func @t7_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[131071, 65535]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %arg0, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %1  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %2, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }]

def n8_vec_before := [llvmfunc|
  llvm.func @n8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[131071, 262143]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %arg0, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %1  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %2, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }]

def t9_highest_bit_before := [llvmfunc|
  llvm.func @t9_highest_bit(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def t10_almost_highest_bit_before := [llvmfunc|
  llvm.func @t10_almost_highest_bit(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def t11_no_shift_before := [llvmfunc|
  llvm.func @t11_no_shift(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-64 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def t10_shift_by_one_before := [llvmfunc|
  llvm.func @t10_shift_by_one(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-63 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def t11_zero_and_almost_bitwidth_before := [llvmfunc|
  llvm.func @t11_zero_and_almost_bitwidth(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-1, -64]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg2  : vector<2xi32>
    %5 = llvm.shl %arg0, %4  : vector<2xi32>
    %6 = llvm.add %arg2, %1  : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi32> to vector<2xi64>
    %8 = llvm.lshr %arg1, %7  : vector<2xi64>
    %9 = llvm.trunc %8 : vector<2xi64> to vector<2xi32>
    %10 = llvm.and %5, %9  : vector<2xi32>
    %11 = llvm.icmp "ne" %10, %3 : vector<2xi32>
    llvm.return %11 : vector<2xi1>
  }]

def n12_bad_before := [llvmfunc|
  llvm.func @n12_bad(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2, -64]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg2  : vector<2xi32>
    %5 = llvm.shl %arg0, %4  : vector<2xi32>
    %6 = llvm.add %arg2, %1  : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi32> to vector<2xi64>
    %8 = llvm.lshr %arg1, %7  : vector<2xi64>
    %9 = llvm.trunc %8 : vector<2xi64> to vector<2xi32>
    %10 = llvm.and %5, %9  : vector<2xi32>
    %11 = llvm.icmp "ne" %10, %3 : vector<2xi32>
    llvm.return %11 : vector<2xi1>
  }]

def t13_x_is_one_before := [llvmfunc|
  llvm.func @t13_x_is_one(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %1, %4  : i32
    %6 = llvm.add %arg1, %2  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %arg0, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

def t14_x_is_one_before := [llvmfunc|
  llvm.func @t14_x_is_one(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %arg0, %4  : i32
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %2, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

def t15_vec_x_is_one_or_zero_before := [llvmfunc|
  llvm.func @t15_vec_x_is_one_or_zero(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %1, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %2  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %arg0, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }]

def t16_vec_y_is_one_or_zero_before := [llvmfunc|
  llvm.func @t16_vec_y_is_one_or_zero(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %arg0, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %1  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %2, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }]

def rawspeed_signbit_before := [llvmfunc|
  llvm.func @rawspeed_signbit(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1 overflow<nsw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.add %arg1, %1 overflow<nsw>  : i32
    %9 = llvm.shl %2, %8  : i32
    %10 = llvm.and %9, %7  : i32
    %11 = llvm.icmp "eq" %10, %3 : i32
    llvm.return %11 : i1
  }]

def n0_combined := [llvmfunc|
  llvm.func @n0(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

theorem inst_combine_n0   : n0_before  ⊑  n0_combined := by
  unfold n0_before n0_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(4294901760 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t1_single_bit_combined := [llvmfunc|
  llvm.func @t1_single_bit(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_t1_single_bit   : t1_single_bit_before  ⊑  t1_single_bit_combined := by
  unfold t1_single_bit_before t1_single_bit_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(131071 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %1, %4  : i32
    %6 = llvm.add %arg1, %2  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %arg0, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def t3_combined := [llvmfunc|
  llvm.func @t3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_t3   : t3_before  ⊑  t3_combined := by
  unfold t3_before t3_combined
  simp_alive_peephole
  sorry
def t3_singlebit_combined := [llvmfunc|
  llvm.func @t3_singlebit(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_t3_singlebit   : t3_singlebit_before  ⊑  t3_singlebit_combined := by
  unfold t3_singlebit_before t3_singlebit_combined
  simp_alive_peephole
  sorry
def n4_combined := [llvmfunc|
  llvm.func @n4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(262143 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %arg0, %4  : i32
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %2, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

theorem inst_combine_n4   : n4_before  ⊑  n4_combined := by
  unfold n4_before n4_combined
  simp_alive_peephole
  sorry
def t5_vec_combined := [llvmfunc|
  llvm.func @t5_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[65535, 32767]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.lshr %arg0, %0  : vector<2xi64>
    %5 = llvm.and %4, %1  : vector<2xi64>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi64>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_t5_vec   : t5_vec_before  ⊑  t5_vec_combined := by
  unfold t5_vec_before t5_vec_combined
  simp_alive_peephole
  sorry
def n6_vec_combined := [llvmfunc|
  llvm.func @n6_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 131071]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %1, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %2  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %arg0, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }]

theorem inst_combine_n6_vec   : n6_vec_before  ⊑  n6_vec_combined := by
  unfold n6_vec_before n6_vec_combined
  simp_alive_peephole
  sorry
def t7_vec_combined := [llvmfunc|
  llvm.func @t7_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_t7_vec   : t7_vec_before  ⊑  t7_vec_combined := by
  unfold t7_vec_before t7_vec_combined
  simp_alive_peephole
  sorry
def n8_vec_combined := [llvmfunc|
  llvm.func @n8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[131071, 262143]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %arg0, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %1  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %2, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }]

theorem inst_combine_n8_vec   : n8_vec_before  ⊑  n8_vec_combined := by
  unfold n8_vec_before n8_vec_combined
  simp_alive_peephole
  sorry
def t9_highest_bit_combined := [llvmfunc|
  llvm.func @t9_highest_bit(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.lshr %arg1, %0  : i64
    %4 = llvm.and %3, %2  : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    llvm.return %5 : i1
  }]

theorem inst_combine_t9_highest_bit   : t9_highest_bit_before  ⊑  t9_highest_bit_combined := by
  unfold t9_highest_bit_before t9_highest_bit_combined
  simp_alive_peephole
  sorry
def t10_almost_highest_bit_combined := [llvmfunc|
  llvm.func @t10_almost_highest_bit(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

theorem inst_combine_t10_almost_highest_bit   : t10_almost_highest_bit_before  ⊑  t10_almost_highest_bit_combined := by
  unfold t10_almost_highest_bit_before t10_almost_highest_bit_combined
  simp_alive_peephole
  sorry
def t11_no_shift_combined := [llvmfunc|
  llvm.func @t11_no_shift(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.and %1, %arg1  : i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_t11_no_shift   : t11_no_shift_before  ⊑  t11_no_shift_combined := by
  unfold t11_no_shift_before t11_no_shift_combined
  simp_alive_peephole
  sorry
def t10_shift_by_one_combined := [llvmfunc|
  llvm.func @t10_shift_by_one(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-63 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

theorem inst_combine_t10_shift_by_one   : t10_shift_by_one_before  ⊑  t10_shift_by_one_combined := by
  unfold t10_shift_by_one_before t10_shift_by_one_combined
  simp_alive_peephole
  sorry
def t11_zero_and_almost_bitwidth_combined := [llvmfunc|
  llvm.func @t11_zero_and_almost_bitwidth(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-1, -64]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg2  : vector<2xi32>
    %5 = llvm.shl %arg0, %4  : vector<2xi32>
    %6 = llvm.add %arg2, %1  : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi32> to vector<2xi64>
    %8 = llvm.lshr %arg1, %7  : vector<2xi64>
    %9 = llvm.trunc %8 : vector<2xi64> to vector<2xi32>
    %10 = llvm.and %5, %9  : vector<2xi32>
    %11 = llvm.icmp "ne" %10, %3 : vector<2xi32>
    llvm.return %11 : vector<2xi1>
  }]

theorem inst_combine_t11_zero_and_almost_bitwidth   : t11_zero_and_almost_bitwidth_before  ⊑  t11_zero_and_almost_bitwidth_combined := by
  unfold t11_zero_and_almost_bitwidth_before t11_zero_and_almost_bitwidth_combined
  simp_alive_peephole
  sorry
def n12_bad_combined := [llvmfunc|
  llvm.func @n12_bad(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2, -64]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg2  : vector<2xi32>
    %5 = llvm.shl %arg0, %4  : vector<2xi32>
    %6 = llvm.add %arg2, %1  : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi32> to vector<2xi64>
    %8 = llvm.lshr %arg1, %7  : vector<2xi64>
    %9 = llvm.trunc %8 : vector<2xi64> to vector<2xi32>
    %10 = llvm.and %5, %9  : vector<2xi32>
    %11 = llvm.icmp "ne" %10, %3 : vector<2xi32>
    llvm.return %11 : vector<2xi1>
  }]

theorem inst_combine_n12_bad   : n12_bad_before  ⊑  n12_bad_combined := by
  unfold n12_bad_before n12_bad_combined
  simp_alive_peephole
  sorry
def t13_x_is_one_combined := [llvmfunc|
  llvm.func @t13_x_is_one(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(65536 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_t13_x_is_one   : t13_x_is_one_before  ⊑  t13_x_is_one_combined := by
  unfold t13_x_is_one_before t13_x_is_one_combined
  simp_alive_peephole
  sorry
def t14_x_is_one_combined := [llvmfunc|
  llvm.func @t14_x_is_one(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_t14_x_is_one   : t14_x_is_one_before  ⊑  t14_x_is_one_combined := by
  unfold t14_x_is_one_before t14_x_is_one_combined
  simp_alive_peephole
  sorry
def t15_vec_x_is_one_or_zero_combined := [llvmfunc|
  llvm.func @t15_vec_x_is_one_or_zero(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.lshr %arg0, %0  : vector<2xi64>
    %5 = llvm.and %4, %1  : vector<2xi64>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi64>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_t15_vec_x_is_one_or_zero   : t15_vec_x_is_one_or_zero_before  ⊑  t15_vec_x_is_one_or_zero_combined := by
  unfold t15_vec_x_is_one_or_zero_before t15_vec_x_is_one_or_zero_combined
  simp_alive_peephole
  sorry
def t16_vec_y_is_one_or_zero_combined := [llvmfunc|
  llvm.func @t16_vec_y_is_one_or_zero(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_t16_vec_y_is_one_or_zero   : t16_vec_y_is_one_or_zero_before  ⊑  t16_vec_y_is_one_or_zero_combined := by
  unfold t16_vec_y_is_one_or_zero_before t16_vec_y_is_one_or_zero_combined
  simp_alive_peephole
  sorry
def rawspeed_signbit_combined := [llvmfunc|
  llvm.func @rawspeed_signbit(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_rawspeed_signbit   : rawspeed_signbit_before  ⊑  rawspeed_signbit_combined := by
  unfold rawspeed_signbit_before rawspeed_signbit_combined
  simp_alive_peephole
  sorry
