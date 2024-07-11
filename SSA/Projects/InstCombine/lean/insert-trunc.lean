import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  insert-trunc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def low_index_same_length_poison_basevec_before := [llvmfunc|
  llvm.func @low_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<4xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }]

def high_index_same_length_poison_basevec_before := [llvmfunc|
  llvm.func @high_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<4xi16>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }]

def wrong_index_same_length_poison_basevec_before := [llvmfunc|
  llvm.func @wrong_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<4xi16>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }]

def low_index_longer_length_poison_basevec_before := [llvmfunc|
  llvm.func @low_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }]

def high_index_longer_length_poison_basevec_before := [llvmfunc|
  llvm.func @high_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }]

def wrong_index_longer_length_poison_basevec_before := [llvmfunc|
  llvm.func @wrong_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }]

def low_index_shorter_length_poison_basevec_before := [llvmfunc|
  llvm.func @low_index_shorter_length_poison_basevec(%arg0: i64) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def wrong_index_shorter_length_poison_basevec_before := [llvmfunc|
  llvm.func @wrong_index_shorter_length_poison_basevec(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

def wrong_width_low_index_shorter_length_poison_basevec_before := [llvmfunc|
  llvm.func @wrong_width_low_index_shorter_length_poison_basevec(%arg0: i65) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i65 to i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

def low_index_shorter_length_poison_basevec_extra_use_before := [llvmfunc|
  llvm.func @low_index_shorter_length_poison_basevec_extra_use(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

def lshr_same_length_poison_basevec_le_before := [llvmfunc|
  llvm.func @lshr_same_length_poison_basevec_le(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }]

def lshr_same_length_poison_basevec_be_before := [llvmfunc|
  llvm.func @lshr_same_length_poison_basevec_be(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }]

def lshr_same_length_poison_basevec_both_endian_before := [llvmfunc|
  llvm.func @lshr_same_length_poison_basevec_both_endian(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }]

def lshr_wrong_index_same_length_poison_basevec_before := [llvmfunc|
  llvm.func @lshr_wrong_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }]

def lshr_longer_length_poison_basevec_le_before := [llvmfunc|
  llvm.func @lshr_longer_length_poison_basevec_le(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.poison : vector<8xi16>
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<8xi16>
    llvm.return %5 : vector<8xi16>
  }]

def lshr_longer_length_poison_basevec_be_before := [llvmfunc|
  llvm.func @lshr_longer_length_poison_basevec_be(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<8xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<8xi16>
    llvm.return %5 : vector<8xi16>
  }]

def lshr_wrong_index_longer_length_poison_basevec_before := [llvmfunc|
  llvm.func @lshr_wrong_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.poison : vector<8xi16>
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<8xi16>
    llvm.return %5 : vector<8xi16>
  }]

def lshr_shorter_length_poison_basevec_le_before := [llvmfunc|
  llvm.func @lshr_shorter_length_poison_basevec_le(%arg0: i64) -> vector<2xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.poison : vector<2xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<2xi16>
    llvm.return %5 : vector<2xi16>
  }]

def lshr_shorter_length_poison_basevec_be_before := [llvmfunc|
  llvm.func @lshr_shorter_length_poison_basevec_be(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }]

def lshr_wrong_index_shorter_length_poison_basevec_before := [llvmfunc|
  llvm.func @lshr_wrong_index_shorter_length_poison_basevec(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }]

def lshr_wrong_shift_shorter_length_poison_basevec_before := [llvmfunc|
  llvm.func @lshr_wrong_shift_shorter_length_poison_basevec(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(57 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }]

def lshr_shorter_length_poison_basevec_be_extra_use_before := [llvmfunc|
  llvm.func @lshr_shorter_length_poison_basevec_be_extra_use(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }]

def low_index_same_length_basevec_before := [llvmfunc|
  llvm.func @low_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }]

def high_index_same_length_basevec_before := [llvmfunc|
  llvm.func @high_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }]

def wrong_index_same_length_basevec_before := [llvmfunc|
  llvm.func @wrong_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }]

def low_index_longer_length_basevec_before := [llvmfunc|
  llvm.func @low_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

def high_index_longer_length_basevec_before := [llvmfunc|
  llvm.func @high_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

def wrong_index_longer_length_basevec_before := [llvmfunc|
  llvm.func @wrong_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

def low_index_shorter_length_basevec_before := [llvmfunc|
  llvm.func @low_index_shorter_length_basevec(%arg0: i64, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

def wrong_index_shorter_length_basevec_before := [llvmfunc|
  llvm.func @wrong_index_shorter_length_basevec(%arg0: i64, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i8
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def lshr_same_length_basevec_le_before := [llvmfunc|
  llvm.func @lshr_same_length_basevec_le(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

def lshr_same_length_basevec_be_before := [llvmfunc|
  llvm.func @lshr_same_length_basevec_be(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

def lshr_same_length_basevec_both_endian_before := [llvmfunc|
  llvm.func @lshr_same_length_basevec_both_endian(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

def lshr_wrong_index_same_length_basevec_before := [llvmfunc|
  llvm.func @lshr_wrong_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

def lshr_longer_length_basevec_le_before := [llvmfunc|
  llvm.func @lshr_longer_length_basevec_le(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<8xi16>
    llvm.return %4 : vector<8xi16>
  }]

def lshr_longer_length_basevec_be_before := [llvmfunc|
  llvm.func @lshr_longer_length_basevec_be(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<8xi16>
    llvm.return %4 : vector<8xi16>
  }]

def lshr_wrong_index_longer_length_basevec_before := [llvmfunc|
  llvm.func @lshr_wrong_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<8xi16>
    llvm.return %4 : vector<8xi16>
  }]

def lshr_shorter_length_basevec_le_before := [llvmfunc|
  llvm.func @lshr_shorter_length_basevec_le(%arg0: i64, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def lshr_shorter_length_basevec_be_before := [llvmfunc|
  llvm.func @lshr_shorter_length_basevec_be(%arg0: i64, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i8
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def lshr_wrong_index_shorter_length_basevec_before := [llvmfunc|
  llvm.func @lshr_wrong_index_shorter_length_basevec(%arg0: i64, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i8
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def low_index_same_length_poison_basevec_combined := [llvmfunc|
  llvm.func @low_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<4xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }]

theorem inst_combine_low_index_same_length_poison_basevec   : low_index_same_length_poison_basevec_before  ⊑  low_index_same_length_poison_basevec_combined := by
  unfold low_index_same_length_poison_basevec_before low_index_same_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def high_index_same_length_poison_basevec_combined := [llvmfunc|
  llvm.func @high_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<4xi16>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }]

theorem inst_combine_high_index_same_length_poison_basevec   : high_index_same_length_poison_basevec_before  ⊑  high_index_same_length_poison_basevec_combined := by
  unfold high_index_same_length_poison_basevec_before high_index_same_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def wrong_index_same_length_poison_basevec_combined := [llvmfunc|
  llvm.func @wrong_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<4xi16>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }]

theorem inst_combine_wrong_index_same_length_poison_basevec   : wrong_index_same_length_poison_basevec_before  ⊑  wrong_index_same_length_poison_basevec_combined := by
  unfold wrong_index_same_length_poison_basevec_before wrong_index_same_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def low_index_longer_length_poison_basevec_combined := [llvmfunc|
  llvm.func @low_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }]

theorem inst_combine_low_index_longer_length_poison_basevec   : low_index_longer_length_poison_basevec_before  ⊑  low_index_longer_length_poison_basevec_combined := by
  unfold low_index_longer_length_poison_basevec_before low_index_longer_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def high_index_longer_length_poison_basevec_combined := [llvmfunc|
  llvm.func @high_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }]

theorem inst_combine_high_index_longer_length_poison_basevec   : high_index_longer_length_poison_basevec_before  ⊑  high_index_longer_length_poison_basevec_combined := by
  unfold high_index_longer_length_poison_basevec_before high_index_longer_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def wrong_index_longer_length_poison_basevec_combined := [llvmfunc|
  llvm.func @wrong_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }]

theorem inst_combine_wrong_index_longer_length_poison_basevec   : wrong_index_longer_length_poison_basevec_before  ⊑  wrong_index_longer_length_poison_basevec_combined := by
  unfold wrong_index_longer_length_poison_basevec_before wrong_index_longer_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def low_index_shorter_length_poison_basevec_combined := [llvmfunc|
  llvm.func @low_index_shorter_length_poison_basevec(%arg0: i64) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_low_index_shorter_length_poison_basevec   : low_index_shorter_length_poison_basevec_before  ⊑  low_index_shorter_length_poison_basevec_combined := by
  unfold low_index_shorter_length_poison_basevec_before low_index_shorter_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def wrong_index_shorter_length_poison_basevec_combined := [llvmfunc|
  llvm.func @wrong_index_shorter_length_poison_basevec(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_wrong_index_shorter_length_poison_basevec   : wrong_index_shorter_length_poison_basevec_before  ⊑  wrong_index_shorter_length_poison_basevec_combined := by
  unfold wrong_index_shorter_length_poison_basevec_before wrong_index_shorter_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def wrong_width_low_index_shorter_length_poison_basevec_combined := [llvmfunc|
  llvm.func @wrong_width_low_index_shorter_length_poison_basevec(%arg0: i65) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i65 to i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_wrong_width_low_index_shorter_length_poison_basevec   : wrong_width_low_index_shorter_length_poison_basevec_before  ⊑  wrong_width_low_index_shorter_length_poison_basevec_combined := by
  unfold wrong_width_low_index_shorter_length_poison_basevec_before wrong_width_low_index_shorter_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def low_index_shorter_length_poison_basevec_extra_use_combined := [llvmfunc|
  llvm.func @low_index_shorter_length_poison_basevec_extra_use(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_low_index_shorter_length_poison_basevec_extra_use   : low_index_shorter_length_poison_basevec_extra_use_before  ⊑  low_index_shorter_length_poison_basevec_extra_use_combined := by
  unfold low_index_shorter_length_poison_basevec_extra_use_before low_index_shorter_length_poison_basevec_extra_use_combined
  simp_alive_peephole
  sorry
def lshr_same_length_poison_basevec_le_combined := [llvmfunc|
  llvm.func @lshr_same_length_poison_basevec_le(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }]

theorem inst_combine_lshr_same_length_poison_basevec_le   : lshr_same_length_poison_basevec_le_before  ⊑  lshr_same_length_poison_basevec_le_combined := by
  unfold lshr_same_length_poison_basevec_le_before lshr_same_length_poison_basevec_le_combined
  simp_alive_peephole
  sorry
def lshr_same_length_poison_basevec_be_combined := [llvmfunc|
  llvm.func @lshr_same_length_poison_basevec_be(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }]

theorem inst_combine_lshr_same_length_poison_basevec_be   : lshr_same_length_poison_basevec_be_before  ⊑  lshr_same_length_poison_basevec_be_combined := by
  unfold lshr_same_length_poison_basevec_be_before lshr_same_length_poison_basevec_be_combined
  simp_alive_peephole
  sorry
def lshr_same_length_poison_basevec_both_endian_combined := [llvmfunc|
  llvm.func @lshr_same_length_poison_basevec_both_endian(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }]

theorem inst_combine_lshr_same_length_poison_basevec_both_endian   : lshr_same_length_poison_basevec_both_endian_before  ⊑  lshr_same_length_poison_basevec_both_endian_combined := by
  unfold lshr_same_length_poison_basevec_both_endian_before lshr_same_length_poison_basevec_both_endian_combined
  simp_alive_peephole
  sorry
def lshr_wrong_index_same_length_poison_basevec_combined := [llvmfunc|
  llvm.func @lshr_wrong_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }]

theorem inst_combine_lshr_wrong_index_same_length_poison_basevec   : lshr_wrong_index_same_length_poison_basevec_before  ⊑  lshr_wrong_index_same_length_poison_basevec_combined := by
  unfold lshr_wrong_index_same_length_poison_basevec_before lshr_wrong_index_same_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def lshr_longer_length_poison_basevec_le_combined := [llvmfunc|
  llvm.func @lshr_longer_length_poison_basevec_le(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.poison : vector<8xi16>
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<8xi16>
    llvm.return %5 : vector<8xi16>
  }]

theorem inst_combine_lshr_longer_length_poison_basevec_le   : lshr_longer_length_poison_basevec_le_before  ⊑  lshr_longer_length_poison_basevec_le_combined := by
  unfold lshr_longer_length_poison_basevec_le_before lshr_longer_length_poison_basevec_le_combined
  simp_alive_peephole
  sorry
def lshr_longer_length_poison_basevec_be_combined := [llvmfunc|
  llvm.func @lshr_longer_length_poison_basevec_be(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<8xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<8xi16>
    llvm.return %5 : vector<8xi16>
  }]

theorem inst_combine_lshr_longer_length_poison_basevec_be   : lshr_longer_length_poison_basevec_be_before  ⊑  lshr_longer_length_poison_basevec_be_combined := by
  unfold lshr_longer_length_poison_basevec_be_before lshr_longer_length_poison_basevec_be_combined
  simp_alive_peephole
  sorry
def lshr_wrong_index_longer_length_poison_basevec_combined := [llvmfunc|
  llvm.func @lshr_wrong_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.poison : vector<8xi16>
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<8xi16>
    llvm.return %5 : vector<8xi16>
  }]

theorem inst_combine_lshr_wrong_index_longer_length_poison_basevec   : lshr_wrong_index_longer_length_poison_basevec_before  ⊑  lshr_wrong_index_longer_length_poison_basevec_combined := by
  unfold lshr_wrong_index_longer_length_poison_basevec_before lshr_wrong_index_longer_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def lshr_shorter_length_poison_basevec_le_combined := [llvmfunc|
  llvm.func @lshr_shorter_length_poison_basevec_le(%arg0: i64) -> vector<2xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.poison : vector<2xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<2xi16>
    llvm.return %5 : vector<2xi16>
  }]

theorem inst_combine_lshr_shorter_length_poison_basevec_le   : lshr_shorter_length_poison_basevec_le_before  ⊑  lshr_shorter_length_poison_basevec_le_combined := by
  unfold lshr_shorter_length_poison_basevec_le_before lshr_shorter_length_poison_basevec_le_combined
  simp_alive_peephole
  sorry
def lshr_shorter_length_poison_basevec_be_combined := [llvmfunc|
  llvm.func @lshr_shorter_length_poison_basevec_be(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }]

theorem inst_combine_lshr_shorter_length_poison_basevec_be   : lshr_shorter_length_poison_basevec_be_before  ⊑  lshr_shorter_length_poison_basevec_be_combined := by
  unfold lshr_shorter_length_poison_basevec_be_before lshr_shorter_length_poison_basevec_be_combined
  simp_alive_peephole
  sorry
def lshr_wrong_index_shorter_length_poison_basevec_combined := [llvmfunc|
  llvm.func @lshr_wrong_index_shorter_length_poison_basevec(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }]

theorem inst_combine_lshr_wrong_index_shorter_length_poison_basevec   : lshr_wrong_index_shorter_length_poison_basevec_before  ⊑  lshr_wrong_index_shorter_length_poison_basevec_combined := by
  unfold lshr_wrong_index_shorter_length_poison_basevec_before lshr_wrong_index_shorter_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def lshr_wrong_shift_shorter_length_poison_basevec_combined := [llvmfunc|
  llvm.func @lshr_wrong_shift_shorter_length_poison_basevec(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(57 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }]

theorem inst_combine_lshr_wrong_shift_shorter_length_poison_basevec   : lshr_wrong_shift_shorter_length_poison_basevec_before  ⊑  lshr_wrong_shift_shorter_length_poison_basevec_combined := by
  unfold lshr_wrong_shift_shorter_length_poison_basevec_before lshr_wrong_shift_shorter_length_poison_basevec_combined
  simp_alive_peephole
  sorry
def lshr_shorter_length_poison_basevec_be_extra_use_combined := [llvmfunc|
  llvm.func @lshr_shorter_length_poison_basevec_be_extra_use(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }]

theorem inst_combine_lshr_shorter_length_poison_basevec_be_extra_use   : lshr_shorter_length_poison_basevec_be_extra_use_before  ⊑  lshr_shorter_length_poison_basevec_be_extra_use_combined := by
  unfold lshr_shorter_length_poison_basevec_be_extra_use_before lshr_shorter_length_poison_basevec_be_extra_use_combined
  simp_alive_peephole
  sorry
def low_index_same_length_basevec_combined := [llvmfunc|
  llvm.func @low_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }]

theorem inst_combine_low_index_same_length_basevec   : low_index_same_length_basevec_before  ⊑  low_index_same_length_basevec_combined := by
  unfold low_index_same_length_basevec_before low_index_same_length_basevec_combined
  simp_alive_peephole
  sorry
def high_index_same_length_basevec_combined := [llvmfunc|
  llvm.func @high_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }]

theorem inst_combine_high_index_same_length_basevec   : high_index_same_length_basevec_before  ⊑  high_index_same_length_basevec_combined := by
  unfold high_index_same_length_basevec_before high_index_same_length_basevec_combined
  simp_alive_peephole
  sorry
def wrong_index_same_length_basevec_combined := [llvmfunc|
  llvm.func @wrong_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }]

theorem inst_combine_wrong_index_same_length_basevec   : wrong_index_same_length_basevec_before  ⊑  wrong_index_same_length_basevec_combined := by
  unfold wrong_index_same_length_basevec_before wrong_index_same_length_basevec_combined
  simp_alive_peephole
  sorry
def low_index_longer_length_basevec_combined := [llvmfunc|
  llvm.func @low_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

theorem inst_combine_low_index_longer_length_basevec   : low_index_longer_length_basevec_before  ⊑  low_index_longer_length_basevec_combined := by
  unfold low_index_longer_length_basevec_before low_index_longer_length_basevec_combined
  simp_alive_peephole
  sorry
def high_index_longer_length_basevec_combined := [llvmfunc|
  llvm.func @high_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

theorem inst_combine_high_index_longer_length_basevec   : high_index_longer_length_basevec_before  ⊑  high_index_longer_length_basevec_combined := by
  unfold high_index_longer_length_basevec_before high_index_longer_length_basevec_combined
  simp_alive_peephole
  sorry
def wrong_index_longer_length_basevec_combined := [llvmfunc|
  llvm.func @wrong_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }]

theorem inst_combine_wrong_index_longer_length_basevec   : wrong_index_longer_length_basevec_before  ⊑  wrong_index_longer_length_basevec_combined := by
  unfold wrong_index_longer_length_basevec_before wrong_index_longer_length_basevec_combined
  simp_alive_peephole
  sorry
def low_index_shorter_length_basevec_combined := [llvmfunc|
  llvm.func @low_index_shorter_length_basevec(%arg0: i64, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_low_index_shorter_length_basevec   : low_index_shorter_length_basevec_before  ⊑  low_index_shorter_length_basevec_combined := by
  unfold low_index_shorter_length_basevec_before low_index_shorter_length_basevec_combined
  simp_alive_peephole
  sorry
def wrong_index_shorter_length_basevec_combined := [llvmfunc|
  llvm.func @wrong_index_shorter_length_basevec(%arg0: i64, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i8
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_wrong_index_shorter_length_basevec   : wrong_index_shorter_length_basevec_before  ⊑  wrong_index_shorter_length_basevec_combined := by
  unfold wrong_index_shorter_length_basevec_before wrong_index_shorter_length_basevec_combined
  simp_alive_peephole
  sorry
def lshr_same_length_basevec_le_combined := [llvmfunc|
  llvm.func @lshr_same_length_basevec_le(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

theorem inst_combine_lshr_same_length_basevec_le   : lshr_same_length_basevec_le_before  ⊑  lshr_same_length_basevec_le_combined := by
  unfold lshr_same_length_basevec_le_before lshr_same_length_basevec_le_combined
  simp_alive_peephole
  sorry
def lshr_same_length_basevec_be_combined := [llvmfunc|
  llvm.func @lshr_same_length_basevec_be(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

theorem inst_combine_lshr_same_length_basevec_be   : lshr_same_length_basevec_be_before  ⊑  lshr_same_length_basevec_be_combined := by
  unfold lshr_same_length_basevec_be_before lshr_same_length_basevec_be_combined
  simp_alive_peephole
  sorry
def lshr_same_length_basevec_both_endian_combined := [llvmfunc|
  llvm.func @lshr_same_length_basevec_both_endian(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

theorem inst_combine_lshr_same_length_basevec_both_endian   : lshr_same_length_basevec_both_endian_before  ⊑  lshr_same_length_basevec_both_endian_combined := by
  unfold lshr_same_length_basevec_both_endian_before lshr_same_length_basevec_both_endian_combined
  simp_alive_peephole
  sorry
def lshr_wrong_index_same_length_basevec_combined := [llvmfunc|
  llvm.func @lshr_wrong_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

theorem inst_combine_lshr_wrong_index_same_length_basevec   : lshr_wrong_index_same_length_basevec_before  ⊑  lshr_wrong_index_same_length_basevec_combined := by
  unfold lshr_wrong_index_same_length_basevec_before lshr_wrong_index_same_length_basevec_combined
  simp_alive_peephole
  sorry
def lshr_longer_length_basevec_le_combined := [llvmfunc|
  llvm.func @lshr_longer_length_basevec_le(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<8xi16>
    llvm.return %4 : vector<8xi16>
  }]

theorem inst_combine_lshr_longer_length_basevec_le   : lshr_longer_length_basevec_le_before  ⊑  lshr_longer_length_basevec_le_combined := by
  unfold lshr_longer_length_basevec_le_before lshr_longer_length_basevec_le_combined
  simp_alive_peephole
  sorry
def lshr_longer_length_basevec_be_combined := [llvmfunc|
  llvm.func @lshr_longer_length_basevec_be(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<8xi16>
    llvm.return %4 : vector<8xi16>
  }]

theorem inst_combine_lshr_longer_length_basevec_be   : lshr_longer_length_basevec_be_before  ⊑  lshr_longer_length_basevec_be_combined := by
  unfold lshr_longer_length_basevec_be_before lshr_longer_length_basevec_be_combined
  simp_alive_peephole
  sorry
def lshr_wrong_index_longer_length_basevec_combined := [llvmfunc|
  llvm.func @lshr_wrong_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<8xi16>
    llvm.return %4 : vector<8xi16>
  }]

theorem inst_combine_lshr_wrong_index_longer_length_basevec   : lshr_wrong_index_longer_length_basevec_before  ⊑  lshr_wrong_index_longer_length_basevec_combined := by
  unfold lshr_wrong_index_longer_length_basevec_before lshr_wrong_index_longer_length_basevec_combined
  simp_alive_peephole
  sorry
def lshr_shorter_length_basevec_le_combined := [llvmfunc|
  llvm.func @lshr_shorter_length_basevec_le(%arg0: i64, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

theorem inst_combine_lshr_shorter_length_basevec_le   : lshr_shorter_length_basevec_le_before  ⊑  lshr_shorter_length_basevec_le_combined := by
  unfold lshr_shorter_length_basevec_le_before lshr_shorter_length_basevec_le_combined
  simp_alive_peephole
  sorry
def lshr_shorter_length_basevec_be_combined := [llvmfunc|
  llvm.func @lshr_shorter_length_basevec_be(%arg0: i64, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i8
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

theorem inst_combine_lshr_shorter_length_basevec_be   : lshr_shorter_length_basevec_be_before  ⊑  lshr_shorter_length_basevec_be_combined := by
  unfold lshr_shorter_length_basevec_be_before lshr_shorter_length_basevec_be_combined
  simp_alive_peephole
  sorry
def lshr_wrong_index_shorter_length_basevec_combined := [llvmfunc|
  llvm.func @lshr_wrong_index_shorter_length_basevec(%arg0: i64, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i8
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

theorem inst_combine_lshr_wrong_index_shorter_length_basevec   : lshr_wrong_index_shorter_length_basevec_before  ⊑  lshr_wrong_index_shorter_length_basevec_combined := by
  unfold lshr_wrong_index_shorter_length_basevec_before lshr_wrong_index_shorter_length_basevec_combined
  simp_alive_peephole
  sorry
