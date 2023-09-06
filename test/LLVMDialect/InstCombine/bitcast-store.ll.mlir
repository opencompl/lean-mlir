module  {
  llvm.mlir.global external constant @G() : !llvm.array<5 x ptr<i8>>
  llvm.func @foo(%arg0: i32, %arg1: !llvm.ptr<f32>) {
    %0 = llvm.bitcast %arg0 : i32 to f32
    llvm.store %0, %arg1 : !llvm.ptr<f32>
    llvm.return
  }
  llvm.func @bar(%arg0: !llvm.ptr<i8, 1>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.bitcast %arg1 : !llvm.ptr<ptr<i8>> to !llvm.ptr<ptr<i8, 1>>
    llvm.store %arg0, %0 : !llvm.ptr<ptr<i8, 1>>
    llvm.return
  }
  llvm.func @swifterror_store(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<ptr<struct<"swift.error", opaque>>>) {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<i64> to !llvm.ptr<struct<"swift.error", opaque>>
    llvm.store %0, %arg1 : !llvm.ptr<ptr<struct<"swift.error", opaque>>>
    llvm.return
  }
  llvm.func @ppcf128_ones_store(%arg0: !llvm.ptr<ppc_fp128>) {
    %0 = llvm.mlir.constant(-1 : i128) : i128
    %1 = llvm.mlir.constant(0 : i128) : i128
    %2 = llvm.or %1, %0  : i128
    %3 = llvm.bitcast %2 : i128 to !llvm.ppc_fp128
    llvm.store %3, %arg0 : !llvm.ptr<ppc_fp128>
    llvm.return
  }
}
