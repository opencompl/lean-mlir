import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitreverse
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def rev8_before := [llvmfunc|
  llvm.func @rev8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(51 : i8) : i8
    %3 = llvm.mlir.constant(-52 : i8) : i8
    %4 = llvm.mlir.constant(1 : i8) : i8
    %5 = llvm.mlir.constant(85 : i8) : i8
    %6 = llvm.mlir.constant(-86 : i8) : i8
    %7 = llvm.lshr %arg0, %0  : i8
    %8 = llvm.shl %arg0, %0  : i8
    %9 = llvm.or %7, %8  : i8
    %10 = llvm.lshr %9, %1  : i8
    %11 = llvm.and %10, %2  : i8
    %12 = llvm.shl %9, %1  : i8
    %13 = llvm.and %12, %3  : i8
    %14 = llvm.or %11, %13  : i8
    %15 = llvm.lshr %14, %4  : i8
    %16 = llvm.and %15, %5  : i8
    %17 = llvm.shl %14, %4  : i8
    %18 = llvm.and %17, %6  : i8
    %19 = llvm.or %16, %18  : i8
    llvm.return %19 : i8
  }]

def rev16_before := [llvmfunc|
  llvm.func @rev16(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(3855 : i16) : i16
    %3 = llvm.mlir.constant(-3856 : i16) : i16
    %4 = llvm.mlir.constant(2 : i16) : i16
    %5 = llvm.mlir.constant(13107 : i16) : i16
    %6 = llvm.mlir.constant(-13108 : i16) : i16
    %7 = llvm.mlir.constant(1 : i16) : i16
    %8 = llvm.mlir.constant(21845 : i16) : i16
    %9 = llvm.mlir.constant(-21846 : i16) : i16
    %10 = llvm.lshr %arg0, %0  : i16
    %11 = llvm.shl %arg0, %0  : i16
    %12 = llvm.or %10, %11  : i16
    %13 = llvm.lshr %12, %1  : i16
    %14 = llvm.and %13, %2  : i16
    %15 = llvm.shl %12, %1  : i16
    %16 = llvm.and %15, %3  : i16
    %17 = llvm.or %14, %16  : i16
    %18 = llvm.lshr %17, %4  : i16
    %19 = llvm.and %18, %5  : i16
    %20 = llvm.shl %17, %4  : i16
    %21 = llvm.and %20, %6  : i16
    %22 = llvm.or %19, %21  : i16
    %23 = llvm.lshr %22, %7  : i16
    %24 = llvm.and %23, %8  : i16
    %25 = llvm.shl %22, %7  : i16
    %26 = llvm.and %25, %9  : i16
    %27 = llvm.or %24, %26  : i16
    llvm.return %27 : i16
  }]

def rev32_before := [llvmfunc|
  llvm.func @rev32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(16711935 : i32) : i32
    %3 = llvm.mlir.constant(-16711936 : i32) : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.constant(252645135 : i32) : i32
    %6 = llvm.mlir.constant(-252645136 : i32) : i32
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.mlir.constant(858993459 : i32) : i32
    %9 = llvm.mlir.constant(-858993460 : i32) : i32
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.mlir.constant(1431655765 : i32) : i32
    %12 = llvm.mlir.constant(-1431655766 : i32) : i32
    %13 = llvm.lshr %arg0, %0  : i32
    %14 = llvm.shl %arg0, %0  : i32
    %15 = llvm.or %13, %14  : i32
    %16 = llvm.lshr %15, %1  : i32
    %17 = llvm.and %16, %2  : i32
    %18 = llvm.shl %15, %1  : i32
    %19 = llvm.and %18, %3  : i32
    %20 = llvm.or %17, %19  : i32
    %21 = llvm.lshr %20, %4  : i32
    %22 = llvm.and %21, %5  : i32
    %23 = llvm.shl %20, %4  : i32
    %24 = llvm.and %23, %6  : i32
    %25 = llvm.or %22, %24  : i32
    %26 = llvm.lshr %25, %7  : i32
    %27 = llvm.and %26, %8  : i32
    %28 = llvm.shl %25, %7  : i32
    %29 = llvm.and %28, %9  : i32
    %30 = llvm.or %27, %29  : i32
    %31 = llvm.lshr %30, %10  : i32
    %32 = llvm.and %31, %11  : i32
    %33 = llvm.shl %30, %10  : i32
    %34 = llvm.and %33, %12  : i32
    %35 = llvm.or %32, %34  : i32
    llvm.return %35 : i32
  }]

