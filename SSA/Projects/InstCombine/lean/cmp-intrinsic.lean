import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cmp-intrinsic
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bswap_eq_i16_before := [llvmfunc|
  llvm.func @bswap_eq_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %2 = llvm.icmp "eq" %1, %0 : i16
    llvm.return %2 : i1
  }]

def bswap_ne_i32_before := [llvmfunc|
  llvm.func @bswap_ne_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

def bswap_eq_v2i64_before := [llvmfunc|
  llvm.func @bswap_eq_v2i64(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi64>
    llvm.return %2 : vector<2xi1>
  }]

def ctlz_eq_bitwidth_i32_before := [llvmfunc|
  llvm.func @ctlz_eq_bitwidth_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ctlz_eq_zero_i32_before := [llvmfunc|
  llvm.func @ctlz_eq_zero_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ctlz_ne_zero_v2i32_before := [llvmfunc|
  llvm.func @ctlz_ne_zero_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def ctlz_eq_bw_minus_1_i32_before := [llvmfunc|
  llvm.func @ctlz_eq_bw_minus_1_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ctlz_ne_bw_minus_1_v2i32_before := [llvmfunc|
  llvm.func @ctlz_ne_bw_minus_1_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def ctlz_eq_other_i32_before := [llvmfunc|
  llvm.func @ctlz_eq_other_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ctlz_ne_other_v2i32_before := [llvmfunc|
  llvm.func @ctlz_ne_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def ctlz_eq_other_i32_multiuse_before := [llvmfunc|
  llvm.func @ctlz_eq_other_i32_multiuse(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ctlz_ne_bitwidth_v2i32_before := [llvmfunc|
  llvm.func @ctlz_ne_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def ctlz_ugt_zero_i32_before := [llvmfunc|
  llvm.func @ctlz_ugt_zero_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ctlz_ugt_one_i32_before := [llvmfunc|
  llvm.func @ctlz_ugt_one_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ctlz_ugt_other_i32_before := [llvmfunc|
  llvm.func @ctlz_ugt_other_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ctlz_ugt_other_multiuse_i32_before := [llvmfunc|
  llvm.func @ctlz_ugt_other_multiuse_i32(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ctlz_ugt_bw_minus_one_i32_before := [llvmfunc|
  llvm.func @ctlz_ugt_bw_minus_one_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ctlz_ult_one_v2i32_before := [llvmfunc|
  llvm.func @ctlz_ult_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def ctlz_ult_other_v2i32_before := [llvmfunc|
  llvm.func @ctlz_ult_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def ctlz_ult_other_multiuse_v2i32_before := [llvmfunc|
  llvm.func @ctlz_ult_other_multiuse_v2i32(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def ctlz_ult_bw_minus_one_v2i32_before := [llvmfunc|
  llvm.func @ctlz_ult_bw_minus_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def ctlz_ult_bitwidth_v2i32_before := [llvmfunc|
  llvm.func @ctlz_ult_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def cttz_ne_bitwidth_i33_before := [llvmfunc|
  llvm.func @cttz_ne_bitwidth_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(33 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    %2 = llvm.icmp "ne" %1, %0 : i33
    llvm.return %2 : i1
  }]

def cttz_eq_bitwidth_v2i32_before := [llvmfunc|
  llvm.func @cttz_eq_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "eq" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def cttz_eq_zero_i33_before := [llvmfunc|
  llvm.func @cttz_eq_zero_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    %2 = llvm.icmp "eq" %1, %0 : i33
    llvm.return %2 : i1
  }]

def cttz_ne_zero_v2i32_before := [llvmfunc|
  llvm.func @cttz_ne_zero_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def cttz_eq_bw_minus_1_i33_before := [llvmfunc|
  llvm.func @cttz_eq_bw_minus_1_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(32 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    %2 = llvm.icmp "eq" %1, %0 : i33
    llvm.return %2 : i1
  }]

def cttz_ne_bw_minus_1_v2i32_before := [llvmfunc|
  llvm.func @cttz_ne_bw_minus_1_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def cttz_eq_other_i33_before := [llvmfunc|
  llvm.func @cttz_eq_other_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(4 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    %2 = llvm.icmp "eq" %1, %0 : i33
    llvm.return %2 : i1
  }]

def cttz_ne_other_v2i32_before := [llvmfunc|
  llvm.func @cttz_ne_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def cttz_eq_other_i33_multiuse_before := [llvmfunc|
  llvm.func @cttz_eq_other_i33_multiuse(%arg0: i33, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(4 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    llvm.store %1, %arg1 {alignment = 4 : i64} : i33, !llvm.ptr]

    %2 = llvm.icmp "eq" %1, %0 : i33
    llvm.return %2 : i1
  }]

def cttz_ugt_zero_i33_before := [llvmfunc|
  llvm.func @cttz_ugt_zero_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    %2 = llvm.icmp "ugt" %1, %0 : i33
    llvm.return %2 : i1
  }]

def cttz_ugt_one_i33_before := [llvmfunc|
  llvm.func @cttz_ugt_one_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(1 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    %2 = llvm.icmp "ugt" %1, %0 : i33
    llvm.return %2 : i1
  }]

def cttz_ugt_other_i33_before := [llvmfunc|
  llvm.func @cttz_ugt_other_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(16 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    %2 = llvm.icmp "ugt" %1, %0 : i33
    llvm.return %2 : i1
  }]

def cttz_ugt_other_multiuse_i33_before := [llvmfunc|
  llvm.func @cttz_ugt_other_multiuse_i33(%arg0: i33, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(16 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    llvm.store %1, %arg1 {alignment = 4 : i64} : i33, !llvm.ptr]

    %2 = llvm.icmp "ugt" %1, %0 : i33
    llvm.return %2 : i1
  }]

def cttz_ugt_bw_minus_one_i33_before := [llvmfunc|
  llvm.func @cttz_ugt_bw_minus_one_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(32 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    %2 = llvm.icmp "ugt" %1, %0 : i33
    llvm.return %2 : i1
  }]

def cttz_ult_one_v2i32_before := [llvmfunc|
  llvm.func @cttz_ult_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def cttz_ult_other_v2i32_before := [llvmfunc|
  llvm.func @cttz_ult_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def cttz_ult_other_multiuse_v2i32_before := [llvmfunc|
  llvm.func @cttz_ult_other_multiuse_v2i32(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def cttz_ult_bw_minus_one_v2i32_before := [llvmfunc|
  llvm.func @cttz_ult_bw_minus_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def cttz_ult_bitwidth_v2i32_before := [llvmfunc|
  llvm.func @cttz_ult_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def ctpop_eq_zero_i11_before := [llvmfunc|
  llvm.func @ctpop_eq_zero_i11(%arg0: i11) -> i1 {
    %0 = llvm.mlir.constant(0 : i11) : i11
    %1 = llvm.intr.ctpop(%arg0)  : (i11) -> i11
    %2 = llvm.icmp "eq" %1, %0 : i11
    llvm.return %2 : i1
  }]

def ctpop_ne_zero_v2i32_before := [llvmfunc|
  llvm.func @ctpop_ne_zero_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def ctpop_eq_bitwidth_i8_before := [llvmfunc|
  llvm.func @ctpop_eq_bitwidth_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ctpop_ne_bitwidth_v2i32_before := [llvmfunc|
  llvm.func @ctpop_ne_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def ctpop_ugt_bitwidth_minus_one_i8_before := [llvmfunc|
  llvm.func @ctpop_ugt_bitwidth_minus_one_i8(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    llvm.store %1, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ctpop_ult_bitwidth_v2i32_before := [llvmfunc|
  llvm.func @ctpop_ult_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def trunc_cttz_eq_other_i33_i15_before := [llvmfunc|
  llvm.func @trunc_cttz_eq_other_i33_i15(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(4 : i15) : i15
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    %2 = llvm.trunc %1 : i33 to i15
    %3 = llvm.icmp "eq" %2, %0 : i15
    llvm.return %3 : i1
  }]

def trunc_cttz_ugt_other_i33_i15_before := [llvmfunc|
  llvm.func @trunc_cttz_ugt_other_i33_i15(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(3 : i15) : i15
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    %2 = llvm.trunc %1 : i33 to i15
    %3 = llvm.icmp "ugt" %2, %0 : i15
    llvm.return %3 : i1
  }]

def trunc_cttz_ult_other_i33_i6_before := [llvmfunc|
  llvm.func @trunc_cttz_ult_other_i33_i6(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(7 : i6) : i6
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i33) -> i33]

    %2 = llvm.trunc %1 : i33 to i6
    %3 = llvm.icmp "ult" %2, %0 : i6
    llvm.return %3 : i1
  }]

def trunc_cttz_ult_other_i33_i5_before := [llvmfunc|
  llvm.func @trunc_cttz_ult_other_i33_i5(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i33) -> i33]

    %2 = llvm.trunc %1 : i33 to i5
    %3 = llvm.icmp "ult" %2, %0 : i5
    llvm.return %3 : i1
  }]

def trunc_cttz_true_ult_other_i32_i5_before := [llvmfunc|
  llvm.func @trunc_cttz_true_ult_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %2 = llvm.trunc %1 : i32 to i5
    %3 = llvm.icmp "ult" %2, %0 : i5
    llvm.return %3 : i1
  }]

def trunc_cttz_false_ult_other_i32_i5_before := [llvmfunc|
  llvm.func @trunc_cttz_false_ult_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.trunc %1 : i32 to i5
    %3 = llvm.icmp "ult" %2, %0 : i5
    llvm.return %3 : i1
  }]

def trunc_cttz_false_ult_other_i32_i6_before := [llvmfunc|
  llvm.func @trunc_cttz_false_ult_other_i32_i6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i6) : i6
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.trunc %1 : i32 to i6
    %3 = llvm.icmp "ult" %2, %0 : i6
    llvm.return %3 : i1
  }]

def trunc_cttz_false_ult_other_i32_i6_extra_use_before := [llvmfunc|
  llvm.func @trunc_cttz_false_ult_other_i32_i6_extra_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i6) : i6
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.trunc %1 : i32 to i6
    llvm.call @use6(%2) : (i6) -> ()
    %3 = llvm.icmp "ult" %2, %0 : i6
    llvm.return %3 : i1
  }]

def trunc_ctlz_ugt_zero_i32_before := [llvmfunc|
  llvm.func @trunc_ctlz_ugt_zero_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i15) : i15
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.trunc %1 : i32 to i15
    %3 = llvm.icmp "ugt" %2, %0 : i15
    llvm.return %3 : i1
  }]

def trunc_ctlz_ugt_one_i32_before := [llvmfunc|
  llvm.func @trunc_ctlz_ugt_one_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i15) : i15
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.trunc %1 : i32 to i15
    %3 = llvm.icmp "ugt" %2, %0 : i15
    llvm.return %3 : i1
  }]

def trunc_ctlz_ugt_other_i33_i6_before := [llvmfunc|
  llvm.func @trunc_ctlz_ugt_other_i33_i6(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(4 : i6) : i6
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i33) -> i33]

    %2 = llvm.trunc %1 : i33 to i6
    %3 = llvm.icmp "ugt" %2, %0 : i6
    llvm.return %3 : i1
  }]

def trunc_ctlz_ugt_other_i33_i5_before := [llvmfunc|
  llvm.func @trunc_ctlz_ugt_other_i33_i5(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i33) -> i33]

    %2 = llvm.trunc %1 : i33 to i5
    %3 = llvm.icmp "ugt" %2, %0 : i5
    llvm.return %3 : i1
  }]

def trunc_ctlz_true_ugt_other_i32_i5_before := [llvmfunc|
  llvm.func @trunc_ctlz_true_ugt_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %2 = llvm.trunc %1 : i32 to i5
    %3 = llvm.icmp "ugt" %2, %0 : i5
    llvm.return %3 : i1
  }]

def trunc_ctlz_false_ugt_other_i32_i5_before := [llvmfunc|
  llvm.func @trunc_ctlz_false_ugt_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.trunc %1 : i32 to i5
    %3 = llvm.icmp "ugt" %2, %0 : i5
    llvm.return %3 : i1
  }]

def trunc_ctlz_false_ugt_other_i32_i6_before := [llvmfunc|
  llvm.func @trunc_ctlz_false_ugt_other_i32_i6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i6) : i6
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.trunc %1 : i32 to i6
    %3 = llvm.icmp "ugt" %2, %0 : i6
    llvm.return %3 : i1
  }]

def trunc_ctlz_false_ugt_other_i32_i6_extra_use_before := [llvmfunc|
  llvm.func @trunc_ctlz_false_ugt_other_i32_i6_extra_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i6) : i6
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.trunc %1 : i32 to i6
    llvm.call @use6(%2) : (i6) -> ()
    %3 = llvm.icmp "ugt" %2, %0 : i6
    llvm.return %3 : i1
  }]

def trunc_ctpop_eq_zero_i11_before := [llvmfunc|
  llvm.func @trunc_ctpop_eq_zero_i11(%arg0: i11) -> i1 {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.intr.ctpop(%arg0)  : (i11) -> i11
    %2 = llvm.trunc %1 : i11 to i5
    %3 = llvm.icmp "eq" %2, %0 : i5
    llvm.return %3 : i1
  }]

def trunc_ctpop_eq_bitwidth_i8_before := [llvmfunc|
  llvm.func @trunc_ctpop_eq_bitwidth_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(8 : i5) : i5
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.trunc %1 : i8 to i5
    %3 = llvm.icmp "eq" %2, %0 : i5
    llvm.return %3 : i1
  }]

def trunc_negative_destbits_not_enough_before := [llvmfunc|
  llvm.func @trunc_negative_destbits_not_enough(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

    %2 = llvm.trunc %1 : i33 to i4
    %3 = llvm.icmp "ult" %2, %0 : i4
    llvm.return %3 : i1
  }]

def bitreverse_ne_22_before := [llvmfunc|
  llvm.func @bitreverse_ne_22(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(22 : i8) : i8
    %1 = llvm.intr.bitreverse(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def bitreverse_ult_22_fail_not_equality_pred_before := [llvmfunc|
  llvm.func @bitreverse_ult_22_fail_not_equality_pred(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(22 : i8) : i8
    %1 = llvm.intr.bitreverse(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }]

def bitreverse_vec_eq_2_2_before := [llvmfunc|
  llvm.func @bitreverse_vec_eq_2_2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.bitreverse(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def bitreverse_vec_eq_1_2_todo_no_splat_before := [llvmfunc|
  llvm.func @bitreverse_vec_eq_1_2_todo_no_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.bitreverse(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def umax_eq_zero_before := [llvmfunc|
  llvm.func @umax_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def umax_eq_1_fail_before := [llvmfunc|
  llvm.func @umax_eq_1_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def umax_sle_zero_fail_before := [llvmfunc|
  llvm.func @umax_sle_zero_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sle" %1, %0 : i8
    llvm.return %2 : i1
  }]

def umax_ne_zero_before := [llvmfunc|
  llvm.func @umax_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def umax_ne_zero_fail_multiuse_before := [llvmfunc|
  llvm.func @umax_ne_zero_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def uadd_sat_ne_zero_fail_multiuse_before := [llvmfunc|
  llvm.func @uadd_sat_ne_zero_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ssub_sat_ne_zero_before := [llvmfunc|
  llvm.func @ssub_sat_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ssub_sat_ne_fail_nonzero_before := [llvmfunc|
  llvm.func @ssub_sat_ne_fail_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ssub_sat_eq_zero_before := [llvmfunc|
  llvm.func @ssub_sat_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ssub_sat_sle_zero_before := [llvmfunc|
  llvm.func @ssub_sat_sle_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sle" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ssub_sat_sge_zero_before := [llvmfunc|
  llvm.func @ssub_sat_sge_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sge" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ssub_sat_slt_zero_before := [llvmfunc|
  llvm.func @ssub_sat_slt_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ssub_sat_slt_neg1_fail_before := [llvmfunc|
  llvm.func @ssub_sat_slt_neg1_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ssub_sat_sgt_zero_before := [llvmfunc|
  llvm.func @ssub_sat_sgt_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ssub_sat_sgt_one_fail_before := [llvmfunc|
  llvm.func @ssub_sat_sgt_one_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def bswap_eq_i16_combined := [llvmfunc|
  llvm.func @bswap_eq_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(256 : i16) : i16
    %1 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_bswap_eq_i16   : bswap_eq_i16_before  ⊑  bswap_eq_i16_combined := by
  unfold bswap_eq_i16_before bswap_eq_i16_combined
  simp_alive_peephole
  sorry
def bswap_ne_i32_combined := [llvmfunc|
  llvm.func @bswap_ne_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(33554432 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_bswap_ne_i32   : bswap_ne_i32_before  ⊑  bswap_ne_i32_combined := by
  unfold bswap_ne_i32_before bswap_ne_i32_combined
  simp_alive_peephole
  sorry
def bswap_eq_v2i64_combined := [llvmfunc|
  llvm.func @bswap_eq_v2i64(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<216172782113783808> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi64>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_bswap_eq_v2i64   : bswap_eq_v2i64_before  ⊑  bswap_eq_v2i64_combined := by
  unfold bswap_eq_v2i64_before bswap_eq_v2i64_combined
  simp_alive_peephole
  sorry
def ctlz_eq_bitwidth_i32_combined := [llvmfunc|
  llvm.func @ctlz_eq_bitwidth_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_ctlz_eq_bitwidth_i32   : ctlz_eq_bitwidth_i32_before  ⊑  ctlz_eq_bitwidth_i32_combined := by
  unfold ctlz_eq_bitwidth_i32_before ctlz_eq_bitwidth_i32_combined
  simp_alive_peephole
  sorry
def ctlz_eq_zero_i32_combined := [llvmfunc|
  llvm.func @ctlz_eq_zero_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_ctlz_eq_zero_i32   : ctlz_eq_zero_i32_before  ⊑  ctlz_eq_zero_i32_combined := by
  unfold ctlz_eq_zero_i32_before ctlz_eq_zero_i32_combined
  simp_alive_peephole
  sorry
def ctlz_ne_zero_v2i32_combined := [llvmfunc|
  llvm.func @ctlz_ne_zero_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ctlz_ne_zero_v2i32   : ctlz_ne_zero_v2i32_before  ⊑  ctlz_ne_zero_v2i32_combined := by
  unfold ctlz_ne_zero_v2i32_before ctlz_ne_zero_v2i32_combined
  simp_alive_peephole
  sorry
def ctlz_eq_bw_minus_1_i32_combined := [llvmfunc|
  llvm.func @ctlz_eq_bw_minus_1_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_ctlz_eq_bw_minus_1_i32   : ctlz_eq_bw_minus_1_i32_before  ⊑  ctlz_eq_bw_minus_1_i32_combined := by
  unfold ctlz_eq_bw_minus_1_i32_before ctlz_eq_bw_minus_1_i32_combined
  simp_alive_peephole
  sorry
def ctlz_ne_bw_minus_1_v2i32_combined := [llvmfunc|
  llvm.func @ctlz_ne_bw_minus_1_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ctlz_ne_bw_minus_1_v2i32   : ctlz_ne_bw_minus_1_v2i32_before  ⊑  ctlz_ne_bw_minus_1_v2i32_combined := by
  unfold ctlz_ne_bw_minus_1_v2i32_before ctlz_ne_bw_minus_1_v2i32_combined
  simp_alive_peephole
  sorry
def ctlz_eq_other_i32_combined := [llvmfunc|
  llvm.func @ctlz_eq_other_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_ctlz_eq_other_i32   : ctlz_eq_other_i32_before  ⊑  ctlz_eq_other_i32_combined := by
  unfold ctlz_eq_other_i32_before ctlz_eq_other_i32_combined
  simp_alive_peephole
  sorry
def ctlz_ne_other_v2i32_combined := [llvmfunc|
  llvm.func @ctlz_ne_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_ctlz_ne_other_v2i32   : ctlz_ne_other_v2i32_before  ⊑  ctlz_ne_other_v2i32_combined := by
  unfold ctlz_ne_other_v2i32_before ctlz_ne_other_v2i32_combined
  simp_alive_peephole
  sorry
def ctlz_eq_other_i32_multiuse_combined := [llvmfunc|
  llvm.func @ctlz_eq_other_i32_multiuse(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_ctlz_eq_other_i32_multiuse   : ctlz_eq_other_i32_multiuse_before  ⊑  ctlz_eq_other_i32_multiuse_combined := by
  unfold ctlz_eq_other_i32_multiuse_before ctlz_eq_other_i32_multiuse_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_ctlz_eq_other_i32_multiuse   : ctlz_eq_other_i32_multiuse_before  ⊑  ctlz_eq_other_i32_multiuse_combined := by
  unfold ctlz_eq_other_i32_multiuse_before ctlz_eq_other_i32_multiuse_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ctlz_eq_other_i32_multiuse   : ctlz_eq_other_i32_multiuse_before  ⊑  ctlz_eq_other_i32_multiuse_combined := by
  unfold ctlz_eq_other_i32_multiuse_before ctlz_eq_other_i32_multiuse_combined
  simp_alive_peephole
  sorry
def ctlz_ne_bitwidth_v2i32_combined := [llvmfunc|
  llvm.func @ctlz_ne_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ctlz_ne_bitwidth_v2i32   : ctlz_ne_bitwidth_v2i32_before  ⊑  ctlz_ne_bitwidth_v2i32_combined := by
  unfold ctlz_ne_bitwidth_v2i32_before ctlz_ne_bitwidth_v2i32_combined
  simp_alive_peephole
  sorry
def ctlz_ugt_zero_i32_combined := [llvmfunc|
  llvm.func @ctlz_ugt_zero_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_ctlz_ugt_zero_i32   : ctlz_ugt_zero_i32_before  ⊑  ctlz_ugt_zero_i32_combined := by
  unfold ctlz_ugt_zero_i32_before ctlz_ugt_zero_i32_combined
  simp_alive_peephole
  sorry
def ctlz_ugt_one_i32_combined := [llvmfunc|
  llvm.func @ctlz_ugt_one_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_ctlz_ugt_one_i32   : ctlz_ugt_one_i32_before  ⊑  ctlz_ugt_one_i32_combined := by
  unfold ctlz_ugt_one_i32_before ctlz_ugt_one_i32_combined
  simp_alive_peephole
  sorry
def ctlz_ugt_other_i32_combined := [llvmfunc|
  llvm.func @ctlz_ugt_other_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_ctlz_ugt_other_i32   : ctlz_ugt_other_i32_before  ⊑  ctlz_ugt_other_i32_combined := by
  unfold ctlz_ugt_other_i32_before ctlz_ugt_other_i32_combined
  simp_alive_peephole
  sorry
def ctlz_ugt_other_multiuse_i32_combined := [llvmfunc|
  llvm.func @ctlz_ugt_other_multiuse_i32(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_ctlz_ugt_other_multiuse_i32   : ctlz_ugt_other_multiuse_i32_before  ⊑  ctlz_ugt_other_multiuse_i32_combined := by
  unfold ctlz_ugt_other_multiuse_i32_before ctlz_ugt_other_multiuse_i32_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_ctlz_ugt_other_multiuse_i32   : ctlz_ugt_other_multiuse_i32_before  ⊑  ctlz_ugt_other_multiuse_i32_combined := by
  unfold ctlz_ugt_other_multiuse_i32_before ctlz_ugt_other_multiuse_i32_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ctlz_ugt_other_multiuse_i32   : ctlz_ugt_other_multiuse_i32_before  ⊑  ctlz_ugt_other_multiuse_i32_combined := by
  unfold ctlz_ugt_other_multiuse_i32_before ctlz_ugt_other_multiuse_i32_combined
  simp_alive_peephole
  sorry
def ctlz_ugt_bw_minus_one_i32_combined := [llvmfunc|
  llvm.func @ctlz_ugt_bw_minus_one_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_ctlz_ugt_bw_minus_one_i32   : ctlz_ugt_bw_minus_one_i32_before  ⊑  ctlz_ugt_bw_minus_one_i32_combined := by
  unfold ctlz_ugt_bw_minus_one_i32_before ctlz_ugt_bw_minus_one_i32_combined
  simp_alive_peephole
  sorry
def ctlz_ult_one_v2i32_combined := [llvmfunc|
  llvm.func @ctlz_ult_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ctlz_ult_one_v2i32   : ctlz_ult_one_v2i32_before  ⊑  ctlz_ult_one_v2i32_combined := by
  unfold ctlz_ult_one_v2i32_before ctlz_ult_one_v2i32_combined
  simp_alive_peephole
  sorry
def ctlz_ult_other_v2i32_combined := [llvmfunc|
  llvm.func @ctlz_ult_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ctlz_ult_other_v2i32   : ctlz_ult_other_v2i32_before  ⊑  ctlz_ult_other_v2i32_combined := by
  unfold ctlz_ult_other_v2i32_before ctlz_ult_other_v2i32_combined
  simp_alive_peephole
  sorry
def ctlz_ult_other_multiuse_v2i32_combined := [llvmfunc|
  llvm.func @ctlz_ult_other_multiuse_v2i32(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_ctlz_ult_other_multiuse_v2i32   : ctlz_ult_other_multiuse_v2i32_before  ⊑  ctlz_ult_other_multiuse_v2i32_combined := by
  unfold ctlz_ult_other_multiuse_v2i32_before ctlz_ult_other_multiuse_v2i32_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

theorem inst_combine_ctlz_ult_other_multiuse_v2i32   : ctlz_ult_other_multiuse_v2i32_before  ⊑  ctlz_ult_other_multiuse_v2i32_combined := by
  unfold ctlz_ult_other_multiuse_v2i32_before ctlz_ult_other_multiuse_v2i32_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ctlz_ult_other_multiuse_v2i32   : ctlz_ult_other_multiuse_v2i32_before  ⊑  ctlz_ult_other_multiuse_v2i32_combined := by
  unfold ctlz_ult_other_multiuse_v2i32_before ctlz_ult_other_multiuse_v2i32_combined
  simp_alive_peephole
  sorry
def ctlz_ult_bw_minus_one_v2i32_combined := [llvmfunc|
  llvm.func @ctlz_ult_bw_minus_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ctlz_ult_bw_minus_one_v2i32   : ctlz_ult_bw_minus_one_v2i32_before  ⊑  ctlz_ult_bw_minus_one_v2i32_combined := by
  unfold ctlz_ult_bw_minus_one_v2i32_before ctlz_ult_bw_minus_one_v2i32_combined
  simp_alive_peephole
  sorry
def ctlz_ult_bitwidth_v2i32_combined := [llvmfunc|
  llvm.func @ctlz_ult_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ctlz_ult_bitwidth_v2i32   : ctlz_ult_bitwidth_v2i32_before  ⊑  ctlz_ult_bitwidth_v2i32_combined := by
  unfold ctlz_ult_bitwidth_v2i32_before ctlz_ult_bitwidth_v2i32_combined
  simp_alive_peephole
  sorry
def cttz_ne_bitwidth_i33_combined := [llvmfunc|
  llvm.func @cttz_ne_bitwidth_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = llvm.icmp "ne" %arg0, %0 : i33
    llvm.return %1 : i1
  }]

theorem inst_combine_cttz_ne_bitwidth_i33   : cttz_ne_bitwidth_i33_before  ⊑  cttz_ne_bitwidth_i33_combined := by
  unfold cttz_ne_bitwidth_i33_before cttz_ne_bitwidth_i33_combined
  simp_alive_peephole
  sorry
def cttz_eq_bitwidth_v2i32_combined := [llvmfunc|
  llvm.func @cttz_eq_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_cttz_eq_bitwidth_v2i32   : cttz_eq_bitwidth_v2i32_before  ⊑  cttz_eq_bitwidth_v2i32_combined := by
  unfold cttz_eq_bitwidth_v2i32_before cttz_eq_bitwidth_v2i32_combined
  simp_alive_peephole
  sorry
def cttz_eq_zero_i33_combined := [llvmfunc|
  llvm.func @cttz_eq_zero_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(1 : i33) : i33
    %1 = llvm.mlir.constant(0 : i33) : i33
    %2 = llvm.and %arg0, %0  : i33
    %3 = llvm.icmp "ne" %2, %1 : i33
    llvm.return %3 : i1
  }]

theorem inst_combine_cttz_eq_zero_i33   : cttz_eq_zero_i33_before  ⊑  cttz_eq_zero_i33_combined := by
  unfold cttz_eq_zero_i33_before cttz_eq_zero_i33_combined
  simp_alive_peephole
  sorry
def cttz_ne_zero_v2i32_combined := [llvmfunc|
  llvm.func @cttz_ne_zero_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_cttz_ne_zero_v2i32   : cttz_ne_zero_v2i32_before  ⊑  cttz_ne_zero_v2i32_combined := by
  unfold cttz_ne_zero_v2i32_before cttz_ne_zero_v2i32_combined
  simp_alive_peephole
  sorry
def cttz_eq_bw_minus_1_i33_combined := [llvmfunc|
  llvm.func @cttz_eq_bw_minus_1_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(-4294967296 : i33) : i33
    %1 = llvm.icmp "eq" %arg0, %0 : i33
    llvm.return %1 : i1
  }]

theorem inst_combine_cttz_eq_bw_minus_1_i33   : cttz_eq_bw_minus_1_i33_before  ⊑  cttz_eq_bw_minus_1_i33_combined := by
  unfold cttz_eq_bw_minus_1_i33_before cttz_eq_bw_minus_1_i33_combined
  simp_alive_peephole
  sorry
def cttz_ne_bw_minus_1_v2i32_combined := [llvmfunc|
  llvm.func @cttz_ne_bw_minus_1_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_cttz_ne_bw_minus_1_v2i32   : cttz_ne_bw_minus_1_v2i32_before  ⊑  cttz_ne_bw_minus_1_v2i32_combined := by
  unfold cttz_ne_bw_minus_1_v2i32_before cttz_ne_bw_minus_1_v2i32_combined
  simp_alive_peephole
  sorry
def cttz_eq_other_i33_combined := [llvmfunc|
  llvm.func @cttz_eq_other_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(31 : i33) : i33
    %1 = llvm.mlir.constant(16 : i33) : i33
    %2 = llvm.and %arg0, %0  : i33
    %3 = llvm.icmp "eq" %2, %1 : i33
    llvm.return %3 : i1
  }]

theorem inst_combine_cttz_eq_other_i33   : cttz_eq_other_i33_before  ⊑  cttz_eq_other_i33_combined := by
  unfold cttz_eq_other_i33_before cttz_eq_other_i33_combined
  simp_alive_peephole
  sorry
def cttz_ne_other_v2i32_combined := [llvmfunc|
  llvm.func @cttz_ne_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_cttz_ne_other_v2i32   : cttz_ne_other_v2i32_before  ⊑  cttz_ne_other_v2i32_combined := by
  unfold cttz_ne_other_v2i32_before cttz_ne_other_v2i32_combined
  simp_alive_peephole
  sorry
def cttz_eq_other_i33_multiuse_combined := [llvmfunc|
  llvm.func @cttz_eq_other_i33_multiuse(%arg0: i33, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(4 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

theorem inst_combine_cttz_eq_other_i33_multiuse   : cttz_eq_other_i33_multiuse_before  ⊑  cttz_eq_other_i33_multiuse_combined := by
  unfold cttz_eq_other_i33_multiuse_before cttz_eq_other_i33_multiuse_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 4 : i64} : i33, !llvm.ptr]

theorem inst_combine_cttz_eq_other_i33_multiuse   : cttz_eq_other_i33_multiuse_before  ⊑  cttz_eq_other_i33_multiuse_combined := by
  unfold cttz_eq_other_i33_multiuse_before cttz_eq_other_i33_multiuse_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "eq" %1, %0 : i33
    llvm.return %2 : i1
  }]

theorem inst_combine_cttz_eq_other_i33_multiuse   : cttz_eq_other_i33_multiuse_before  ⊑  cttz_eq_other_i33_multiuse_combined := by
  unfold cttz_eq_other_i33_multiuse_before cttz_eq_other_i33_multiuse_combined
  simp_alive_peephole
  sorry
def cttz_ugt_zero_i33_combined := [llvmfunc|
  llvm.func @cttz_ugt_zero_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(1 : i33) : i33
    %1 = llvm.mlir.constant(0 : i33) : i33
    %2 = llvm.and %arg0, %0  : i33
    %3 = llvm.icmp "eq" %2, %1 : i33
    llvm.return %3 : i1
  }]

theorem inst_combine_cttz_ugt_zero_i33   : cttz_ugt_zero_i33_before  ⊑  cttz_ugt_zero_i33_combined := by
  unfold cttz_ugt_zero_i33_before cttz_ugt_zero_i33_combined
  simp_alive_peephole
  sorry
def cttz_ugt_one_i33_combined := [llvmfunc|
  llvm.func @cttz_ugt_one_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(3 : i33) : i33
    %1 = llvm.mlir.constant(0 : i33) : i33
    %2 = llvm.and %arg0, %0  : i33
    %3 = llvm.icmp "eq" %2, %1 : i33
    llvm.return %3 : i1
  }]

theorem inst_combine_cttz_ugt_one_i33   : cttz_ugt_one_i33_before  ⊑  cttz_ugt_one_i33_combined := by
  unfold cttz_ugt_one_i33_before cttz_ugt_one_i33_combined
  simp_alive_peephole
  sorry
def cttz_ugt_other_i33_combined := [llvmfunc|
  llvm.func @cttz_ugt_other_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(131071 : i33) : i33
    %1 = llvm.mlir.constant(0 : i33) : i33
    %2 = llvm.and %arg0, %0  : i33
    %3 = llvm.icmp "eq" %2, %1 : i33
    llvm.return %3 : i1
  }]

theorem inst_combine_cttz_ugt_other_i33   : cttz_ugt_other_i33_before  ⊑  cttz_ugt_other_i33_combined := by
  unfold cttz_ugt_other_i33_before cttz_ugt_other_i33_combined
  simp_alive_peephole
  sorry
def cttz_ugt_other_multiuse_i33_combined := [llvmfunc|
  llvm.func @cttz_ugt_other_multiuse_i33(%arg0: i33, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(16 : i33) : i33
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

theorem inst_combine_cttz_ugt_other_multiuse_i33   : cttz_ugt_other_multiuse_i33_before  ⊑  cttz_ugt_other_multiuse_i33_combined := by
  unfold cttz_ugt_other_multiuse_i33_before cttz_ugt_other_multiuse_i33_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 4 : i64} : i33, !llvm.ptr]

theorem inst_combine_cttz_ugt_other_multiuse_i33   : cttz_ugt_other_multiuse_i33_before  ⊑  cttz_ugt_other_multiuse_i33_combined := by
  unfold cttz_ugt_other_multiuse_i33_before cttz_ugt_other_multiuse_i33_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "ugt" %1, %0 : i33
    llvm.return %2 : i1
  }]

theorem inst_combine_cttz_ugt_other_multiuse_i33   : cttz_ugt_other_multiuse_i33_before  ⊑  cttz_ugt_other_multiuse_i33_combined := by
  unfold cttz_ugt_other_multiuse_i33_before cttz_ugt_other_multiuse_i33_combined
  simp_alive_peephole
  sorry
def cttz_ugt_bw_minus_one_i33_combined := [llvmfunc|
  llvm.func @cttz_ugt_bw_minus_one_i33(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = llvm.icmp "eq" %arg0, %0 : i33
    llvm.return %1 : i1
  }]

theorem inst_combine_cttz_ugt_bw_minus_one_i33   : cttz_ugt_bw_minus_one_i33_before  ⊑  cttz_ugt_bw_minus_one_i33_combined := by
  unfold cttz_ugt_bw_minus_one_i33_before cttz_ugt_bw_minus_one_i33_combined
  simp_alive_peephole
  sorry
def cttz_ult_one_v2i32_combined := [llvmfunc|
  llvm.func @cttz_ult_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_cttz_ult_one_v2i32   : cttz_ult_one_v2i32_before  ⊑  cttz_ult_one_v2i32_combined := by
  unfold cttz_ult_one_v2i32_before cttz_ult_one_v2i32_combined
  simp_alive_peephole
  sorry
def cttz_ult_other_v2i32_combined := [llvmfunc|
  llvm.func @cttz_ult_other_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_cttz_ult_other_v2i32   : cttz_ult_other_v2i32_before  ⊑  cttz_ult_other_v2i32_combined := by
  unfold cttz_ult_other_v2i32_before cttz_ult_other_v2i32_combined
  simp_alive_peephole
  sorry
def cttz_ult_other_multiuse_v2i32_combined := [llvmfunc|
  llvm.func @cttz_ult_other_multiuse_v2i32(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_cttz_ult_other_multiuse_v2i32   : cttz_ult_other_multiuse_v2i32_before  ⊑  cttz_ult_other_multiuse_v2i32_combined := by
  unfold cttz_ult_other_multiuse_v2i32_before cttz_ult_other_multiuse_v2i32_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

theorem inst_combine_cttz_ult_other_multiuse_v2i32   : cttz_ult_other_multiuse_v2i32_before  ⊑  cttz_ult_other_multiuse_v2i32_combined := by
  unfold cttz_ult_other_multiuse_v2i32_before cttz_ult_other_multiuse_v2i32_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_cttz_ult_other_multiuse_v2i32   : cttz_ult_other_multiuse_v2i32_before  ⊑  cttz_ult_other_multiuse_v2i32_combined := by
  unfold cttz_ult_other_multiuse_v2i32_before cttz_ult_other_multiuse_v2i32_combined
  simp_alive_peephole
  sorry
def cttz_ult_bw_minus_one_v2i32_combined := [llvmfunc|
  llvm.func @cttz_ult_bw_minus_one_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_cttz_ult_bw_minus_one_v2i32   : cttz_ult_bw_minus_one_v2i32_before  ⊑  cttz_ult_bw_minus_one_v2i32_combined := by
  unfold cttz_ult_bw_minus_one_v2i32_before cttz_ult_bw_minus_one_v2i32_combined
  simp_alive_peephole
  sorry
def cttz_ult_bitwidth_v2i32_combined := [llvmfunc|
  llvm.func @cttz_ult_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_cttz_ult_bitwidth_v2i32   : cttz_ult_bitwidth_v2i32_before  ⊑  cttz_ult_bitwidth_v2i32_combined := by
  unfold cttz_ult_bitwidth_v2i32_before cttz_ult_bitwidth_v2i32_combined
  simp_alive_peephole
  sorry
def ctpop_eq_zero_i11_combined := [llvmfunc|
  llvm.func @ctpop_eq_zero_i11(%arg0: i11) -> i1 {
    %0 = llvm.mlir.constant(0 : i11) : i11
    %1 = llvm.icmp "eq" %arg0, %0 : i11
    llvm.return %1 : i1
  }]

theorem inst_combine_ctpop_eq_zero_i11   : ctpop_eq_zero_i11_before  ⊑  ctpop_eq_zero_i11_combined := by
  unfold ctpop_eq_zero_i11_before ctpop_eq_zero_i11_combined
  simp_alive_peephole
  sorry
def ctpop_ne_zero_v2i32_combined := [llvmfunc|
  llvm.func @ctpop_ne_zero_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ctpop_ne_zero_v2i32   : ctpop_ne_zero_v2i32_before  ⊑  ctpop_ne_zero_v2i32_combined := by
  unfold ctpop_ne_zero_v2i32_before ctpop_ne_zero_v2i32_combined
  simp_alive_peephole
  sorry
def ctpop_eq_bitwidth_i8_combined := [llvmfunc|
  llvm.func @ctpop_eq_bitwidth_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ctpop_eq_bitwidth_i8   : ctpop_eq_bitwidth_i8_before  ⊑  ctpop_eq_bitwidth_i8_combined := by
  unfold ctpop_eq_bitwidth_i8_before ctpop_eq_bitwidth_i8_combined
  simp_alive_peephole
  sorry
def ctpop_ne_bitwidth_v2i32_combined := [llvmfunc|
  llvm.func @ctpop_ne_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ctpop_ne_bitwidth_v2i32   : ctpop_ne_bitwidth_v2i32_before  ⊑  ctpop_ne_bitwidth_v2i32_combined := by
  unfold ctpop_ne_bitwidth_v2i32_before ctpop_ne_bitwidth_v2i32_combined
  simp_alive_peephole
  sorry
def ctpop_ugt_bitwidth_minus_one_i8_combined := [llvmfunc|
  llvm.func @ctpop_ugt_bitwidth_minus_one_i8(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    llvm.store %1, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_ctpop_ugt_bitwidth_minus_one_i8   : ctpop_ugt_bitwidth_minus_one_i8_before  ⊑  ctpop_ugt_bitwidth_minus_one_i8_combined := by
  unfold ctpop_ugt_bitwidth_minus_one_i8_before ctpop_ugt_bitwidth_minus_one_i8_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_ctpop_ugt_bitwidth_minus_one_i8   : ctpop_ugt_bitwidth_minus_one_i8_before  ⊑  ctpop_ugt_bitwidth_minus_one_i8_combined := by
  unfold ctpop_ugt_bitwidth_minus_one_i8_before ctpop_ugt_bitwidth_minus_one_i8_combined
  simp_alive_peephole
  sorry
def ctpop_ult_bitwidth_v2i32_combined := [llvmfunc|
  llvm.func @ctpop_ult_bitwidth_v2i32(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ctpop_ult_bitwidth_v2i32   : ctpop_ult_bitwidth_v2i32_before  ⊑  ctpop_ult_bitwidth_v2i32_combined := by
  unfold ctpop_ult_bitwidth_v2i32_before ctpop_ult_bitwidth_v2i32_combined
  simp_alive_peephole
  sorry
def trunc_cttz_eq_other_i33_i15_combined := [llvmfunc|
  llvm.func @trunc_cttz_eq_other_i33_i15(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(31 : i33) : i33
    %1 = llvm.mlir.constant(16 : i33) : i33
    %2 = llvm.and %arg0, %0  : i33
    %3 = llvm.icmp "eq" %2, %1 : i33
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_cttz_eq_other_i33_i15   : trunc_cttz_eq_other_i33_i15_before  ⊑  trunc_cttz_eq_other_i33_i15_combined := by
  unfold trunc_cttz_eq_other_i33_i15_before trunc_cttz_eq_other_i33_i15_combined
  simp_alive_peephole
  sorry
def trunc_cttz_ugt_other_i33_i15_combined := [llvmfunc|
  llvm.func @trunc_cttz_ugt_other_i33_i15(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(15 : i33) : i33
    %1 = llvm.mlir.constant(0 : i33) : i33
    %2 = llvm.and %arg0, %0  : i33
    %3 = llvm.icmp "eq" %2, %1 : i33
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_cttz_ugt_other_i33_i15   : trunc_cttz_ugt_other_i33_i15_before  ⊑  trunc_cttz_ugt_other_i33_i15_combined := by
  unfold trunc_cttz_ugt_other_i33_i15_before trunc_cttz_ugt_other_i33_i15_combined
  simp_alive_peephole
  sorry
def trunc_cttz_ult_other_i33_i6_combined := [llvmfunc|
  llvm.func @trunc_cttz_ult_other_i33_i6(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(127 : i33) : i33
    %1 = llvm.mlir.constant(0 : i33) : i33
    %2 = llvm.and %arg0, %0  : i33
    %3 = llvm.icmp "ne" %2, %1 : i33
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_cttz_ult_other_i33_i6   : trunc_cttz_ult_other_i33_i6_before  ⊑  trunc_cttz_ult_other_i33_i6_combined := by
  unfold trunc_cttz_ult_other_i33_i6_before trunc_cttz_ult_other_i33_i6_combined
  simp_alive_peephole
  sorry
def trunc_cttz_ult_other_i33_i5_combined := [llvmfunc|
  llvm.func @trunc_cttz_ult_other_i33_i5(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i33) -> i33]

theorem inst_combine_trunc_cttz_ult_other_i33_i5   : trunc_cttz_ult_other_i33_i5_before  ⊑  trunc_cttz_ult_other_i33_i5_combined := by
  unfold trunc_cttz_ult_other_i33_i5_before trunc_cttz_ult_other_i33_i5_combined
  simp_alive_peephole
  sorry
    %2 = llvm.trunc %1 : i33 to i5
    %3 = llvm.icmp "ult" %2, %0 : i5
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_cttz_ult_other_i33_i5   : trunc_cttz_ult_other_i33_i5_before  ⊑  trunc_cttz_ult_other_i33_i5_combined := by
  unfold trunc_cttz_ult_other_i33_i5_before trunc_cttz_ult_other_i33_i5_combined
  simp_alive_peephole
  sorry
def trunc_cttz_true_ult_other_i32_i5_combined := [llvmfunc|
  llvm.func @trunc_cttz_true_ult_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_cttz_true_ult_other_i32_i5   : trunc_cttz_true_ult_other_i32_i5_before  ⊑  trunc_cttz_true_ult_other_i32_i5_combined := by
  unfold trunc_cttz_true_ult_other_i32_i5_before trunc_cttz_true_ult_other_i32_i5_combined
  simp_alive_peephole
  sorry
def trunc_cttz_false_ult_other_i32_i5_combined := [llvmfunc|
  llvm.func @trunc_cttz_false_ult_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_trunc_cttz_false_ult_other_i32_i5   : trunc_cttz_false_ult_other_i32_i5_before  ⊑  trunc_cttz_false_ult_other_i32_i5_combined := by
  unfold trunc_cttz_false_ult_other_i32_i5_before trunc_cttz_false_ult_other_i32_i5_combined
  simp_alive_peephole
  sorry
    %2 = llvm.trunc %1 : i32 to i5
    %3 = llvm.icmp "ult" %2, %0 : i5
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_cttz_false_ult_other_i32_i5   : trunc_cttz_false_ult_other_i32_i5_before  ⊑  trunc_cttz_false_ult_other_i32_i5_combined := by
  unfold trunc_cttz_false_ult_other_i32_i5_before trunc_cttz_false_ult_other_i32_i5_combined
  simp_alive_peephole
  sorry
def trunc_cttz_false_ult_other_i32_i6_combined := [llvmfunc|
  llvm.func @trunc_cttz_false_ult_other_i32_i6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_cttz_false_ult_other_i32_i6   : trunc_cttz_false_ult_other_i32_i6_before  ⊑  trunc_cttz_false_ult_other_i32_i6_combined := by
  unfold trunc_cttz_false_ult_other_i32_i6_before trunc_cttz_false_ult_other_i32_i6_combined
  simp_alive_peephole
  sorry
def trunc_cttz_false_ult_other_i32_i6_extra_use_combined := [llvmfunc|
  llvm.func @trunc_cttz_false_ult_other_i32_i6_extra_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i6) : i6
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_trunc_cttz_false_ult_other_i32_i6_extra_use   : trunc_cttz_false_ult_other_i32_i6_extra_use_before  ⊑  trunc_cttz_false_ult_other_i32_i6_extra_use_combined := by
  unfold trunc_cttz_false_ult_other_i32_i6_extra_use_before trunc_cttz_false_ult_other_i32_i6_extra_use_combined
  simp_alive_peephole
  sorry
    %2 = llvm.trunc %1 : i32 to i6
    llvm.call @use6(%2) : (i6) -> ()
    %3 = llvm.icmp "ult" %2, %0 : i6
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_cttz_false_ult_other_i32_i6_extra_use   : trunc_cttz_false_ult_other_i32_i6_extra_use_before  ⊑  trunc_cttz_false_ult_other_i32_i6_extra_use_combined := by
  unfold trunc_cttz_false_ult_other_i32_i6_extra_use_before trunc_cttz_false_ult_other_i32_i6_extra_use_combined
  simp_alive_peephole
  sorry
def trunc_ctlz_ugt_zero_i32_combined := [llvmfunc|
  llvm.func @trunc_ctlz_ugt_zero_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_trunc_ctlz_ugt_zero_i32   : trunc_ctlz_ugt_zero_i32_before  ⊑  trunc_ctlz_ugt_zero_i32_combined := by
  unfold trunc_ctlz_ugt_zero_i32_before trunc_ctlz_ugt_zero_i32_combined
  simp_alive_peephole
  sorry
def trunc_ctlz_ugt_one_i32_combined := [llvmfunc|
  llvm.func @trunc_ctlz_ugt_one_i32(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_trunc_ctlz_ugt_one_i32   : trunc_ctlz_ugt_one_i32_before  ⊑  trunc_ctlz_ugt_one_i32_combined := by
  unfold trunc_ctlz_ugt_one_i32_before trunc_ctlz_ugt_one_i32_combined
  simp_alive_peephole
  sorry
def trunc_ctlz_ugt_other_i33_i6_combined := [llvmfunc|
  llvm.func @trunc_ctlz_ugt_other_i33_i6(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(268435456 : i33) : i33
    %1 = llvm.icmp "ult" %arg0, %0 : i33
    llvm.return %1 : i1
  }]

theorem inst_combine_trunc_ctlz_ugt_other_i33_i6   : trunc_ctlz_ugt_other_i33_i6_before  ⊑  trunc_ctlz_ugt_other_i33_i6_combined := by
  unfold trunc_ctlz_ugt_other_i33_i6_before trunc_ctlz_ugt_other_i33_i6_combined
  simp_alive_peephole
  sorry
def trunc_ctlz_ugt_other_i33_i5_combined := [llvmfunc|
  llvm.func @trunc_ctlz_ugt_other_i33_i5(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i33) -> i33]

theorem inst_combine_trunc_ctlz_ugt_other_i33_i5   : trunc_ctlz_ugt_other_i33_i5_before  ⊑  trunc_ctlz_ugt_other_i33_i5_combined := by
  unfold trunc_ctlz_ugt_other_i33_i5_before trunc_ctlz_ugt_other_i33_i5_combined
  simp_alive_peephole
  sorry
    %2 = llvm.trunc %1 : i33 to i5
    %3 = llvm.icmp "ugt" %2, %0 : i5
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_ctlz_ugt_other_i33_i5   : trunc_ctlz_ugt_other_i33_i5_before  ⊑  trunc_ctlz_ugt_other_i33_i5_combined := by
  unfold trunc_ctlz_ugt_other_i33_i5_before trunc_ctlz_ugt_other_i33_i5_combined
  simp_alive_peephole
  sorry
def trunc_ctlz_true_ugt_other_i32_i5_combined := [llvmfunc|
  llvm.func @trunc_ctlz_true_ugt_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(134217728 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_trunc_ctlz_true_ugt_other_i32_i5   : trunc_ctlz_true_ugt_other_i32_i5_before  ⊑  trunc_ctlz_true_ugt_other_i32_i5_combined := by
  unfold trunc_ctlz_true_ugt_other_i32_i5_before trunc_ctlz_true_ugt_other_i32_i5_combined
  simp_alive_peephole
  sorry
def trunc_ctlz_false_ugt_other_i32_i5_combined := [llvmfunc|
  llvm.func @trunc_ctlz_false_ugt_other_i32_i5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_trunc_ctlz_false_ugt_other_i32_i5   : trunc_ctlz_false_ugt_other_i32_i5_before  ⊑  trunc_ctlz_false_ugt_other_i32_i5_combined := by
  unfold trunc_ctlz_false_ugt_other_i32_i5_before trunc_ctlz_false_ugt_other_i32_i5_combined
  simp_alive_peephole
  sorry
    %2 = llvm.trunc %1 : i32 to i5
    %3 = llvm.icmp "ugt" %2, %0 : i5
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_ctlz_false_ugt_other_i32_i5   : trunc_ctlz_false_ugt_other_i32_i5_before  ⊑  trunc_ctlz_false_ugt_other_i32_i5_combined := by
  unfold trunc_ctlz_false_ugt_other_i32_i5_before trunc_ctlz_false_ugt_other_i32_i5_combined
  simp_alive_peephole
  sorry
def trunc_ctlz_false_ugt_other_i32_i6_combined := [llvmfunc|
  llvm.func @trunc_ctlz_false_ugt_other_i32_i6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(134217728 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_trunc_ctlz_false_ugt_other_i32_i6   : trunc_ctlz_false_ugt_other_i32_i6_before  ⊑  trunc_ctlz_false_ugt_other_i32_i6_combined := by
  unfold trunc_ctlz_false_ugt_other_i32_i6_before trunc_ctlz_false_ugt_other_i32_i6_combined
  simp_alive_peephole
  sorry
def trunc_ctlz_false_ugt_other_i32_i6_extra_use_combined := [llvmfunc|
  llvm.func @trunc_ctlz_false_ugt_other_i32_i6_extra_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i6) : i6
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_trunc_ctlz_false_ugt_other_i32_i6_extra_use   : trunc_ctlz_false_ugt_other_i32_i6_extra_use_before  ⊑  trunc_ctlz_false_ugt_other_i32_i6_extra_use_combined := by
  unfold trunc_ctlz_false_ugt_other_i32_i6_extra_use_before trunc_ctlz_false_ugt_other_i32_i6_extra_use_combined
  simp_alive_peephole
  sorry
    %2 = llvm.trunc %1 : i32 to i6
    llvm.call @use6(%2) : (i6) -> ()
    %3 = llvm.icmp "ugt" %2, %0 : i6
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_ctlz_false_ugt_other_i32_i6_extra_use   : trunc_ctlz_false_ugt_other_i32_i6_extra_use_before  ⊑  trunc_ctlz_false_ugt_other_i32_i6_extra_use_combined := by
  unfold trunc_ctlz_false_ugt_other_i32_i6_extra_use_before trunc_ctlz_false_ugt_other_i32_i6_extra_use_combined
  simp_alive_peephole
  sorry
def trunc_ctpop_eq_zero_i11_combined := [llvmfunc|
  llvm.func @trunc_ctpop_eq_zero_i11(%arg0: i11) -> i1 {
    %0 = llvm.mlir.constant(0 : i11) : i11
    %1 = llvm.icmp "eq" %arg0, %0 : i11
    llvm.return %1 : i1
  }]

theorem inst_combine_trunc_ctpop_eq_zero_i11   : trunc_ctpop_eq_zero_i11_before  ⊑  trunc_ctpop_eq_zero_i11_combined := by
  unfold trunc_ctpop_eq_zero_i11_before trunc_ctpop_eq_zero_i11_combined
  simp_alive_peephole
  sorry
def trunc_ctpop_eq_bitwidth_i8_combined := [llvmfunc|
  llvm.func @trunc_ctpop_eq_bitwidth_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_trunc_ctpop_eq_bitwidth_i8   : trunc_ctpop_eq_bitwidth_i8_before  ⊑  trunc_ctpop_eq_bitwidth_i8_combined := by
  unfold trunc_ctpop_eq_bitwidth_i8_before trunc_ctpop_eq_bitwidth_i8_combined
  simp_alive_peephole
  sorry
def trunc_negative_destbits_not_enough_combined := [llvmfunc|
  llvm.func @trunc_negative_destbits_not_enough(%arg0: i33) -> i1 {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i33) -> i33]

theorem inst_combine_trunc_negative_destbits_not_enough   : trunc_negative_destbits_not_enough_before  ⊑  trunc_negative_destbits_not_enough_combined := by
  unfold trunc_negative_destbits_not_enough_before trunc_negative_destbits_not_enough_combined
  simp_alive_peephole
  sorry
    %2 = llvm.trunc %1 : i33 to i4
    %3 = llvm.icmp "ult" %2, %0 : i4
    llvm.return %3 : i1
  }]

theorem inst_combine_trunc_negative_destbits_not_enough   : trunc_negative_destbits_not_enough_before  ⊑  trunc_negative_destbits_not_enough_combined := by
  unfold trunc_negative_destbits_not_enough_before trunc_negative_destbits_not_enough_combined
  simp_alive_peephole
  sorry
def bitreverse_ne_22_combined := [llvmfunc|
  llvm.func @bitreverse_ne_22(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(104 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_bitreverse_ne_22   : bitreverse_ne_22_before  ⊑  bitreverse_ne_22_combined := by
  unfold bitreverse_ne_22_before bitreverse_ne_22_combined
  simp_alive_peephole
  sorry
def bitreverse_ult_22_fail_not_equality_pred_combined := [llvmfunc|
  llvm.func @bitreverse_ult_22_fail_not_equality_pred(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(22 : i8) : i8
    %1 = llvm.intr.bitreverse(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_bitreverse_ult_22_fail_not_equality_pred   : bitreverse_ult_22_fail_not_equality_pred_before  ⊑  bitreverse_ult_22_fail_not_equality_pred_combined := by
  unfold bitreverse_ult_22_fail_not_equality_pred_before bitreverse_ult_22_fail_not_equality_pred_combined
  simp_alive_peephole
  sorry
def bitreverse_vec_eq_2_2_combined := [llvmfunc|
  llvm.func @bitreverse_vec_eq_2_2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_bitreverse_vec_eq_2_2   : bitreverse_vec_eq_2_2_before  ⊑  bitreverse_vec_eq_2_2_combined := by
  unfold bitreverse_vec_eq_2_2_before bitreverse_vec_eq_2_2_combined
  simp_alive_peephole
  sorry
def bitreverse_vec_eq_1_2_todo_no_splat_combined := [llvmfunc|
  llvm.func @bitreverse_vec_eq_1_2_todo_no_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.bitreverse(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_bitreverse_vec_eq_1_2_todo_no_splat   : bitreverse_vec_eq_1_2_todo_no_splat_before  ⊑  bitreverse_vec_eq_1_2_todo_no_splat_combined := by
  unfold bitreverse_vec_eq_1_2_todo_no_splat_before bitreverse_vec_eq_1_2_todo_no_splat_combined
  simp_alive_peephole
  sorry
def umax_eq_zero_combined := [llvmfunc|
  llvm.func @umax_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_umax_eq_zero   : umax_eq_zero_before  ⊑  umax_eq_zero_combined := by
  unfold umax_eq_zero_before umax_eq_zero_combined
  simp_alive_peephole
  sorry
def umax_eq_1_fail_combined := [llvmfunc|
  llvm.func @umax_eq_1_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_umax_eq_1_fail   : umax_eq_1_fail_before  ⊑  umax_eq_1_fail_combined := by
  unfold umax_eq_1_fail_before umax_eq_1_fail_combined
  simp_alive_peephole
  sorry
def umax_sle_zero_fail_combined := [llvmfunc|
  llvm.func @umax_sle_zero_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_umax_sle_zero_fail   : umax_sle_zero_fail_before  ⊑  umax_sle_zero_fail_combined := by
  unfold umax_sle_zero_fail_before umax_sle_zero_fail_combined
  simp_alive_peephole
  sorry
def umax_ne_zero_combined := [llvmfunc|
  llvm.func @umax_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_umax_ne_zero   : umax_ne_zero_before  ⊑  umax_ne_zero_combined := by
  unfold umax_ne_zero_before umax_ne_zero_combined
  simp_alive_peephole
  sorry
def umax_ne_zero_fail_multiuse_combined := [llvmfunc|
  llvm.func @umax_ne_zero_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_umax_ne_zero_fail_multiuse   : umax_ne_zero_fail_multiuse_before  ⊑  umax_ne_zero_fail_multiuse_combined := by
  unfold umax_ne_zero_fail_multiuse_before umax_ne_zero_fail_multiuse_combined
  simp_alive_peephole
  sorry
def uadd_sat_ne_zero_fail_multiuse_combined := [llvmfunc|
  llvm.func @uadd_sat_ne_zero_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_uadd_sat_ne_zero_fail_multiuse   : uadd_sat_ne_zero_fail_multiuse_before  ⊑  uadd_sat_ne_zero_fail_multiuse_combined := by
  unfold uadd_sat_ne_zero_fail_multiuse_before uadd_sat_ne_zero_fail_multiuse_combined
  simp_alive_peephole
  sorry
def ssub_sat_ne_zero_combined := [llvmfunc|
  llvm.func @ssub_sat_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ssub_sat_ne_zero   : ssub_sat_ne_zero_before  ⊑  ssub_sat_ne_zero_combined := by
  unfold ssub_sat_ne_zero_before ssub_sat_ne_zero_combined
  simp_alive_peephole
  sorry
def ssub_sat_ne_fail_nonzero_combined := [llvmfunc|
  llvm.func @ssub_sat_ne_fail_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_ssub_sat_ne_fail_nonzero   : ssub_sat_ne_fail_nonzero_before  ⊑  ssub_sat_ne_fail_nonzero_combined := by
  unfold ssub_sat_ne_fail_nonzero_before ssub_sat_ne_fail_nonzero_combined
  simp_alive_peephole
  sorry
def ssub_sat_eq_zero_combined := [llvmfunc|
  llvm.func @ssub_sat_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ssub_sat_eq_zero   : ssub_sat_eq_zero_before  ⊑  ssub_sat_eq_zero_combined := by
  unfold ssub_sat_eq_zero_before ssub_sat_eq_zero_combined
  simp_alive_peephole
  sorry
def ssub_sat_sle_zero_combined := [llvmfunc|
  llvm.func @ssub_sat_sle_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ssub_sat_sle_zero   : ssub_sat_sle_zero_before  ⊑  ssub_sat_sle_zero_combined := by
  unfold ssub_sat_sle_zero_before ssub_sat_sle_zero_combined
  simp_alive_peephole
  sorry
def ssub_sat_sge_zero_combined := [llvmfunc|
  llvm.func @ssub_sat_sge_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ssub_sat_sge_zero   : ssub_sat_sge_zero_before  ⊑  ssub_sat_sge_zero_combined := by
  unfold ssub_sat_sge_zero_before ssub_sat_sge_zero_combined
  simp_alive_peephole
  sorry
def ssub_sat_slt_zero_combined := [llvmfunc|
  llvm.func @ssub_sat_slt_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ssub_sat_slt_zero   : ssub_sat_slt_zero_before  ⊑  ssub_sat_slt_zero_combined := by
  unfold ssub_sat_slt_zero_before ssub_sat_slt_zero_combined
  simp_alive_peephole
  sorry
def ssub_sat_slt_neg1_fail_combined := [llvmfunc|
  llvm.func @ssub_sat_slt_neg1_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_ssub_sat_slt_neg1_fail   : ssub_sat_slt_neg1_fail_before  ⊑  ssub_sat_slt_neg1_fail_combined := by
  unfold ssub_sat_slt_neg1_fail_before ssub_sat_slt_neg1_fail_combined
  simp_alive_peephole
  sorry
def ssub_sat_sgt_zero_combined := [llvmfunc|
  llvm.func @ssub_sat_sgt_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ssub_sat_sgt_zero   : ssub_sat_sgt_zero_before  ⊑  ssub_sat_sgt_zero_combined := by
  unfold ssub_sat_sgt_zero_before ssub_sat_sgt_zero_combined
  simp_alive_peephole
  sorry
def ssub_sat_sgt_one_fail_combined := [llvmfunc|
  llvm.func @ssub_sat_sgt_one_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_ssub_sat_sgt_one_fail   : ssub_sat_sgt_one_fail_before  ⊑  ssub_sat_sgt_one_fail_combined := by
  unfold ssub_sat_sgt_one_fail_before ssub_sat_sgt_one_fail_combined
  simp_alive_peephole
  sorry
