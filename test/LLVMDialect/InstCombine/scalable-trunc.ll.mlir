module  {
  llvm.func @trunc_nxv2i64_to_nxv2i32(%arg0: !llvm.ptr<i32>, %arg1: !llvm.vec<? x 4 x i32>) {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.call @llvm.aarch64.sve.ptrue.nxv16i1(%0) : (i32) -> !llvm.vec<? x 16 x i1>
    %2 = llvm.bitcast %arg1 : !llvm.vec<? x 4 x i32> to !llvm.vec<? x 2 x i64>
    %3 = llvm.call @llvm.aarch64.sve.convert.from.svbool.nxv2i1(%1) : (!llvm.vec<? x 16 x i1>) -> !llvm.vec<? x 2 x i1>
    %4 = llvm.trunc %2 : !llvm.vec<? x 2 x i64> to !llvm.vec<? x 2 x i32>
    llvm.call @llvm.aarch64.sve.st1.nxv2i32(%4, %3, %arg0) : (!llvm.vec<? x 2 x i32>, !llvm.vec<? x 2 x i1>, !llvm.ptr<i32>) -> ()
    llvm.return
  }
  llvm.func @llvm.aarch64.sve.st1.nxv2i32(!llvm.vec<? x 2 x i32>, !llvm.vec<? x 2 x i1>, !llvm.ptr<i32>)
  llvm.func @llvm.aarch64.sve.convert.from.svbool.nxv2i1(!llvm.vec<? x 16 x i1>) -> !llvm.vec<? x 2 x i1>
  llvm.func @llvm.aarch64.sve.ptrue.nxv16i1(i32) -> !llvm.vec<? x 16 x i1>
}