def rev32_bswap_before := [llvmfunc|
  llvm.func @rev32_bswap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1431655765 : i32) : i32
    %2 = llvm.mlir.constant(-1431655766 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(858993459 : i32) : i32
    %5 = llvm.mlir.constant(-858993460 : i32) : i32
    %6 = llvm.mlir.constant(4 : i32) : i32
    %7 = llvm.mlir.constant(252645135 : i32) : i32
    %8 = llvm.mlir.constant(-252645136 : i32) : i32
    %9 = llvm.lshr %arg0, %0  : i32
    %10 = llvm.and %9, %1  : i32
    %11 = llvm.shl %arg0, %0  : i32
    %12 = llvm.and %11, %2  : i32
    %13 = llvm.or %10, %12  : i32
    %14 = llvm.lshr %13, %3  : i32
    %15 = llvm.and %14, %4  : i32
    %16 = llvm.shl %13, %3  : i32
    %17 = llvm.and %16, %5  : i32
    %18 = llvm.or %15, %17  : i32
    %19 = llvm.lshr %18, %6  : i32
    %20 = llvm.and %19, %7  : i32
    %21 = llvm.shl %18, %6  : i32
    %22 = llvm.and %21, %8  : i32
    %23 = llvm.or %20, %22  : i32
    %24 = llvm.intr.bswap(%23)  : (i32) -> i32
    llvm.return %24 : i32
  }]

def rev64_before := [llvmfunc|
  llvm.func @rev64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(281470681808895 : i64) : i64
    %3 = llvm.mlir.constant(-281470681808896 : i64) : i64
    %4 = llvm.mlir.constant(8 : i64) : i64
    %5 = llvm.mlir.constant(71777214294589695 : i64) : i64
    %6 = llvm.mlir.constant(-71777214294589696 : i64) : i64
    %7 = llvm.mlir.constant(4 : i64) : i64
    %8 = llvm.mlir.constant(1085102592571150095 : i64) : i64
    %9 = llvm.mlir.constant(-1085102592571150096 : i64) : i64
    %10 = llvm.mlir.constant(2 : i64) : i64
    %11 = llvm.mlir.constant(3689348814741910323 : i64) : i64
    %12 = llvm.mlir.constant(-3689348814741910324 : i64) : i64
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.mlir.constant(6148914691236517205 : i64) : i64
    %15 = llvm.mlir.constant(-6148914691236517206 : i64) : i64
    %16 = llvm.lshr %arg0, %0  : i64
    %17 = llvm.shl %arg0, %0  : i64
    %18 = llvm.or %16, %17  : i64
    %19 = llvm.lshr %18, %1  : i64
    %20 = llvm.and %19, %2  : i64
    %21 = llvm.shl %18, %1  : i64
    %22 = llvm.and %21, %3  : i64
    %23 = llvm.or %20, %22  : i64
    %24 = llvm.lshr %23, %4  : i64
    %25 = llvm.and %24, %5  : i64
    %26 = llvm.shl %23, %4  : i64
    %27 = llvm.and %26, %6  : i64
    %28 = llvm.or %25, %27  : i64
    %29 = llvm.lshr %28, %7  : i64
    %30 = llvm.and %29, %8  : i64
    %31 = llvm.shl %28, %7  : i64
    %32 = llvm.and %31, %9  : i64
    %33 = llvm.or %30, %32  : i64
    %34 = llvm.lshr %33, %10  : i64
    %35 = llvm.and %34, %11  : i64
    %36 = llvm.shl %33, %10  : i64
    %37 = llvm.and %36, %12  : i64
    %38 = llvm.or %35, %37  : i64
    %39 = llvm.lshr %38, %13  : i64
    %40 = llvm.and %39, %14  : i64
    %41 = llvm.shl %38, %13  : i64
    %42 = llvm.and %41, %15  : i64
    %43 = llvm.or %40, %42  : i64
    llvm.return %43 : i64
  }]

