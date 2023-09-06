module  {
  llvm.func @alloca(%arg0: !llvm.vec<? x 4 x i32>) -> !llvm.vec<? x 4 x i32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.vec<? x 4 x i32> : (i32) -> !llvm.ptr<vec<? x 4 x i32>>
    llvm.store %arg0, %1 : !llvm.ptr<vec<? x 4 x i32>>
    %2 = llvm.load %1 : !llvm.ptr<vec<? x 4 x i32>>
    llvm.return %2 : !llvm.vec<? x 4 x i32>
  }
  llvm.func @alloca_dead_store(%arg0: !llvm.vec<? x 4 x i32>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.vec<? x 4 x i32> : (i32) -> !llvm.ptr<vec<? x 4 x i32>>
    llvm.store %arg0, %1 : !llvm.ptr<vec<? x 4 x i32>>
    llvm.return
  }
  llvm.func @use(...)
  llvm.func @alloca_zero_byte_move_first_inst() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.vec<? x 16 x i8> : (i32) -> !llvm.ptr<vec<? x 16 x i8>>
    llvm.call @use(%1) : (!llvm.ptr<vec<? x 16 x i8>>) -> ()
    %2 = llvm.alloca %0 x !llvm.struct<()> : (i32) -> !llvm.ptr<struct<()>>
    llvm.call @use(%2) : (!llvm.ptr<struct<()>>) -> ()
    llvm.return
  }
}
