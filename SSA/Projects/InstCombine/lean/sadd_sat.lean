import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sadd_sat
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sadd_sat32_before := [llvmfunc|
  llvm.func @sadd_sat32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }]

def sadd_sat32_mm_before := [llvmfunc|
  llvm.func @sadd_sat32_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.return %7 : i32
  }]

def ssub_sat32_before := [llvmfunc|
  llvm.func @ssub_sat32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.sub %2, %3  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }]

def ssub_sat32_mm_before := [llvmfunc|
  llvm.func @ssub_sat32_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.sub %2, %3  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.return %7 : i32
  }]

def smul_sat32_before := [llvmfunc|
  llvm.func @smul_sat32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.mul %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }]

def smul_sat32_mm_before := [llvmfunc|
  llvm.func @smul_sat32_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.mul %3, %2  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.return %7 : i32
  }]

def sadd_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @sadd_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.sext %arg0 : i16 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i16
    llvm.return %9 : i16
  }]

def sadd_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @sadd_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.sext %arg0 : i16 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.intr.smin(%4, %0)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%5, %1)  : (i32, i32) -> i32
    %7 = llvm.trunc %6 : i32 to i16
    llvm.return %7 : i16
  }]

def ssub_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @ssub_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.sext %arg0 : i16 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i16
    llvm.return %9 : i16
  }]

def ssub_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @ssub_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.sext %arg0 : i16 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.intr.smin(%4, %0)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%5, %1)  : (i32, i32) -> i32
    %7 = llvm.trunc %6 : i32 to i16
    llvm.return %7 : i16
  }]

def sadd_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @sadd_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }]

def sadd_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @sadd_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.intr.smin(%4, %0)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%5, %1)  : (i32, i32) -> i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }]

def ssub_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @ssub_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }]

def ssub_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @ssub_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.intr.smin(%4, %0)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%5, %1)  : (i32, i32) -> i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }]

def sadd_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @sadd_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> (i64 {llvm.signext}) {
    %0 = llvm.mlir.constant(9223372036854775807 : i65) : i65
    %1 = llvm.mlir.constant(-9223372036854775808 : i65) : i65
    %2 = llvm.sext %arg0 : i64 to i65
    %3 = llvm.sext %arg1 : i64 to i65
    %4 = llvm.add %3, %2  : i65
    %5 = llvm.icmp "slt" %4, %0 : i65
    %6 = llvm.select %5, %4, %0 : i1, i65
    %7 = llvm.icmp "sgt" %6, %1 : i65
    %8 = llvm.select %7, %6, %1 : i1, i65
    %9 = llvm.trunc %8 : i65 to i64
    llvm.return %9 : i64
  }]

def ssub_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @ssub_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> (i64 {llvm.signext}) {
    %0 = llvm.mlir.constant(9223372036854775807 : i65) : i65
    %1 = llvm.mlir.constant(-9223372036854775808 : i65) : i65
    %2 = llvm.sext %arg0 : i64 to i65
    %3 = llvm.sext %arg1 : i64 to i65
    %4 = llvm.sub %2, %3  : i65
    %5 = llvm.icmp "slt" %4, %0 : i65
    %6 = llvm.select %5, %4, %0 : i1, i65
    %7 = llvm.icmp "sgt" %6, %1 : i65
    %8 = llvm.select %7, %6, %1 : i1, i65
    %9 = llvm.trunc %8 : i65 to i64
    llvm.return %9 : i64
  }]

def sadd_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @sadd_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> (i4 {llvm.signext}) {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.sext %arg0 : i4 to i32
    %3 = llvm.sext %arg1 : i4 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i4
    llvm.return %9 : i4
  }]

def ssub_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @ssub_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> (i4 {llvm.signext}) {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.sext %arg0 : i4 to i32
    %3 = llvm.sext %arg1 : i4 to i32
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i4
    llvm.return %9 : i4
  }]