def rev8_xor_before := [llvmfunc|
  llvm.func @rev8_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(85 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.mlir.constant(102 : i8) : i8
    %4 = llvm.mlir.constant(4 : i8) : i8
    %5 = llvm.mlir.constant(5 : i8) : i8
    %6 = llvm.mlir.constant(1 : i8) : i8
    %7 = llvm.mlir.constant(7 : i8) : i8
    %8 = llvm.and %arg0, %0  : i8
    %9 = llvm.xor %arg0, %8  : i8
    %10 = llvm.shl %8, %1  : i8
    %11 = llvm.lshr %8, %2  : i8
    %12 = llvm.or %11, %9  : i8
    %13 = llvm.or %12, %10  : i8
    %14 = llvm.and %13, %3  : i8
    %15 = llvm.xor %13, %14  : i8
    %16 = llvm.lshr %14, %4  : i8
    %17 = llvm.or %16, %15  : i8
    %18 = llvm.shl %14, %5  : i8
    %19 = llvm.shl %17, %6  : i8
    %20 = llvm.or %18, %19  : i8
    %21 = llvm.lshr %arg0, %7  : i8
    %22 = llvm.or %20, %21  : i8
    llvm.return %22 : i8
  }]

def rev8_xor_vector_before := [llvmfunc|
  llvm.func @rev8_xor_vector(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<85> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<102> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %5 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %6 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %7 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.and %arg0, %0  : vector<2xi8>
    %9 = llvm.xor %arg0, %8  : vector<2xi8>
    %10 = llvm.shl %8, %1  : vector<2xi8>
    %11 = llvm.lshr %8, %2  : vector<2xi8>
    %12 = llvm.or %11, %9  : vector<2xi8>
    %13 = llvm.or %12, %10  : vector<2xi8>
    %14 = llvm.and %13, %3  : vector<2xi8>
    %15 = llvm.xor %13, %14  : vector<2xi8>
    %16 = llvm.lshr %14, %4  : vector<2xi8>
    %17 = llvm.or %16, %15  : vector<2xi8>
    %18 = llvm.shl %14, %5  : vector<2xi8>
    %19 = llvm.shl %17, %6  : vector<2xi8>
    %20 = llvm.or %18, %19  : vector<2xi8>
    %21 = llvm.lshr %arg0, %7  : vector<2xi8>
    %22 = llvm.or %20, %21  : vector<2xi8>
    llvm.return %22 : vector<2xi8>
  }]

def rev8_mul_and_urem_before := [llvmfunc|
  llvm.func @rev8_mul_and_urem(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8623620610 : i64) : i64
    %1 = llvm.mlir.constant(1136090292240 : i64) : i64
    %2 = llvm.mlir.constant(1023 : i64) : i64
    %3 = llvm.zext %arg0 : i8 to i64
    %4 = llvm.mul %3, %0 overflow<nsw, nuw>  : i64
    %5 = llvm.and %4, %1  : i64
    %6 = llvm.urem %5, %2  : i64
    %7 = llvm.trunc %6 : i64 to i8
    llvm.return %7 : i8
  }]

def rev8_mul_and_mul_before := [llvmfunc|
  llvm.func @rev8_mul_and_mul(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2149582850 : i64) : i64
    %1 = llvm.mlir.constant(36578664720 : i64) : i64
    %2 = llvm.mlir.constant(4311810305 : i64) : i64
    %3 = llvm.mlir.constant(32 : i64) : i64
    %4 = llvm.zext %arg0 : i8 to i64
    %5 = llvm.mul %4, %0 overflow<nsw, nuw>  : i64
    %6 = llvm.and %5, %1  : i64
    %7 = llvm.mul %6, %2  : i64
    %8 = llvm.lshr %7, %3  : i64
    %9 = llvm.trunc %8 : i64 to i8
    llvm.return %9 : i8
  }]

