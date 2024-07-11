import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-12-08-Select-ICmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def visible_before := [llvmfunc|
  llvm.func @visible(%arg0: i32, %arg1: i64, %arg2: i64, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.getelementptr %2[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg1, %5 {alignment = 4 : i64} : i64, !llvm.ptr]

    %6 = llvm.getelementptr %3[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg2, %6 {alignment = 4 : i64} : i64, !llvm.ptr]

    %7 = llvm.getelementptr %4[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg3, %7 {alignment = 4 : i64} : i64, !llvm.ptr]

    %8 = llvm.icmp "eq" %arg0, %1 : i32
    %9 = llvm.getelementptr %2[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %11 = llvm.getelementptr %3[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %13 = llvm.getelementptr %4[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    %14 = llvm.load %13 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %15 = llvm.call @determinant(%10, %12, %14) : (i64, i64, i64) -> i32
    %16 = llvm.icmp "slt" %15, %1 : i32
    %17 = llvm.icmp "sgt" %15, %1 : i32
    %18 = llvm.select %8, %16, %17 : i1, i1
    %19 = llvm.zext %18 : i1 to i32
    llvm.return %19 : i32
  }]

def visible_combined := [llvmfunc|
  llvm.func @visible(%arg0: i32, %arg1: i64, %arg2: i64, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.call @determinant(%arg1, %arg2, %arg3) : (i64, i64, i64) -> i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.icmp "sgt" %2, %0 : i32
    %5 = llvm.select %1, %3, %4 : i1, i1
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_visible   : visible_before  ⊑  visible_combined := by
  unfold visible_before visible_combined
  simp_alive_peephole
  sorry
