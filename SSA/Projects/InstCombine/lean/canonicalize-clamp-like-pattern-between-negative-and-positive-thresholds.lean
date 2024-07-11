import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-clamp-like-pattern-between-negative-and-positive-thresholds
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_ult_slt_128_before := [llvmfunc|
  llvm.func @t0_ult_slt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def t1_ult_slt_0_before := [llvmfunc|
  llvm.func @t1_ult_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def t2_ult_sgt_128_before := [llvmfunc|
  llvm.func @t2_ult_sgt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg2, %arg1 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def t3_ult_sgt_neg1_before := [llvmfunc|
  llvm.func @t3_ult_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg2, %arg1 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def t4_ugt_slt_128_before := [llvmfunc|
  llvm.func @t4_ugt_slt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(143 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    %7 = llvm.select %6, %4, %arg0 : i1, i32
    llvm.return %7 : i32
  }]

def t5_ugt_slt_0_before := [llvmfunc|
  llvm.func @t5_ugt_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(143 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    %7 = llvm.select %6, %4, %arg0 : i1, i32
    llvm.return %7 : i32
  }]

def t6_ugt_sgt_128_before := [llvmfunc|
  llvm.func @t6_ugt_sgt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(143 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg2, %arg1 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    %7 = llvm.select %6, %4, %arg0 : i1, i32
    llvm.return %7 : i32
  }]

def t7_ugt_sgt_neg1_before := [llvmfunc|
  llvm.func @t7_ugt_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(143 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg2, %arg1 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    %7 = llvm.select %6, %4, %arg0 : i1, i32
    llvm.return %7 : i32
  }]

def n8_ult_slt_129_before := [llvmfunc|
  llvm.func @n8_ult_slt_129(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(129 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def n9_ult_slt_neg17_before := [llvmfunc|
  llvm.func @n9_ult_slt_neg17(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def n10_ugt_slt_before := [llvmfunc|
  llvm.func @n10_ugt_slt(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def n11_uge_slt_before := [llvmfunc|
  llvm.func @n11_uge_slt(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(129 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }]

def n12_ule_slt_before := [llvmfunc|
  llvm.func @n12_ule_slt(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }]

def t10_oneuse0_before := [llvmfunc|
  llvm.func @t10_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def n11_oneuse1_before := [llvmfunc|
  llvm.func @n11_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def t12_oneuse2_before := [llvmfunc|
  llvm.func @t12_oneuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def n13_oneuse3_before := [llvmfunc|
  llvm.func @n13_oneuse3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def n14_oneuse4_before := [llvmfunc|
  llvm.func @n14_oneuse4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def n15_oneuse5_before := [llvmfunc|
  llvm.func @n15_oneuse5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def n16_oneuse6_before := [llvmfunc|
  llvm.func @n16_oneuse6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def n17_oneuse7_before := [llvmfunc|
  llvm.func @n17_oneuse7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def n18_oneuse8_before := [llvmfunc|
  llvm.func @n18_oneuse8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def n19_oneuse9_before := [llvmfunc|
  llvm.func @n19_oneuse9(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

def t20_ult_slt_vec_splat_before := [llvmfunc|
  llvm.func @t20_ult_slt_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<144> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %5 = llvm.add %arg0, %1  : vector<2xi32>
    %6 = llvm.icmp "ult" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %arg0, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def t21_ult_slt_vec_nonsplat_before := [llvmfunc|
  llvm.func @t21_ult_slt_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[128, 64]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[16, 8]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[144, 264]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %5 = llvm.add %arg0, %1  : vector<2xi32>
    %6 = llvm.icmp "ult" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %arg0, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def t22_uge_slt_before := [llvmfunc|
  llvm.func @t22_uge_slt(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[144, 0]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %5 = llvm.add %arg0, %1  : vector<2xi32>
    %6 = llvm.icmp "uge" %5, %2 : vector<2xi32>
    llvm.call @use2xi1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.select %6, %4, %arg0 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def t23_ult_sge_before := [llvmfunc|
  llvm.func @t23_ult_sge(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[128, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[16, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[144, -1]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sge" %arg0, %0 : vector<2xi32>
    llvm.call @use2xi1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.select %3, %arg2, %arg1 : vector<2xi1>, vector<2xi32>
    %5 = llvm.add %arg0, %1  : vector<2xi32>
    %6 = llvm.icmp "ult" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %arg0, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def t0_ult_slt_128_combined := [llvmfunc|
  llvm.func @t0_ult_slt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t0_ult_slt_128   : t0_ult_slt_128_before  ⊑  t0_ult_slt_128_combined := by
  unfold t0_ult_slt_128_before t0_ult_slt_128_combined
  simp_alive_peephole
  sorry
def t1_ult_slt_0_combined := [llvmfunc|
  llvm.func @t1_ult_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t1_ult_slt_0   : t1_ult_slt_0_before  ⊑  t1_ult_slt_0_combined := by
  unfold t1_ult_slt_0_before t1_ult_slt_0_combined
  simp_alive_peephole
  sorry
def t2_ult_sgt_128_combined := [llvmfunc|
  llvm.func @t2_ult_sgt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t2_ult_sgt_128   : t2_ult_sgt_128_before  ⊑  t2_ult_sgt_128_combined := by
  unfold t2_ult_sgt_128_before t2_ult_sgt_128_combined
  simp_alive_peephole
  sorry
def t3_ult_sgt_neg1_combined := [llvmfunc|
  llvm.func @t3_ult_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t3_ult_sgt_neg1   : t3_ult_sgt_neg1_before  ⊑  t3_ult_sgt_neg1_combined := by
  unfold t3_ult_sgt_neg1_before t3_ult_sgt_neg1_combined
  simp_alive_peephole
  sorry
def t4_ugt_slt_128_combined := [llvmfunc|
  llvm.func @t4_ugt_slt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t4_ugt_slt_128   : t4_ugt_slt_128_before  ⊑  t4_ugt_slt_128_combined := by
  unfold t4_ugt_slt_128_before t4_ugt_slt_128_combined
  simp_alive_peephole
  sorry
def t5_ugt_slt_0_combined := [llvmfunc|
  llvm.func @t5_ugt_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t5_ugt_slt_0   : t5_ugt_slt_0_before  ⊑  t5_ugt_slt_0_combined := by
  unfold t5_ugt_slt_0_before t5_ugt_slt_0_combined
  simp_alive_peephole
  sorry
def t6_ugt_sgt_128_combined := [llvmfunc|
  llvm.func @t6_ugt_sgt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t6_ugt_sgt_128   : t6_ugt_sgt_128_before  ⊑  t6_ugt_sgt_128_combined := by
  unfold t6_ugt_sgt_128_before t6_ugt_sgt_128_combined
  simp_alive_peephole
  sorry
def t7_ugt_sgt_neg1_combined := [llvmfunc|
  llvm.func @t7_ugt_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t7_ugt_sgt_neg1   : t7_ugt_sgt_neg1_before  ⊑  t7_ugt_sgt_neg1_combined := by
  unfold t7_ugt_sgt_neg1_before t7_ugt_sgt_neg1_combined
  simp_alive_peephole
  sorry
def n8_ult_slt_129_combined := [llvmfunc|
  llvm.func @n8_ult_slt_129(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(129 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n8_ult_slt_129   : n8_ult_slt_129_before  ⊑  n8_ult_slt_129_combined := by
  unfold n8_ult_slt_129_before n8_ult_slt_129_combined
  simp_alive_peephole
  sorry
def n9_ult_slt_neg17_combined := [llvmfunc|
  llvm.func @n9_ult_slt_neg17(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n9_ult_slt_neg17   : n9_ult_slt_neg17_before  ⊑  n9_ult_slt_neg17_combined := by
  unfold n9_ult_slt_neg17_before n9_ult_slt_neg17_combined
  simp_alive_peephole
  sorry
def n10_ugt_slt_combined := [llvmfunc|
  llvm.func @n10_ugt_slt(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n10_ugt_slt   : n10_ugt_slt_before  ⊑  n10_ugt_slt_combined := by
  unfold n10_ugt_slt_before n10_ugt_slt_combined
  simp_alive_peephole
  sorry
def n11_uge_slt_combined := [llvmfunc|
  llvm.func @n11_uge_slt(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(129 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n11_uge_slt   : n11_uge_slt_before  ⊑  n11_uge_slt_combined := by
  unfold n11_uge_slt_before n11_uge_slt_combined
  simp_alive_peephole
  sorry
def n12_ule_slt_combined := [llvmfunc|
  llvm.func @n12_ule_slt(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n12_ule_slt   : n12_ule_slt_before  ⊑  n12_ule_slt_combined := by
  unfold n12_ule_slt_before n12_ule_slt_combined
  simp_alive_peephole
  sorry
def t10_oneuse0_combined := [llvmfunc|
  llvm.func @t10_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(127 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.icmp "sgt" %arg0, %2 : i32
    %6 = llvm.select %4, %arg1, %arg0 : i1, i32
    %7 = llvm.select %5, %arg2, %6 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_t10_oneuse0   : t10_oneuse0_before  ⊑  t10_oneuse0_combined := by
  unfold t10_oneuse0_before t10_oneuse0_combined
  simp_alive_peephole
  sorry
def n11_oneuse1_combined := [llvmfunc|
  llvm.func @n11_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n11_oneuse1   : n11_oneuse1_before  ⊑  n11_oneuse1_combined := by
  unfold n11_oneuse1_before n11_oneuse1_combined
  simp_alive_peephole
  sorry
def t12_oneuse2_combined := [llvmfunc|
  llvm.func @t12_oneuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(127 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.icmp "sgt" %arg0, %2 : i32
    %6 = llvm.select %4, %arg1, %arg0 : i1, i32
    %7 = llvm.select %5, %arg2, %6 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_t12_oneuse2   : t12_oneuse2_before  ⊑  t12_oneuse2_combined := by
  unfold t12_oneuse2_before t12_oneuse2_combined
  simp_alive_peephole
  sorry
def n13_oneuse3_combined := [llvmfunc|
  llvm.func @n13_oneuse3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n13_oneuse3   : n13_oneuse3_before  ⊑  n13_oneuse3_combined := by
  unfold n13_oneuse3_before n13_oneuse3_combined
  simp_alive_peephole
  sorry
def n14_oneuse4_combined := [llvmfunc|
  llvm.func @n14_oneuse4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n14_oneuse4   : n14_oneuse4_before  ⊑  n14_oneuse4_combined := by
  unfold n14_oneuse4_before n14_oneuse4_combined
  simp_alive_peephole
  sorry
def n15_oneuse5_combined := [llvmfunc|
  llvm.func @n15_oneuse5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n15_oneuse5   : n15_oneuse5_before  ⊑  n15_oneuse5_combined := by
  unfold n15_oneuse5_before n15_oneuse5_combined
  simp_alive_peephole
  sorry
def n16_oneuse6_combined := [llvmfunc|
  llvm.func @n16_oneuse6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n16_oneuse6   : n16_oneuse6_before  ⊑  n16_oneuse6_combined := by
  unfold n16_oneuse6_before n16_oneuse6_combined
  simp_alive_peephole
  sorry
def n17_oneuse7_combined := [llvmfunc|
  llvm.func @n17_oneuse7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n17_oneuse7   : n17_oneuse7_before  ⊑  n17_oneuse7_combined := by
  unfold n17_oneuse7_before n17_oneuse7_combined
  simp_alive_peephole
  sorry
def n18_oneuse8_combined := [llvmfunc|
  llvm.func @n18_oneuse8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n18_oneuse8   : n18_oneuse8_before  ⊑  n18_oneuse8_combined := by
  unfold n18_oneuse8_before n18_oneuse8_combined
  simp_alive_peephole
  sorry
def n19_oneuse9_combined := [llvmfunc|
  llvm.func @n19_oneuse9(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n19_oneuse9   : n19_oneuse9_before  ⊑  n19_oneuse9_combined := by
  unfold n19_oneuse9_before n19_oneuse9_combined
  simp_alive_peephole
  sorry
def t20_ult_slt_vec_splat_combined := [llvmfunc|
  llvm.func @t20_ult_slt_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<127> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %1 : vector<2xi32>
    %4 = llvm.select %2, %arg1, %arg0 : vector<2xi1>, vector<2xi32>
    %5 = llvm.select %3, %arg2, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_t20_ult_slt_vec_splat   : t20_ult_slt_vec_splat_before  ⊑  t20_ult_slt_vec_splat_combined := by
  unfold t20_ult_slt_vec_splat_before t20_ult_slt_vec_splat_combined
  simp_alive_peephole
  sorry
def t21_ult_slt_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t21_ult_slt_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-16, -8]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[127, 255]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %1 : vector<2xi32>
    %4 = llvm.select %2, %arg1, %arg0 : vector<2xi1>, vector<2xi32>
    %5 = llvm.select %3, %arg2, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_t21_ult_slt_vec_nonsplat   : t21_ult_slt_vec_nonsplat_before  ⊑  t21_ult_slt_vec_nonsplat_combined := by
  unfold t21_ult_slt_vec_nonsplat_before t21_ult_slt_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def t22_uge_slt_combined := [llvmfunc|
  llvm.func @t22_uge_slt(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[144, 0]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %5 = llvm.add %arg0, %1  : vector<2xi32>
    %6 = llvm.icmp "uge" %5, %2 : vector<2xi32>
    llvm.call @use2xi1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.select %6, %4, %arg0 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_t22_uge_slt   : t22_uge_slt_before  ⊑  t22_uge_slt_combined := by
  unfold t22_uge_slt_before t22_uge_slt_combined
  simp_alive_peephole
  sorry
def t23_ult_sge_combined := [llvmfunc|
  llvm.func @t23_ult_sge(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[128, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-16, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[127, 2147483646]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sge" %arg0, %0 : vector<2xi32>
    llvm.call @use2xi1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %5 = llvm.icmp "sgt" %arg0, %2 : vector<2xi32>
    %6 = llvm.select %4, %arg1, %arg0 : vector<2xi1>, vector<2xi32>
    %7 = llvm.select %5, %arg2, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_t23_ult_sge   : t23_ult_sge_before  ⊑  t23_ult_sge_combined := by
  unfold t23_ult_sge_before t23_ult_sge_combined
  simp_alive_peephole
  sorry