def rev8_mul_and_lshr_before := [llvmfunc|
  llvm.func @rev8_mul_and_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2050 : i64) : i64
    %1 = llvm.mlir.constant(139536 : i64) : i64
    %2 = llvm.mlir.constant(32800 : i64) : i64
    %3 = llvm.mlir.constant(558144 : i64) : i64
    %4 = llvm.mlir.constant(65793 : i64) : i64
    %5 = llvm.mlir.constant(16 : i64) : i64
    %6 = llvm.zext %arg0 : i8 to i64
    %7 = llvm.mul %6, %0 overflow<nsw, nuw>  : i64
    %8 = llvm.and %7, %1  : i64
    %9 = llvm.mul %6, %2 overflow<nsw, nuw>  : i64
    %10 = llvm.and %9, %3  : i64
    %11 = llvm.or %8, %10  : i64
    %12 = llvm.mul %11, %4 overflow<nsw, nuw>  : i64
    %13 = llvm.lshr %12, %5  : i64
    %14 = llvm.trunc %13 : i64 to i8
    llvm.return %14 : i8
  }]

def shuf_4bits_before := [llvmfunc|
  llvm.func @shuf_4bits(%arg0: vector<4xi1>) -> i4 {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi1> 
    %2 = llvm.bitcast %1 : vector<4xi1> to i4
    llvm.return %2 : i4
  }]

def shuf_load_4bits_before := [llvmfunc|
  llvm.func @shuf_load_4bits(%arg0: !llvm.ptr) -> i4 {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi1>]

    %2 = llvm.shufflevector %1, %0 [3, 2, 1, 0] : vector<4xi1> 
    %3 = llvm.bitcast %2 : vector<4xi1> to i4
    llvm.return %3 : i4
  }]

def shuf_bitcast_twice_4bits_before := [llvmfunc|
  llvm.func @shuf_bitcast_twice_4bits(%arg0: i4) -> i4 {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.bitcast %arg0 : i4 to vector<4xi1>
    %2 = llvm.shufflevector %1, %0 [-1, 2, 1, 0] : vector<4xi1> 
    %3 = llvm.bitcast %2 : vector<4xi1> to i4
    llvm.return %3 : i4
  }]

def shuf_4bits_not_reverse_before := [llvmfunc|
  llvm.func @shuf_4bits_not_reverse(%arg0: vector<4xi1>) -> i4 {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %0 [3, 1, 2, 0] : vector<4xi1> 
    %2 = llvm.bitcast %1 : vector<4xi1> to i4
    llvm.return %2 : i4
  }]

def shuf_4bits_extra_use_before := [llvmfunc|
  llvm.func @shuf_4bits_extra_use(%arg0: vector<4xi1>) -> i4 {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi1> 
    llvm.call @use(%1) : (vector<4xi1>) -> ()
    %2 = llvm.bitcast %1 : vector<4xi1> to i4
    llvm.return %2 : i4
  }]

