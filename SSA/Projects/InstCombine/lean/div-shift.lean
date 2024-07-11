import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  div-shift
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i16 {llvm.zeroext}, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.sdiv %1, %2  : i32
    llvm.return %3 : i32
  }]

def t1vec_before := [llvmfunc|
  llvm.func @t1vec(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.shl %0, %arg1  : vector<2xi32>
    %3 = llvm.sdiv %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.udiv %arg0, %2  : i64
    llvm.return %3 : i64
  }]

def t3_before := [llvmfunc|
  llvm.func @t3(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.udiv %arg0, %2  : i64
    llvm.return %3 : i64
  }]

def t4_before := [llvmfunc|
  llvm.func @t4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.udiv %arg0, %4  : i32
    llvm.return %5 : i32
  }]

def t5_before := [llvmfunc|
  llvm.func @t5(%arg0: i1, %arg1: i1, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(64 : i32) : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.select %arg0, %1, %2 : i1, i32
    %5 = llvm.select %arg1, %4, %3 : i1, i32
    %6 = llvm.udiv %arg2, %5  : i32
    llvm.return %6 : i32
  }]

def t6_before := [llvmfunc|
  llvm.func @t6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    %4 = llvm.udiv %arg1, %3  : i32
    llvm.return %4 : i32
  }]

