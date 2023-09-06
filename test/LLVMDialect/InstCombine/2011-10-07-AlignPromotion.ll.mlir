module  {
  llvm.func @t(%arg0: !llvm.ptr<struct<"struct.CGPoint", (f32, f32)>>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"struct.CGPoint", (f32, f32)> : (i32) -> !llvm.ptr<struct<"struct.CGPoint", (f32, f32)>>
    %2 = llvm.bitcast %arg0 : !llvm.ptr<struct<"struct.CGPoint", (f32, f32)>> to !llvm.ptr<i64>
    %3 = llvm.bitcast %1 : !llvm.ptr<struct<"struct.CGPoint", (f32, f32)>> to !llvm.ptr<i64>
    %4 = llvm.load %2 : !llvm.ptr<i64>
    llvm.store %4, %3 : !llvm.ptr<i64>
    llvm.call @foo(%3) : (!llvm.ptr<i64>) -> ()
    llvm.return
  }
  llvm.func @foo(!llvm.ptr<i64>)
}
