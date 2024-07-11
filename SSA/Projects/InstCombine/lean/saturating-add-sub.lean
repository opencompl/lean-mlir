import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  saturating-add-sub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_scalar_uadd_canonical_before := [llvmfunc|
  llvm.func @test_scalar_uadd_canonical(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.intr.uadd.sat(%0, %arg0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

def test_vector_uadd_canonical_before := [llvmfunc|
  llvm.func @test_vector_uadd_canonical(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.uadd.sat(%0, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def test_scalar_sadd_canonical_before := [llvmfunc|
  llvm.func @test_scalar_sadd_canonical(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.intr.sadd.sat(%0, %arg0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

def test_vector_sadd_canonical_before := [llvmfunc|
  llvm.func @test_vector_sadd_canonical(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, -20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.sadd.sat(%0, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def test_scalar_uadd_combine_before := [llvmfunc|
  llvm.func @test_scalar_uadd_combine(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.intr.uadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_uadd_combine_before := [llvmfunc|
  llvm.func @test_vector_uadd_combine(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.uadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.uadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_vector_uadd_combine_non_splat_before := [llvmfunc|
  llvm.func @test_vector_uadd_combine_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[30, 40]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.uadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.uadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_uadd_overflow_before := [llvmfunc|
  llvm.func @test_scalar_uadd_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-56 : i8) : i8
    %2 = llvm.intr.uadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_uadd_overflow_before := [llvmfunc|
  llvm.func @test_vector_uadd_overflow(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<100> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-56> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.uadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.uadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_sadd_both_positive_before := [llvmfunc|
  llvm.func @test_scalar_sadd_both_positive(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_sadd_both_positive_before := [llvmfunc|
  llvm.func @test_vector_sadd_both_positive(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.sadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.sadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_sadd_both_negative_before := [llvmfunc|
  llvm.func @test_scalar_sadd_both_negative(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(-20 : i8) : i8
    %2 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_sadd_both_negative_before := [llvmfunc|
  llvm.func @test_vector_sadd_both_negative(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-20> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.sadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.sadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_sadd_different_sign_before := [llvmfunc|
  llvm.func @test_scalar_sadd_different_sign(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(-20 : i8) : i8
    %2 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_sadd_overflow_before := [llvmfunc|
  llvm.func @test_scalar_sadd_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.intr.sadd.sat(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def test_scalar_uadd_neg_neg_before := [llvmfunc|
  llvm.func @test_scalar_uadd_neg_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_uadd_neg_neg_before := [llvmfunc|
  llvm.func @test_vector_uadd_neg_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.uadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_uadd_nneg_nneg_before := [llvmfunc|
  llvm.func @test_scalar_uadd_nneg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_uadd_nneg_nneg_before := [llvmfunc|
  llvm.func @test_vector_uadd_nneg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.uadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_uadd_neg_nneg_before := [llvmfunc|
  llvm.func @test_scalar_uadd_neg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_uadd_neg_nneg_before := [llvmfunc|
  llvm.func @test_vector_uadd_neg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.uadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_uadd_never_overflows_before := [llvmfunc|
  llvm.func @test_scalar_uadd_never_overflows(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_uadd_never_overflows_before := [llvmfunc|
  llvm.func @test_vector_uadd_never_overflows(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.uadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_uadd_always_overflows_before := [llvmfunc|
  llvm.func @test_scalar_uadd_always_overflows(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_uadd_always_overflows_before := [llvmfunc|
  llvm.func @test_vector_uadd_always_overflows(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-64> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<64> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.uadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_sadd_neg_nneg_before := [llvmfunc|
  llvm.func @test_scalar_sadd_neg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_sadd_neg_nneg_before := [llvmfunc|
  llvm.func @test_vector_sadd_neg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.sadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_sadd_nneg_neg_before := [llvmfunc|
  llvm.func @test_scalar_sadd_nneg_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_sadd_nneg_neg_before := [llvmfunc|
  llvm.func @test_vector_sadd_nneg_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.sadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_sadd_neg_neg_before := [llvmfunc|
  llvm.func @test_scalar_sadd_neg_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_sadd_neg_neg_before := [llvmfunc|
  llvm.func @test_vector_sadd_neg_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.sadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_sadd_always_overflows_low_before := [llvmfunc|
  llvm.func @test_scalar_sadd_always_overflows_low(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-120 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.intr.sadd.sat(%3, %1)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def test_scalar_sadd_always_overflows_high_before := [llvmfunc|
  llvm.func @test_scalar_sadd_always_overflows_high(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(120 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.intr.sadd.sat(%3, %1)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def test_scalar_uadd_sub_nuw_lost_no_ov_before := [llvmfunc|
  llvm.func @test_scalar_uadd_sub_nuw_lost_no_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.sub %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_uadd_urem_no_ov_before := [llvmfunc|
  llvm.func @test_scalar_uadd_urem_no_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-100 : i8) : i8
    %2 = llvm.urem %arg0, %0  : i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_uadd_urem_may_ov_before := [llvmfunc|
  llvm.func @test_scalar_uadd_urem_may_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-99 : i8) : i8
    %2 = llvm.urem %arg0, %0  : i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_uadd_udiv_known_bits_before := [llvmfunc|
  llvm.func @test_scalar_uadd_udiv_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-66 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.udiv %0, %arg0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.intr.uadd.sat(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def test_scalar_sadd_srem_no_ov_before := [llvmfunc|
  llvm.func @test_scalar_sadd_srem_no_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(28 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_sadd_srem_may_ov_before := [llvmfunc|
  llvm.func @test_scalar_sadd_srem_may_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(29 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_sadd_srem_and_no_ov_before := [llvmfunc|
  llvm.func @test_scalar_sadd_srem_and_no_ov(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.intr.sadd.sat(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def test_scalar_usub_canonical_before := [llvmfunc|
  llvm.func @test_scalar_usub_canonical(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

def test_scalar_ssub_canonical_before := [llvmfunc|
  llvm.func @test_scalar_ssub_canonical(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

def test_vector_ssub_canonical_before := [llvmfunc|
  llvm.func @test_vector_ssub_canonical(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ssub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def test_vector_ssub_canonical_min_non_splat_before := [llvmfunc|
  llvm.func @test_vector_ssub_canonical_min_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, -10]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ssub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def test_scalar_ssub_canonical_min_before := [llvmfunc|
  llvm.func @test_scalar_ssub_canonical_min(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

def test_vector_ssub_canonical_min_before := [llvmfunc|
  llvm.func @test_vector_ssub_canonical_min(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-128, -10]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ssub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def test_scalar_usub_combine_before := [llvmfunc|
  llvm.func @test_scalar_usub_combine(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_simplify_decrement_before := [llvmfunc|
  llvm.func @test_simplify_decrement(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.sub %arg0, %1  : i8
    %4 = llvm.select %2, %0, %3 : i1, i8
    llvm.return %4 : i8
  }]

def test_simplify_decrement_ne_before := [llvmfunc|
  llvm.func @test_simplify_decrement_ne(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use.i1(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %1  : i8
    %4 = llvm.select %2, %3, %0 : i1, i8
    llvm.return %4 : i8
  }]

def test_simplify_decrement_vec_before := [llvmfunc|
  llvm.func @test_simplify_decrement_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %4 = llvm.sub %arg0, %2  : vector<2xi8>
    %5 = llvm.select %3, %1, %4 : vector<2xi1>, vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def test_simplify_decrement_vec_poison_before := [llvmfunc|
  llvm.func @test_simplify_decrement_vec_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %10 = llvm.sub %arg0, %2  : vector<2xi8>
    %11 = llvm.select %9, %8, %10 : vector<2xi1>, vector<2xi8>
    llvm.return %11 : vector<2xi8>
  }]

def test_simplify_decrement_invalid_ne_before := [llvmfunc|
  llvm.func @test_simplify_decrement_invalid_ne(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.sub %arg0, %1  : i8
    %4 = llvm.select %2, %0, %3 : i1, i8
    llvm.return %4 : i8
  }]

def test_invalid_simplify_sub2_before := [llvmfunc|
  llvm.func @test_invalid_simplify_sub2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.sub %arg0, %1  : i8
    %4 = llvm.select %2, %0, %3 : i1, i8
    llvm.return %4 : i8
  }]

def test_invalid_simplify_eq2_before := [llvmfunc|
  llvm.func @test_invalid_simplify_eq2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.sub %arg0, %1  : i8
    %5 = llvm.select %3, %2, %4 : i1, i8
    llvm.return %5 : i8
  }]

def test_invalid_simplify_select_1_before := [llvmfunc|
  llvm.func @test_invalid_simplify_select_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.sub %arg0, %1  : i8
    %4 = llvm.select %2, %1, %3 : i1, i8
    llvm.return %4 : i8
  }]

def test_invalid_simplify_other_before := [llvmfunc|
  llvm.func @test_invalid_simplify_other(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.sub %arg1, %1  : i8
    %4 = llvm.select %2, %0, %3 : i1, i8
    llvm.return %4 : i8
  }]

def test_vector_usub_combine_before := [llvmfunc|
  llvm.func @test_vector_usub_combine(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_vector_usub_combine_non_splat_before := [llvmfunc|
  llvm.func @test_vector_usub_combine_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[30, 40]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_usub_overflow_before := [llvmfunc|
  llvm.func @test_scalar_usub_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-56 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_usub_overflow_before := [llvmfunc|
  llvm.func @test_vector_usub_overflow(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<100> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-56> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_ssub_both_positive_before := [llvmfunc|
  llvm.func @test_scalar_ssub_both_positive(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.intr.ssub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.ssub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_ssub_both_positive_before := [llvmfunc|
  llvm.func @test_vector_ssub_both_positive(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.ssub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.ssub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_ssub_both_negative_before := [llvmfunc|
  llvm.func @test_scalar_ssub_both_negative(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(-20 : i8) : i8
    %2 = llvm.intr.ssub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.ssub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_ssub_both_negative_before := [llvmfunc|
  llvm.func @test_vector_ssub_both_negative(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-20> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.ssub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.ssub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_ssub_different_sign_before := [llvmfunc|
  llvm.func @test_scalar_ssub_different_sign(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(-20 : i8) : i8
    %2 = llvm.intr.ssub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.ssub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_sadd_ssub_before := [llvmfunc|
  llvm.func @test_scalar_sadd_ssub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(-20 : i8) : i8
    %2 = llvm.intr.sadd.sat(%0, %arg0)  : (i8, i8) -> i8
    %3 = llvm.intr.ssub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_sadd_ssub_before := [llvmfunc|
  llvm.func @test_vector_sadd_ssub(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.sadd.sat(%0, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.ssub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_ssub_overflow_before := [llvmfunc|
  llvm.func @test_scalar_ssub_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.intr.ssub.sat(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def test_scalar_usub_nneg_neg_before := [llvmfunc|
  llvm.func @test_scalar_usub_nneg_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_usub_nneg_neg_before := [llvmfunc|
  llvm.func @test_vector_usub_nneg_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_usub_neg_nneg_before := [llvmfunc|
  llvm.func @test_scalar_usub_neg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_usub_neg_nneg_before := [llvmfunc|
  llvm.func @test_vector_usub_neg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_usub_nneg_nneg_before := [llvmfunc|
  llvm.func @test_scalar_usub_nneg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_usub_nneg_nneg_before := [llvmfunc|
  llvm.func @test_vector_usub_nneg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_usub_never_overflows_before := [llvmfunc|
  llvm.func @test_scalar_usub_never_overflows(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_usub_never_overflows_before := [llvmfunc|
  llvm.func @test_vector_usub_never_overflows(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_usub_always_overflows_before := [llvmfunc|
  llvm.func @test_scalar_usub_always_overflows(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(100 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_usub_always_overflows_before := [llvmfunc|
  llvm.func @test_vector_usub_always_overflows(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<100> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_ssub_neg_neg_before := [llvmfunc|
  llvm.func @test_scalar_ssub_neg_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.ssub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_ssub_neg_neg_before := [llvmfunc|
  llvm.func @test_vector_ssub_neg_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ssub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_ssub_nneg_nneg_before := [llvmfunc|
  llvm.func @test_scalar_ssub_nneg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.ssub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_ssub_nneg_nneg_before := [llvmfunc|
  llvm.func @test_vector_ssub_nneg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ssub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_ssub_neg_nneg_before := [llvmfunc|
  llvm.func @test_scalar_ssub_neg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.ssub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_vector_ssub_neg_nneg_before := [llvmfunc|
  llvm.func @test_vector_ssub_neg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ssub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_ssub_always_overflows_low_before := [llvmfunc|
  llvm.func @test_scalar_ssub_always_overflows_low(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(120 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.intr.ssub.sat(%1, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def test_scalar_ssub_always_overflows_high_before := [llvmfunc|
  llvm.func @test_scalar_ssub_always_overflows_high(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-120 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.intr.ssub.sat(%1, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def test_scalar_usub_add_nuw_no_ov_before := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_no_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_usub_add_nuw_nsw_no_ov_before := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_nsw_no_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_usub_add_nuw_eq_before := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_eq(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %2 = llvm.intr.usub.sat(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def test_scalar_usub_add_nuw_may_ov_before := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_may_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_usub_urem_must_ov_before := [llvmfunc|
  llvm.func @test_scalar_usub_urem_must_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.urem %arg0, %0  : i8
    %2 = llvm.intr.usub.sat(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def test_scalar_usub_urem_must_zero_before := [llvmfunc|
  llvm.func @test_scalar_usub_urem_must_zero(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.urem %arg0, %0  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_usub_add_nuw_known_bits_before := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.intr.usub.sat(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def test_scalar_usub_add_nuw_inferred_before := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_inferred(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.add %2, %1  : i8
    llvm.return %3 : i8
  }]

def test_vector_usub_add_nuw_no_ov_before := [llvmfunc|
  llvm.func @test_vector_usub_add_nuw_no_ov(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<9> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_vector_usub_add_nuw_no_ov_nonsplat1_before := [llvmfunc|
  llvm.func @test_vector_usub_add_nuw_no_ov_nonsplat1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 9]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_vector_usub_add_nuw_no_ov_nonsplat1_poison_before := [llvmfunc|
  llvm.func @test_vector_usub_add_nuw_no_ov_nonsplat1_poison(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(9 : i8) : i8
    %3 = llvm.mlir.constant(10 : i8) : i8
    %4 = llvm.mlir.undef : vector<3xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<3xi8>
    %11 = llvm.add %arg0, %0 overflow<nuw>  : vector<3xi8>
    %12 = llvm.intr.usub.sat(%11, %10)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

def test_vector_usub_add_nuw_no_ov_nonsplat2_before := [llvmfunc|
  llvm.func @test_vector_usub_add_nuw_no_ov_nonsplat2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, 9]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<9> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_vector_usub_add_nuw_no_ov_nonsplat3_before := [llvmfunc|
  llvm.func @test_vector_usub_add_nuw_no_ov_nonsplat3(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, 9]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %2 = llvm.intr.usub.sat(%1, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def test_scalar_ssub_add_nsw_no_ov_before := [llvmfunc|
  llvm.func @test_scalar_ssub_add_nsw_no_ov(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.intr.ssub.sat(%1, %2)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

def test_scalar_ssub_add_nsw_may_ov_before := [llvmfunc|
  llvm.func @test_scalar_ssub_add_nsw_may_ov(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.intr.ssub.sat(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def test_vector_ssub_add_nsw_no_ov_splat_before := [llvmfunc|
  llvm.func @test_vector_ssub_add_nsw_no_ov_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.intr.ssub.sat(%1, %2)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_vector_ssub_add_nsw_no_ov_nonsplat1_before := [llvmfunc|
  llvm.func @test_vector_ssub_add_nsw_no_ov_nonsplat1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[7, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.and %arg1, %1  : vector<2xi8>
    %4 = llvm.intr.ssub.sat(%2, %3)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def test_vector_ssub_add_nsw_no_ov_nonsplat2_before := [llvmfunc|
  llvm.func @test_vector_ssub_add_nsw_no_ov_nonsplat2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[7, 8]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.and %arg1, %1  : vector<2xi8>
    %4 = llvm.intr.ssub.sat(%2, %3)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def test_vector_ssub_add_nsw_no_ov_nonsplat3_before := [llvmfunc|
  llvm.func @test_vector_ssub_add_nsw_no_ov_nonsplat3(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[7, 6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.intr.ssub.sat(%1, %2)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def test_scalar_usub_add_before := [llvmfunc|
  llvm.func @test_scalar_usub_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.add %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def test_scalar_usub_add_extra_use_before := [llvmfunc|
  llvm.func @test_scalar_usub_add_extra_use(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.store %0, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

    %1 = llvm.add %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def test_scalar_usub_add_commuted_before := [llvmfunc|
  llvm.func @test_scalar_usub_add_commuted(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.add %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def test_scalar_usub_add_commuted_wrong_before := [llvmfunc|
  llvm.func @test_scalar_usub_add_commuted_wrong(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.add %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def test_scalar_usub_add_const_before := [llvmfunc|
  llvm.func @test_scalar_usub_add_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.add %1, %0  : i8
    llvm.return %2 : i8
  }]

def test_scalar_usub_sub_before := [llvmfunc|
  llvm.func @test_scalar_usub_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def test_scalar_usub_sub_extra_use_before := [llvmfunc|
  llvm.func @test_scalar_usub_sub_extra_use(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.store %0, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def test_vector_usub_sub_before := [llvmfunc|
  llvm.func @test_vector_usub_sub(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.sub %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def test_scalar_usub_sub_wrong_before := [llvmfunc|
  llvm.func @test_scalar_usub_sub_wrong(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def test_scalar_usub_sub_wrong2_before := [llvmfunc|
  llvm.func @test_scalar_usub_sub_wrong2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def test_scalar_uadd_sub_before := [llvmfunc|
  llvm.func @test_scalar_uadd_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def test_scalar_uadd_sub_extra_use_before := [llvmfunc|
  llvm.func @test_scalar_uadd_sub_extra_use(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.store %0, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def test_scalar_uadd_sub_commuted_before := [llvmfunc|
  llvm.func @test_scalar_uadd_sub_commuted(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.uadd.sat(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def test_scalar_uadd_sub_commuted_wrong_before := [llvmfunc|
  llvm.func @test_scalar_uadd_sub_commuted_wrong(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def test_scalar_uadd_sub_const_before := [llvmfunc|
  llvm.func @test_scalar_uadd_sub_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.sub %1, %0  : i8
    llvm.return %2 : i8
  }]

def scalar_uadd_eq_zero_before := [llvmfunc|
  llvm.func @scalar_uadd_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def scalar_uadd_ne_zero_before := [llvmfunc|
  llvm.func @scalar_uadd_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def scalar_usub_eq_zero_before := [llvmfunc|
  llvm.func @scalar_usub_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def scalar_usub_ne_zero_before := [llvmfunc|
  llvm.func @scalar_usub_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def uadd_sat_before := [llvmfunc|
  llvm.func @uadd_sat(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %arg1, %arg0  : i32
    %3 = llvm.icmp "ult" %1, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    llvm.return %4 : i32
  }]

def uadd_sat_nonstrict_before := [llvmfunc|
  llvm.func @uadd_sat_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %arg1, %arg0  : i32
    %3 = llvm.icmp "ule" %1, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    llvm.return %4 : i32
  }]

def uadd_sat_commute_add_before := [llvmfunc|
  llvm.func @uadd_sat_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.urem %0, %arg0  : i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.add %2, %arg1  : i32
    %5 = llvm.icmp "ult" %3, %arg1 : i32
    %6 = llvm.select %5, %1, %4 : i1, i32
    llvm.return %6 : i32
  }]

def uadd_sat_ugt_before := [llvmfunc|
  llvm.func @uadd_sat_ugt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2442 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %arg1, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.add %2, %arg0  : i32
    %5 = llvm.icmp "ugt" %2, %3 : i32
    %6 = llvm.select %5, %1, %4 : i1, i32
    llvm.return %6 : i32
  }]

def uadd_sat_uge_before := [llvmfunc|
  llvm.func @uadd_sat_uge(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2442 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %arg1, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.add %2, %arg0  : i32
    %5 = llvm.icmp "uge" %2, %3 : i32
    %6 = llvm.select %5, %1, %4 : i1, i32
    llvm.return %6 : i32
  }]

def uadd_sat_ugt_commute_add_before := [llvmfunc|
  llvm.func @uadd_sat_ugt_commute_add(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2442, 4242]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %4 = llvm.srem %1, %arg0  : vector<2xi32>
    %5 = llvm.xor %4, %2  : vector<2xi32>
    %6 = llvm.add %4, %3  : vector<2xi32>
    %7 = llvm.icmp "ugt" %3, %5 : vector<2xi32>
    %8 = llvm.select %7, %2, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def uadd_sat_commute_select_before := [llvmfunc|
  llvm.func @uadd_sat_commute_select(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2442 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %arg1, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.add %2, %arg0  : i32
    %5 = llvm.icmp "ult" %2, %3 : i32
    %6 = llvm.select %5, %4, %1 : i1, i32
    llvm.return %6 : i32
  }]

def uadd_sat_commute_select_nonstrict_before := [llvmfunc|
  llvm.func @uadd_sat_commute_select_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2442 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %arg1, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.add %2, %arg0  : i32
    %5 = llvm.icmp "ule" %2, %3 : i32
    %6 = llvm.select %5, %4, %1 : i1, i32
    llvm.return %6 : i32
  }]

def uadd_sat_commute_select_commute_add_before := [llvmfunc|
  llvm.func @uadd_sat_commute_select_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(2442 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.urem %0, %arg0  : i32
    %4 = llvm.sdiv %arg1, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.add %3, %4  : i32
    %7 = llvm.icmp "ult" %4, %5 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }]

def uadd_sat_commute_select_ugt_before := [llvmfunc|
  llvm.func @uadd_sat_commute_select_ugt(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.add %arg1, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ugt" %1, %arg1 : vector<2xi32>
    %4 = llvm.select %3, %2, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def uadd_sat_commute_select_ugt_commute_add_before := [llvmfunc|
  llvm.func @uadd_sat_commute_select_ugt_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.srem %0, %arg0  : i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.add %2, %arg1  : i32
    %5 = llvm.icmp "ugt" %3, %arg1 : i32
    %6 = llvm.select %5, %4, %1 : i1, i32
    llvm.return %6 : i32
  }]

def not_uadd_sat_before := [llvmfunc|
  llvm.func @not_uadd_sat(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %arg1 : i1, i32
    llvm.return %4 : i32
  }]

def not_uadd_sat2_before := [llvmfunc|
  llvm.func @not_uadd_sat2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %2 : i1, i32
    llvm.return %5 : i32
  }]

def uadd_sat_not_before := [llvmfunc|
  llvm.func @uadd_sat_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    llvm.return %4 : i32
  }]

def uadd_sat_not_nonstrict_before := [llvmfunc|
  llvm.func @uadd_sat_not_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.icmp "ule" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    llvm.return %4 : i32
  }]

def uadd_sat_not_commute_add_before := [llvmfunc|
  llvm.func @uadd_sat_not_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.srem %0, %arg0  : i32
    %3 = llvm.urem %0, %arg1  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.add %3, %4  : i32
    %6 = llvm.icmp "ult" %2, %3 : i32
    %7 = llvm.select %6, %1, %5 : i1, i32
    llvm.return %7 : i32
  }]

def uadd_sat_not_ugt_before := [llvmfunc|
  llvm.func @uadd_sat_not_ugt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    llvm.return %4 : i32
  }]

def uadd_sat_not_uge_before := [llvmfunc|
  llvm.func @uadd_sat_not_uge(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.icmp "uge" %arg1, %arg0 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    llvm.return %4 : i32
  }]

def uadd_sat_not_ugt_commute_add_before := [llvmfunc|
  llvm.func @uadd_sat_not_ugt_commute_add(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2442, 4242]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %3 = llvm.xor %arg0, %1  : vector<2xi32>
    %4 = llvm.add %2, %3  : vector<2xi32>
    %5 = llvm.icmp "ugt" %2, %arg0 : vector<2xi32>
    %6 = llvm.select %5, %1, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def uadd_sat_not_commute_select_before := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.icmp "ult" %arg1, %arg0 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    llvm.return %4 : i32
  }]

def uadd_sat_not_commute_select_nonstrict_before := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.icmp "ule" %arg1, %arg0 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    llvm.return %4 : i32
  }]

def uadd_sat_not_commute_select_commute_add_before := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.add %2, %3  : i32
    %5 = llvm.icmp "ult" %2, %arg0 : i32
    %6 = llvm.select %5, %4, %1 : i1, i32
    llvm.return %6 : i32
  }]

def uadd_sat_not_commute_select_ugt_before := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select_ugt(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[12, 412]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.urem %0, %arg0  : vector<2xi32>
    %4 = llvm.srem %1, %arg1  : vector<2xi32>
    %5 = llvm.xor %3, %2  : vector<2xi32>
    %6 = llvm.add %4, %5  : vector<2xi32>
    %7 = llvm.icmp "ugt" %3, %4 : vector<2xi32>
    %8 = llvm.select %7, %6, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def uadd_sat_not_commute_select_ugt_commute_add_before := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select_ugt_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    llvm.return %4 : i32
  }]

def uadd_sat_not_commute_select_uge_commute_add_before := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select_uge_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.icmp "uge" %arg0, %arg1 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    llvm.return %4 : i32
  }]

def uadd_sat_constant_before := [llvmfunc|
  llvm.func @uadd_sat_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-43 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    llvm.return %5 : i32
  }]

def uadd_sat_constant_commute_before := [llvmfunc|
  llvm.func @uadd_sat_constant_commute(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-43 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %2 : i1, i32
    llvm.return %5 : i32
  }]

def uadd_sat_canon_before := [llvmfunc|
  llvm.func @uadd_sat_canon(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def uadd_sat_canon_y_before := [llvmfunc|
  llvm.func @uadd_sat_canon_y(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def uadd_sat_canon_nuw_before := [llvmfunc|
  llvm.func @uadd_sat_canon_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def uadd_sat_canon_y_nuw_before := [llvmfunc|
  llvm.func @uadd_sat_canon_y_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def uadd_sat_constant_vec_before := [llvmfunc|
  llvm.func @uadd_sat_constant_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-43> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.add %arg0, %0  : vector<4xi32>
    %4 = llvm.icmp "ugt" %arg0, %1 : vector<4xi32>
    %5 = llvm.select %4, %2, %3 : vector<4xi1>, vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def uadd_sat_constant_vec_commute_before := [llvmfunc|
  llvm.func @uadd_sat_constant_vec_commute(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-43> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.add %arg0, %0  : vector<4xi32>
    %4 = llvm.icmp "ult" %arg0, %1 : vector<4xi32>
    %5 = llvm.select %4, %3, %2 : vector<4xi1>, vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def uadd_sat_constant_vec_commute_undefs_before := [llvmfunc|
  llvm.func @uadd_sat_constant_vec_commute_undefs(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(-43 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %11, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %11, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(-1 : i32) : i32
    %22 = llvm.mlir.undef : vector<4xi32>
    %23 = llvm.mlir.constant(0 : i32) : i32
    %24 = llvm.insertelement %21, %22[%23 : i32] : vector<4xi32>
    %25 = llvm.mlir.constant(1 : i32) : i32
    %26 = llvm.insertelement %0, %24[%25 : i32] : vector<4xi32>
    %27 = llvm.mlir.constant(2 : i32) : i32
    %28 = llvm.insertelement %21, %26[%27 : i32] : vector<4xi32>
    %29 = llvm.mlir.constant(3 : i32) : i32
    %30 = llvm.insertelement %21, %28[%29 : i32] : vector<4xi32>
    %31 = llvm.add %arg0, %10  : vector<4xi32>
    %32 = llvm.icmp "ult" %arg0, %20 : vector<4xi32>
    %33 = llvm.select %32, %31, %30 : vector<4xi1>, vector<4xi32>
    llvm.return %33 : vector<4xi32>
  }]

def unsigned_sat_variable_using_min_add_before := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_min_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @get_i32() : () -> i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.icmp "ult" %arg0, %2 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    %5 = llvm.add %4, %1  : i32
    llvm.return %5 : i32
  }]

def unsigned_sat_variable_using_min_commute_add_before := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_min_commute_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @get_i32() : () -> i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.icmp "ult" %arg0, %2 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    %5 = llvm.add %1, %4  : i32
    llvm.return %5 : i32
  }]

def unsigned_sat_variable_using_min_commute_select_before := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_min_commute_select(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.call @get_v2i8() : () -> vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %arg0 : vector<2xi8>
    %4 = llvm.select %3, %2, %arg0 : vector<2xi1>, vector<2xi8>
    %5 = llvm.add %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def unsigned_sat_variable_using_min_commute_add_select_before := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_min_commute_add_select(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.call @get_v2i8() : () -> vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %arg0 : vector<2xi8>
    %4 = llvm.select %3, %2, %arg0 : vector<2xi1>, vector<2xi8>
    %5 = llvm.add %1, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def unsigned_sat_variable_using_wrong_min_before := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_wrong_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @get_i32() : () -> i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    %5 = llvm.add %1, %4  : i32
    llvm.return %5 : i32
  }]

def unsigned_sat_variable_using_wrong_value_before := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_wrong_value(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @get_i32() : () -> i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.icmp "ult" %arg0, %2 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    %5 = llvm.add %arg1, %4  : i32
    llvm.return %5 : i32
  }]

def unsigned_sat_constant_using_min_before := [llvmfunc|
  llvm.func @unsigned_sat_constant_using_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-43 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def unsigned_sat_constant_using_min_splat_before := [llvmfunc|
  llvm.func @unsigned_sat_constant_using_min_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<14> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %0 : vector<2xi1>, vector<2xi32>
    %4 = llvm.add %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def unsigned_sat_constant_using_min_wrong_constant_before := [llvmfunc|
  llvm.func @unsigned_sat_constant_using_min_wrong_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-42 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def uadd_sat_via_add_before := [llvmfunc|
  llvm.func @uadd_sat_via_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def uadd_sat_via_add_nonstrict_before := [llvmfunc|
  llvm.func @uadd_sat_via_add_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ule" %1, %arg1 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def uadd_sat_via_add_swapped_select_before := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_select(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "uge" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

def uadd_sat_via_add_swapped_select_strict_before := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_select_strict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

def uadd_sat_via_add_swapped_cmp_before := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_cmp(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ugt" %arg1, %1 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def uadd_sat_via_add_swapped_cmp_nonstrict_before := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_cmp_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "uge" %arg1, %1 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def uadd_sat_via_add_swapped_cmp_nonstric_before := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_cmp_nonstric(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ule" %arg1, %1 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

def uadd_sat_via_add_swapped_cmp_select_nonstrict_before := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_cmp_select_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ult" %arg1, %1 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

def test_scalar_uadd_canonical_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_canonical(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_uadd_canonical   : test_scalar_uadd_canonical_before  ⊑  test_scalar_uadd_canonical_combined := by
  unfold test_scalar_uadd_canonical_before test_scalar_uadd_canonical_combined
  simp_alive_peephole
  sorry
def test_vector_uadd_canonical_combined := [llvmfunc|
  llvm.func @test_vector_uadd_canonical(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_uadd_canonical   : test_vector_uadd_canonical_before  ⊑  test_vector_uadd_canonical_combined := by
  unfold test_vector_uadd_canonical_before test_vector_uadd_canonical_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_canonical_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_canonical(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_sadd_canonical   : test_scalar_sadd_canonical_before  ⊑  test_scalar_sadd_canonical_combined := by
  unfold test_scalar_sadd_canonical_before test_scalar_sadd_canonical_combined
  simp_alive_peephole
  sorry
def test_vector_sadd_canonical_combined := [llvmfunc|
  llvm.func @test_vector_sadd_canonical(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, -20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_sadd_canonical   : test_vector_sadd_canonical_before  ⊑  test_vector_sadd_canonical_combined := by
  unfold test_vector_sadd_canonical_before test_vector_sadd_canonical_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_combine_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_combine(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(30 : i8) : i8
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_uadd_combine   : test_scalar_uadd_combine_before  ⊑  test_scalar_uadd_combine_combined := by
  unfold test_scalar_uadd_combine_before test_scalar_uadd_combine_combined
  simp_alive_peephole
  sorry
def test_vector_uadd_combine_combined := [llvmfunc|
  llvm.func @test_vector_uadd_combine(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_uadd_combine   : test_vector_uadd_combine_before  ⊑  test_vector_uadd_combine_combined := by
  unfold test_vector_uadd_combine_before test_vector_uadd_combine_combined
  simp_alive_peephole
  sorry
def test_vector_uadd_combine_non_splat_combined := [llvmfunc|
  llvm.func @test_vector_uadd_combine_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[30, 40]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.uadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.uadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_uadd_combine_non_splat   : test_vector_uadd_combine_non_splat_before  ⊑  test_vector_uadd_combine_non_splat_combined := by
  unfold test_vector_uadd_combine_non_splat_before test_vector_uadd_combine_non_splat_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_overflow_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_uadd_overflow   : test_scalar_uadd_overflow_before  ⊑  test_scalar_uadd_overflow_combined := by
  unfold test_scalar_uadd_overflow_before test_scalar_uadd_overflow_combined
  simp_alive_peephole
  sorry
def test_vector_uadd_overflow_combined := [llvmfunc|
  llvm.func @test_vector_uadd_overflow(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_test_vector_uadd_overflow   : test_vector_uadd_overflow_before  ⊑  test_vector_uadd_overflow_combined := by
  unfold test_vector_uadd_overflow_before test_vector_uadd_overflow_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_both_positive_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_both_positive(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(30 : i8) : i8
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_sadd_both_positive   : test_scalar_sadd_both_positive_before  ⊑  test_scalar_sadd_both_positive_combined := by
  unfold test_scalar_sadd_both_positive_before test_scalar_sadd_both_positive_combined
  simp_alive_peephole
  sorry
def test_vector_sadd_both_positive_combined := [llvmfunc|
  llvm.func @test_vector_sadd_both_positive(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_sadd_both_positive   : test_vector_sadd_both_positive_before  ⊑  test_vector_sadd_both_positive_combined := by
  unfold test_vector_sadd_both_positive_before test_vector_sadd_both_positive_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_both_negative_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_both_negative(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-30 : i8) : i8
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_sadd_both_negative   : test_scalar_sadd_both_negative_before  ⊑  test_scalar_sadd_both_negative_combined := by
  unfold test_scalar_sadd_both_negative_before test_scalar_sadd_both_negative_combined
  simp_alive_peephole
  sorry
def test_vector_sadd_both_negative_combined := [llvmfunc|
  llvm.func @test_vector_sadd_both_negative(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-30> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_sadd_both_negative   : test_vector_sadd_both_negative_before  ⊑  test_vector_sadd_both_negative_combined := by
  unfold test_vector_sadd_both_negative_before test_vector_sadd_both_negative_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_different_sign_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_different_sign(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(-20 : i8) : i8
    %2 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_sadd_different_sign   : test_scalar_sadd_different_sign_before  ⊑  test_scalar_sadd_different_sign_combined := by
  unfold test_scalar_sadd_different_sign_before test_scalar_sadd_different_sign_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_overflow_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.intr.sadd.sat(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_test_scalar_sadd_overflow   : test_scalar_sadd_overflow_before  ⊑  test_scalar_sadd_overflow_combined := by
  unfold test_scalar_sadd_overflow_before test_scalar_sadd_overflow_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_neg_neg_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_neg_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_uadd_neg_neg   : test_scalar_uadd_neg_neg_before  ⊑  test_scalar_uadd_neg_neg_combined := by
  unfold test_scalar_uadd_neg_neg_before test_scalar_uadd_neg_neg_combined
  simp_alive_peephole
  sorry
def test_vector_uadd_neg_neg_combined := [llvmfunc|
  llvm.func @test_vector_uadd_neg_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_test_vector_uadd_neg_neg   : test_vector_uadd_neg_neg_before  ⊑  test_vector_uadd_neg_neg_combined := by
  unfold test_vector_uadd_neg_neg_before test_vector_uadd_neg_neg_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_nneg_nneg_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_nneg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_uadd_nneg_nneg   : test_scalar_uadd_nneg_nneg_before  ⊑  test_scalar_uadd_nneg_nneg_combined := by
  unfold test_scalar_uadd_nneg_nneg_before test_scalar_uadd_nneg_nneg_combined
  simp_alive_peephole
  sorry
def test_vector_uadd_nneg_nneg_combined := [llvmfunc|
  llvm.func @test_vector_uadd_nneg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nuw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_uadd_nneg_nneg   : test_vector_uadd_nneg_nneg_before  ⊑  test_vector_uadd_nneg_nneg_combined := by
  unfold test_vector_uadd_nneg_nneg_before test_vector_uadd_nneg_nneg_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_neg_nneg_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_neg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_uadd_neg_nneg   : test_scalar_uadd_neg_nneg_before  ⊑  test_scalar_uadd_neg_nneg_combined := by
  unfold test_scalar_uadd_neg_nneg_before test_scalar_uadd_neg_nneg_combined
  simp_alive_peephole
  sorry
def test_vector_uadd_neg_nneg_combined := [llvmfunc|
  llvm.func @test_vector_uadd_neg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.uadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_uadd_neg_nneg   : test_vector_uadd_neg_nneg_before  ⊑  test_vector_uadd_neg_nneg_combined := by
  unfold test_vector_uadd_neg_nneg_before test_vector_uadd_neg_nneg_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_never_overflows_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_never_overflows(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_uadd_never_overflows   : test_scalar_uadd_never_overflows_before  ⊑  test_scalar_uadd_never_overflows_combined := by
  unfold test_scalar_uadd_never_overflows_before test_scalar_uadd_never_overflows_combined
  simp_alive_peephole
  sorry
def test_vector_uadd_never_overflows_combined := [llvmfunc|
  llvm.func @test_vector_uadd_never_overflows(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_uadd_never_overflows   : test_vector_uadd_never_overflows_before  ⊑  test_vector_uadd_never_overflows_combined := by
  unfold test_vector_uadd_never_overflows_before test_vector_uadd_never_overflows_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_always_overflows_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_always_overflows(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_uadd_always_overflows   : test_scalar_uadd_always_overflows_before  ⊑  test_scalar_uadd_always_overflows_combined := by
  unfold test_scalar_uadd_always_overflows_before test_scalar_uadd_always_overflows_combined
  simp_alive_peephole
  sorry
def test_vector_uadd_always_overflows_combined := [llvmfunc|
  llvm.func @test_vector_uadd_always_overflows(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_test_vector_uadd_always_overflows   : test_vector_uadd_always_overflows_before  ⊑  test_vector_uadd_always_overflows_combined := by
  unfold test_vector_uadd_always_overflows_before test_vector_uadd_always_overflows_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_neg_nneg_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_neg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_sadd_neg_nneg   : test_scalar_sadd_neg_nneg_before  ⊑  test_scalar_sadd_neg_nneg_combined := by
  unfold test_scalar_sadd_neg_nneg_before test_scalar_sadd_neg_nneg_combined
  simp_alive_peephole
  sorry
def test_vector_sadd_neg_nneg_combined := [llvmfunc|
  llvm.func @test_vector_sadd_neg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_sadd_neg_nneg   : test_vector_sadd_neg_nneg_before  ⊑  test_vector_sadd_neg_nneg_combined := by
  unfold test_vector_sadd_neg_nneg_before test_vector_sadd_neg_nneg_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_nneg_neg_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_nneg_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_sadd_nneg_neg   : test_scalar_sadd_nneg_neg_before  ⊑  test_scalar_sadd_nneg_neg_combined := by
  unfold test_scalar_sadd_nneg_neg_before test_scalar_sadd_nneg_neg_combined
  simp_alive_peephole
  sorry
def test_vector_sadd_nneg_neg_combined := [llvmfunc|
  llvm.func @test_vector_sadd_nneg_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_sadd_nneg_neg   : test_vector_sadd_nneg_neg_before  ⊑  test_vector_sadd_nneg_neg_combined := by
  unfold test_vector_sadd_nneg_neg_before test_vector_sadd_nneg_neg_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_neg_neg_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_neg_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_sadd_neg_neg   : test_scalar_sadd_neg_neg_before  ⊑  test_scalar_sadd_neg_neg_combined := by
  unfold test_scalar_sadd_neg_neg_before test_scalar_sadd_neg_neg_combined
  simp_alive_peephole
  sorry
def test_vector_sadd_neg_neg_combined := [llvmfunc|
  llvm.func @test_vector_sadd_neg_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.sadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_sadd_neg_neg   : test_vector_sadd_neg_neg_before  ⊑  test_vector_sadd_neg_neg_combined := by
  unfold test_vector_sadd_neg_neg_before test_vector_sadd_neg_neg_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_always_overflows_low_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_always_overflows_low(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_sadd_always_overflows_low   : test_scalar_sadd_always_overflows_low_before  ⊑  test_scalar_sadd_always_overflows_low_combined := by
  unfold test_scalar_sadd_always_overflows_low_before test_scalar_sadd_always_overflows_low_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_always_overflows_high_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_always_overflows_high(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_sadd_always_overflows_high   : test_scalar_sadd_always_overflows_high_before  ⊑  test_scalar_sadd_always_overflows_high_combined := by
  unfold test_scalar_sadd_always_overflows_high_before test_scalar_sadd_always_overflows_high_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_sub_nuw_lost_no_ov_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_sub_nuw_lost_no_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_uadd_sub_nuw_lost_no_ov   : test_scalar_uadd_sub_nuw_lost_no_ov_before  ⊑  test_scalar_uadd_sub_nuw_lost_no_ov_combined := by
  unfold test_scalar_uadd_sub_nuw_lost_no_ov_before test_scalar_uadd_sub_nuw_lost_no_ov_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_urem_no_ov_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_urem_no_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-100 : i8) : i8
    %2 = llvm.urem %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_uadd_urem_no_ov   : test_scalar_uadd_urem_no_ov_before  ⊑  test_scalar_uadd_urem_no_ov_combined := by
  unfold test_scalar_uadd_urem_no_ov_before test_scalar_uadd_urem_no_ov_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_urem_may_ov_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_urem_may_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-99 : i8) : i8
    %2 = llvm.urem %arg0, %0  : i8
    %3 = llvm.intr.uadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_uadd_urem_may_ov   : test_scalar_uadd_urem_may_ov_before  ⊑  test_scalar_uadd_urem_may_ov_combined := by
  unfold test_scalar_uadd_urem_may_ov_before test_scalar_uadd_urem_may_ov_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_udiv_known_bits_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_udiv_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-66 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.udiv %0, %arg0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.add %2, %3 overflow<nuw>  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test_scalar_uadd_udiv_known_bits   : test_scalar_uadd_udiv_known_bits_before  ⊑  test_scalar_uadd_udiv_known_bits_combined := by
  unfold test_scalar_uadd_udiv_known_bits_before test_scalar_uadd_udiv_known_bits_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_srem_no_ov_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_srem_no_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(28 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_sadd_srem_no_ov   : test_scalar_sadd_srem_no_ov_before  ⊑  test_scalar_sadd_srem_no_ov_combined := by
  unfold test_scalar_sadd_srem_no_ov_before test_scalar_sadd_srem_no_ov_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_srem_may_ov_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_srem_may_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(29 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_sadd_srem_may_ov   : test_scalar_sadd_srem_may_ov_before  ⊑  test_scalar_sadd_srem_may_ov_combined := by
  unfold test_scalar_sadd_srem_may_ov_before test_scalar_sadd_srem_may_ov_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_srem_and_no_ov_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_srem_and_no_ov(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.add %2, %3 overflow<nsw>  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test_scalar_sadd_srem_and_no_ov   : test_scalar_sadd_srem_and_no_ov_before  ⊑  test_scalar_sadd_srem_and_no_ov_combined := by
  unfold test_scalar_sadd_srem_and_no_ov_before test_scalar_sadd_srem_and_no_ov_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_canonical_combined := [llvmfunc|
  llvm.func @test_scalar_usub_canonical(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_usub_canonical   : test_scalar_usub_canonical_before  ⊑  test_scalar_usub_canonical_combined := by
  unfold test_scalar_usub_canonical_before test_scalar_usub_canonical_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_canonical_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_canonical(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_ssub_canonical   : test_scalar_ssub_canonical_before  ⊑  test_scalar_ssub_canonical_combined := by
  unfold test_scalar_ssub_canonical_before test_scalar_ssub_canonical_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_canonical_combined := [llvmfunc|
  llvm.func @test_vector_ssub_canonical(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_canonical   : test_vector_ssub_canonical_before  ⊑  test_vector_ssub_canonical_combined := by
  unfold test_vector_ssub_canonical_before test_vector_ssub_canonical_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_canonical_min_non_splat_combined := [llvmfunc|
  llvm.func @test_vector_ssub_canonical_min_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-10, 10]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_canonical_min_non_splat   : test_vector_ssub_canonical_min_non_splat_before  ⊑  test_vector_ssub_canonical_min_non_splat_combined := by
  unfold test_vector_ssub_canonical_min_non_splat_before test_vector_ssub_canonical_min_non_splat_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_canonical_min_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_canonical_min(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.intr.ssub.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_ssub_canonical_min   : test_scalar_ssub_canonical_min_before  ⊑  test_scalar_ssub_canonical_min_combined := by
  unfold test_scalar_ssub_canonical_min_before test_scalar_ssub_canonical_min_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_canonical_min_combined := [llvmfunc|
  llvm.func @test_vector_ssub_canonical_min(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-128, -10]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ssub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_canonical_min   : test_vector_ssub_canonical_min_before  ⊑  test_vector_ssub_canonical_min_combined := by
  unfold test_vector_ssub_canonical_min_before test_vector_ssub_canonical_min_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_combine_combined := [llvmfunc|
  llvm.func @test_scalar_usub_combine(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(30 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_usub_combine   : test_scalar_usub_combine_before  ⊑  test_scalar_usub_combine_combined := by
  unfold test_scalar_usub_combine_before test_scalar_usub_combine_combined
  simp_alive_peephole
  sorry
def test_simplify_decrement_combined := [llvmfunc|
  llvm.func @test_simplify_decrement(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_simplify_decrement   : test_simplify_decrement_before  ⊑  test_simplify_decrement_combined := by
  unfold test_simplify_decrement_before test_simplify_decrement_combined
  simp_alive_peephole
  sorry
def test_simplify_decrement_ne_combined := [llvmfunc|
  llvm.func @test_simplify_decrement_ne(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use.i1(%2) : (i1) -> ()
    %3 = llvm.intr.usub.sat(%arg0, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_simplify_decrement_ne   : test_simplify_decrement_ne_before  ⊑  test_simplify_decrement_ne_combined := by
  unfold test_simplify_decrement_ne_before test_simplify_decrement_ne_combined
  simp_alive_peephole
  sorry
def test_simplify_decrement_vec_combined := [llvmfunc|
  llvm.func @test_simplify_decrement_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_simplify_decrement_vec   : test_simplify_decrement_vec_before  ⊑  test_simplify_decrement_vec_combined := by
  unfold test_simplify_decrement_vec_before test_simplify_decrement_vec_combined
  simp_alive_peephole
  sorry
def test_simplify_decrement_vec_poison_combined := [llvmfunc|
  llvm.func @test_simplify_decrement_vec_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_simplify_decrement_vec_poison   : test_simplify_decrement_vec_poison_before  ⊑  test_simplify_decrement_vec_poison_combined := by
  unfold test_simplify_decrement_vec_poison_before test_simplify_decrement_vec_poison_combined
  simp_alive_peephole
  sorry
def test_simplify_decrement_invalid_ne_combined := [llvmfunc|
  llvm.func @test_simplify_decrement_invalid_ne(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.sext %1 : i1 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_test_simplify_decrement_invalid_ne   : test_simplify_decrement_invalid_ne_before  ⊑  test_simplify_decrement_invalid_ne_combined := by
  unfold test_simplify_decrement_invalid_ne_before test_simplify_decrement_invalid_ne_combined
  simp_alive_peephole
  sorry
def test_invalid_simplify_sub2_combined := [llvmfunc|
  llvm.func @test_invalid_simplify_sub2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.add %arg0, %1  : i8
    %4 = llvm.select %2, %0, %3 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test_invalid_simplify_sub2   : test_invalid_simplify_sub2_before  ⊑  test_invalid_simplify_sub2_combined := by
  unfold test_invalid_simplify_sub2_before test_invalid_simplify_sub2_combined
  simp_alive_peephole
  sorry
def test_invalid_simplify_eq2_combined := [llvmfunc|
  llvm.func @test_invalid_simplify_eq2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.select %3, %2, %4 : i1, i8
    llvm.return %5 : i8
  }]

theorem inst_combine_test_invalid_simplify_eq2   : test_invalid_simplify_eq2_before  ⊑  test_invalid_simplify_eq2_combined := by
  unfold test_invalid_simplify_eq2_before test_invalid_simplify_eq2_combined
  simp_alive_peephole
  sorry
def test_invalid_simplify_select_1_combined := [llvmfunc|
  llvm.func @test_invalid_simplify_select_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.select %3, %2, %4 : i1, i8
    llvm.return %5 : i8
  }]

theorem inst_combine_test_invalid_simplify_select_1   : test_invalid_simplify_select_1_before  ⊑  test_invalid_simplify_select_1_combined := by
  unfold test_invalid_simplify_select_1_before test_invalid_simplify_select_1_combined
  simp_alive_peephole
  sorry
def test_invalid_simplify_other_combined := [llvmfunc|
  llvm.func @test_invalid_simplify_other(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.select %2, %0, %3 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test_invalid_simplify_other   : test_invalid_simplify_other_before  ⊑  test_invalid_simplify_other_combined := by
  unfold test_invalid_simplify_other_before test_invalid_simplify_other_combined
  simp_alive_peephole
  sorry
def test_vector_usub_combine_combined := [llvmfunc|
  llvm.func @test_vector_usub_combine(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_combine   : test_vector_usub_combine_before  ⊑  test_vector_usub_combine_combined := by
  unfold test_vector_usub_combine_before test_vector_usub_combine_combined
  simp_alive_peephole
  sorry
def test_vector_usub_combine_non_splat_combined := [llvmfunc|
  llvm.func @test_vector_usub_combine_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[30, 40]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_combine_non_splat   : test_vector_usub_combine_non_splat_before  ⊑  test_vector_usub_combine_non_splat_combined := by
  unfold test_vector_usub_combine_non_splat_before test_vector_usub_combine_non_splat_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_overflow_combined := [llvmfunc|
  llvm.func @test_scalar_usub_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_usub_overflow   : test_scalar_usub_overflow_before  ⊑  test_scalar_usub_overflow_combined := by
  unfold test_scalar_usub_overflow_before test_scalar_usub_overflow_combined
  simp_alive_peephole
  sorry
def test_vector_usub_overflow_combined := [llvmfunc|
  llvm.func @test_vector_usub_overflow(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_overflow   : test_vector_usub_overflow_before  ⊑  test_vector_usub_overflow_combined := by
  unfold test_vector_usub_overflow_before test_vector_usub_overflow_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_both_positive_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_both_positive(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-30 : i8) : i8
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_ssub_both_positive   : test_scalar_ssub_both_positive_before  ⊑  test_scalar_ssub_both_positive_combined := by
  unfold test_scalar_ssub_both_positive_before test_scalar_ssub_both_positive_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_both_positive_combined := [llvmfunc|
  llvm.func @test_vector_ssub_both_positive(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-30> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_both_positive   : test_vector_ssub_both_positive_before  ⊑  test_vector_ssub_both_positive_combined := by
  unfold test_vector_ssub_both_positive_before test_vector_ssub_both_positive_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_both_negative_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_both_negative(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(30 : i8) : i8
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_ssub_both_negative   : test_scalar_ssub_both_negative_before  ⊑  test_scalar_ssub_both_negative_combined := by
  unfold test_scalar_ssub_both_negative_before test_scalar_ssub_both_negative_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_both_negative_combined := [llvmfunc|
  llvm.func @test_vector_ssub_both_negative(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_both_negative   : test_vector_ssub_both_negative_before  ⊑  test_vector_ssub_both_negative_combined := by
  unfold test_vector_ssub_both_negative_before test_vector_ssub_both_negative_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_different_sign_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_different_sign(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_ssub_different_sign   : test_scalar_ssub_different_sign_before  ⊑  test_scalar_ssub_different_sign_combined := by
  unfold test_scalar_ssub_different_sign_before test_scalar_ssub_different_sign_combined
  simp_alive_peephole
  sorry
def test_scalar_sadd_ssub_combined := [llvmfunc|
  llvm.func @test_scalar_sadd_ssub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(30 : i8) : i8
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_sadd_ssub   : test_scalar_sadd_ssub_before  ⊑  test_scalar_sadd_ssub_combined := by
  unfold test_scalar_sadd_ssub_before test_scalar_sadd_ssub_combined
  simp_alive_peephole
  sorry
def test_vector_sadd_ssub_combined := [llvmfunc|
  llvm.func @test_vector_sadd_ssub(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-30> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_sadd_ssub   : test_vector_sadd_ssub_before  ⊑  test_vector_sadd_ssub_combined := by
  unfold test_vector_sadd_ssub_before test_vector_sadd_ssub_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_overflow_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_overflow(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-100 : i8) : i8
    %1 = llvm.intr.sadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.intr.sadd.sat(%1, %0)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_test_scalar_ssub_overflow   : test_scalar_ssub_overflow_before  ⊑  test_scalar_ssub_overflow_combined := by
  unfold test_scalar_ssub_overflow_before test_scalar_ssub_overflow_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_nneg_neg_combined := [llvmfunc|
  llvm.func @test_scalar_usub_nneg_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_usub_nneg_neg   : test_scalar_usub_nneg_neg_before  ⊑  test_scalar_usub_nneg_neg_combined := by
  unfold test_scalar_usub_nneg_neg_before test_scalar_usub_nneg_neg_combined
  simp_alive_peephole
  sorry
def test_vector_usub_nneg_neg_combined := [llvmfunc|
  llvm.func @test_vector_usub_nneg_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_nneg_neg   : test_vector_usub_nneg_neg_before  ⊑  test_vector_usub_nneg_neg_combined := by
  unfold test_vector_usub_nneg_neg_before test_vector_usub_nneg_neg_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_neg_nneg_combined := [llvmfunc|
  llvm.func @test_scalar_usub_neg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.add %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_usub_neg_nneg   : test_scalar_usub_neg_nneg_before  ⊑  test_scalar_usub_neg_nneg_combined := by
  unfold test_scalar_usub_neg_nneg_before test_scalar_usub_neg_nneg_combined
  simp_alive_peephole
  sorry
def test_vector_usub_neg_nneg_combined := [llvmfunc|
  llvm.func @test_vector_usub_neg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_neg_nneg   : test_vector_usub_neg_nneg_before  ⊑  test_vector_usub_neg_nneg_combined := by
  unfold test_vector_usub_neg_nneg_before test_vector_usub_neg_nneg_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_nneg_nneg_combined := [llvmfunc|
  llvm.func @test_scalar_usub_nneg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_usub_nneg_nneg   : test_scalar_usub_nneg_nneg_before  ⊑  test_scalar_usub_nneg_nneg_combined := by
  unfold test_scalar_usub_nneg_nneg_before test_scalar_usub_nneg_nneg_combined
  simp_alive_peephole
  sorry
def test_vector_usub_nneg_nneg_combined := [llvmfunc|
  llvm.func @test_vector_usub_nneg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_nneg_nneg   : test_vector_usub_nneg_nneg_before  ⊑  test_vector_usub_nneg_nneg_combined := by
  unfold test_vector_usub_nneg_nneg_before test_vector_usub_nneg_nneg_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_never_overflows_combined := [llvmfunc|
  llvm.func @test_scalar_usub_never_overflows(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_usub_never_overflows   : test_scalar_usub_never_overflows_before  ⊑  test_scalar_usub_never_overflows_combined := by
  unfold test_scalar_usub_never_overflows_before test_scalar_usub_never_overflows_combined
  simp_alive_peephole
  sorry
def test_vector_usub_never_overflows_combined := [llvmfunc|
  llvm.func @test_vector_usub_never_overflows(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_never_overflows   : test_vector_usub_never_overflows_before  ⊑  test_vector_usub_never_overflows_combined := by
  unfold test_vector_usub_never_overflows_before test_vector_usub_never_overflows_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_always_overflows_combined := [llvmfunc|
  llvm.func @test_scalar_usub_always_overflows(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_usub_always_overflows   : test_scalar_usub_always_overflows_before  ⊑  test_scalar_usub_always_overflows_combined := by
  unfold test_scalar_usub_always_overflows_before test_scalar_usub_always_overflows_combined
  simp_alive_peephole
  sorry
def test_vector_usub_always_overflows_combined := [llvmfunc|
  llvm.func @test_vector_usub_always_overflows(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_always_overflows   : test_vector_usub_always_overflows_before  ⊑  test_vector_usub_always_overflows_combined := by
  unfold test_vector_usub_always_overflows_before test_vector_usub_always_overflows_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_neg_neg_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_neg_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_ssub_neg_neg   : test_scalar_ssub_neg_neg_before  ⊑  test_scalar_ssub_neg_neg_combined := by
  unfold test_scalar_ssub_neg_neg_before test_scalar_ssub_neg_neg_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_neg_neg_combined := [llvmfunc|
  llvm.func @test_vector_ssub_neg_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_neg_neg   : test_vector_ssub_neg_neg_before  ⊑  test_vector_ssub_neg_neg_combined := by
  unfold test_vector_ssub_neg_neg_before test_vector_ssub_neg_neg_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_nneg_nneg_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_nneg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_ssub_nneg_nneg   : test_scalar_ssub_nneg_nneg_before  ⊑  test_scalar_ssub_nneg_nneg_combined := by
  unfold test_scalar_ssub_nneg_nneg_before test_scalar_ssub_nneg_nneg_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_nneg_nneg_combined := [llvmfunc|
  llvm.func @test_vector_ssub_nneg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_nneg_nneg   : test_vector_ssub_nneg_nneg_before  ⊑  test_vector_ssub_nneg_nneg_combined := by
  unfold test_vector_ssub_nneg_nneg_before test_vector_ssub_nneg_nneg_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_neg_nneg_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_neg_nneg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.intr.sadd.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_ssub_neg_nneg   : test_scalar_ssub_neg_nneg_before  ⊑  test_scalar_ssub_neg_nneg_combined := by
  unfold test_scalar_ssub_neg_nneg_before test_scalar_ssub_neg_nneg_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_neg_nneg_combined := [llvmfunc|
  llvm.func @test_vector_ssub_neg_nneg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.sadd.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_neg_nneg   : test_vector_ssub_neg_nneg_before  ⊑  test_vector_ssub_neg_nneg_combined := by
  unfold test_vector_ssub_neg_nneg_before test_vector_ssub_neg_nneg_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_always_overflows_low_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_always_overflows_low(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_ssub_always_overflows_low   : test_scalar_ssub_always_overflows_low_before  ⊑  test_scalar_ssub_always_overflows_low_combined := by
  unfold test_scalar_ssub_always_overflows_low_before test_scalar_ssub_always_overflows_low_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_always_overflows_high_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_always_overflows_high(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_ssub_always_overflows_high   : test_scalar_ssub_always_overflows_high_before  ⊑  test_scalar_ssub_always_overflows_high_combined := by
  unfold test_scalar_ssub_always_overflows_high_before test_scalar_ssub_always_overflows_high_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_add_nuw_no_ov_combined := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_no_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_usub_add_nuw_no_ov   : test_scalar_usub_add_nuw_no_ov_before  ⊑  test_scalar_usub_add_nuw_no_ov_combined := by
  unfold test_scalar_usub_add_nuw_no_ov_before test_scalar_usub_add_nuw_no_ov_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_add_nuw_nsw_no_ov_combined := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_nsw_no_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_usub_add_nuw_nsw_no_ov   : test_scalar_usub_add_nuw_nsw_no_ov_before  ⊑  test_scalar_usub_add_nuw_nsw_no_ov_combined := by
  unfold test_scalar_usub_add_nuw_nsw_no_ov_before test_scalar_usub_add_nuw_nsw_no_ov_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_add_nuw_eq_combined := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_eq(%arg0: i8) -> i8 {
    llvm.return %arg0 : i8
  }]

theorem inst_combine_test_scalar_usub_add_nuw_eq   : test_scalar_usub_add_nuw_eq_before  ⊑  test_scalar_usub_add_nuw_eq_combined := by
  unfold test_scalar_usub_add_nuw_eq_before test_scalar_usub_add_nuw_eq_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_add_nuw_may_ov_combined := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_may_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_usub_add_nuw_may_ov   : test_scalar_usub_add_nuw_may_ov_before  ⊑  test_scalar_usub_add_nuw_may_ov_combined := by
  unfold test_scalar_usub_add_nuw_may_ov_before test_scalar_usub_add_nuw_may_ov_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_urem_must_ov_combined := [llvmfunc|
  llvm.func @test_scalar_usub_urem_must_ov(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_usub_urem_must_ov   : test_scalar_usub_urem_must_ov_before  ⊑  test_scalar_usub_urem_must_ov_combined := by
  unfold test_scalar_usub_urem_must_ov_before test_scalar_usub_urem_must_ov_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_urem_must_zero_combined := [llvmfunc|
  llvm.func @test_scalar_usub_urem_must_zero(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.urem %arg0, %0  : i8
    %3 = llvm.intr.usub.sat(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_usub_urem_must_zero   : test_scalar_usub_urem_must_zero_before  ⊑  test_scalar_usub_urem_must_zero_combined := by
  unfold test_scalar_usub_urem_must_zero_before test_scalar_usub_urem_must_zero_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_add_nuw_known_bits_combined := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_known_bits(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.sub %2, %3 overflow<nuw>  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test_scalar_usub_add_nuw_known_bits   : test_scalar_usub_add_nuw_known_bits_before  ⊑  test_scalar_usub_add_nuw_known_bits_combined := by
  unfold test_scalar_usub_add_nuw_known_bits_before test_scalar_usub_add_nuw_known_bits_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_add_nuw_inferred_combined := [llvmfunc|
  llvm.func @test_scalar_usub_add_nuw_inferred(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.add %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_usub_add_nuw_inferred   : test_scalar_usub_add_nuw_inferred_before  ⊑  test_scalar_usub_add_nuw_inferred_combined := by
  unfold test_scalar_usub_add_nuw_inferred_before test_scalar_usub_add_nuw_inferred_combined
  simp_alive_peephole
  sorry
def test_vector_usub_add_nuw_no_ov_combined := [llvmfunc|
  llvm.func @test_vector_usub_add_nuw_no_ov(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_add_nuw_no_ov   : test_vector_usub_add_nuw_no_ov_before  ⊑  test_vector_usub_add_nuw_no_ov_combined := by
  unfold test_vector_usub_add_nuw_no_ov_before test_vector_usub_add_nuw_no_ov_combined
  simp_alive_peephole
  sorry
def test_vector_usub_add_nuw_no_ov_nonsplat1_combined := [llvmfunc|
  llvm.func @test_vector_usub_add_nuw_no_ov_nonsplat1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_add_nuw_no_ov_nonsplat1   : test_vector_usub_add_nuw_no_ov_nonsplat1_before  ⊑  test_vector_usub_add_nuw_no_ov_nonsplat1_combined := by
  unfold test_vector_usub_add_nuw_no_ov_nonsplat1_before test_vector_usub_add_nuw_no_ov_nonsplat1_combined
  simp_alive_peephole
  sorry
def test_vector_usub_add_nuw_no_ov_nonsplat1_poison_combined := [llvmfunc|
  llvm.func @test_vector_usub_add_nuw_no_ov_nonsplat1_poison(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(9 : i8) : i8
    %3 = llvm.mlir.constant(10 : i8) : i8
    %4 = llvm.mlir.undef : vector<3xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<3xi8>
    %11 = llvm.add %arg0, %0 overflow<nuw>  : vector<3xi8>
    %12 = llvm.intr.usub.sat(%11, %10)  : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_test_vector_usub_add_nuw_no_ov_nonsplat1_poison   : test_vector_usub_add_nuw_no_ov_nonsplat1_poison_before  ⊑  test_vector_usub_add_nuw_no_ov_nonsplat1_poison_combined := by
  unfold test_vector_usub_add_nuw_no_ov_nonsplat1_poison_before test_vector_usub_add_nuw_no_ov_nonsplat1_poison_combined
  simp_alive_peephole
  sorry
def test_vector_usub_add_nuw_no_ov_nonsplat2_combined := [llvmfunc|
  llvm.func @test_vector_usub_add_nuw_no_ov_nonsplat2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, 9]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<9> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.intr.usub.sat(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_add_nuw_no_ov_nonsplat2   : test_vector_usub_add_nuw_no_ov_nonsplat2_before  ⊑  test_vector_usub_add_nuw_no_ov_nonsplat2_combined := by
  unfold test_vector_usub_add_nuw_no_ov_nonsplat2_before test_vector_usub_add_nuw_no_ov_nonsplat2_combined
  simp_alive_peephole
  sorry
def test_vector_usub_add_nuw_no_ov_nonsplat3_combined := [llvmfunc|
  llvm.func @test_vector_usub_add_nuw_no_ov_nonsplat3(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[10, 9]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %2 = llvm.intr.usub.sat(%1, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_add_nuw_no_ov_nonsplat3   : test_vector_usub_add_nuw_no_ov_nonsplat3_before  ⊑  test_vector_usub_add_nuw_no_ov_nonsplat3_combined := by
  unfold test_vector_usub_add_nuw_no_ov_nonsplat3_before test_vector_usub_add_nuw_no_ov_nonsplat3_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_add_nsw_no_ov_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_add_nsw_no_ov(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_ssub_add_nsw_no_ov   : test_scalar_ssub_add_nsw_no_ov_before  ⊑  test_scalar_ssub_add_nsw_no_ov_combined := by
  unfold test_scalar_ssub_add_nsw_no_ov_before test_scalar_ssub_add_nsw_no_ov_combined
  simp_alive_peephole
  sorry
def test_scalar_ssub_add_nsw_may_ov_combined := [llvmfunc|
  llvm.func @test_scalar_ssub_add_nsw_may_ov(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.intr.ssub.sat(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test_scalar_ssub_add_nsw_may_ov   : test_scalar_ssub_add_nsw_may_ov_before  ⊑  test_scalar_ssub_add_nsw_may_ov_combined := by
  unfold test_scalar_ssub_add_nsw_may_ov_before test_scalar_ssub_add_nsw_may_ov_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_add_nsw_no_ov_splat_combined := [llvmfunc|
  llvm.func @test_vector_ssub_add_nsw_no_ov_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_add_nsw_no_ov_splat   : test_vector_ssub_add_nsw_no_ov_splat_before  ⊑  test_vector_ssub_add_nsw_no_ov_splat_combined := by
  unfold test_vector_ssub_add_nsw_no_ov_splat_before test_vector_ssub_add_nsw_no_ov_splat_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_add_nsw_no_ov_nonsplat1_combined := [llvmfunc|
  llvm.func @test_vector_ssub_add_nsw_no_ov_nonsplat1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[7, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.and %arg1, %1  : vector<2xi8>
    %4 = llvm.sub %2, %3 overflow<nsw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_add_nsw_no_ov_nonsplat1   : test_vector_ssub_add_nsw_no_ov_nonsplat1_before  ⊑  test_vector_ssub_add_nsw_no_ov_nonsplat1_combined := by
  unfold test_vector_ssub_add_nsw_no_ov_nonsplat1_before test_vector_ssub_add_nsw_no_ov_nonsplat1_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_add_nsw_no_ov_nonsplat2_combined := [llvmfunc|
  llvm.func @test_vector_ssub_add_nsw_no_ov_nonsplat2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[7, 8]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.and %arg1, %1  : vector<2xi8>
    %4 = llvm.intr.ssub.sat(%2, %3)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_add_nsw_no_ov_nonsplat2   : test_vector_ssub_add_nsw_no_ov_nonsplat2_before  ⊑  test_vector_ssub_add_nsw_no_ov_nonsplat2_combined := by
  unfold test_vector_ssub_add_nsw_no_ov_nonsplat2_before test_vector_ssub_add_nsw_no_ov_nonsplat2_combined
  simp_alive_peephole
  sorry
def test_vector_ssub_add_nsw_no_ov_nonsplat3_combined := [llvmfunc|
  llvm.func @test_vector_ssub_add_nsw_no_ov_nonsplat3(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[7, 6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.intr.ssub.sat(%1, %2)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_test_vector_ssub_add_nsw_no_ov_nonsplat3   : test_vector_ssub_add_nsw_no_ov_nonsplat3_before  ⊑  test_vector_ssub_add_nsw_no_ov_nonsplat3_combined := by
  unfold test_vector_ssub_add_nsw_no_ov_nonsplat3_before test_vector_ssub_add_nsw_no_ov_nonsplat3_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_add_combined := [llvmfunc|
  llvm.func @test_scalar_usub_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_usub_add   : test_scalar_usub_add_before  ⊑  test_scalar_usub_add_combined := by
  unfold test_scalar_usub_add_before test_scalar_usub_add_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_add_extra_use_combined := [llvmfunc|
  llvm.func @test_scalar_usub_add_extra_use(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.store %0, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_scalar_usub_add_extra_use   : test_scalar_usub_add_extra_use_before  ⊑  test_scalar_usub_add_extra_use_combined := by
  unfold test_scalar_usub_add_extra_use_before test_scalar_usub_add_extra_use_combined
  simp_alive_peephole
  sorry
    %1 = llvm.add %0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_usub_add_extra_use   : test_scalar_usub_add_extra_use_before  ⊑  test_scalar_usub_add_extra_use_combined := by
  unfold test_scalar_usub_add_extra_use_before test_scalar_usub_add_extra_use_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_add_commuted_combined := [llvmfunc|
  llvm.func @test_scalar_usub_add_commuted(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_usub_add_commuted   : test_scalar_usub_add_commuted_before  ⊑  test_scalar_usub_add_commuted_combined := by
  unfold test_scalar_usub_add_commuted_before test_scalar_usub_add_commuted_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_add_commuted_wrong_combined := [llvmfunc|
  llvm.func @test_scalar_usub_add_commuted_wrong(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.add %0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_usub_add_commuted_wrong   : test_scalar_usub_add_commuted_wrong_before  ⊑  test_scalar_usub_add_commuted_wrong_combined := by
  unfold test_scalar_usub_add_commuted_wrong_before test_scalar_usub_add_commuted_wrong_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_add_const_combined := [llvmfunc|
  llvm.func @test_scalar_usub_add_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_usub_add_const   : test_scalar_usub_add_const_before  ⊑  test_scalar_usub_add_const_combined := by
  unfold test_scalar_usub_add_const_before test_scalar_usub_add_const_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_sub_combined := [llvmfunc|
  llvm.func @test_scalar_usub_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_scalar_usub_sub   : test_scalar_usub_sub_before  ⊑  test_scalar_usub_sub_combined := by
  unfold test_scalar_usub_sub_before test_scalar_usub_sub_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_sub_extra_use_combined := [llvmfunc|
  llvm.func @test_scalar_usub_sub_extra_use(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.store %0, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_scalar_usub_sub_extra_use   : test_scalar_usub_sub_extra_use_before  ⊑  test_scalar_usub_sub_extra_use_combined := by
  unfold test_scalar_usub_sub_extra_use_before test_scalar_usub_sub_extra_use_combined
  simp_alive_peephole
  sorry
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_usub_sub_extra_use   : test_scalar_usub_sub_extra_use_before  ⊑  test_scalar_usub_sub_extra_use_combined := by
  unfold test_scalar_usub_sub_extra_use_before test_scalar_usub_sub_extra_use_combined
  simp_alive_peephole
  sorry
def test_vector_usub_sub_combined := [llvmfunc|
  llvm.func @test_vector_usub_sub(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_test_vector_usub_sub   : test_vector_usub_sub_before  ⊑  test_vector_usub_sub_combined := by
  unfold test_vector_usub_sub_before test_vector_usub_sub_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_sub_wrong_combined := [llvmfunc|
  llvm.func @test_scalar_usub_sub_wrong(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_usub_sub_wrong   : test_scalar_usub_sub_wrong_before  ⊑  test_scalar_usub_sub_wrong_combined := by
  unfold test_scalar_usub_sub_wrong_before test_scalar_usub_sub_wrong_combined
  simp_alive_peephole
  sorry
def test_scalar_usub_sub_wrong2_combined := [llvmfunc|
  llvm.func @test_scalar_usub_sub_wrong2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_usub_sub_wrong2   : test_scalar_usub_sub_wrong2_before  ⊑  test_scalar_usub_sub_wrong2_combined := by
  unfold test_scalar_usub_sub_wrong2_before test_scalar_usub_sub_wrong2_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_sub_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_uadd_sub   : test_scalar_uadd_sub_before  ⊑  test_scalar_uadd_sub_combined := by
  unfold test_scalar_uadd_sub_before test_scalar_uadd_sub_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_sub_extra_use_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_sub_extra_use(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.store %0, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_scalar_uadd_sub_extra_use   : test_scalar_uadd_sub_extra_use_before  ⊑  test_scalar_uadd_sub_extra_use_combined := by
  unfold test_scalar_uadd_sub_extra_use_before test_scalar_uadd_sub_extra_use_combined
  simp_alive_peephole
  sorry
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_uadd_sub_extra_use   : test_scalar_uadd_sub_extra_use_before  ⊑  test_scalar_uadd_sub_extra_use_combined := by
  unfold test_scalar_uadd_sub_extra_use_before test_scalar_uadd_sub_extra_use_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_sub_commuted_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_sub_commuted(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.uadd.sat(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_uadd_sub_commuted   : test_scalar_uadd_sub_commuted_before  ⊑  test_scalar_uadd_sub_commuted_combined := by
  unfold test_scalar_uadd_sub_commuted_before test_scalar_uadd_sub_commuted_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_sub_commuted_wrong_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_sub_commuted_wrong(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_scalar_uadd_sub_commuted_wrong   : test_scalar_uadd_sub_commuted_wrong_before  ⊑  test_scalar_uadd_sub_commuted_wrong_combined := by
  unfold test_scalar_uadd_sub_commuted_wrong_before test_scalar_uadd_sub_commuted_wrong_combined
  simp_alive_peephole
  sorry
def test_scalar_uadd_sub_const_combined := [llvmfunc|
  llvm.func @test_scalar_uadd_sub_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-42 : i8) : i8
    %2 = llvm.intr.uadd.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.add %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_scalar_uadd_sub_const   : test_scalar_uadd_sub_const_before  ⊑  test_scalar_uadd_sub_const_combined := by
  unfold test_scalar_uadd_sub_const_before test_scalar_uadd_sub_const_combined
  simp_alive_peephole
  sorry
def scalar_uadd_eq_zero_combined := [llvmfunc|
  llvm.func @scalar_uadd_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_scalar_uadd_eq_zero   : scalar_uadd_eq_zero_before  ⊑  scalar_uadd_eq_zero_combined := by
  unfold scalar_uadd_eq_zero_before scalar_uadd_eq_zero_combined
  simp_alive_peephole
  sorry
def scalar_uadd_ne_zero_combined := [llvmfunc|
  llvm.func @scalar_uadd_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_scalar_uadd_ne_zero   : scalar_uadd_ne_zero_before  ⊑  scalar_uadd_ne_zero_combined := by
  unfold scalar_uadd_ne_zero_before scalar_uadd_ne_zero_combined
  simp_alive_peephole
  sorry
def scalar_usub_eq_zero_combined := [llvmfunc|
  llvm.func @scalar_usub_eq_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_scalar_usub_eq_zero   : scalar_usub_eq_zero_before  ⊑  scalar_usub_eq_zero_combined := by
  unfold scalar_usub_eq_zero_before scalar_usub_eq_zero_combined
  simp_alive_peephole
  sorry
def scalar_usub_ne_zero_combined := [llvmfunc|
  llvm.func @scalar_usub_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_scalar_usub_ne_zero   : scalar_usub_ne_zero_before  ⊑  scalar_usub_ne_zero_combined := by
  unfold scalar_usub_ne_zero_before scalar_usub_ne_zero_combined
  simp_alive_peephole
  sorry
def uadd_sat_combined := [llvmfunc|
  llvm.func @uadd_sat(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_sat   : uadd_sat_before  ⊑  uadd_sat_combined := by
  unfold uadd_sat_before uadd_sat_combined
  simp_alive_peephole
  sorry
def uadd_sat_nonstrict_combined := [llvmfunc|
  llvm.func @uadd_sat_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_sat_nonstrict   : uadd_sat_nonstrict_before  ⊑  uadd_sat_nonstrict_combined := by
  unfold uadd_sat_nonstrict_before uadd_sat_nonstrict_combined
  simp_alive_peephole
  sorry
def uadd_sat_commute_add_combined := [llvmfunc|
  llvm.func @uadd_sat_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.urem %0, %arg0  : i32
    %2 = llvm.intr.uadd.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_commute_add   : uadd_sat_commute_add_before  ⊑  uadd_sat_commute_add_combined := by
  unfold uadd_sat_commute_add_before uadd_sat_commute_add_combined
  simp_alive_peephole
  sorry
def uadd_sat_ugt_combined := [llvmfunc|
  llvm.func @uadd_sat_ugt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2442 : i32) : i32
    %1 = llvm.sdiv %arg1, %0  : i32
    %2 = llvm.intr.uadd.sat(%arg0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_ugt   : uadd_sat_ugt_before  ⊑  uadd_sat_ugt_combined := by
  unfold uadd_sat_ugt_before uadd_sat_ugt_combined
  simp_alive_peephole
  sorry
def uadd_sat_uge_combined := [llvmfunc|
  llvm.func @uadd_sat_uge(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2442 : i32) : i32
    %1 = llvm.sdiv %arg1, %0  : i32
    %2 = llvm.intr.uadd.sat(%arg0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_uge   : uadd_sat_uge_before  ⊑  uadd_sat_uge_combined := by
  unfold uadd_sat_uge_before uadd_sat_uge_combined
  simp_alive_peephole
  sorry
def uadd_sat_ugt_commute_add_combined := [llvmfunc|
  llvm.func @uadd_sat_ugt_commute_add(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2442, 4242]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %3 = llvm.srem %1, %arg0  : vector<2xi32>
    %4 = llvm.intr.uadd.sat(%3, %2)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_uadd_sat_ugt_commute_add   : uadd_sat_ugt_commute_add_before  ⊑  uadd_sat_ugt_commute_add_combined := by
  unfold uadd_sat_ugt_commute_add_before uadd_sat_ugt_commute_add_combined
  simp_alive_peephole
  sorry
def uadd_sat_commute_select_combined := [llvmfunc|
  llvm.func @uadd_sat_commute_select(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2442 : i32) : i32
    %1 = llvm.sdiv %arg1, %0  : i32
    %2 = llvm.intr.uadd.sat(%arg0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_commute_select   : uadd_sat_commute_select_before  ⊑  uadd_sat_commute_select_combined := by
  unfold uadd_sat_commute_select_before uadd_sat_commute_select_combined
  simp_alive_peephole
  sorry
def uadd_sat_commute_select_nonstrict_combined := [llvmfunc|
  llvm.func @uadd_sat_commute_select_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2442 : i32) : i32
    %1 = llvm.sdiv %arg1, %0  : i32
    %2 = llvm.intr.uadd.sat(%arg0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_commute_select_nonstrict   : uadd_sat_commute_select_nonstrict_before  ⊑  uadd_sat_commute_select_nonstrict_combined := by
  unfold uadd_sat_commute_select_nonstrict_before uadd_sat_commute_select_nonstrict_combined
  simp_alive_peephole
  sorry
def uadd_sat_commute_select_commute_add_combined := [llvmfunc|
  llvm.func @uadd_sat_commute_select_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(2442 : i32) : i32
    %2 = llvm.urem %0, %arg0  : i32
    %3 = llvm.sdiv %arg1, %1  : i32
    %4 = llvm.intr.uadd.sat(%2, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_uadd_sat_commute_select_commute_add   : uadd_sat_commute_select_commute_add_before  ⊑  uadd_sat_commute_select_commute_add_combined := by
  unfold uadd_sat_commute_select_commute_add_before uadd_sat_commute_select_commute_add_combined
  simp_alive_peephole
  sorry
def uadd_sat_commute_select_ugt_combined := [llvmfunc|
  llvm.func @uadd_sat_commute_select_ugt(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.uadd.sat(%arg0, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_uadd_sat_commute_select_ugt   : uadd_sat_commute_select_ugt_before  ⊑  uadd_sat_commute_select_ugt_combined := by
  unfold uadd_sat_commute_select_ugt_before uadd_sat_commute_select_ugt_combined
  simp_alive_peephole
  sorry
def uadd_sat_commute_select_ugt_commute_add_combined := [llvmfunc|
  llvm.func @uadd_sat_commute_select_ugt_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.srem %0, %arg0  : i32
    %2 = llvm.intr.uadd.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_commute_select_ugt_commute_add   : uadd_sat_commute_select_ugt_commute_add_before  ⊑  uadd_sat_commute_select_ugt_commute_add_combined := by
  unfold uadd_sat_commute_select_ugt_commute_add_before uadd_sat_commute_select_ugt_commute_add_combined
  simp_alive_peephole
  sorry
def not_uadd_sat_combined := [llvmfunc|
  llvm.func @not_uadd_sat(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %arg1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_not_uadd_sat   : not_uadd_sat_before  ⊑  not_uadd_sat_combined := by
  unfold not_uadd_sat_before not_uadd_sat_combined
  simp_alive_peephole
  sorry
def not_uadd_sat2_combined := [llvmfunc|
  llvm.func @not_uadd_sat2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_not_uadd_sat2   : not_uadd_sat2_before  ⊑  not_uadd_sat2_combined := by
  unfold not_uadd_sat2_before not_uadd_sat2_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_combined := [llvmfunc|
  llvm.func @uadd_sat_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.uadd.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_not   : uadd_sat_not_before  ⊑  uadd_sat_not_combined := by
  unfold uadd_sat_not_before uadd_sat_not_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_nonstrict_combined := [llvmfunc|
  llvm.func @uadd_sat_not_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.uadd.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_not_nonstrict   : uadd_sat_not_nonstrict_before  ⊑  uadd_sat_not_nonstrict_combined := by
  unfold uadd_sat_not_nonstrict_before uadd_sat_not_nonstrict_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_commute_add_combined := [llvmfunc|
  llvm.func @uadd_sat_not_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.srem %0, %arg0  : i32
    %3 = llvm.urem %0, %arg1  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.intr.uadd.sat(%3, %4)  : (i32, i32) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_uadd_sat_not_commute_add   : uadd_sat_not_commute_add_before  ⊑  uadd_sat_not_commute_add_combined := by
  unfold uadd_sat_not_commute_add_before uadd_sat_not_commute_add_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_ugt_combined := [llvmfunc|
  llvm.func @uadd_sat_not_ugt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.uadd.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_not_ugt   : uadd_sat_not_ugt_before  ⊑  uadd_sat_not_ugt_combined := by
  unfold uadd_sat_not_ugt_before uadd_sat_not_ugt_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_uge_combined := [llvmfunc|
  llvm.func @uadd_sat_not_uge(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.uadd.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_not_uge   : uadd_sat_not_uge_before  ⊑  uadd_sat_not_uge_combined := by
  unfold uadd_sat_not_uge_before uadd_sat_not_uge_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_ugt_commute_add_combined := [llvmfunc|
  llvm.func @uadd_sat_not_ugt_commute_add(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2442, 4242]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %3 = llvm.xor %arg0, %1  : vector<2xi32>
    %4 = llvm.intr.uadd.sat(%2, %3)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_uadd_sat_not_ugt_commute_add   : uadd_sat_not_ugt_commute_add_before  ⊑  uadd_sat_not_ugt_commute_add_combined := by
  unfold uadd_sat_not_ugt_commute_add_before uadd_sat_not_ugt_commute_add_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_commute_select_combined := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.uadd.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_not_commute_select   : uadd_sat_not_commute_select_before  ⊑  uadd_sat_not_commute_select_combined := by
  unfold uadd_sat_not_commute_select_before uadd_sat_not_commute_select_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_commute_select_nonstrict_combined := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.uadd.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_not_commute_select_nonstrict   : uadd_sat_not_commute_select_nonstrict_before  ⊑  uadd_sat_not_commute_select_nonstrict_combined := by
  unfold uadd_sat_not_commute_select_nonstrict_before uadd_sat_not_commute_select_nonstrict_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_commute_select_commute_add_combined := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.intr.uadd.sat(%2, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_uadd_sat_not_commute_select_commute_add   : uadd_sat_not_commute_select_commute_add_before  ⊑  uadd_sat_not_commute_select_commute_add_combined := by
  unfold uadd_sat_not_commute_select_commute_add_before uadd_sat_not_commute_select_commute_add_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_commute_select_ugt_combined := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select_ugt(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[12, 412]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.urem %0, %arg0  : vector<2xi32>
    %4 = llvm.srem %1, %arg1  : vector<2xi32>
    %5 = llvm.xor %3, %2  : vector<2xi32>
    %6 = llvm.intr.uadd.sat(%4, %5)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_uadd_sat_not_commute_select_ugt   : uadd_sat_not_commute_select_ugt_before  ⊑  uadd_sat_not_commute_select_ugt_combined := by
  unfold uadd_sat_not_commute_select_ugt_before uadd_sat_not_commute_select_ugt_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_commute_select_ugt_commute_add_combined := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select_ugt_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.uadd.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_not_commute_select_ugt_commute_add   : uadd_sat_not_commute_select_ugt_commute_add_before  ⊑  uadd_sat_not_commute_select_ugt_commute_add_combined := by
  unfold uadd_sat_not_commute_select_ugt_commute_add_before uadd_sat_not_commute_select_ugt_commute_add_combined
  simp_alive_peephole
  sorry
def uadd_sat_not_commute_select_uge_commute_add_combined := [llvmfunc|
  llvm.func @uadd_sat_not_commute_select_uge_commute_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.uadd.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_uadd_sat_not_commute_select_uge_commute_add   : uadd_sat_not_commute_select_uge_commute_add_before  ⊑  uadd_sat_not_commute_select_uge_commute_add_combined := by
  unfold uadd_sat_not_commute_select_uge_commute_add_before uadd_sat_not_commute_select_uge_commute_add_combined
  simp_alive_peephole
  sorry
def uadd_sat_constant_combined := [llvmfunc|
  llvm.func @uadd_sat_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-43 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_uadd_sat_constant   : uadd_sat_constant_before  ⊑  uadd_sat_constant_combined := by
  unfold uadd_sat_constant_before uadd_sat_constant_combined
  simp_alive_peephole
  sorry
def uadd_sat_constant_commute_combined := [llvmfunc|
  llvm.func @uadd_sat_constant_commute(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_uadd_sat_constant_commute   : uadd_sat_constant_commute_before  ⊑  uadd_sat_constant_commute_combined := by
  unfold uadd_sat_constant_commute_before uadd_sat_constant_commute_combined
  simp_alive_peephole
  sorry
def uadd_sat_canon_combined := [llvmfunc|
  llvm.func @uadd_sat_canon(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_sat_canon   : uadd_sat_canon_before  ⊑  uadd_sat_canon_combined := by
  unfold uadd_sat_canon_before uadd_sat_canon_combined
  simp_alive_peephole
  sorry
def uadd_sat_canon_y_combined := [llvmfunc|
  llvm.func @uadd_sat_canon_y(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.uadd.sat(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_sat_canon_y   : uadd_sat_canon_y_before  ⊑  uadd_sat_canon_y_combined := by
  unfold uadd_sat_canon_y_before uadd_sat_canon_y_combined
  simp_alive_peephole
  sorry
def uadd_sat_canon_nuw_combined := [llvmfunc|
  llvm.func @uadd_sat_canon_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_sat_canon_nuw   : uadd_sat_canon_nuw_before  ⊑  uadd_sat_canon_nuw_combined := by
  unfold uadd_sat_canon_nuw_before uadd_sat_canon_nuw_combined
  simp_alive_peephole
  sorry
def uadd_sat_canon_y_nuw_combined := [llvmfunc|
  llvm.func @uadd_sat_canon_y_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_sat_canon_y_nuw   : uadd_sat_canon_y_nuw_before  ⊑  uadd_sat_canon_y_nuw_combined := by
  unfold uadd_sat_canon_y_nuw_before uadd_sat_canon_y_nuw_combined
  simp_alive_peephole
  sorry
def uadd_sat_constant_vec_combined := [llvmfunc|
  llvm.func @uadd_sat_constant_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-43> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.add %arg0, %0  : vector<4xi32>
    %4 = llvm.icmp "ugt" %arg0, %1 : vector<4xi32>
    %5 = llvm.select %4, %2, %3 : vector<4xi1>, vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

theorem inst_combine_uadd_sat_constant_vec   : uadd_sat_constant_vec_before  ⊑  uadd_sat_constant_vec_combined := by
  unfold uadd_sat_constant_vec_before uadd_sat_constant_vec_combined
  simp_alive_peephole
  sorry
def uadd_sat_constant_vec_commute_combined := [llvmfunc|
  llvm.func @uadd_sat_constant_vec_commute(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_uadd_sat_constant_vec_commute   : uadd_sat_constant_vec_commute_before  ⊑  uadd_sat_constant_vec_commute_combined := by
  unfold uadd_sat_constant_vec_commute_before uadd_sat_constant_vec_commute_combined
  simp_alive_peephole
  sorry
def uadd_sat_constant_vec_commute_undefs_combined := [llvmfunc|
  llvm.func @uadd_sat_constant_vec_commute_undefs(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(-43 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %11, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %11, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(-1 : i32) : i32
    %22 = llvm.mlir.undef : vector<4xi32>
    %23 = llvm.mlir.constant(0 : i32) : i32
    %24 = llvm.insertelement %21, %22[%23 : i32] : vector<4xi32>
    %25 = llvm.mlir.constant(1 : i32) : i32
    %26 = llvm.insertelement %0, %24[%25 : i32] : vector<4xi32>
    %27 = llvm.mlir.constant(2 : i32) : i32
    %28 = llvm.insertelement %21, %26[%27 : i32] : vector<4xi32>
    %29 = llvm.mlir.constant(3 : i32) : i32
    %30 = llvm.insertelement %21, %28[%29 : i32] : vector<4xi32>
    %31 = llvm.add %arg0, %10  : vector<4xi32>
    %32 = llvm.icmp "ult" %arg0, %20 : vector<4xi32>
    %33 = llvm.select %32, %31, %30 : vector<4xi1>, vector<4xi32>
    llvm.return %33 : vector<4xi32>
  }]

theorem inst_combine_uadd_sat_constant_vec_commute_undefs   : uadd_sat_constant_vec_commute_undefs_before  ⊑  uadd_sat_constant_vec_commute_undefs_combined := by
  unfold uadd_sat_constant_vec_commute_undefs_before uadd_sat_constant_vec_commute_undefs_combined
  simp_alive_peephole
  sorry
def unsigned_sat_variable_using_min_add_combined := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_min_add(%arg0: i32) -> i32 {
    %0 = llvm.call @get_i32() : () -> i32
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_unsigned_sat_variable_using_min_add   : unsigned_sat_variable_using_min_add_before  ⊑  unsigned_sat_variable_using_min_add_combined := by
  unfold unsigned_sat_variable_using_min_add_before unsigned_sat_variable_using_min_add_combined
  simp_alive_peephole
  sorry
def unsigned_sat_variable_using_min_commute_add_combined := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_min_commute_add(%arg0: i32) -> i32 {
    %0 = llvm.call @get_i32() : () -> i32
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_unsigned_sat_variable_using_min_commute_add   : unsigned_sat_variable_using_min_commute_add_before  ⊑  unsigned_sat_variable_using_min_commute_add_combined := by
  unfold unsigned_sat_variable_using_min_commute_add_before unsigned_sat_variable_using_min_commute_add_combined
  simp_alive_peephole
  sorry
def unsigned_sat_variable_using_min_commute_select_combined := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_min_commute_select(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.call @get_v2i8() : () -> vector<2xi8>
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_unsigned_sat_variable_using_min_commute_select   : unsigned_sat_variable_using_min_commute_select_before  ⊑  unsigned_sat_variable_using_min_commute_select_combined := by
  unfold unsigned_sat_variable_using_min_commute_select_before unsigned_sat_variable_using_min_commute_select_combined
  simp_alive_peephole
  sorry
def unsigned_sat_variable_using_min_commute_add_select_combined := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_min_commute_add_select(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.call @get_v2i8() : () -> vector<2xi8>
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_unsigned_sat_variable_using_min_commute_add_select   : unsigned_sat_variable_using_min_commute_add_select_before  ⊑  unsigned_sat_variable_using_min_commute_add_select_combined := by
  unfold unsigned_sat_variable_using_min_commute_add_select_before unsigned_sat_variable_using_min_commute_add_select_combined
  simp_alive_peephole
  sorry
def unsigned_sat_variable_using_wrong_min_combined := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_wrong_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @get_i32() : () -> i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.intr.smin(%2, %arg0)  : (i32, i32) -> i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_unsigned_sat_variable_using_wrong_min   : unsigned_sat_variable_using_wrong_min_before  ⊑  unsigned_sat_variable_using_wrong_min_combined := by
  unfold unsigned_sat_variable_using_wrong_min_before unsigned_sat_variable_using_wrong_min_combined
  simp_alive_peephole
  sorry
def unsigned_sat_variable_using_wrong_value_combined := [llvmfunc|
  llvm.func @unsigned_sat_variable_using_wrong_value(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @get_i32() : () -> i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.intr.umin(%2, %arg0)  : (i32, i32) -> i32
    %4 = llvm.add %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_unsigned_sat_variable_using_wrong_value   : unsigned_sat_variable_using_wrong_value_before  ⊑  unsigned_sat_variable_using_wrong_value_combined := by
  unfold unsigned_sat_variable_using_wrong_value_before unsigned_sat_variable_using_wrong_value_combined
  simp_alive_peephole
  sorry
def unsigned_sat_constant_using_min_combined := [llvmfunc|
  llvm.func @unsigned_sat_constant_using_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-43 : i32) : i32
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_unsigned_sat_constant_using_min   : unsigned_sat_constant_using_min_before  ⊑  unsigned_sat_constant_using_min_combined := by
  unfold unsigned_sat_constant_using_min_before unsigned_sat_constant_using_min_combined
  simp_alive_peephole
  sorry
def unsigned_sat_constant_using_min_splat_combined := [llvmfunc|
  llvm.func @unsigned_sat_constant_using_min_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.uadd.sat(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_unsigned_sat_constant_using_min_splat   : unsigned_sat_constant_using_min_splat_before  ⊑  unsigned_sat_constant_using_min_splat_combined := by
  unfold unsigned_sat_constant_using_min_splat_before unsigned_sat_constant_using_min_splat_combined
  simp_alive_peephole
  sorry
def unsigned_sat_constant_using_min_wrong_constant_combined := [llvmfunc|
  llvm.func @unsigned_sat_constant_using_min_wrong_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-42 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_unsigned_sat_constant_using_min_wrong_constant   : unsigned_sat_constant_using_min_wrong_constant_before  ⊑  unsigned_sat_constant_using_min_wrong_constant_combined := by
  unfold unsigned_sat_constant_using_min_wrong_constant_before unsigned_sat_constant_using_min_wrong_constant_combined
  simp_alive_peephole
  sorry
def uadd_sat_via_add_combined := [llvmfunc|
  llvm.func @uadd_sat_via_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.uadd.sat(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_sat_via_add   : uadd_sat_via_add_before  ⊑  uadd_sat_via_add_combined := by
  unfold uadd_sat_via_add_before uadd_sat_via_add_combined
  simp_alive_peephole
  sorry
def uadd_sat_via_add_nonstrict_combined := [llvmfunc|
  llvm.func @uadd_sat_via_add_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_uadd_sat_via_add_nonstrict   : uadd_sat_via_add_nonstrict_before  ⊑  uadd_sat_via_add_nonstrict_combined := by
  unfold uadd_sat_via_add_nonstrict_before uadd_sat_via_add_nonstrict_combined
  simp_alive_peephole
  sorry
def uadd_sat_via_add_swapped_select_combined := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_select(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.uadd.sat(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_sat_via_add_swapped_select   : uadd_sat_via_add_swapped_select_before  ⊑  uadd_sat_via_add_swapped_select_combined := by
  unfold uadd_sat_via_add_swapped_select_before uadd_sat_via_add_swapped_select_combined
  simp_alive_peephole
  sorry
def uadd_sat_via_add_swapped_select_strict_combined := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_select_strict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_uadd_sat_via_add_swapped_select_strict   : uadd_sat_via_add_swapped_select_strict_before  ⊑  uadd_sat_via_add_swapped_select_strict_combined := by
  unfold uadd_sat_via_add_swapped_select_strict_before uadd_sat_via_add_swapped_select_strict_combined
  simp_alive_peephole
  sorry
def uadd_sat_via_add_swapped_cmp_combined := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_cmp(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.uadd.sat(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_sat_via_add_swapped_cmp   : uadd_sat_via_add_swapped_cmp_before  ⊑  uadd_sat_via_add_swapped_cmp_combined := by
  unfold uadd_sat_via_add_swapped_cmp_before uadd_sat_via_add_swapped_cmp_combined
  simp_alive_peephole
  sorry
def uadd_sat_via_add_swapped_cmp_nonstrict_combined := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_cmp_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_uadd_sat_via_add_swapped_cmp_nonstrict   : uadd_sat_via_add_swapped_cmp_nonstrict_before  ⊑  uadd_sat_via_add_swapped_cmp_nonstrict_combined := by
  unfold uadd_sat_via_add_swapped_cmp_nonstrict_before uadd_sat_via_add_swapped_cmp_nonstrict_combined
  simp_alive_peephole
  sorry
def uadd_sat_via_add_swapped_cmp_nonstric_combined := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_cmp_nonstric(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.uadd.sat(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_sat_via_add_swapped_cmp_nonstric   : uadd_sat_via_add_swapped_cmp_nonstric_before  ⊑  uadd_sat_via_add_swapped_cmp_nonstric_combined := by
  unfold uadd_sat_via_add_swapped_cmp_nonstric_before uadd_sat_via_add_swapped_cmp_nonstric_combined
  simp_alive_peephole
  sorry
def uadd_sat_via_add_swapped_cmp_select_nonstrict_combined := [llvmfunc|
  llvm.func @uadd_sat_via_add_swapped_cmp_select_nonstrict(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_uadd_sat_via_add_swapped_cmp_select_nonstrict   : uadd_sat_via_add_swapped_cmp_select_nonstrict_before  ⊑  uadd_sat_via_add_swapped_cmp_select_nonstrict_combined := by
  unfold uadd_sat_via_add_swapped_cmp_select_nonstrict_before uadd_sat_via_add_swapped_cmp_select_nonstrict_combined
  simp_alive_peephole
  sorry