def udiv_umin_before := [llvmfunc|
  llvm.func @udiv_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def udiv_umax_before := [llvmfunc|
  llvm.func @udiv_umax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.intr.umax(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def udiv_umin__before := [llvmfunc|
  llvm.func @udiv_umin_(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.intr.umin(%1, %arg2)  : (i8, i8) -> i8
    %3 = llvm.udiv %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def udiv_umin_extra_use_before := [llvmfunc|
  llvm.func @udiv_umin_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def udiv_smin_before := [llvmfunc|
  llvm.func @udiv_smin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def udiv_smax_before := [llvmfunc|
  llvm.func @udiv_smax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def t7_before := [llvmfunc|
  llvm.func @t7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    %2 = llvm.sdiv %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def t8_before := [llvmfunc|
  llvm.func @t8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.sdiv %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def t9_before := [llvmfunc|
  llvm.func @t9(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : vector<2xi32>
    %2 = llvm.sdiv %1, %arg0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def t10_before := [llvmfunc|
  llvm.func @t10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.sdiv %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def t11_before := [llvmfunc|
  llvm.func @t11(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %1 = llvm.sdiv %0, %arg0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def t12_before := [llvmfunc|
  llvm.func @t12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.udiv %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def t13_before := [llvmfunc|
  llvm.func @t13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.udiv %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def t14_before := [llvmfunc|
  llvm.func @t14(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : vector<2xi32>
    %2 = llvm.udiv %1, %arg0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def t15_before := [llvmfunc|
  llvm.func @t15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.udiv %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def t16_before := [llvmfunc|
  llvm.func @t16(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : vector<2xi32>
    %1 = llvm.udiv %0, %arg0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def sdiv_mul_shl_nsw_before := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def sdiv_mul_shl_nsw_exact_commute1_before := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw_exact_commute1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg1, %arg0 overflow<nsw>  : i5
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def sdiv_mul_shl_nsw_commute2_before := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw_commute2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg1, %arg0 overflow<nsw>  : i5
    %1 = llvm.shl %arg2, %arg0 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def sdiv_mul_shl_nsw_use1_before := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def sdiv_mul_shl_nsw_use2_before := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def sdiv_mul_shl_nsw_use3_before := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def sdiv_shl_mul_nsw_before := [llvmfunc|
  llvm.func @sdiv_shl_mul_nsw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg2, %arg0 overflow<nsw>  : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def sdiv_mul_shl_missing_nsw1_before := [llvmfunc|
  llvm.func @sdiv_mul_shl_missing_nsw1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def sdiv_mul_shl_missing_nsw2_before := [llvmfunc|
  llvm.func @sdiv_mul_shl_missing_nsw2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def udiv_mul_shl_nuw_before := [llvmfunc|
  llvm.func @udiv_mul_shl_nuw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def udiv_mul_shl_nuw_exact_commute1_before := [llvmfunc|
  llvm.func @udiv_mul_shl_nuw_exact_commute1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg1, %arg0 overflow<nuw>  : i5
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def udiv_mul_shl_nuw_commute2_before := [llvmfunc|
  llvm.func @udiv_mul_shl_nuw_commute2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %1 = llvm.shl %arg2, %arg0 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def udiv_mul_shl_nsw_use1_before := [llvmfunc|
  llvm.func @udiv_mul_shl_nsw_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def udiv_mul_shl_nsw_use2_before := [llvmfunc|
  llvm.func @udiv_mul_shl_nsw_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def udiv_mul_shl_nsw_use3_before := [llvmfunc|
  llvm.func @udiv_mul_shl_nsw_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def udiv_shl_mul_nuw_before := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def udiv_shl_mul_nuw_swap_before := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_swap(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def udiv_shl_mul_nuw_exact_before := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_exact(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def udiv_shl_mul_nuw_vec_before := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_vec(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : vector<2xi4>
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : vector<2xi4>
    %2 = llvm.udiv %0, %1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

def udiv_shl_mul_nuw_extra_use_of_shl_before := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_extra_use_of_shl(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def udiv_shl_mul_nuw_extra_use_of_mul_before := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_extra_use_of_mul(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def udiv_shl_mul_nuw_extra_use_before := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def sdiv_shl_mul_nuw_before := [llvmfunc|
  llvm.func @sdiv_shl_mul_nuw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def udiv_mul_shl_missing_nsw1_before := [llvmfunc|
  llvm.func @udiv_mul_shl_missing_nsw1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def udiv_mul_shl_missing_nsw2_before := [llvmfunc|
  llvm.func @udiv_mul_shl_missing_nsw2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }]

def udiv_shl_nuw_before := [llvmfunc|
  llvm.func @udiv_shl_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def udiv_shl_nuw_exact_before := [llvmfunc|
  llvm.func @udiv_shl_nuw_exact(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : vector<2xi4>
    %1 = llvm.udiv %arg0, %0  : vector<2xi4>
    llvm.return %1 : vector<2xi4>
  }]

def udiv_shl_before := [llvmfunc|
  llvm.func @udiv_shl(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2  : i8
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def udiv_shl_nuw_use_before := [llvmfunc|
  llvm.func @udiv_shl_nuw_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def udiv_lshr_mul_nuw_before := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }]

def udiv_lshr_mul_nuw_exact_commute1_before := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw_exact_commute1(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mul %arg1, %arg0 overflow<nuw>  : vector<2xi4>
    %1 = llvm.lshr %0, %arg2  : vector<2xi4>
    %2 = llvm.udiv %1, %arg0  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

def udiv_lshr_mul_nuw_commute2_before := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg1, %arg0 overflow<nuw>  : i8
    %1 = llvm.lshr %arg2, %0  : i8
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }]

def udiv_lshr_mul_nuw_use1_before := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.lshr %0, %arg2  : i8
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }]

def udiv_lshr_mul_nuw_use2_before := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }]

def udiv_lshr_mul_nuw_use3_before := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.lshr %0, %arg2  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }]

def udiv_lshr_mul_nsw_before := [llvmfunc|
  llvm.func @udiv_lshr_mul_nsw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }]

def sdiv_lshr_mul_nsw_before := [llvmfunc|
  llvm.func @sdiv_lshr_mul_nsw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    %2 = llvm.sdiv %1, %arg0  : i8
    llvm.return %2 : i8
  }]

def sdiv_shl_shl_nsw2_nuw_before := [llvmfunc|
  llvm.func @sdiv_shl_shl_nsw2_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def sdiv_shl_shl_nsw2_nuw_exact_use_before := [llvmfunc|
  llvm.func @sdiv_shl_shl_nsw2_nuw_exact_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def sdiv_shl_shl_nsw_nuw2_before := [llvmfunc|
  llvm.func @sdiv_shl_shl_nsw_nuw2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def sdiv_shl_shl_nsw_nuw_before := [llvmfunc|
  llvm.func @sdiv_shl_shl_nsw_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def sdiv_shl_shl_nuw_nsw2_before := [llvmfunc|
  llvm.func @sdiv_shl_shl_nuw_nsw2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def udiv_shl_shl_nuw2_before := [llvmfunc|
  llvm.func @udiv_shl_shl_nuw2(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : vector<2xi8>
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : vector<2xi8>
    %2 = llvm.udiv %0, %1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def udiv_shl_shl_nuw2_exact_use2_before := [llvmfunc|
  llvm.func @udiv_shl_shl_nuw2_exact_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def udiv_shl_shl_nuw_nsw_before := [llvmfunc|
  llvm.func @udiv_shl_shl_nuw_nsw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def udiv_shl_shl_nsw_nuw_before := [llvmfunc|
  llvm.func @udiv_shl_shl_nsw_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def udiv_shl_shl_nuw_nsw2_before := [llvmfunc|
  llvm.func @udiv_shl_shl_nuw_nsw2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

def udiv_shl_nuw_divisor_before := [llvmfunc|
  llvm.func @udiv_shl_nuw_divisor(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def udiv_fail_shl_overflow_before := [llvmfunc|
  llvm.func @udiv_fail_shl_overflow(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def udiv_shl_no_overflow_before := [llvmfunc|
  llvm.func @udiv_shl_no_overflow(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def sdiv_shl_pair_const_before := [llvmfunc|
  llvm.func @sdiv_shl_pair_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.shl %arg0, %1 overflow<nsw>  : i32
    %4 = llvm.sdiv %2, %3  : i32
    llvm.return %4 : i32
  }]

def udiv_shl_pair_const_before := [llvmfunc|
  llvm.func @udiv_shl_pair_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.shl %arg0, %1 overflow<nuw>  : i32
    %4 = llvm.udiv %2, %3  : i32
    llvm.return %4 : i32
  }]

def sdiv_shl_pair1_before := [llvmfunc|
  llvm.func @sdiv_shl_pair1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def sdiv_shl_pair2_before := [llvmfunc|
  llvm.func @sdiv_shl_pair2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def sdiv_shl_pair3_before := [llvmfunc|
  llvm.func @sdiv_shl_pair3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def sdiv_shl_no_pair_fail_before := [llvmfunc|
  llvm.func @sdiv_shl_no_pair_fail(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg1, %arg3 overflow<nuw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def udiv_shl_pair1_before := [llvmfunc|
  llvm.func @udiv_shl_pair1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def udiv_shl_pair2_before := [llvmfunc|
  llvm.func @udiv_shl_pair2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def udiv_shl_pair3_before := [llvmfunc|
  llvm.func @udiv_shl_pair3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def sdiv_shl_pair_overflow_fail1_before := [llvmfunc|
  llvm.func @sdiv_shl_pair_overflow_fail1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def sdiv_shl_pair_overflow_fail2_before := [llvmfunc|
  llvm.func @sdiv_shl_pair_overflow_fail2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def udiv_shl_pair_overflow_fail1_before := [llvmfunc|
  llvm.func @udiv_shl_pair_overflow_fail1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def udiv_shl_pair_overflow_fail2_before := [llvmfunc|
  llvm.func @udiv_shl_pair_overflow_fail2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def udiv_shl_pair_overflow_fail3_before := [llvmfunc|
  llvm.func @udiv_shl_pair_overflow_fail3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg0, %arg2  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def sdiv_shl_pair_multiuse1_before := [llvmfunc|
  llvm.func @sdiv_shl_pair_multiuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def sdiv_shl_pair_multiuse2_before := [llvmfunc|
  llvm.func @sdiv_shl_pair_multiuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def sdiv_shl_pair_multiuse3_before := [llvmfunc|
  llvm.func @sdiv_shl_pair_multiuse3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def pr69291_before := [llvmfunc|
  llvm.func @pr69291() -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i32]

    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : i32
    %4 = llvm.shl %2, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.sdiv %3, %4  : i32
    llvm.return %5 : i32
  }]

def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i16 {llvm.zeroext}, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.add %arg1, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t1vec_combined := [llvmfunc|
  llvm.func @t1vec(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.add %arg1, %0  : vector<2xi32>
    %3 = llvm.lshr %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_t1vec   : t1vec_before  ⊑  t1vec_combined := by
  unfold t1vec_before t1vec_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.lshr %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t3_combined := [llvmfunc|
  llvm.func @t3(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.add %arg1, %0  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.lshr %arg0, %2  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_t3   : t3_before  ⊑  t3_combined := by
  unfold t3_before t3_combined
  simp_alive_peephole
  sorry
def t4_combined := [llvmfunc|
  llvm.func @t4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.umax(%arg1, %0)  : (i32, i32) -> i32
    %2 = llvm.lshr %arg0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t4   : t4_before  ⊑  t4_combined := by
  unfold t4_before t4_combined
  simp_alive_peephole
  sorry
def t5_combined := [llvmfunc|
  llvm.func @t5(%arg0: i1, %arg1: i1, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.select %arg1, %2, %arg2 : i1, i32
    %4 = llvm.lshr %arg2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t5   : t5_before  ⊑  t5_combined := by
  unfold t5_before t5_combined
  simp_alive_peephole
  sorry
def t6_combined := [llvmfunc|
  llvm.func @t6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.udiv %arg1, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t6   : t6_before  ⊑  t6_combined := by
  unfold t6_before t6_combined
  simp_alive_peephole
  sorry
def udiv_umin_combined := [llvmfunc|
  llvm.func @udiv_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_udiv_umin   : udiv_umin_before  ⊑  udiv_umin_combined := by
  unfold udiv_umin_before udiv_umin_combined
  simp_alive_peephole
  sorry
def udiv_umax_combined := [llvmfunc|
  llvm.func @udiv_umax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.umax(%arg1, %arg2)  : (i8, i8) -> i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_udiv_umax   : udiv_umax_before  ⊑  udiv_umax_combined := by
  unfold udiv_umax_before udiv_umax_combined
  simp_alive_peephole
  sorry
def udiv_umin__combined := [llvmfunc|
  llvm.func @udiv_umin_(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %2 = llvm.intr.umin(%1, %arg2)  : (i8, i8) -> i8
    %3 = llvm.udiv %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_udiv_umin_   : udiv_umin__before  ⊑  udiv_umin__combined := by
  unfold udiv_umin__before udiv_umin__combined
  simp_alive_peephole
  sorry
def udiv_umin_extra_use_combined := [llvmfunc|
  llvm.func @udiv_umin_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_udiv_umin_extra_use   : udiv_umin_extra_use_before  ⊑  udiv_umin_extra_use_combined := by
  unfold udiv_umin_extra_use_before udiv_umin_extra_use_combined
  simp_alive_peephole
  sorry
def udiv_smin_combined := [llvmfunc|
  llvm.func @udiv_smin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i8
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_udiv_smin   : udiv_smin_before  ⊑  udiv_smin_combined := by
  unfold udiv_smin_before udiv_smin_combined
  simp_alive_peephole
  sorry
def udiv_smax_combined := [llvmfunc|
  llvm.func @udiv_smax(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i8
    %3 = llvm.intr.smax(%1, %2)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_udiv_smax   : udiv_smax_before  ⊑  udiv_smax_combined := by
  unfold udiv_smax_before udiv_smax_combined
  simp_alive_peephole
  sorry
def t7_combined := [llvmfunc|
  llvm.func @t7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_t7   : t7_before  ⊑  t7_combined := by
  unfold t7_before t7_combined
  simp_alive_peephole
  sorry
def t8_combined := [llvmfunc|
  llvm.func @t8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.sdiv %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t8   : t8_before  ⊑  t8_combined := by
  unfold t8_before t8_combined
  simp_alive_peephole
  sorry
def t9_combined := [llvmfunc|
  llvm.func @t9(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[4, 8]> : vector<2xi32>) : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_t9   : t9_before  ⊑  t9_combined := by
  unfold t9_before t9_combined
  simp_alive_peephole
  sorry
def t10_combined := [llvmfunc|
  llvm.func @t10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t10   : t10_before  ⊑  t10_combined := by
  unfold t10_before t10_combined
  simp_alive_peephole
  sorry
def t11_combined := [llvmfunc|
  llvm.func @t11(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_t11   : t11_before  ⊑  t11_combined := by
  unfold t11_before t11_combined
  simp_alive_peephole
  sorry
def t12_combined := [llvmfunc|
  llvm.func @t12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_t12   : t12_before  ⊑  t12_combined := by
  unfold t12_before t12_combined
  simp_alive_peephole
  sorry
def t13_combined := [llvmfunc|
  llvm.func @t13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.udiv %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t13   : t13_before  ⊑  t13_combined := by
  unfold t13_before t13_combined
  simp_alive_peephole
  sorry
def t14_combined := [llvmfunc|
  llvm.func @t14(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[4, 8]> : vector<2xi32>) : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_t14   : t14_before  ⊑  t14_combined := by
  unfold t14_before t14_combined
  simp_alive_peephole
  sorry
def t15_combined := [llvmfunc|
  llvm.func @t15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t15   : t15_before  ⊑  t15_combined := by
  unfold t15_before t15_combined
  simp_alive_peephole
  sorry
def t16_combined := [llvmfunc|
  llvm.func @t16(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_t16   : t16_before  ⊑  t16_combined := by
  unfold t16_before t16_combined
  simp_alive_peephole
  sorry
def sdiv_mul_shl_nsw_combined := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.shl %0, %arg2 overflow<nuw>  : i5
    %2 = llvm.sdiv %arg1, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_sdiv_mul_shl_nsw   : sdiv_mul_shl_nsw_before  ⊑  sdiv_mul_shl_nsw_combined := by
  unfold sdiv_mul_shl_nsw_before sdiv_mul_shl_nsw_combined
  simp_alive_peephole
  sorry
def sdiv_mul_shl_nsw_exact_commute1_combined := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw_exact_commute1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.shl %0, %arg2 overflow<nuw>  : i5
    %2 = llvm.sdiv %arg1, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_sdiv_mul_shl_nsw_exact_commute1   : sdiv_mul_shl_nsw_exact_commute1_before  ⊑  sdiv_mul_shl_nsw_exact_commute1_combined := by
  unfold sdiv_mul_shl_nsw_exact_commute1_before sdiv_mul_shl_nsw_exact_commute1_combined
  simp_alive_peephole
  sorry
def sdiv_mul_shl_nsw_commute2_combined := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw_commute2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg1, %arg0 overflow<nsw>  : i5
    %1 = llvm.shl %arg2, %arg0 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_sdiv_mul_shl_nsw_commute2   : sdiv_mul_shl_nsw_commute2_before  ⊑  sdiv_mul_shl_nsw_commute2_combined := by
  unfold sdiv_mul_shl_nsw_commute2_before sdiv_mul_shl_nsw_commute2_combined
  simp_alive_peephole
  sorry
def sdiv_mul_shl_nsw_use1_combined := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i8
    %3 = llvm.sdiv %arg1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_sdiv_mul_shl_nsw_use1   : sdiv_mul_shl_nsw_use1_before  ⊑  sdiv_mul_shl_nsw_use1_combined := by
  unfold sdiv_mul_shl_nsw_use1_before sdiv_mul_shl_nsw_use1_combined
  simp_alive_peephole
  sorry
def sdiv_mul_shl_nsw_use2_combined := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i8
    %3 = llvm.sdiv %arg1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_sdiv_mul_shl_nsw_use2   : sdiv_mul_shl_nsw_use2_before  ⊑  sdiv_mul_shl_nsw_use2_combined := by
  unfold sdiv_mul_shl_nsw_use2_before sdiv_mul_shl_nsw_use2_combined
  simp_alive_peephole
  sorry
def sdiv_mul_shl_nsw_use3_combined := [llvmfunc|
  llvm.func @sdiv_mul_shl_nsw_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sdiv_mul_shl_nsw_use3   : sdiv_mul_shl_nsw_use3_before  ⊑  sdiv_mul_shl_nsw_use3_combined := by
  unfold sdiv_mul_shl_nsw_use3_before sdiv_mul_shl_nsw_use3_combined
  simp_alive_peephole
  sorry
def sdiv_shl_mul_nsw_combined := [llvmfunc|
  llvm.func @sdiv_shl_mul_nsw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg2, %arg0 overflow<nsw>  : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_sdiv_shl_mul_nsw   : sdiv_shl_mul_nsw_before  ⊑  sdiv_shl_mul_nsw_combined := by
  unfold sdiv_shl_mul_nsw_before sdiv_shl_mul_nsw_combined
  simp_alive_peephole
  sorry
def sdiv_mul_shl_missing_nsw1_combined := [llvmfunc|
  llvm.func @sdiv_mul_shl_missing_nsw1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_sdiv_mul_shl_missing_nsw1   : sdiv_mul_shl_missing_nsw1_before  ⊑  sdiv_mul_shl_missing_nsw1_combined := by
  unfold sdiv_mul_shl_missing_nsw1_before sdiv_mul_shl_missing_nsw1_combined
  simp_alive_peephole
  sorry
def sdiv_mul_shl_missing_nsw2_combined := [llvmfunc|
  llvm.func @sdiv_mul_shl_missing_nsw2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_sdiv_mul_shl_missing_nsw2   : sdiv_mul_shl_missing_nsw2_before  ⊑  sdiv_mul_shl_missing_nsw2_combined := by
  unfold sdiv_mul_shl_missing_nsw2_before sdiv_mul_shl_missing_nsw2_combined
  simp_alive_peephole
  sorry
def udiv_mul_shl_nuw_combined := [llvmfunc|
  llvm.func @udiv_mul_shl_nuw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.lshr %arg1, %arg2  : i5
    llvm.return %0 : i5
  }]

theorem inst_combine_udiv_mul_shl_nuw   : udiv_mul_shl_nuw_before  ⊑  udiv_mul_shl_nuw_combined := by
  unfold udiv_mul_shl_nuw_before udiv_mul_shl_nuw_combined
  simp_alive_peephole
  sorry
def udiv_mul_shl_nuw_exact_commute1_combined := [llvmfunc|
  llvm.func @udiv_mul_shl_nuw_exact_commute1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.lshr %arg1, %arg2  : i5
    llvm.return %0 : i5
  }]

theorem inst_combine_udiv_mul_shl_nuw_exact_commute1   : udiv_mul_shl_nuw_exact_commute1_before  ⊑  udiv_mul_shl_nuw_exact_commute1_combined := by
  unfold udiv_mul_shl_nuw_exact_commute1_before udiv_mul_shl_nuw_exact_commute1_combined
  simp_alive_peephole
  sorry
def udiv_mul_shl_nuw_commute2_combined := [llvmfunc|
  llvm.func @udiv_mul_shl_nuw_commute2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %1 = llvm.shl %arg2, %arg0 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_udiv_mul_shl_nuw_commute2   : udiv_mul_shl_nuw_commute2_before  ⊑  udiv_mul_shl_nuw_commute2_combined := by
  unfold udiv_mul_shl_nuw_commute2_before udiv_mul_shl_nuw_commute2_combined
  simp_alive_peephole
  sorry
def udiv_mul_shl_nsw_use1_combined := [llvmfunc|
  llvm.func @udiv_mul_shl_nsw_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.lshr %arg1, %arg2  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_udiv_mul_shl_nsw_use1   : udiv_mul_shl_nsw_use1_before  ⊑  udiv_mul_shl_nsw_use1_combined := by
  unfold udiv_mul_shl_nsw_use1_before udiv_mul_shl_nsw_use1_combined
  simp_alive_peephole
  sorry
def udiv_mul_shl_nsw_use2_combined := [llvmfunc|
  llvm.func @udiv_mul_shl_nsw_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.lshr %arg1, %arg2  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_udiv_mul_shl_nsw_use2   : udiv_mul_shl_nsw_use2_before  ⊑  udiv_mul_shl_nsw_use2_combined := by
  unfold udiv_mul_shl_nsw_use2_before udiv_mul_shl_nsw_use2_combined
  simp_alive_peephole
  sorry
def udiv_mul_shl_nsw_use3_combined := [llvmfunc|
  llvm.func @udiv_mul_shl_nsw_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.lshr %arg1, %arg2  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_mul_shl_nsw_use3   : udiv_mul_shl_nsw_use3_before  ⊑  udiv_mul_shl_nsw_use3_combined := by
  unfold udiv_mul_shl_nsw_use3_before udiv_mul_shl_nsw_use3_combined
  simp_alive_peephole
  sorry
def udiv_shl_mul_nuw_combined := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.shl %0, %arg2 overflow<nuw>  : i5
    %2 = llvm.udiv %1, %arg1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_udiv_shl_mul_nuw   : udiv_shl_mul_nuw_before  ⊑  udiv_shl_mul_nuw_combined := by
  unfold udiv_shl_mul_nuw_before udiv_shl_mul_nuw_combined
  simp_alive_peephole
  sorry
def udiv_shl_mul_nuw_swap_combined := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_swap(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.shl %0, %arg2 overflow<nuw>  : i5
    %2 = llvm.udiv %1, %arg1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_udiv_shl_mul_nuw_swap   : udiv_shl_mul_nuw_swap_before  ⊑  udiv_shl_mul_nuw_swap_combined := by
  unfold udiv_shl_mul_nuw_swap_before udiv_shl_mul_nuw_swap_combined
  simp_alive_peephole
  sorry
def udiv_shl_mul_nuw_exact_combined := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_exact(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.shl %0, %arg2 overflow<nuw>  : i5
    %2 = llvm.udiv %1, %arg1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_udiv_shl_mul_nuw_exact   : udiv_shl_mul_nuw_exact_before  ⊑  udiv_shl_mul_nuw_exact_combined := by
  unfold udiv_shl_mul_nuw_exact_before udiv_shl_mul_nuw_exact_combined
  simp_alive_peephole
  sorry
def udiv_shl_mul_nuw_vec_combined := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_vec(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.shl %1, %arg2 overflow<nuw>  : vector<2xi4>
    %3 = llvm.udiv %2, %arg1  : vector<2xi4>
    llvm.return %3 : vector<2xi4>
  }]

theorem inst_combine_udiv_shl_mul_nuw_vec   : udiv_shl_mul_nuw_vec_before  ⊑  udiv_shl_mul_nuw_vec_combined := by
  unfold udiv_shl_mul_nuw_vec_before udiv_shl_mul_nuw_vec_combined
  simp_alive_peephole
  sorry
def udiv_shl_mul_nuw_extra_use_of_shl_combined := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_extra_use_of_shl(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i8
    %3 = llvm.udiv %2, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_udiv_shl_mul_nuw_extra_use_of_shl   : udiv_shl_mul_nuw_extra_use_of_shl_before  ⊑  udiv_shl_mul_nuw_extra_use_of_shl_combined := by
  unfold udiv_shl_mul_nuw_extra_use_of_shl_before udiv_shl_mul_nuw_extra_use_of_shl_combined
  simp_alive_peephole
  sorry
def udiv_shl_mul_nuw_extra_use_of_mul_combined := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_extra_use_of_mul(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_shl_mul_nuw_extra_use_of_mul   : udiv_shl_mul_nuw_extra_use_of_mul_before  ⊑  udiv_shl_mul_nuw_extra_use_of_mul_combined := by
  unfold udiv_shl_mul_nuw_extra_use_of_mul_before udiv_shl_mul_nuw_extra_use_of_mul_combined
  simp_alive_peephole
  sorry
def udiv_shl_mul_nuw_extra_use_combined := [llvmfunc|
  llvm.func @udiv_shl_mul_nuw_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.mul %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_shl_mul_nuw_extra_use   : udiv_shl_mul_nuw_extra_use_before  ⊑  udiv_shl_mul_nuw_extra_use_combined := by
  unfold udiv_shl_mul_nuw_extra_use_before udiv_shl_mul_nuw_extra_use_combined
  simp_alive_peephole
  sorry
def sdiv_shl_mul_nuw_combined := [llvmfunc|
  llvm.func @sdiv_shl_mul_nuw(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %2 = llvm.sdiv %0, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_sdiv_shl_mul_nuw   : sdiv_shl_mul_nuw_before  ⊑  sdiv_shl_mul_nuw_combined := by
  unfold sdiv_shl_mul_nuw_before sdiv_shl_mul_nuw_combined
  simp_alive_peephole
  sorry
def udiv_mul_shl_missing_nsw1_combined := [llvmfunc|
  llvm.func @udiv_mul_shl_missing_nsw1(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_udiv_mul_shl_missing_nsw1   : udiv_mul_shl_missing_nsw1_before  ⊑  udiv_mul_shl_missing_nsw1_combined := by
  unfold udiv_mul_shl_missing_nsw1_before udiv_mul_shl_missing_nsw1_combined
  simp_alive_peephole
  sorry
def udiv_mul_shl_missing_nsw2_combined := [llvmfunc|
  llvm.func @udiv_mul_shl_missing_nsw2(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i5
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i5
    %2 = llvm.udiv %0, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_udiv_mul_shl_missing_nsw2   : udiv_mul_shl_missing_nsw2_before  ⊑  udiv_mul_shl_missing_nsw2_combined := by
  unfold udiv_mul_shl_missing_nsw2_before udiv_mul_shl_missing_nsw2_combined
  simp_alive_peephole
  sorry
def udiv_shl_nuw_combined := [llvmfunc|
  llvm.func @udiv_shl_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_udiv_shl_nuw   : udiv_shl_nuw_before  ⊑  udiv_shl_nuw_combined := by
  unfold udiv_shl_nuw_before udiv_shl_nuw_combined
  simp_alive_peephole
  sorry
def udiv_shl_nuw_exact_combined := [llvmfunc|
  llvm.func @udiv_shl_nuw_exact(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : vector<2xi4>
    %1 = llvm.udiv %arg0, %0  : vector<2xi4>
    llvm.return %1 : vector<2xi4>
  }]

theorem inst_combine_udiv_shl_nuw_exact   : udiv_shl_nuw_exact_before  ⊑  udiv_shl_nuw_exact_combined := by
  unfold udiv_shl_nuw_exact_before udiv_shl_nuw_exact_combined
  simp_alive_peephole
  sorry
def udiv_shl_combined := [llvmfunc|
  llvm.func @udiv_shl(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2  : i8
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_udiv_shl   : udiv_shl_before  ⊑  udiv_shl_combined := by
  unfold udiv_shl_before udiv_shl_combined
  simp_alive_peephole
  sorry
def udiv_shl_nuw_use_combined := [llvmfunc|
  llvm.func @udiv_shl_nuw_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_udiv_shl_nuw_use   : udiv_shl_nuw_use_before  ⊑  udiv_shl_nuw_use_combined := by
  unfold udiv_shl_nuw_use_before udiv_shl_nuw_use_combined
  simp_alive_peephole
  sorry
def udiv_lshr_mul_nuw_combined := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.lshr %arg1, %arg2  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_udiv_lshr_mul_nuw   : udiv_lshr_mul_nuw_before  ⊑  udiv_lshr_mul_nuw_combined := by
  unfold udiv_lshr_mul_nuw_before udiv_lshr_mul_nuw_combined
  simp_alive_peephole
  sorry
def udiv_lshr_mul_nuw_exact_commute1_combined := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw_exact_commute1(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.lshr %arg1, %arg2  : vector<2xi4>
    llvm.return %0 : vector<2xi4>
  }]

theorem inst_combine_udiv_lshr_mul_nuw_exact_commute1   : udiv_lshr_mul_nuw_exact_commute1_before  ⊑  udiv_lshr_mul_nuw_exact_commute1_combined := by
  unfold udiv_lshr_mul_nuw_exact_commute1_before udiv_lshr_mul_nuw_exact_commute1_combined
  simp_alive_peephole
  sorry
def udiv_lshr_mul_nuw_commute2_combined := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg1, %arg0 overflow<nuw>  : i8
    %1 = llvm.lshr %arg2, %0  : i8
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_lshr_mul_nuw_commute2   : udiv_lshr_mul_nuw_commute2_before  ⊑  udiv_lshr_mul_nuw_commute2_combined := by
  unfold udiv_lshr_mul_nuw_commute2_before udiv_lshr_mul_nuw_commute2_combined
  simp_alive_peephole
  sorry
def udiv_lshr_mul_nuw_use1_combined := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.lshr %arg1, %arg2  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_udiv_lshr_mul_nuw_use1   : udiv_lshr_mul_nuw_use1_before  ⊑  udiv_lshr_mul_nuw_use1_combined := by
  unfold udiv_lshr_mul_nuw_use1_before udiv_lshr_mul_nuw_use1_combined
  simp_alive_peephole
  sorry
def udiv_lshr_mul_nuw_use2_combined := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.lshr %arg1, %arg2  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_lshr_mul_nuw_use2   : udiv_lshr_mul_nuw_use2_before  ⊑  udiv_lshr_mul_nuw_use2_combined := by
  unfold udiv_lshr_mul_nuw_use2_before udiv_lshr_mul_nuw_use2_combined
  simp_alive_peephole
  sorry
def udiv_lshr_mul_nuw_use3_combined := [llvmfunc|
  llvm.func @udiv_lshr_mul_nuw_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.lshr %0, %arg2  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.lshr %arg1, %arg2  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_lshr_mul_nuw_use3   : udiv_lshr_mul_nuw_use3_before  ⊑  udiv_lshr_mul_nuw_use3_combined := by
  unfold udiv_lshr_mul_nuw_use3_before udiv_lshr_mul_nuw_use3_combined
  simp_alive_peephole
  sorry
def udiv_lshr_mul_nsw_combined := [llvmfunc|
  llvm.func @udiv_lshr_mul_nsw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    %2 = llvm.udiv %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_lshr_mul_nsw   : udiv_lshr_mul_nsw_before  ⊑  udiv_lshr_mul_nsw_combined := by
  unfold udiv_lshr_mul_nsw_before udiv_lshr_mul_nsw_combined
  simp_alive_peephole
  sorry
def sdiv_lshr_mul_nsw_combined := [llvmfunc|
  llvm.func @sdiv_lshr_mul_nsw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    %2 = llvm.sdiv %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sdiv_lshr_mul_nsw   : sdiv_lshr_mul_nsw_before  ⊑  sdiv_lshr_mul_nsw_combined := by
  unfold sdiv_lshr_mul_nsw_before sdiv_lshr_mul_nsw_combined
  simp_alive_peephole
  sorry
def sdiv_shl_shl_nsw2_nuw_combined := [llvmfunc|
  llvm.func @sdiv_shl_shl_nsw2_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_sdiv_shl_shl_nsw2_nuw   : sdiv_shl_shl_nsw2_nuw_before  ⊑  sdiv_shl_shl_nsw2_nuw_combined := by
  unfold sdiv_shl_shl_nsw2_nuw_before sdiv_shl_shl_nsw2_nuw_combined
  simp_alive_peephole
  sorry
def sdiv_shl_shl_nsw2_nuw_exact_use_combined := [llvmfunc|
  llvm.func @sdiv_shl_shl_nsw2_nuw_exact_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.sdiv %arg0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sdiv_shl_shl_nsw2_nuw_exact_use   : sdiv_shl_shl_nsw2_nuw_exact_use_before  ⊑  sdiv_shl_shl_nsw2_nuw_exact_use_combined := by
  unfold sdiv_shl_shl_nsw2_nuw_exact_use_before sdiv_shl_shl_nsw2_nuw_exact_use_combined
  simp_alive_peephole
  sorry
def sdiv_shl_shl_nsw_nuw2_combined := [llvmfunc|
  llvm.func @sdiv_shl_shl_nsw_nuw2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sdiv_shl_shl_nsw_nuw2   : sdiv_shl_shl_nsw_nuw2_before  ⊑  sdiv_shl_shl_nsw_nuw2_combined := by
  unfold sdiv_shl_shl_nsw_nuw2_before sdiv_shl_shl_nsw_nuw2_combined
  simp_alive_peephole
  sorry
def sdiv_shl_shl_nsw_nuw_combined := [llvmfunc|
  llvm.func @sdiv_shl_shl_nsw_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sdiv_shl_shl_nsw_nuw   : sdiv_shl_shl_nsw_nuw_before  ⊑  sdiv_shl_shl_nsw_nuw_combined := by
  unfold sdiv_shl_shl_nsw_nuw_before sdiv_shl_shl_nsw_nuw_combined
  simp_alive_peephole
  sorry
def sdiv_shl_shl_nuw_nsw2_combined := [llvmfunc|
  llvm.func @sdiv_shl_shl_nuw_nsw2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i8
    %2 = llvm.sdiv %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sdiv_shl_shl_nuw_nsw2   : sdiv_shl_shl_nuw_nsw2_before  ⊑  sdiv_shl_shl_nuw_nsw2_combined := by
  unfold sdiv_shl_shl_nuw_nsw2_before sdiv_shl_shl_nuw_nsw2_combined
  simp_alive_peephole
  sorry
def udiv_shl_shl_nuw2_combined := [llvmfunc|
  llvm.func @udiv_shl_shl_nuw2(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.udiv %arg0, %arg1  : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_udiv_shl_shl_nuw2   : udiv_shl_shl_nuw2_before  ⊑  udiv_shl_shl_nuw2_combined := by
  unfold udiv_shl_shl_nuw2_before udiv_shl_shl_nuw2_combined
  simp_alive_peephole
  sorry
def udiv_shl_shl_nuw2_exact_use2_combined := [llvmfunc|
  llvm.func @udiv_shl_shl_nuw2_exact_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.udiv %arg0, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_shl_shl_nuw2_exact_use2   : udiv_shl_shl_nuw2_exact_use2_before  ⊑  udiv_shl_shl_nuw2_exact_use2_combined := by
  unfold udiv_shl_shl_nuw2_exact_use2_before udiv_shl_shl_nuw2_exact_use2_combined
  simp_alive_peephole
  sorry
def udiv_shl_shl_nuw_nsw_combined := [llvmfunc|
  llvm.func @udiv_shl_shl_nuw_nsw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nsw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_shl_shl_nuw_nsw   : udiv_shl_shl_nuw_nsw_before  ⊑  udiv_shl_shl_nuw_nsw_combined := by
  unfold udiv_shl_shl_nuw_nsw_before udiv_shl_shl_nuw_nsw_combined
  simp_alive_peephole
  sorry
def udiv_shl_shl_nsw_nuw_combined := [llvmfunc|
  llvm.func @udiv_shl_shl_nsw_nuw(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw>  : i8
    %1 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %2 = llvm.udiv %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_shl_shl_nsw_nuw   : udiv_shl_shl_nsw_nuw_before  ⊑  udiv_shl_shl_nsw_nuw_combined := by
  unfold udiv_shl_shl_nsw_nuw_before udiv_shl_shl_nsw_nuw_combined
  simp_alive_peephole
  sorry
def udiv_shl_shl_nuw_nsw2_combined := [llvmfunc|
  llvm.func @udiv_shl_shl_nuw_nsw2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.udiv %arg0, %arg1  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_udiv_shl_shl_nuw_nsw2   : udiv_shl_shl_nuw_nsw2_before  ⊑  udiv_shl_shl_nuw_nsw2_combined := by
  unfold udiv_shl_shl_nuw_nsw2_before udiv_shl_shl_nuw_nsw2_combined
  simp_alive_peephole
  sorry
def udiv_shl_nuw_divisor_combined := [llvmfunc|
  llvm.func @udiv_shl_nuw_divisor(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg1, %arg2 overflow<nuw>  : i8
    %1 = llvm.udiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_udiv_shl_nuw_divisor   : udiv_shl_nuw_divisor_before  ⊑  udiv_shl_nuw_divisor_combined := by
  unfold udiv_shl_nuw_divisor_before udiv_shl_nuw_divisor_combined
  simp_alive_peephole
  sorry
def udiv_fail_shl_overflow_combined := [llvmfunc|
  llvm.func @udiv_fail_shl_overflow(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    %4 = llvm.udiv %arg0, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_udiv_fail_shl_overflow   : udiv_fail_shl_overflow_before  ⊑  udiv_fail_shl_overflow_combined := by
  unfold udiv_fail_shl_overflow_before udiv_fail_shl_overflow_combined
  simp_alive_peephole
  sorry
def udiv_shl_no_overflow_combined := [llvmfunc|
  llvm.func @udiv_shl_no_overflow(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.add %arg1, %0  : i8
    %2 = llvm.lshr %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_shl_no_overflow   : udiv_shl_no_overflow_before  ⊑  udiv_shl_no_overflow_combined := by
  unfold udiv_shl_no_overflow_before udiv_shl_no_overflow_combined
  simp_alive_peephole
  sorry
def sdiv_shl_pair_const_combined := [llvmfunc|
  llvm.func @sdiv_shl_pair_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sdiv_shl_pair_const   : sdiv_shl_pair_const_before  ⊑  sdiv_shl_pair_const_combined := by
  unfold sdiv_shl_pair_const_before sdiv_shl_pair_const_combined
  simp_alive_peephole
  sorry
def udiv_shl_pair_const_combined := [llvmfunc|
  llvm.func @udiv_shl_pair_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_udiv_shl_pair_const   : udiv_shl_pair_const_before  ⊑  udiv_shl_pair_const_combined := by
  unfold udiv_shl_pair_const_before udiv_shl_pair_const_combined
  simp_alive_peephole
  sorry
def sdiv_shl_pair1_combined := [llvmfunc|
  llvm.func @sdiv_shl_pair1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sdiv_shl_pair1   : sdiv_shl_pair1_before  ⊑  sdiv_shl_pair1_combined := by
  unfold sdiv_shl_pair1_before sdiv_shl_pair1_combined
  simp_alive_peephole
  sorry
def sdiv_shl_pair2_combined := [llvmfunc|
  llvm.func @sdiv_shl_pair2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sdiv_shl_pair2   : sdiv_shl_pair2_before  ⊑  sdiv_shl_pair2_combined := by
  unfold sdiv_shl_pair2_before sdiv_shl_pair2_combined
  simp_alive_peephole
  sorry
def sdiv_shl_pair3_combined := [llvmfunc|
  llvm.func @sdiv_shl_pair3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sdiv_shl_pair3   : sdiv_shl_pair3_before  ⊑  sdiv_shl_pair3_combined := by
  unfold sdiv_shl_pair3_before sdiv_shl_pair3_combined
  simp_alive_peephole
  sorry
def sdiv_shl_no_pair_fail_combined := [llvmfunc|
  llvm.func @sdiv_shl_no_pair_fail(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg2 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg1, %arg3 overflow<nuw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sdiv_shl_no_pair_fail   : sdiv_shl_no_pair_fail_before  ⊑  sdiv_shl_no_pair_fail_combined := by
  unfold sdiv_shl_no_pair_fail_before sdiv_shl_no_pair_fail_combined
  simp_alive_peephole
  sorry
def udiv_shl_pair1_combined := [llvmfunc|
  llvm.func @udiv_shl_pair1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_udiv_shl_pair1   : udiv_shl_pair1_before  ⊑  udiv_shl_pair1_combined := by
  unfold udiv_shl_pair1_before udiv_shl_pair1_combined
  simp_alive_peephole
  sorry
def udiv_shl_pair2_combined := [llvmfunc|
  llvm.func @udiv_shl_pair2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_udiv_shl_pair2   : udiv_shl_pair2_before  ⊑  udiv_shl_pair2_combined := by
  unfold udiv_shl_pair2_before udiv_shl_pair2_combined
  simp_alive_peephole
  sorry
def udiv_shl_pair3_combined := [llvmfunc|
  llvm.func @udiv_shl_pair3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_udiv_shl_pair3   : udiv_shl_pair3_before  ⊑  udiv_shl_pair3_combined := by
  unfold udiv_shl_pair3_before udiv_shl_pair3_combined
  simp_alive_peephole
  sorry
def sdiv_shl_pair_overflow_fail1_combined := [llvmfunc|
  llvm.func @sdiv_shl_pair_overflow_fail1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sdiv_shl_pair_overflow_fail1   : sdiv_shl_pair_overflow_fail1_before  ⊑  sdiv_shl_pair_overflow_fail1_combined := by
  unfold sdiv_shl_pair_overflow_fail1_before sdiv_shl_pair_overflow_fail1_combined
  simp_alive_peephole
  sorry
def sdiv_shl_pair_overflow_fail2_combined := [llvmfunc|
  llvm.func @sdiv_shl_pair_overflow_fail2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.sdiv %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sdiv_shl_pair_overflow_fail2   : sdiv_shl_pair_overflow_fail2_before  ⊑  sdiv_shl_pair_overflow_fail2_combined := by
  unfold sdiv_shl_pair_overflow_fail2_before sdiv_shl_pair_overflow_fail2_combined
  simp_alive_peephole
  sorry
def udiv_shl_pair_overflow_fail1_combined := [llvmfunc|
  llvm.func @udiv_shl_pair_overflow_fail1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_udiv_shl_pair_overflow_fail1   : udiv_shl_pair_overflow_fail1_before  ⊑  udiv_shl_pair_overflow_fail1_combined := by
  unfold udiv_shl_pair_overflow_fail1_before udiv_shl_pair_overflow_fail1_combined
  simp_alive_peephole
  sorry
def udiv_shl_pair_overflow_fail2_combined := [llvmfunc|
  llvm.func @udiv_shl_pair_overflow_fail2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.shl %arg0, %arg2  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_udiv_shl_pair_overflow_fail2   : udiv_shl_pair_overflow_fail2_before  ⊑  udiv_shl_pair_overflow_fail2_combined := by
  unfold udiv_shl_pair_overflow_fail2_before udiv_shl_pair_overflow_fail2_combined
  simp_alive_peephole
  sorry
def udiv_shl_pair_overflow_fail3_combined := [llvmfunc|
  llvm.func @udiv_shl_pair_overflow_fail3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.shl %arg0, %arg2  : i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_udiv_shl_pair_overflow_fail3   : udiv_shl_pair_overflow_fail3_before  ⊑  udiv_shl_pair_overflow_fail3_combined := by
  unfold udiv_shl_pair_overflow_fail3_before udiv_shl_pair_overflow_fail3_combined
  simp_alive_peephole
  sorry
def sdiv_shl_pair_multiuse1_combined := [llvmfunc|
  llvm.func @sdiv_shl_pair_multiuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i32
    %3 = llvm.lshr %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sdiv_shl_pair_multiuse1   : sdiv_shl_pair_multiuse1_before  ⊑  sdiv_shl_pair_multiuse1_combined := by
  unfold sdiv_shl_pair_multiuse1_before sdiv_shl_pair_multiuse1_combined
  simp_alive_peephole
  sorry
def sdiv_shl_pair_multiuse2_combined := [llvmfunc|
  llvm.func @sdiv_shl_pair_multiuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i32
    %3 = llvm.lshr %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sdiv_shl_pair_multiuse2   : sdiv_shl_pair_multiuse2_before  ⊑  sdiv_shl_pair_multiuse2_combined := by
  unfold sdiv_shl_pair_multiuse2_before sdiv_shl_pair_multiuse2_combined
  simp_alive_peephole
  sorry
def sdiv_shl_pair_multiuse3_combined := [llvmfunc|
  llvm.func @sdiv_shl_pair_multiuse3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %2 = llvm.shl %arg0, %arg2 overflow<nsw>  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i32
    %4 = llvm.lshr %3, %arg2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_sdiv_shl_pair_multiuse3   : sdiv_shl_pair_multiuse3_before  ⊑  sdiv_shl_pair_multiuse3_combined := by
  unfold sdiv_shl_pair_multiuse3_before sdiv_shl_pair_multiuse3_combined
  simp_alive_peephole
  sorry
def pr69291_combined := [llvmfunc|
  llvm.func @pr69291() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_pr69291   : pr69291_before  ⊑  pr69291_combined := by
  unfold pr69291_before pr69291_combined
  simp_alive_peephole
  sorry
