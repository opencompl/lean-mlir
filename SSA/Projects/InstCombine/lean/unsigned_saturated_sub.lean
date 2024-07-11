import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unsigned_saturated_sub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def usub_sat_C1_C2_before := [llvmfunc|
  llvm.func @usub_sat_C1_C2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.intr.usub.sat(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def usub_sat_C1_C2_produce_0_before := [llvmfunc|
  llvm.func @usub_sat_C1_C2_produce_0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nuw>  : i32
    %2 = llvm.intr.usub.sat(%1, %0)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

def usub_sat_C1_C2_produce_0_too_before := [llvmfunc|
  llvm.func @usub_sat_C1_C2_produce_0_too(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.intr.usub.sat(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def usub_sat_C1_C2_splat_before := [llvmfunc|
  llvm.func @usub_sat_C1_C2_splat(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<14> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def usub_sat_C1_C2_non_splat_before := [llvmfunc|
  llvm.func @usub_sat_C1_C2_non_splat(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[50, 64]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[20, 14]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def usub_sat_C1_C2_splat_produce_0_before := [llvmfunc|
  llvm.func @usub_sat_C1_C2_splat_produce_0(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<14> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %2 = llvm.intr.usub.sat(%1, %0)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

def usub_sat_C1_C2_splat_produce_0_too_before := [llvmfunc|
  llvm.func @usub_sat_C1_C2_splat_produce_0_too(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<14> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def usub_sat_C1_C2_non_splat_produce_0_too_before := [llvmfunc|
  llvm.func @usub_sat_C1_C2_non_splat_produce_0_too(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[12, 13]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[14, 15]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def usub_sat_C1_C2_without_nuw_before := [llvmfunc|
  llvm.func @usub_sat_C1_C2_without_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.intr.usub.sat(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

def max_sub_ugt_before := [llvmfunc|
  llvm.func @max_sub_ugt(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.return %3 : i64
  }]

def max_sub_uge_before := [llvmfunc|
  llvm.func @max_sub_uge(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.return %3 : i64
  }]

def max_sub_uge_extrause1_before := [llvmfunc|
  llvm.func @max_sub_uge_extrause1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.return %3 : i64
  }]

def max_sub_uge_extrause2_before := [llvmfunc|
  llvm.func @max_sub_uge_extrause2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.call @usei1(%1) : (i1) -> ()
    llvm.return %3 : i64
  }]

def max_sub_uge_extrause3_before := [llvmfunc|
  llvm.func @max_sub_uge_extrause3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.call @usei1(%1) : (i1) -> ()
    llvm.return %3 : i64
  }]

def max_sub_ugt_vec_before := [llvmfunc|
  llvm.func @max_sub_ugt_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "ugt" %arg0, %arg1 : vector<4xi32>
    %3 = llvm.sub %arg0, %arg1  : vector<4xi32>
    %4 = llvm.select %2, %3, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def max_sub_ult_before := [llvmfunc|
  llvm.func @max_sub_ult(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ult" %arg1, %arg0 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    %4 = llvm.sub %arg1, %arg0  : i64
    llvm.call @use(%4) : (i64) -> ()
    llvm.return %3 : i64
  }]

def max_sub_ugt_sel_swapped_before := [llvmfunc|
  llvm.func @max_sub_ugt_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.sub %arg1, %arg0  : i64
    llvm.call @use(%4) : (i64) -> ()
    llvm.return %3 : i64
  }]

def max_sub_ult_sel_swapped_before := [llvmfunc|
  llvm.func @max_sub_ult_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ult" %arg0, %arg1 : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    llvm.return %3 : i64
  }]

def neg_max_sub_ugt_before := [llvmfunc|
  llvm.func @neg_max_sub_ugt(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    %4 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use(%4) : (i64) -> ()
    llvm.return %3 : i64
  }]

def neg_max_sub_ult_before := [llvmfunc|
  llvm.func @neg_max_sub_ult(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ult" %arg1, %arg0 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    llvm.return %3 : i64
  }]

def neg_max_sub_ugt_sel_swapped_before := [llvmfunc|
  llvm.func @neg_max_sub_ugt_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    llvm.return %3 : i64
  }]

def neg_max_sub_ugt_sel_swapped_extrause1_before := [llvmfunc|
  llvm.func @neg_max_sub_ugt_sel_swapped_extrause1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    llvm.call @usei1(%1) : (i1) -> ()
    llvm.return %3 : i64
  }]

def neg_max_sub_ugt_sel_swapped_extrause2_before := [llvmfunc|
  llvm.func @neg_max_sub_ugt_sel_swapped_extrause2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.return %3 : i64
  }]

def neg_max_sub_ugt_sel_swapped_extrause3_before := [llvmfunc|
  llvm.func @neg_max_sub_ugt_sel_swapped_extrause3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.call @usei1(%1) : (i1) -> ()
    llvm.return %3 : i64
  }]

def neg_max_sub_ult_sel_swapped_before := [llvmfunc|
  llvm.func @neg_max_sub_ult_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ult" %arg0, %arg1 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use(%4) : (i64) -> ()
    llvm.return %3 : i64
  }]

def max_sub_ugt_c1_before := [llvmfunc|
  llvm.func @max_sub_ugt_c1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def max_sub_ugt_c01_before := [llvmfunc|
  llvm.func @max_sub_ugt_c01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.add %arg0, %1  : i32
    %4 = llvm.select %2, %3, %0 : i1, i32
    llvm.return %4 : i32
  }]

def max_sub_ugt_c10_before := [llvmfunc|
  llvm.func @max_sub_ugt_c10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def max_sub_ugt_c910_before := [llvmfunc|
  llvm.func @max_sub_ugt_c910(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def max_sub_ugt_c1110_before := [llvmfunc|
  llvm.func @max_sub_ugt_c1110(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def max_sub_ugt_c0_before := [llvmfunc|
  llvm.func @max_sub_ugt_c0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.add %arg0, %1  : i32
    %4 = llvm.select %2, %3, %1 : i1, i32
    llvm.return %4 : i32
  }]

def max_sub_ugt_cmiss_before := [llvmfunc|
  llvm.func @max_sub_ugt_cmiss(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def max_sub_ult_c1_before := [llvmfunc|
  llvm.func @max_sub_ult_c1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def max_sub_ult_c2_before := [llvmfunc|
  llvm.func @max_sub_ult_c2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def max_sub_ult_c2_oneuseicmp_before := [llvmfunc|
  llvm.func @max_sub_ult_c2_oneuseicmp(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.call @usei1(%3) : (i1) -> ()
    llvm.return %5 : i32
  }]

def max_sub_ult_c2_oneusesub_before := [llvmfunc|
  llvm.func @max_sub_ult_c2_oneusesub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.call @usei32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

def max_sub_ult_c32_before := [llvmfunc|
  llvm.func @max_sub_ult_c32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def max_sub_ugt_c32_before := [llvmfunc|
  llvm.func @max_sub_ugt_c32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %0, %arg0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def max_sub_uge_c32_before := [llvmfunc|
  llvm.func @max_sub_uge_c32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "uge" %0, %arg0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def max_sub_ult_c12_before := [llvmfunc|
  llvm.func @max_sub_ult_c12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def max_sub_ult_c0_before := [llvmfunc|
  llvm.func @max_sub_ult_c0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.add %arg0, %1  : i32
    %4 = llvm.select %2, %3, %0 : i1, i32
    llvm.return %4 : i32
  }]

def usub_sat_C1_C2_combined := [llvmfunc|
  llvm.func @usub_sat_C1_C2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.intr.usub.sat(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_usub_sat_C1_C2   : usub_sat_C1_C2_before  ⊑  usub_sat_C1_C2_combined := by
  unfold usub_sat_C1_C2_before usub_sat_C1_C2_combined
  simp_alive_peephole
  sorry
def usub_sat_C1_C2_produce_0_combined := [llvmfunc|
  llvm.func @usub_sat_C1_C2_produce_0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nuw>  : i32
    %2 = llvm.intr.usub.sat(%1, %0)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_usub_sat_C1_C2_produce_0   : usub_sat_C1_C2_produce_0_before  ⊑  usub_sat_C1_C2_produce_0_combined := by
  unfold usub_sat_C1_C2_produce_0_before usub_sat_C1_C2_produce_0_combined
  simp_alive_peephole
  sorry
def usub_sat_C1_C2_produce_0_too_combined := [llvmfunc|
  llvm.func @usub_sat_C1_C2_produce_0_too(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.intr.usub.sat(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_usub_sat_C1_C2_produce_0_too   : usub_sat_C1_C2_produce_0_too_before  ⊑  usub_sat_C1_C2_produce_0_too_combined := by
  unfold usub_sat_C1_C2_produce_0_too_before usub_sat_C1_C2_produce_0_too_combined
  simp_alive_peephole
  sorry
def usub_sat_C1_C2_splat_combined := [llvmfunc|
  llvm.func @usub_sat_C1_C2_splat(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<14> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_usub_sat_C1_C2_splat   : usub_sat_C1_C2_splat_before  ⊑  usub_sat_C1_C2_splat_combined := by
  unfold usub_sat_C1_C2_splat_before usub_sat_C1_C2_splat_combined
  simp_alive_peephole
  sorry
def usub_sat_C1_C2_non_splat_combined := [llvmfunc|
  llvm.func @usub_sat_C1_C2_non_splat(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[50, 64]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[20, 14]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_usub_sat_C1_C2_non_splat   : usub_sat_C1_C2_non_splat_before  ⊑  usub_sat_C1_C2_non_splat_combined := by
  unfold usub_sat_C1_C2_non_splat_before usub_sat_C1_C2_non_splat_combined
  simp_alive_peephole
  sorry
def usub_sat_C1_C2_splat_produce_0_combined := [llvmfunc|
  llvm.func @usub_sat_C1_C2_splat_produce_0(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<14> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %2 = llvm.intr.usub.sat(%1, %0)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_usub_sat_C1_C2_splat_produce_0   : usub_sat_C1_C2_splat_produce_0_before  ⊑  usub_sat_C1_C2_splat_produce_0_combined := by
  unfold usub_sat_C1_C2_splat_produce_0_before usub_sat_C1_C2_splat_produce_0_combined
  simp_alive_peephole
  sorry
def usub_sat_C1_C2_splat_produce_0_too_combined := [llvmfunc|
  llvm.func @usub_sat_C1_C2_splat_produce_0_too(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<14> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_usub_sat_C1_C2_splat_produce_0_too   : usub_sat_C1_C2_splat_produce_0_too_before  ⊑  usub_sat_C1_C2_splat_produce_0_too_combined := by
  unfold usub_sat_C1_C2_splat_produce_0_too_before usub_sat_C1_C2_splat_produce_0_too_combined
  simp_alive_peephole
  sorry
def usub_sat_C1_C2_non_splat_produce_0_too_combined := [llvmfunc|
  llvm.func @usub_sat_C1_C2_non_splat_produce_0_too(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[12, 13]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[14, 15]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_usub_sat_C1_C2_non_splat_produce_0_too   : usub_sat_C1_C2_non_splat_produce_0_too_before  ⊑  usub_sat_C1_C2_non_splat_produce_0_too_combined := by
  unfold usub_sat_C1_C2_non_splat_produce_0_too_before usub_sat_C1_C2_non_splat_produce_0_too_combined
  simp_alive_peephole
  sorry
def usub_sat_C1_C2_without_nuw_combined := [llvmfunc|
  llvm.func @usub_sat_C1_C2_without_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.intr.usub.sat(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_usub_sat_C1_C2_without_nuw   : usub_sat_C1_C2_without_nuw_before  ⊑  usub_sat_C1_C2_without_nuw_combined := by
  unfold usub_sat_C1_C2_without_nuw_before usub_sat_C1_C2_without_nuw_combined
  simp_alive_peephole
  sorry
def max_sub_ugt_combined := [llvmfunc|
  llvm.func @max_sub_ugt(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_max_sub_ugt   : max_sub_ugt_before  ⊑  max_sub_ugt_combined := by
  unfold max_sub_ugt_before max_sub_ugt_combined
  simp_alive_peephole
  sorry
def max_sub_uge_combined := [llvmfunc|
  llvm.func @max_sub_uge(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_max_sub_uge   : max_sub_uge_before  ⊑  max_sub_uge_combined := by
  unfold max_sub_uge_before max_sub_uge_combined
  simp_alive_peephole
  sorry
def max_sub_uge_extrause1_combined := [llvmfunc|
  llvm.func @max_sub_uge_extrause1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sub %arg0, %arg1  : i64
    %1 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    llvm.call @use(%0) : (i64) -> ()
    llvm.return %1 : i64
  }]

theorem inst_combine_max_sub_uge_extrause1   : max_sub_uge_extrause1_before  ⊑  max_sub_uge_extrause1_combined := by
  unfold max_sub_uge_extrause1_before max_sub_uge_extrause1_combined
  simp_alive_peephole
  sorry
def max_sub_uge_extrause2_combined := [llvmfunc|
  llvm.func @max_sub_uge_extrause2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    llvm.call @usei1(%0) : (i1) -> ()
    llvm.return %1 : i64
  }]

theorem inst_combine_max_sub_uge_extrause2   : max_sub_uge_extrause2_before  ⊑  max_sub_uge_extrause2_combined := by
  unfold max_sub_uge_extrause2_before max_sub_uge_extrause2_combined
  simp_alive_peephole
  sorry
def max_sub_uge_extrause3_combined := [llvmfunc|
  llvm.func @max_sub_uge_extrause3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.call @usei1(%0) : (i1) -> ()
    llvm.return %2 : i64
  }]

theorem inst_combine_max_sub_uge_extrause3   : max_sub_uge_extrause3_before  ⊑  max_sub_uge_extrause3_combined := by
  unfold max_sub_uge_extrause3_before max_sub_uge_extrause3_combined
  simp_alive_peephole
  sorry
def max_sub_ugt_vec_combined := [llvmfunc|
  llvm.func @max_sub_ugt_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_max_sub_ugt_vec   : max_sub_ugt_vec_before  ⊑  max_sub_ugt_vec_combined := by
  unfold max_sub_ugt_vec_before max_sub_ugt_vec_combined
  simp_alive_peephole
  sorry
def max_sub_ult_combined := [llvmfunc|
  llvm.func @max_sub_ult(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    %1 = llvm.sub %arg1, %arg0  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %0 : i64
  }]

theorem inst_combine_max_sub_ult   : max_sub_ult_before  ⊑  max_sub_ult_combined := by
  unfold max_sub_ult_before max_sub_ult_combined
  simp_alive_peephole
  sorry
def max_sub_ugt_sel_swapped_combined := [llvmfunc|
  llvm.func @max_sub_ugt_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    %1 = llvm.sub %arg1, %arg0  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %0 : i64
  }]

theorem inst_combine_max_sub_ugt_sel_swapped   : max_sub_ugt_sel_swapped_before  ⊑  max_sub_ugt_sel_swapped_combined := by
  unfold max_sub_ugt_sel_swapped_before max_sub_ugt_sel_swapped_combined
  simp_alive_peephole
  sorry
def max_sub_ult_sel_swapped_combined := [llvmfunc|
  llvm.func @max_sub_ult_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_max_sub_ult_sel_swapped   : max_sub_ult_sel_swapped_before  ⊑  max_sub_ult_sel_swapped_combined := by
  unfold max_sub_ult_sel_swapped_before max_sub_ult_sel_swapped_combined
  simp_alive_peephole
  sorry
def neg_max_sub_ugt_combined := [llvmfunc|
  llvm.func @neg_max_sub_ugt(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    %2 = llvm.sub %0, %1  : i64
    %3 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use(%3) : (i64) -> ()
    llvm.return %2 : i64
  }]

theorem inst_combine_neg_max_sub_ugt   : neg_max_sub_ugt_before  ⊑  neg_max_sub_ugt_combined := by
  unfold neg_max_sub_ugt_before neg_max_sub_ugt_combined
  simp_alive_peephole
  sorry
def neg_max_sub_ult_combined := [llvmfunc|
  llvm.func @neg_max_sub_ult(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_neg_max_sub_ult   : neg_max_sub_ult_before  ⊑  neg_max_sub_ult_combined := by
  unfold neg_max_sub_ult_before neg_max_sub_ult_combined
  simp_alive_peephole
  sorry
def neg_max_sub_ugt_sel_swapped_combined := [llvmfunc|
  llvm.func @neg_max_sub_ugt_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_neg_max_sub_ugt_sel_swapped   : neg_max_sub_ugt_sel_swapped_before  ⊑  neg_max_sub_ugt_sel_swapped_combined := by
  unfold neg_max_sub_ugt_sel_swapped_before neg_max_sub_ugt_sel_swapped_combined
  simp_alive_peephole
  sorry
def neg_max_sub_ugt_sel_swapped_extrause1_combined := [llvmfunc|
  llvm.func @neg_max_sub_ugt_sel_swapped_extrause1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    %3 = llvm.sub %0, %2  : i64
    llvm.call @usei1(%1) : (i1) -> ()
    llvm.return %3 : i64
  }]

theorem inst_combine_neg_max_sub_ugt_sel_swapped_extrause1   : neg_max_sub_ugt_sel_swapped_extrause1_before  ⊑  neg_max_sub_ugt_sel_swapped_extrause1_combined := by
  unfold neg_max_sub_ugt_sel_swapped_extrause1_before neg_max_sub_ugt_sel_swapped_extrause1_combined
  simp_alive_peephole
  sorry
def neg_max_sub_ugt_sel_swapped_extrause2_combined := [llvmfunc|
  llvm.func @neg_max_sub_ugt_sel_swapped_extrause2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg1, %arg0  : i64
    %2 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    %3 = llvm.sub %0, %2  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %3 : i64
  }]

theorem inst_combine_neg_max_sub_ugt_sel_swapped_extrause2   : neg_max_sub_ugt_sel_swapped_extrause2_before  ⊑  neg_max_sub_ugt_sel_swapped_extrause2_combined := by
  unfold neg_max_sub_ugt_sel_swapped_extrause2_before neg_max_sub_ugt_sel_swapped_extrause2_combined
  simp_alive_peephole
  sorry
def neg_max_sub_ugt_sel_swapped_extrause3_combined := [llvmfunc|
  llvm.func @neg_max_sub_ugt_sel_swapped_extrause3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.call @usei1(%1) : (i1) -> ()
    llvm.return %3 : i64
  }]

theorem inst_combine_neg_max_sub_ugt_sel_swapped_extrause3   : neg_max_sub_ugt_sel_swapped_extrause3_before  ⊑  neg_max_sub_ugt_sel_swapped_extrause3_combined := by
  unfold neg_max_sub_ugt_sel_swapped_extrause3_before neg_max_sub_ugt_sel_swapped_extrause3_combined
  simp_alive_peephole
  sorry
def neg_max_sub_ult_sel_swapped_combined := [llvmfunc|
  llvm.func @neg_max_sub_ult_sel_swapped(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.intr.usub.sat(%arg0, %arg1)  : (i64, i64) -> i64
    %2 = llvm.sub %0, %1  : i64
    %3 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use(%3) : (i64) -> ()
    llvm.return %2 : i64
  }]

theorem inst_combine_neg_max_sub_ult_sel_swapped   : neg_max_sub_ult_sel_swapped_before  ⊑  neg_max_sub_ult_sel_swapped_combined := by
  unfold neg_max_sub_ult_sel_swapped_before neg_max_sub_ult_sel_swapped_combined
  simp_alive_peephole
  sorry
def max_sub_ugt_c1_combined := [llvmfunc|
  llvm.func @max_sub_ugt_c1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_max_sub_ugt_c1   : max_sub_ugt_c1_before  ⊑  max_sub_ugt_c1_combined := by
  unfold max_sub_ugt_c1_before max_sub_ugt_c1_combined
  simp_alive_peephole
  sorry
def max_sub_ugt_c01_combined := [llvmfunc|
  llvm.func @max_sub_ugt_c01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_max_sub_ugt_c01   : max_sub_ugt_c01_before  ⊑  max_sub_ugt_c01_combined := by
  unfold max_sub_ugt_c01_before max_sub_ugt_c01_combined
  simp_alive_peephole
  sorry
def max_sub_ugt_c10_combined := [llvmfunc|
  llvm.func @max_sub_ugt_c10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_max_sub_ugt_c10   : max_sub_ugt_c10_before  ⊑  max_sub_ugt_c10_combined := by
  unfold max_sub_ugt_c10_before max_sub_ugt_c10_combined
  simp_alive_peephole
  sorry
def max_sub_ugt_c910_combined := [llvmfunc|
  llvm.func @max_sub_ugt_c910(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_max_sub_ugt_c910   : max_sub_ugt_c910_before  ⊑  max_sub_ugt_c910_combined := by
  unfold max_sub_ugt_c910_before max_sub_ugt_c910_combined
  simp_alive_peephole
  sorry
def max_sub_ugt_c1110_combined := [llvmfunc|
  llvm.func @max_sub_ugt_c1110(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_max_sub_ugt_c1110   : max_sub_ugt_c1110_before  ⊑  max_sub_ugt_c1110_combined := by
  unfold max_sub_ugt_c1110_before max_sub_ugt_c1110_combined
  simp_alive_peephole
  sorry
def max_sub_ugt_c0_combined := [llvmfunc|
  llvm.func @max_sub_ugt_c0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_max_sub_ugt_c0   : max_sub_ugt_c0_before  ⊑  max_sub_ugt_c0_combined := by
  unfold max_sub_ugt_c0_before max_sub_ugt_c0_combined
  simp_alive_peephole
  sorry
def max_sub_ugt_cmiss_combined := [llvmfunc|
  llvm.func @max_sub_ugt_cmiss(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_max_sub_ugt_cmiss   : max_sub_ugt_cmiss_before  ⊑  max_sub_ugt_cmiss_combined := by
  unfold max_sub_ugt_cmiss_before max_sub_ugt_cmiss_combined
  simp_alive_peephole
  sorry
def max_sub_ult_c1_combined := [llvmfunc|
  llvm.func @max_sub_ult_c1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_max_sub_ult_c1   : max_sub_ult_c1_before  ⊑  max_sub_ult_c1_combined := by
  unfold max_sub_ult_c1_before max_sub_ult_c1_combined
  simp_alive_peephole
  sorry
def max_sub_ult_c2_combined := [llvmfunc|
  llvm.func @max_sub_ult_c2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.usub.sat(%0, %arg0)  : (i32, i32) -> i32
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_max_sub_ult_c2   : max_sub_ult_c2_before  ⊑  max_sub_ult_c2_combined := by
  unfold max_sub_ult_c2_before max_sub_ult_c2_combined
  simp_alive_peephole
  sorry
def max_sub_ult_c2_oneuseicmp_combined := [llvmfunc|
  llvm.func @max_sub_ult_c2_oneuseicmp(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.intr.usub.sat(%0, %arg0)  : (i32, i32) -> i32
    %4 = llvm.sub %1, %3 overflow<nsw>  : i32
    llvm.call @usei1(%2) : (i1) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_max_sub_ult_c2_oneuseicmp   : max_sub_ult_c2_oneuseicmp_before  ⊑  max_sub_ult_c2_oneuseicmp_combined := by
  unfold max_sub_ult_c2_oneuseicmp_before max_sub_ult_c2_oneuseicmp_combined
  simp_alive_peephole
  sorry
def max_sub_ult_c2_oneusesub_combined := [llvmfunc|
  llvm.func @max_sub_ult_c2_oneusesub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.intr.usub.sat(%1, %arg0)  : (i32, i32) -> i32
    %5 = llvm.sub %2, %4 overflow<nsw>  : i32
    llvm.call @usei32(%3) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_max_sub_ult_c2_oneusesub   : max_sub_ult_c2_oneusesub_before  ⊑  max_sub_ult_c2_oneusesub_combined := by
  unfold max_sub_ult_c2_oneusesub_before max_sub_ult_c2_oneusesub_combined
  simp_alive_peephole
  sorry
def max_sub_ult_c32_combined := [llvmfunc|
  llvm.func @max_sub_ult_c32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_max_sub_ult_c32   : max_sub_ult_c32_before  ⊑  max_sub_ult_c32_combined := by
  unfold max_sub_ult_c32_before max_sub_ult_c32_combined
  simp_alive_peephole
  sorry
def max_sub_ugt_c32_combined := [llvmfunc|
  llvm.func @max_sub_ugt_c32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_max_sub_ugt_c32   : max_sub_ugt_c32_before  ⊑  max_sub_ugt_c32_combined := by
  unfold max_sub_ugt_c32_before max_sub_ugt_c32_combined
  simp_alive_peephole
  sorry
def max_sub_uge_c32_combined := [llvmfunc|
  llvm.func @max_sub_uge_c32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_max_sub_uge_c32   : max_sub_uge_c32_before  ⊑  max_sub_uge_c32_combined := by
  unfold max_sub_uge_c32_before max_sub_uge_c32_combined
  simp_alive_peephole
  sorry
def max_sub_ult_c12_combined := [llvmfunc|
  llvm.func @max_sub_ult_c12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_max_sub_ult_c12   : max_sub_ult_c12_before  ⊑  max_sub_ult_c12_combined := by
  unfold max_sub_ult_c12_before max_sub_ult_c12_combined
  simp_alive_peephole
  sorry
def max_sub_ult_c0_combined := [llvmfunc|
  llvm.func @max_sub_ult_c0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_max_sub_ult_c0   : max_sub_ult_c0_before  ⊑  max_sub_ult_c0_combined := by
  unfold max_sub_ult_c0_before max_sub_ult_c0_combined
  simp_alive_peephole
  sorry