def rev_i1_before := [llvmfunc|
  llvm.func @rev_i1(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    llvm.call @use_i32(%0) : (i32) -> ()
    %1 = llvm.intr.bitreverse(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

def rev_v2i1_before := [llvmfunc|
  llvm.func @rev_v2i1(%arg0: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %1 = llvm.intr.bitreverse(%0)  : (vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def rev_i2_before := [llvmfunc|
  llvm.func @rev_i2(%arg0: i2) -> i32 {
    %0 = llvm.zext %arg0 : i2 to i32
    %1 = llvm.intr.bitreverse(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

def PR59897_before := [llvmfunc|
  llvm.func @PR59897(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.zext %arg0 : i1 to i32
    %3 = llvm.intr.bitreverse(%2)  : (i32) -> i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.lshr %4, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    llvm.return %6 : i64
  }]

def rev_xor_lhs_rev16_before := [llvmfunc|
  llvm.func @rev_xor_lhs_rev16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i16) -> i16
    %1 = llvm.xor %0, %arg1  : i16
    %2 = llvm.intr.bitreverse(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }]

def rev_and_rhs_rev32_before := [llvmfunc|
  llvm.func @rev_and_rhs_rev32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg1)  : (i32) -> i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.bitreverse(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def rev_or_rhs_rev32_before := [llvmfunc|
  llvm.func @rev_or_rhs_rev32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg1)  : (i32) -> i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.intr.bitreverse(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def rev_or_rhs_rev64_before := [llvmfunc|
  llvm.func @rev_or_rhs_rev64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg1)  : (i64) -> i64
    %1 = llvm.or %arg0, %0  : i64
    %2 = llvm.intr.bitreverse(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def rev_xor_rhs_rev64_before := [llvmfunc|
  llvm.func @rev_xor_rhs_rev64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg1)  : (i64) -> i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.intr.bitreverse(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def rev_xor_rhs_i32vec_before := [llvmfunc|
  llvm.func @rev_xor_rhs_i32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bitreverse(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bitreverse(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def rev_and_rhs_rev64_multiuse1_before := [llvmfunc|
  llvm.func @rev_and_rhs_rev64_multiuse1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg1)  : (i64) -> i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bitreverse(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }]

def rev_and_rhs_rev64_multiuse2_before := [llvmfunc|
  llvm.func @rev_and_rhs_rev64_multiuse2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg1)  : (i64) -> i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bitreverse(%1)  : (i64) -> i64
    %3 = llvm.mul %0, %2  : i64
    llvm.return %3 : i64
  }]

def rev_all_operand64_before := [llvmfunc|
  llvm.func @rev_all_operand64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bitreverse(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.intr.bitreverse(%2)  : (i64) -> i64
    llvm.return %3 : i64
  }]

def rev_all_operand64_multiuse_both_before := [llvmfunc|
  llvm.func @rev_all_operand64_multiuse_both(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bitreverse(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.intr.bitreverse(%2)  : (i64) -> i64
    llvm.call @use_i64(%0) : (i64) -> ()
    llvm.call @use_i64(%1) : (i64) -> ()
    llvm.return %3 : i64
  }]

def rev8_combined := [llvmfunc|
  llvm.func @rev8(%arg0: i8) -> i8 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_rev8   : rev8_before  ⊑  rev8_combined := by
  unfold rev8_before rev8_combined
  simp_alive_peephole
  sorry
def rev16_combined := [llvmfunc|
  llvm.func @rev16(%arg0: i16) -> i16 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_rev16   : rev16_before  ⊑  rev16_combined := by
  unfold rev16_before rev16_combined
  simp_alive_peephole
  sorry
def rev32_combined := [llvmfunc|
  llvm.func @rev32(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_rev32   : rev32_before  ⊑  rev32_combined := by
  unfold rev32_before rev32_combined
  simp_alive_peephole
  sorry
def rev32_bswap_combined := [llvmfunc|
  llvm.func @rev32_bswap(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_rev32_bswap   : rev32_bswap_before  ⊑  rev32_bswap_combined := by
  unfold rev32_bswap_before rev32_bswap_combined
  simp_alive_peephole
  sorry
def rev64_combined := [llvmfunc|
  llvm.func @rev64(%arg0: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_rev64   : rev64_before  ⊑  rev64_combined := by
  unfold rev64_before rev64_combined
  simp_alive_peephole
  sorry
def rev8_xor_combined := [llvmfunc|
  llvm.func @rev8_xor(%arg0: i8) -> i8 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_rev8_xor   : rev8_xor_before  ⊑  rev8_xor_combined := by
  unfold rev8_xor_before rev8_xor_combined
  simp_alive_peephole
  sorry
def rev8_xor_vector_combined := [llvmfunc|
  llvm.func @rev8_xor_vector(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.bitreverse(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_rev8_xor_vector   : rev8_xor_vector_before  ⊑  rev8_xor_vector_combined := by
  unfold rev8_xor_vector_before rev8_xor_vector_combined
  simp_alive_peephole
  sorry
def rev8_mul_and_urem_combined := [llvmfunc|
  llvm.func @rev8_mul_and_urem(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8623620610 : i64) : i64
    %1 = llvm.mlir.constant(1136090292240 : i64) : i64
    %2 = llvm.mlir.constant(1023 : i64) : i64
    %3 = llvm.zext %arg0 : i8 to i64
    %4 = llvm.mul %3, %0 overflow<nsw, nuw>  : i64
    %5 = llvm.and %4, %1  : i64
    %6 = llvm.urem %5, %2  : i64
    %7 = llvm.trunc %6 : i64 to i8
    llvm.return %7 : i8
  }]

theorem inst_combine_rev8_mul_and_urem   : rev8_mul_and_urem_before  ⊑  rev8_mul_and_urem_combined := by
  unfold rev8_mul_and_urem_before rev8_mul_and_urem_combined
  simp_alive_peephole
  sorry
def rev8_mul_and_mul_combined := [llvmfunc|
  llvm.func @rev8_mul_and_mul(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2149582850 : i64) : i64
    %1 = llvm.mlir.constant(36578664720 : i64) : i64
    %2 = llvm.mlir.constant(4311810305 : i64) : i64
    %3 = llvm.mlir.constant(32 : i64) : i64
    %4 = llvm.zext %arg0 : i8 to i64
    %5 = llvm.mul %4, %0 overflow<nsw, nuw>  : i64
    %6 = llvm.and %5, %1  : i64
    %7 = llvm.mul %6, %2  : i64
    %8 = llvm.lshr %7, %3  : i64
    %9 = llvm.trunc %8 : i64 to i8
    llvm.return %9 : i8
  }]

theorem inst_combine_rev8_mul_and_mul   : rev8_mul_and_mul_before  ⊑  rev8_mul_and_mul_combined := by
  unfold rev8_mul_and_mul_before rev8_mul_and_mul_combined
  simp_alive_peephole
  sorry
def rev8_mul_and_lshr_combined := [llvmfunc|
  llvm.func @rev8_mul_and_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2050 : i64) : i64
    %1 = llvm.mlir.constant(139536 : i64) : i64
    %2 = llvm.mlir.constant(32800 : i64) : i64
    %3 = llvm.mlir.constant(558144 : i64) : i64
    %4 = llvm.mlir.constant(65793 : i64) : i64
    %5 = llvm.mlir.constant(16 : i64) : i64
    %6 = llvm.zext %arg0 : i8 to i64
    %7 = llvm.mul %6, %0 overflow<nsw, nuw>  : i64
    %8 = llvm.and %7, %1  : i64
    %9 = llvm.mul %6, %2 overflow<nsw, nuw>  : i64
    %10 = llvm.and %9, %3  : i64
    %11 = llvm.or %8, %10  : i64
    %12 = llvm.mul %11, %4 overflow<nsw, nuw>  : i64
    %13 = llvm.lshr %12, %5  : i64
    %14 = llvm.trunc %13 : i64 to i8
    llvm.return %14 : i8
  }]

theorem inst_combine_rev8_mul_and_lshr   : rev8_mul_and_lshr_before  ⊑  rev8_mul_and_lshr_combined := by
  unfold rev8_mul_and_lshr_before rev8_mul_and_lshr_combined
  simp_alive_peephole
  sorry
def shuf_4bits_combined := [llvmfunc|
  llvm.func @shuf_4bits(%arg0: vector<4xi1>) -> i4 {
    %0 = llvm.bitcast %arg0 : vector<4xi1> to i4
    %1 = llvm.intr.bitreverse(%0)  : (i4) -> i4
    llvm.return %1 : i4
  }]

theorem inst_combine_shuf_4bits   : shuf_4bits_before  ⊑  shuf_4bits_combined := by
  unfold shuf_4bits_before shuf_4bits_combined
  simp_alive_peephole
  sorry
def shuf_load_4bits_combined := [llvmfunc|
  llvm.func @shuf_load_4bits(%arg0: !llvm.ptr) -> i4 {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i4
    %1 = llvm.intr.bitreverse(%0)  : (i4) -> i4
    llvm.return %1 : i4
  }]

theorem inst_combine_shuf_load_4bits   : shuf_load_4bits_before  ⊑  shuf_load_4bits_combined := by
  unfold shuf_load_4bits_before shuf_load_4bits_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_twice_4bits_combined := [llvmfunc|
  llvm.func @shuf_bitcast_twice_4bits(%arg0: i4) -> i4 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i4) -> i4
    llvm.return %0 : i4
  }]

theorem inst_combine_shuf_bitcast_twice_4bits   : shuf_bitcast_twice_4bits_before  ⊑  shuf_bitcast_twice_4bits_combined := by
  unfold shuf_bitcast_twice_4bits_before shuf_bitcast_twice_4bits_combined
  simp_alive_peephole
  sorry
def shuf_4bits_not_reverse_combined := [llvmfunc|
  llvm.func @shuf_4bits_not_reverse(%arg0: vector<4xi1>) -> i4 {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %0 [3, 1, 2, 0] : vector<4xi1> 
    %2 = llvm.bitcast %1 : vector<4xi1> to i4
    llvm.return %2 : i4
  }]

theorem inst_combine_shuf_4bits_not_reverse   : shuf_4bits_not_reverse_before  ⊑  shuf_4bits_not_reverse_combined := by
  unfold shuf_4bits_not_reverse_before shuf_4bits_not_reverse_combined
  simp_alive_peephole
  sorry
def shuf_4bits_extra_use_combined := [llvmfunc|
  llvm.func @shuf_4bits_extra_use(%arg0: vector<4xi1>) -> i4 {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi1> 
    llvm.call @use(%1) : (vector<4xi1>) -> ()
    %2 = llvm.bitcast %1 : vector<4xi1> to i4
    llvm.return %2 : i4
  }]

theorem inst_combine_shuf_4bits_extra_use   : shuf_4bits_extra_use_before  ⊑  shuf_4bits_extra_use_combined := by
  unfold shuf_4bits_extra_use_before shuf_4bits_extra_use_combined
  simp_alive_peephole
  sorry
def rev_i1_combined := [llvmfunc|
  llvm.func @rev_i1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.zext %arg0 : i1 to i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_rev_i1   : rev_i1_before  ⊑  rev_i1_combined := by
  unfold rev_i1_before rev_i1_combined
  simp_alive_peephole
  sorry
def rev_v2i1_combined := [llvmfunc|
  llvm.func @rev_v2i1(%arg0: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_rev_v2i1   : rev_v2i1_before  ⊑  rev_v2i1_combined := by
  unfold rev_v2i1_before rev_v2i1_combined
  simp_alive_peephole
  sorry
def rev_i2_combined := [llvmfunc|
  llvm.func @rev_i2(%arg0: i2) -> i32 {
    %0 = llvm.zext %arg0 : i2 to i32
    %1 = llvm.intr.bitreverse(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rev_i2   : rev_i2_before  ⊑  rev_i2_combined := by
  unfold rev_i2_before rev_i2_combined
  simp_alive_peephole
  sorry
def PR59897_combined := [llvmfunc|
  llvm.func @PR59897(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.zext %1 : i1 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_PR59897   : PR59897_before  ⊑  PR59897_combined := by
  unfold PR59897_before PR59897_combined
  simp_alive_peephole
  sorry
def rev_xor_lhs_rev16_combined := [llvmfunc|
  llvm.func @rev_xor_lhs_rev16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bitreverse(%arg1)  : (i16) -> i16
    %1 = llvm.xor %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_rev_xor_lhs_rev16   : rev_xor_lhs_rev16_before  ⊑  rev_xor_lhs_rev16_combined := by
  unfold rev_xor_lhs_rev16_before rev_xor_lhs_rev16_combined
  simp_alive_peephole
  sorry
def rev_and_rhs_rev32_combined := [llvmfunc|
  llvm.func @rev_and_rhs_rev32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = llvm.and %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rev_and_rhs_rev32   : rev_and_rhs_rev32_before  ⊑  rev_and_rhs_rev32_combined := by
  unfold rev_and_rhs_rev32_before rev_and_rhs_rev32_combined
  simp_alive_peephole
  sorry
def rev_or_rhs_rev32_combined := [llvmfunc|
  llvm.func @rev_or_rhs_rev32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = llvm.or %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rev_or_rhs_rev32   : rev_or_rhs_rev32_before  ⊑  rev_or_rhs_rev32_combined := by
  unfold rev_or_rhs_rev32_before rev_or_rhs_rev32_combined
  simp_alive_peephole
  sorry
def rev_or_rhs_rev64_combined := [llvmfunc|
  llvm.func @rev_or_rhs_rev64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i64) -> i64
    %1 = llvm.or %0, %arg1  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_rev_or_rhs_rev64   : rev_or_rhs_rev64_before  ⊑  rev_or_rhs_rev64_combined := by
  unfold rev_or_rhs_rev64_before rev_or_rhs_rev64_combined
  simp_alive_peephole
  sorry
def rev_xor_rhs_rev64_combined := [llvmfunc|
  llvm.func @rev_xor_rhs_rev64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i64) -> i64
    %1 = llvm.xor %0, %arg1  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_rev_xor_rhs_rev64   : rev_xor_rhs_rev64_before  ⊑  rev_xor_rhs_rev64_combined := by
  unfold rev_xor_rhs_rev64_before rev_xor_rhs_rev64_combined
  simp_alive_peephole
  sorry
def rev_xor_rhs_i32vec_combined := [llvmfunc|
  llvm.func @rev_xor_rhs_i32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bitreverse(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.xor %0, %arg1  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_rev_xor_rhs_i32vec   : rev_xor_rhs_i32vec_before  ⊑  rev_xor_rhs_i32vec_combined := by
  unfold rev_xor_rhs_i32vec_before rev_xor_rhs_i32vec_combined
  simp_alive_peephole
  sorry
def rev_and_rhs_rev64_multiuse1_combined := [llvmfunc|
  llvm.func @rev_and_rhs_rev64_multiuse1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg1)  : (i64) -> i64
    %1 = llvm.and %0, %arg0  : i64
    %2 = llvm.intr.bitreverse(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_rev_and_rhs_rev64_multiuse1   : rev_and_rhs_rev64_multiuse1_before  ⊑  rev_and_rhs_rev64_multiuse1_combined := by
  unfold rev_and_rhs_rev64_multiuse1_before rev_and_rhs_rev64_multiuse1_combined
  simp_alive_peephole
  sorry
def rev_and_rhs_rev64_multiuse2_combined := [llvmfunc|
  llvm.func @rev_and_rhs_rev64_multiuse2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg1)  : (i64) -> i64
    %1 = llvm.and %0, %arg0  : i64
    %2 = llvm.intr.bitreverse(%1)  : (i64) -> i64
    %3 = llvm.mul %0, %2  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_rev_and_rhs_rev64_multiuse2   : rev_and_rhs_rev64_multiuse2_before  ⊑  rev_and_rhs_rev64_multiuse2_combined := by
  unfold rev_and_rhs_rev64_multiuse2_before rev_and_rhs_rev64_multiuse2_combined
  simp_alive_peephole
  sorry
def rev_all_operand64_combined := [llvmfunc|
  llvm.func @rev_all_operand64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1  : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_rev_all_operand64   : rev_all_operand64_before  ⊑  rev_all_operand64_combined := by
  unfold rev_all_operand64_before rev_all_operand64_combined
  simp_alive_peephole
  sorry
def rev_all_operand64_multiuse_both_combined := [llvmfunc|
  llvm.func @rev_all_operand64_multiuse_both(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bitreverse(%arg1)  : (i64) -> i64
    %2 = llvm.and %arg0, %arg1  : i64
    llvm.call @use_i64(%0) : (i64) -> ()
    llvm.call @use_i64(%1) : (i64) -> ()
    llvm.return %2 : i64
  }]

theorem inst_combine_rev_all_operand64_multiuse_both   : rev_all_operand64_multiuse_both_before  ⊑  rev_all_operand64_multiuse_both_combined := by
  unfold rev_all_operand64_multiuse_both_before rev_all_operand64_multiuse_both_combined
  simp_alive_peephole
  sorry
