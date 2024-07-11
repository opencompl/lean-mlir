import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  callsite_nonnull_args_through_casts
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def nonnullAfterBitCast_before := [llvmfunc|
  llvm.func @nonnullAfterBitCast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def nonnullAfterSExt_before := [llvmfunc|
  llvm.func @nonnullAfterSExt(%arg0: i8) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.inttoptr %3 : i64 to !llvm.ptr
    llvm.call @foo(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

def nonnullAfterZExt_before := [llvmfunc|
  llvm.func @nonnullAfterZExt(%arg0: i8) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.inttoptr %3 : i64 to !llvm.ptr
    llvm.call @foo(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

def nonnullAfterInt2Ptr_before := [llvmfunc|
  llvm.func @nonnullAfterInt2Ptr(%arg0: i32, %arg1: i64) {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(100 : i64) : i64
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    llvm.call @foo(%3) : (!llvm.ptr) -> ()
    %4 = llvm.sdiv %1, %arg1  : i64
    %5 = llvm.inttoptr %4 : i64 to !llvm.ptr
    llvm.call @foo(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

def nonnullAfterPtr2Int_before := [llvmfunc|
  llvm.func @nonnullAfterPtr2Int() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    llvm.call @foo(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

def maybenullAfterInt2Ptr_before := [llvmfunc|
  llvm.func @maybenullAfterInt2Ptr(%arg0: i128) {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.icmp "ne" %arg0, %0 : i128
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.inttoptr %arg0 : i128 to !llvm.ptr
    llvm.call @foo(%2) : (!llvm.ptr) -> ()
    llvm.return
  }]

def maybenullAfterPtr2Int_before := [llvmfunc|
  llvm.func @maybenullAfterPtr2Int() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    llvm.call @foo(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

def maybenullAfterAddrspacecast_before := [llvmfunc|
  llvm.func @maybenullAfterAddrspacecast(%arg0: !llvm.ptr {llvm.nonnull}) {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<1>
    llvm.call @bar(%0) : (!llvm.ptr<1>) -> ()
    llvm.call @foo(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }]

def nonnullAfterBitCast_combined := [llvmfunc|
  llvm.func @nonnullAfterBitCast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_nonnullAfterBitCast   : nonnullAfterBitCast_before  ⊑  nonnullAfterBitCast_combined := by
  unfold nonnullAfterBitCast_before nonnullAfterBitCast_combined
  simp_alive_peephole
  sorry
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_nonnullAfterBitCast   : nonnullAfterBitCast_before  ⊑  nonnullAfterBitCast_combined := by
  unfold nonnullAfterBitCast_before nonnullAfterBitCast_combined
  simp_alive_peephole
  sorry
def nonnullAfterSExt_combined := [llvmfunc|
  llvm.func @nonnullAfterSExt(%arg0: i8) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.zext %arg0 : i8 to i64
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    llvm.call @foo(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_nonnullAfterSExt   : nonnullAfterSExt_before  ⊑  nonnullAfterSExt_combined := by
  unfold nonnullAfterSExt_before nonnullAfterSExt_combined
  simp_alive_peephole
  sorry
def nonnullAfterZExt_combined := [llvmfunc|
  llvm.func @nonnullAfterZExt(%arg0: i8) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.zext %arg0 : i8 to i64
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    llvm.call @foo(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_nonnullAfterZExt   : nonnullAfterZExt_before  ⊑  nonnullAfterZExt_combined := by
  unfold nonnullAfterZExt_before nonnullAfterZExt_combined
  simp_alive_peephole
  sorry
def nonnullAfterInt2Ptr_combined := [llvmfunc|
  llvm.func @nonnullAfterInt2Ptr(%arg0: i32, %arg1: i64) {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(100 : i64) : i64
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.inttoptr %3 : i64 to !llvm.ptr
    llvm.call @foo(%4) : (!llvm.ptr) -> ()
    %5 = llvm.sdiv %1, %arg1  : i64
    %6 = llvm.inttoptr %5 : i64 to !llvm.ptr
    llvm.call @foo(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_nonnullAfterInt2Ptr   : nonnullAfterInt2Ptr_before  ⊑  nonnullAfterInt2Ptr_combined := by
  unfold nonnullAfterInt2Ptr_before nonnullAfterInt2Ptr_combined
  simp_alive_peephole
  sorry
def nonnullAfterPtr2Int_combined := [llvmfunc|
  llvm.func @nonnullAfterPtr2Int() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_nonnullAfterPtr2Int   : nonnullAfterPtr2Int_before  ⊑  nonnullAfterPtr2Int_combined := by
  unfold nonnullAfterPtr2Int_before nonnullAfterPtr2Int_combined
  simp_alive_peephole
  sorry
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_nonnullAfterPtr2Int   : nonnullAfterPtr2Int_before  ⊑  nonnullAfterPtr2Int_combined := by
  unfold nonnullAfterPtr2Int_before nonnullAfterPtr2Int_combined
  simp_alive_peephole
  sorry
def maybenullAfterInt2Ptr_combined := [llvmfunc|
  llvm.func @maybenullAfterInt2Ptr(%arg0: i128) {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.icmp "ne" %arg0, %0 : i128
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.trunc %arg0 : i128 to i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    llvm.call @foo(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_maybenullAfterInt2Ptr   : maybenullAfterInt2Ptr_before  ⊑  maybenullAfterInt2Ptr_combined := by
  unfold maybenullAfterInt2Ptr_before maybenullAfterInt2Ptr_combined
  simp_alive_peephole
  sorry
def maybenullAfterPtr2Int_combined := [llvmfunc|
  llvm.func @maybenullAfterPtr2Int() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4294967292 : i64) : i64
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_maybenullAfterPtr2Int   : maybenullAfterPtr2Int_before  ⊑  maybenullAfterPtr2Int_combined := by
  unfold maybenullAfterPtr2Int_before maybenullAfterPtr2Int_combined
  simp_alive_peephole
  sorry
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.and %3, %1  : i64
    %5 = llvm.inttoptr %4 : i64 to !llvm.ptr
    llvm.call @foo(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_maybenullAfterPtr2Int   : maybenullAfterPtr2Int_before  ⊑  maybenullAfterPtr2Int_combined := by
  unfold maybenullAfterPtr2Int_before maybenullAfterPtr2Int_combined
  simp_alive_peephole
  sorry
def maybenullAfterAddrspacecast_combined := [llvmfunc|
  llvm.func @maybenullAfterAddrspacecast(%arg0: !llvm.ptr {llvm.nonnull}) {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<1>
    llvm.call @bar(%0) : (!llvm.ptr<1>) -> ()
    llvm.call @foo(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_maybenullAfterAddrspacecast   : maybenullAfterAddrspacecast_before  ⊑  maybenullAfterAddrspacecast_combined := by
  unfold maybenullAfterAddrspacecast_before maybenullAfterAddrspacecast_combined
  simp_alive_peephole
  sorry
