module  {
  llvm.func @test_extract_insert_same_idx(%arg0: !llvm.vec<? x 64 x i8>, %arg1: !llvm.vec<? x 16 x i8>) -> !llvm.vec<? x 16 x i8> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.nxv64i8.nxv16i8(%arg0, %arg1, %0) : (!llvm.vec<? x 64 x i8>, !llvm.vec<? x 16 x i8>, i64) -> !llvm.vec<? x 64 x i8>
    %2 = llvm.call @llvm.vector.extract.nxv16i8.nxv64i8(%1, %0) : (!llvm.vec<? x 64 x i8>, i64) -> !llvm.vec<? x 16 x i8>
    llvm.return %2 : !llvm.vec<? x 16 x i8>
  }
  llvm.func @test_extract_insert_dif_idx(%arg0: !llvm.vec<? x 64 x i8>, %arg1: !llvm.vec<? x 16 x i8>) -> !llvm.vec<? x 16 x i8> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(48 : i64) : i64
    %2 = llvm.call @llvm.vector.insert.nxv64i8.nxv16i8(%arg0, %arg1, %1) : (!llvm.vec<? x 64 x i8>, !llvm.vec<? x 16 x i8>, i64) -> !llvm.vec<? x 64 x i8>
    %3 = llvm.call @llvm.vector.extract.nxv16i8.nxv64i8(%2, %0) : (!llvm.vec<? x 64 x i8>, i64) -> !llvm.vec<? x 16 x i8>
    llvm.return %3 : !llvm.vec<? x 16 x i8>
  }
  llvm.func @neg_test_extract_insert_same_idx_dif_ret_size(%arg0: !llvm.vec<? x 64 x i8>, %arg1: !llvm.vec<? x 16 x i8>) -> !llvm.vec<? x 32 x i8> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.nxv64i8.nxv16i8(%arg0, %arg1, %0) : (!llvm.vec<? x 64 x i8>, !llvm.vec<? x 16 x i8>, i64) -> !llvm.vec<? x 64 x i8>
    %2 = llvm.call @llvm.vector.extract.nxv32i8.nxv64i8(%1, %0) : (!llvm.vec<? x 64 x i8>, i64) -> !llvm.vec<? x 32 x i8>
    llvm.return %2 : !llvm.vec<? x 32 x i8>
  }
  llvm.func @llvm.vector.insert.nxv64i8.nxv16i8(!llvm.vec<? x 64 x i8>, !llvm.vec<? x 16 x i8>, i64) -> !llvm.vec<? x 64 x i8>
  llvm.func @llvm.vector.extract.nxv16i8.nxv64i8(!llvm.vec<? x 64 x i8>, i64) -> !llvm.vec<? x 16 x i8>
  llvm.func @llvm.vector.extract.nxv32i8.nxv64i8(!llvm.vec<? x 64 x i8>, i64) -> !llvm.vec<? x 32 x i8>
}
