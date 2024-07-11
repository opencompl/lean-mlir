import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr38984-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR38984_1_before := [llvmfunc|
  llvm.func @PR38984_1() -> vector<4xi1> {
    %0 = llvm.mlir.addressof @offsets : !llvm.ptr
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i16]

    %5 = llvm.insertelement %4, %1[%2 : i32] : vector<4xi16>
    %6 = llvm.getelementptr %3[%5] : (!llvm.ptr, vector<4xi16>) -> !llvm.vec<4 x ptr>, i32
    %7 = llvm.getelementptr %3[%5] : (!llvm.ptr, vector<4xi16>) -> !llvm.vec<4 x ptr>, i32
    %8 = llvm.icmp "eq" %6, %7 : !llvm.vec<4 x ptr>
    llvm.return %8 : vector<4xi1>
  }]

def PR38984_2_before := [llvmfunc|
  llvm.func @PR38984_2() -> vector<4xi1> {
    %0 = llvm.mlir.addressof @offsets : !llvm.ptr
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%4, %3] : (!llvm.ptr, i64, i32) -> !llvm.ptr, !llvm.array<21 x i16>
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.load %0 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %9 = llvm.insertelement %8, %1[%2 : i32] : vector<4xi16>
    %10 = llvm.getelementptr %6[%9] : (!llvm.ptr, vector<4xi16>) -> !llvm.vec<4 x ptr>, i16
    %11 = llvm.getelementptr %7[%9] : (!llvm.ptr, vector<4xi16>) -> !llvm.vec<4 x ptr>, i16
    %12 = llvm.icmp "eq" %10, %11 : !llvm.vec<4 x ptr>
    llvm.return %12 : vector<4xi1>
  }]

def PR38984_1_combined := [llvmfunc|
  llvm.func @PR38984_1() -> vector<4xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    llvm.return %1 : vector<4xi1>
  }]

theorem inst_combine_PR38984_1   : PR38984_1_before  ⊑  PR38984_1_combined := by
  unfold PR38984_1_before PR38984_1_combined
  simp_alive_peephole
  sorry
def PR38984_2_combined := [llvmfunc|
  llvm.func @PR38984_2() -> vector<4xi1> {
    %0 = llvm.mlir.addressof @offsets : !llvm.ptr
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(1 : i16) : i16
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%4, %3] : (!llvm.ptr, i16, i16) -> !llvm.ptr, !llvm.array<21 x i16>
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.load %0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %9 = llvm.insertelement %8, %1[%2 : i64] : vector<4xi16>
    %10 = llvm.getelementptr %6[%9] : (!llvm.ptr, vector<4xi16>) -> !llvm.vec<4 x ptr>, i16
    %11 = llvm.getelementptr %7[%9] : (!llvm.ptr, vector<4xi16>) -> !llvm.vec<4 x ptr>, i16
    %12 = llvm.icmp "eq" %10, %11 : !llvm.vec<4 x ptr>
    llvm.return %12 : vector<4xi1>
  }]

theorem inst_combine_PR38984_2   : PR38984_2_before  ⊑  PR38984_2_combined := by
  unfold PR38984_2_before PR38984_2_combined
  simp_alive_peephole
  sorry