def sadd_satv4i32_before := [llvmfunc|
  llvm.func @sadd_satv4i32(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.sext %arg0 : vector<4xi32> to vector<4xi64>
    %3 = llvm.sext %arg1 : vector<4xi32> to vector<4xi64>
    %4 = llvm.add %3, %2  : vector<4xi64>
    %5 = llvm.icmp "slt" %4, %0 : vector<4xi64>
    %6 = llvm.select %5, %4, %0 : vector<4xi1>, vector<4xi64>
    %7 = llvm.icmp "sgt" %6, %1 : vector<4xi64>
    %8 = llvm.select %7, %6, %1 : vector<4xi1>, vector<4xi64>
    %9 = llvm.trunc %8 : vector<4xi64> to vector<4xi32>
    llvm.return %9 : vector<4xi32>
  }]

def sadd_satv4i32_mm_before := [llvmfunc|
  llvm.func @sadd_satv4i32_mm(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.sext %arg0 : vector<4xi32> to vector<4xi64>
    %3 = llvm.sext %arg1 : vector<4xi32> to vector<4xi64>
    %4 = llvm.add %3, %2  : vector<4xi64>
    %5 = llvm.intr.smin(%4, %0)  : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %6 = llvm.intr.smax(%5, %1)  : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %7 = llvm.trunc %6 : vector<4xi64> to vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

def ssub_satv4i32_before := [llvmfunc|
  llvm.func @ssub_satv4i32(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.sext %arg0 : vector<4xi32> to vector<4xi64>
    %3 = llvm.sext %arg1 : vector<4xi32> to vector<4xi64>
    %4 = llvm.sub %3, %2  : vector<4xi64>
    %5 = llvm.icmp "slt" %4, %0 : vector<4xi64>
    %6 = llvm.select %5, %4, %0 : vector<4xi1>, vector<4xi64>
    %7 = llvm.icmp "sgt" %6, %1 : vector<4xi64>
    %8 = llvm.select %7, %6, %1 : vector<4xi1>, vector<4xi64>
    %9 = llvm.trunc %8 : vector<4xi64> to vector<4xi32>
    llvm.return %9 : vector<4xi32>
  }]

def ssub_satv4i32_mm_before := [llvmfunc|
  llvm.func @ssub_satv4i32_mm(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.sext %arg0 : vector<4xi32> to vector<4xi64>
    %3 = llvm.sext %arg1 : vector<4xi32> to vector<4xi64>
    %4 = llvm.sub %3, %2  : vector<4xi64>
    %5 = llvm.intr.smin(%4, %0)  : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %6 = llvm.intr.smax(%5, %1)  : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %7 = llvm.trunc %6 : vector<4xi64> to vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

def sadd_satv4i4_before := [llvmfunc|
  llvm.func @sadd_satv4i4(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %arg1  : vector<4xi32>
    %3 = llvm.icmp "slt" %2, %0 : vector<4xi32>
    %4 = llvm.select %3, %2, %0 : vector<4xi1>, vector<4xi32>
    %5 = llvm.icmp "sgt" %4, %1 : vector<4xi32>
    %6 = llvm.select %5, %4, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }]

def ssub_satv4i4_before := [llvmfunc|
  llvm.func @ssub_satv4i4(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %arg1  : vector<4xi32>
    %3 = llvm.icmp "slt" %2, %0 : vector<4xi32>
    %4 = llvm.select %3, %2, %0 : vector<4xi1>, vector<4xi32>
    %5 = llvm.icmp "sgt" %4, %1 : vector<4xi32>
    %6 = llvm.select %5, %4, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }]

def sadd_sat32_extrause_1_before := [llvmfunc|
  llvm.func @sadd_sat32_extrause_1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use64(%8) : (i64) -> ()
    llvm.return %9 : i32
  }]

def sadd_sat32_extrause_2_before := [llvmfunc|
  llvm.func @sadd_sat32_extrause_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use64(%6) : (i64) -> ()
    llvm.return %9 : i32
  }]

def sadd_sat32_extrause_2_mm_before := [llvmfunc|
  llvm.func @sadd_sat32_extrause_2_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.call @use64(%5) : (i64) -> ()
    llvm.return %7 : i32
  }]

def sadd_sat32_extrause_3_before := [llvmfunc|
  llvm.func @sadd_sat32_extrause_3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use64(%4) : (i64) -> ()
    llvm.return %9 : i32
  }]

def sadd_sat32_extrause_3_mm_before := [llvmfunc|
  llvm.func @sadd_sat32_extrause_3_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.call @use64(%4) : (i64) -> ()
    llvm.return %7 : i32
  }]

def sadd_sat32_trunc_before := [llvmfunc|
  llvm.func @sadd_sat32_trunc(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i64) : i64
    %1 = llvm.mlir.constant(-32768 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }]

def sadd_sat32_ext16_before := [llvmfunc|
  llvm.func @sadd_sat32_ext16(%arg0: i32, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i16 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }]

def sadd_sat8_ext8_before := [llvmfunc|
  llvm.func @sadd_sat8_ext8(%arg0: i8, %arg1: i16) -> i8 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }]

def sadd_sat32_zext_before := [llvmfunc|
  llvm.func @sadd_sat32_zext(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }]

def sadd_sat32_maxmin_before := [llvmfunc|
  llvm.func @sadd_sat32_maxmin(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i64) : i64
    %1 = llvm.mlir.constant(2147483647 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "sgt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "slt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }]

def sadd_sat32_notrunc_before := [llvmfunc|
  llvm.func @sadd_sat32_notrunc(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(-2147483648 : i64) : i64
    %1 = llvm.mlir.constant(2147483647 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "sgt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "slt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    llvm.return %8 : i64
  }]

def ashrA_before := [llvmfunc|
  llvm.func @ashrA(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(2147483647 : i64) : i64
    %2 = llvm.mlir.constant(-2147483648 : i64) : i64
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.sext %arg1 : i32 to i64
    %5 = llvm.add %4, %3  : i64
    %6 = llvm.intr.smin(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.intr.smax(%6, %2)  : (i64, i64) -> i64
    %8 = llvm.trunc %7 : i64 to i32
    llvm.return %8 : i32
  }]

def ashrB_before := [llvmfunc|
  llvm.func @ashrB(%arg0: i32, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.mlir.constant(2147483647 : i64) : i64
    %3 = llvm.sext %arg0 : i32 to i64
    %4 = llvm.ashr %arg1, %0  : i64
    %5 = llvm.add %4, %3  : i64
    %6 = llvm.icmp "sgt" %5, %1 : i64
    %7 = llvm.select %6, %5, %1 : i1, i64
    %8 = llvm.icmp "slt" %7, %2 : i64
    %9 = llvm.select %8, %7, %2 : i1, i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }]

def ashrAB_before := [llvmfunc|
  llvm.func @ashrAB(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.mlir.constant(2147483647 : i64) : i64
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.ashr %arg1, %0  : i64
    %5 = llvm.add %4, %3  : i64
    %6 = llvm.icmp "sgt" %5, %1 : i64
    %7 = llvm.select %6, %5, %1 : i1, i64
    %8 = llvm.icmp "slt" %7, %2 : i64
    %9 = llvm.select %8, %7, %2 : i1, i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }]

def ashrA31_before := [llvmfunc|
  llvm.func @ashrA31(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.mlir.constant(2147483647 : i64) : i64
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.sext %arg1 : i32 to i64
    %5 = llvm.add %4, %3  : i64
    %6 = llvm.icmp "sgt" %5, %1 : i64
    %7 = llvm.select %6, %5, %1 : i1, i64
    %8 = llvm.icmp "slt" %7, %2 : i64
    %9 = llvm.select %8, %7, %2 : i1, i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }]

def ashrA33_before := [llvmfunc|
  llvm.func @ashrA33(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(33 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.mlir.constant(2147483647 : i64) : i64
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.sext %arg1 : i32 to i64
    %5 = llvm.add %4, %3  : i64
    %6 = llvm.icmp "sgt" %5, %1 : i64
    %7 = llvm.select %6, %5, %1 : i1, i64
    %8 = llvm.icmp "slt" %7, %2 : i64
    %9 = llvm.select %8, %7, %2 : i1, i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }]

def ashrv2i8_before := [llvmfunc|
  llvm.func @ashrv2i8(%arg0: vector<2xi16>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 12]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<-128> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<127> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.ashr %arg0, %0  : vector<2xi16>
    %4 = llvm.sext %arg1 : vector<2xi8> to vector<2xi16>
    %5 = llvm.add %4, %3  : vector<2xi16>
    %6 = llvm.icmp "sgt" %5, %1 : vector<2xi16>
    %7 = llvm.select %6, %5, %1 : vector<2xi1>, vector<2xi16>
    %8 = llvm.icmp "slt" %7, %2 : vector<2xi16>
    %9 = llvm.select %8, %7, %2 : vector<2xi1>, vector<2xi16>
    %10 = llvm.trunc %9 : vector<2xi16> to vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def ashrv2i8_s_before := [llvmfunc|
  llvm.func @ashrv2i8_s(%arg0: vector<2xi16>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<-128> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<127> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.ashr %arg0, %0  : vector<2xi16>
    %4 = llvm.sext %arg1 : vector<2xi8> to vector<2xi16>
    %5 = llvm.add %4, %3  : vector<2xi16>
    %6 = llvm.icmp "sgt" %5, %1 : vector<2xi16>
    %7 = llvm.select %6, %5, %1 : vector<2xi1>, vector<2xi16>
    %8 = llvm.icmp "slt" %7, %2 : vector<2xi16>
    %9 = llvm.select %8, %7, %2 : vector<2xi1>, vector<2xi16>
    %10 = llvm.trunc %9 : vector<2xi16> to vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def or_before := [llvmfunc|
  llvm.func @or(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-16 : i16) : i16
    %1 = llvm.mlir.constant(-128 : i16) : i16
    %2 = llvm.mlir.constant(127 : i16) : i16
    %3 = llvm.sext %arg0 : i8 to i16
    %4 = llvm.or %arg1, %0  : i16
    %5 = llvm.sub %3, %4 overflow<nsw>  : i16
    %6 = llvm.icmp "sgt" %5, %1 : i16
    %7 = llvm.select %6, %5, %1 : i1, i16
    %8 = llvm.icmp "slt" %7, %2 : i16
    %9 = llvm.select %8, %7, %2 : i1, i16
    llvm.return %9 : i16
  }]

def const_before := [llvmfunc|
  llvm.func @const(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(10 : i16) : i16
    %1 = llvm.mlir.constant(-128 : i16) : i16
    %2 = llvm.mlir.constant(127 : i16) : i16
    %3 = llvm.sext %arg0 : i8 to i16
    %4 = llvm.add %3, %0  : i16
    %5 = llvm.icmp "sgt" %4, %1 : i16
    %6 = llvm.select %5, %4, %1 : i1, i16
    %7 = llvm.icmp "slt" %6, %2 : i16
    %8 = llvm.select %7, %6, %2 : i1, i16
    llvm.return %8 : i16
  }]

def sadd_sat32_combined := [llvmfunc|
  llvm.func @sadd_sat32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sadd_sat32   : sadd_sat32_before  ⊑  sadd_sat32_combined := by
  unfold sadd_sat32_before sadd_sat32_combined
  simp_alive_peephole
  sorry
def sadd_sat32_mm_combined := [llvmfunc|
  llvm.func @sadd_sat32_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sadd_sat32_mm   : sadd_sat32_mm_before  ⊑  sadd_sat32_mm_combined := by
  unfold sadd_sat32_mm_before sadd_sat32_mm_combined
  simp_alive_peephole
  sorry
def ssub_sat32_combined := [llvmfunc|
  llvm.func @ssub_sat32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ssub_sat32   : ssub_sat32_before  ⊑  ssub_sat32_combined := by
  unfold ssub_sat32_before ssub_sat32_combined
  simp_alive_peephole
  sorry
def ssub_sat32_mm_combined := [llvmfunc|
  llvm.func @ssub_sat32_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ssub_sat32_mm   : ssub_sat32_mm_before  ⊑  ssub_sat32_mm_combined := by
  unfold ssub_sat32_mm_before ssub_sat32_mm_combined
  simp_alive_peephole
  sorry
def smul_sat32_combined := [llvmfunc|
  llvm.func @smul_sat32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.mul %3, %2 overflow<nsw>  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_smul_sat32   : smul_sat32_before  ⊑  smul_sat32_combined := by
  unfold smul_sat32_before smul_sat32_combined
  simp_alive_peephole
  sorry
def smul_sat32_mm_combined := [llvmfunc|
  llvm.func @smul_sat32_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.mul %3, %2 overflow<nsw>  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_smul_sat32_mm   : smul_sat32_mm_before  ⊑  smul_sat32_mm_combined := by
  unfold smul_sat32_mm_before smul_sat32_mm_combined
  simp_alive_peephole
  sorry
def sadd_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @sadd_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (i16, i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_sadd_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) ->    : sadd_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before  ⊑  sadd_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined := by
  unfold sadd_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before sadd_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def sadd_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @sadd_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (i16, i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_sadd_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) ->    : sadd_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before  ⊑  sadd_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined := by
  unfold sadd_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before sadd_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def ssub_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @ssub_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i16, i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_ssub_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) ->    : ssub_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before  ⊑  ssub_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined := by
  unfold ssub_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before ssub_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def ssub_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @ssub_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i16, i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_ssub_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) ->    : ssub_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before  ⊑  ssub_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined := by
  unfold ssub_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _before ssub_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def sadd_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @sadd_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_sadd_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) ->    : sadd_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before  ⊑  sadd_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined := by
  unfold sadd_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before sadd_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def sadd_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @sadd_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_sadd_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) ->    : sadd_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before  ⊑  sadd_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined := by
  unfold sadd_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before sadd_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def ssub_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @ssub_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ssub_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) ->    : ssub_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before  ⊑  ssub_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined := by
  unfold ssub_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before ssub_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def ssub_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @ssub_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ssub_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) ->    : ssub_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before  ⊑  ssub_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined := by
  unfold ssub_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before ssub_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def sadd_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @sadd_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> (i64 {llvm.signext}) {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (i64, i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_sadd_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) ->    : sadd_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _before  ⊑  sadd_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _combined := by
  unfold sadd_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _before sadd_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def ssub_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @ssub_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> (i64 {llvm.signext}) {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_ssub_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) ->    : ssub_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _before  ⊑  ssub_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _combined := by
  unfold ssub_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _before ssub_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def sadd_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @sadd_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> (i4 {llvm.signext}) {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.sext %arg0 : i4 to i32
    %3 = llvm.sext %arg1 : i4 to i32
    %4 = llvm.add %3, %2 overflow<nsw>  : i32
    %5 = llvm.intr.smin(%4, %0)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%5, %1)  : (i32, i32) -> i32
    %7 = llvm.trunc %6 : i32 to i4
    llvm.return %7 : i4
  }]

theorem inst_combine_sadd_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) ->    : sadd_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _before  ⊑  sadd_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _combined := by
  unfold sadd_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _before sadd_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def ssub_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @ssub_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> (i4 {llvm.signext}) {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.sext %arg0 : i4 to i32
    %3 = llvm.sext %arg1 : i4 to i32
    %4 = llvm.sub %2, %3 overflow<nsw>  : i32
    %5 = llvm.intr.smin(%4, %0)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%5, %1)  : (i32, i32) -> i32
    %7 = llvm.trunc %6 : i32 to i4
    llvm.return %7 : i4
  }]

theorem inst_combine_ssub_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) ->    : ssub_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _before  ⊑  ssub_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _combined := by
  unfold ssub_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _before ssub_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def sadd_satv4i32_combined := [llvmfunc|
  llvm.func @sadd_satv4i32(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_sadd_satv4i32   : sadd_satv4i32_before  ⊑  sadd_satv4i32_combined := by
  unfold sadd_satv4i32_before sadd_satv4i32_combined
  simp_alive_peephole
  sorry
def sadd_satv4i32_mm_combined := [llvmfunc|
  llvm.func @sadd_satv4i32_mm(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_sadd_satv4i32_mm   : sadd_satv4i32_mm_before  ⊑  sadd_satv4i32_mm_combined := by
  unfold sadd_satv4i32_mm_before sadd_satv4i32_mm_combined
  simp_alive_peephole
  sorry
def ssub_satv4i32_combined := [llvmfunc|
  llvm.func @ssub_satv4i32(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.intr.ssub.sat(%arg1, %arg0)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_ssub_satv4i32   : ssub_satv4i32_before  ⊑  ssub_satv4i32_combined := by
  unfold ssub_satv4i32_before ssub_satv4i32_combined
  simp_alive_peephole
  sorry
def ssub_satv4i32_mm_combined := [llvmfunc|
  llvm.func @ssub_satv4i32_mm(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.intr.ssub.sat(%arg1, %arg0)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_ssub_satv4i32_mm   : ssub_satv4i32_mm_before  ⊑  ssub_satv4i32_mm_combined := by
  unfold ssub_satv4i32_mm_before ssub_satv4i32_mm_combined
  simp_alive_peephole
  sorry
def sadd_satv4i4_combined := [llvmfunc|
  llvm.func @sadd_satv4i4(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %arg1  : vector<4xi32>
    %3 = llvm.intr.smin(%2, %0)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %4 = llvm.intr.smax(%3, %1)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_sadd_satv4i4   : sadd_satv4i4_before  ⊑  sadd_satv4i4_combined := by
  unfold sadd_satv4i4_before sadd_satv4i4_combined
  simp_alive_peephole
  sorry
def ssub_satv4i4_combined := [llvmfunc|
  llvm.func @ssub_satv4i4(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %arg1  : vector<4xi32>
    %3 = llvm.intr.smin(%2, %0)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %4 = llvm.intr.smax(%3, %1)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_ssub_satv4i4   : ssub_satv4i4_before  ⊑  ssub_satv4i4_combined := by
  unfold ssub_satv4i4_before ssub_satv4i4_combined
  simp_alive_peephole
  sorry
def sadd_sat32_extrause_1_combined := [llvmfunc|
  llvm.func @sadd_sat32_extrause_1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (i32, i32) -> i32
    %1 = llvm.sext %0 : i32 to i64
    llvm.call @use64(%1) : (i64) -> ()
    llvm.return %0 : i32
  }]

theorem inst_combine_sadd_sat32_extrause_1   : sadd_sat32_extrause_1_before  ⊑  sadd_sat32_extrause_1_combined := by
  unfold sadd_sat32_extrause_1_before sadd_sat32_extrause_1_combined
  simp_alive_peephole
  sorry
def sadd_sat32_extrause_2_combined := [llvmfunc|
  llvm.func @sadd_sat32_extrause_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.call @use64(%5) : (i64) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_sadd_sat32_extrause_2   : sadd_sat32_extrause_2_before  ⊑  sadd_sat32_extrause_2_combined := by
  unfold sadd_sat32_extrause_2_before sadd_sat32_extrause_2_combined
  simp_alive_peephole
  sorry
def sadd_sat32_extrause_2_mm_combined := [llvmfunc|
  llvm.func @sadd_sat32_extrause_2_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.call @use64(%5) : (i64) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_sadd_sat32_extrause_2_mm   : sadd_sat32_extrause_2_mm_before  ⊑  sadd_sat32_extrause_2_mm_combined := by
  unfold sadd_sat32_extrause_2_mm_before sadd_sat32_extrause_2_mm_combined
  simp_alive_peephole
  sorry
def sadd_sat32_extrause_3_combined := [llvmfunc|
  llvm.func @sadd_sat32_extrause_3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.call @use64(%4) : (i64) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_sadd_sat32_extrause_3   : sadd_sat32_extrause_3_before  ⊑  sadd_sat32_extrause_3_combined := by
  unfold sadd_sat32_extrause_3_before sadd_sat32_extrause_3_combined
  simp_alive_peephole
  sorry
def sadd_sat32_extrause_3_mm_combined := [llvmfunc|
  llvm.func @sadd_sat32_extrause_3_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.call @use64(%4) : (i64) -> ()
    llvm.return %7 : i32
  }]

theorem inst_combine_sadd_sat32_extrause_3_mm   : sadd_sat32_extrause_3_mm_before  ⊑  sadd_sat32_extrause_3_mm_combined := by
  unfold sadd_sat32_extrause_3_mm_before sadd_sat32_extrause_3_mm_combined
  simp_alive_peephole
  sorry
def sadd_sat32_trunc_combined := [llvmfunc|
  llvm.func @sadd_sat32_trunc(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i64) : i64
    %1 = llvm.mlir.constant(-32768 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_sadd_sat32_trunc   : sadd_sat32_trunc_before  ⊑  sadd_sat32_trunc_combined := by
  unfold sadd_sat32_trunc_before sadd_sat32_trunc_combined
  simp_alive_peephole
  sorry
def sadd_sat32_ext16_combined := [llvmfunc|
  llvm.func @sadd_sat32_ext16(%arg0: i32, %arg1: i16) -> i32 {
    %0 = llvm.sext %arg1 : i16 to i32
    %1 = llvm.intr.sadd.sat(%0, %arg0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sadd_sat32_ext16   : sadd_sat32_ext16_before  ⊑  sadd_sat32_ext16_combined := by
  unfold sadd_sat32_ext16_before sadd_sat32_ext16_combined
  simp_alive_peephole
  sorry
def sadd_sat8_ext8_combined := [llvmfunc|
  llvm.func @sadd_sat8_ext8(%arg0: i8, %arg1: i16) -> i8 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.add %3, %2 overflow<nsw>  : i32
    %5 = llvm.intr.smin(%4, %0)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%5, %1)  : (i32, i32) -> i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }]

theorem inst_combine_sadd_sat8_ext8   : sadd_sat8_ext8_before  ⊑  sadd_sat8_ext8_combined := by
  unfold sadd_sat8_ext8_before sadd_sat8_ext8_combined
  simp_alive_peephole
  sorry
def sadd_sat32_zext_combined := [llvmfunc|
  llvm.func @sadd_sat32_zext(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i64
    %4 = llvm.intr.umin(%3, %0)  : (i64, i64) -> i64
    %5 = llvm.trunc %4 : i64 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_sadd_sat32_zext   : sadd_sat32_zext_before  ⊑  sadd_sat32_zext_combined := by
  unfold sadd_sat32_zext_before sadd_sat32_zext_combined
  simp_alive_peephole
  sorry
def sadd_sat32_maxmin_combined := [llvmfunc|
  llvm.func @sadd_sat32_maxmin(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sadd_sat32_maxmin   : sadd_sat32_maxmin_before  ⊑  sadd_sat32_maxmin_combined := by
  unfold sadd_sat32_maxmin_before sadd_sat32_maxmin_combined
  simp_alive_peephole
  sorry
def sadd_sat32_notrunc_combined := [llvmfunc|
  llvm.func @sadd_sat32_notrunc(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.intr.sadd.sat(%arg1, %arg0)  : (i32, i32) -> i32
    %1 = llvm.sext %0 : i32 to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_sadd_sat32_notrunc   : sadd_sat32_notrunc_before  ⊑  sadd_sat32_notrunc_combined := by
  unfold sadd_sat32_notrunc_before sadd_sat32_notrunc_combined
  simp_alive_peephole
  sorry
def ashrA_combined := [llvmfunc|
  llvm.func @ashrA(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.intr.sadd.sat(%2, %arg1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashrA   : ashrA_before  ⊑  ashrA_combined := by
  unfold ashrA_before ashrA_combined
  simp_alive_peephole
  sorry
def ashrB_combined := [llvmfunc|
  llvm.func @ashrB(%arg0: i32, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg1, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.intr.sadd.sat(%2, %arg0)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashrB   : ashrB_before  ⊑  ashrB_combined := by
  unfold ashrB_before ashrB_combined
  simp_alive_peephole
  sorry
def ashrAB_combined := [llvmfunc|
  llvm.func @ashrAB(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.lshr %arg1, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.trunc %1 : i64 to i32
    %5 = llvm.intr.sadd.sat(%3, %4)  : (i32, i32) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_ashrAB   : ashrAB_before  ⊑  ashrAB_combined := by
  unfold ashrAB_before ashrAB_combined
  simp_alive_peephole
  sorry
def ashrA31_combined := [llvmfunc|
  llvm.func @ashrA31(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.mlir.constant(2147483647 : i64) : i64
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.sext %arg1 : i32 to i64
    %5 = llvm.add %3, %4 overflow<nsw>  : i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.intr.smin(%6, %2)  : (i64, i64) -> i64
    %8 = llvm.trunc %7 : i64 to i32
    llvm.return %8 : i32
  }]

theorem inst_combine_ashrA31   : ashrA31_before  ⊑  ashrA31_combined := by
  unfold ashrA31_before ashrA31_combined
  simp_alive_peephole
  sorry
def ashrA33_combined := [llvmfunc|
  llvm.func @ashrA33(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(33 : i64) : i64
    %1 = llvm.ashr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.intr.sadd.sat(%2, %arg1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashrA33   : ashrA33_before  ⊑  ashrA33_combined := by
  unfold ashrA33_before ashrA33_combined
  simp_alive_peephole
  sorry
def ashrv2i8_combined := [llvmfunc|
  llvm.func @ashrv2i8(%arg0: vector<2xi16>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 12]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<-128> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<127> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.ashr %arg0, %0  : vector<2xi16>
    %4 = llvm.sext %arg1 : vector<2xi8> to vector<2xi16>
    %5 = llvm.add %3, %4  : vector<2xi16>
    %6 = llvm.intr.smax(%5, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %7 = llvm.intr.smin(%6, %2)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %8 = llvm.trunc %7 : vector<2xi16> to vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

theorem inst_combine_ashrv2i8   : ashrv2i8_before  ⊑  ashrv2i8_combined := by
  unfold ashrv2i8_before ashrv2i8_combined
  simp_alive_peephole
  sorry
def ashrv2i8_s_combined := [llvmfunc|
  llvm.func @ashrv2i8_s(%arg0: vector<2xi16>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.lshr %arg0, %0  : vector<2xi16>
    %2 = llvm.trunc %1 : vector<2xi16> to vector<2xi8>
    %3 = llvm.intr.sadd.sat(%2, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_ashrv2i8_s   : ashrv2i8_s_before  ⊑  ashrv2i8_s_combined := by
  unfold ashrv2i8_s_before ashrv2i8_s_combined
  simp_alive_peephole
  sorry
def or_combined := [llvmfunc|
  llvm.func @or(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.trunc %arg1 : i16 to i8
    %2 = llvm.or %1, %0  : i8
    %3 = llvm.intr.ssub.sat(%arg0, %2)  : (i8, i8) -> i8
    %4 = llvm.sext %3 : i8 to i16
    llvm.return %4 : i16
  }]

theorem inst_combine_or   : or_before  ⊑  or_combined := by
  unfold or_before or_combined
  simp_alive_peephole
  sorry
def const_combined := [llvmfunc|
  llvm.func @const(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(117 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.intr.smin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    %4 = llvm.sext %3 : i8 to i16
    llvm.return %4 : i16
  }]

theorem inst_combine_const   : const_before  ⊑  const_combined := by
  unfold const_before const_combined
  simp_alive_peephole
  sorry
