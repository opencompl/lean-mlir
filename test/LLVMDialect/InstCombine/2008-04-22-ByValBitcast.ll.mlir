module  {
  llvm.func @foo(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.bitcast %arg0 : !llvm.ptr<i8> to !llvm.ptr<struct<"struct.NSRect", (array<4 x f32>)>>
    llvm.call @bar(%0, %1) : (i32, !llvm.ptr<struct<"struct.NSRect", (array<4 x f32>)>>) -> ()
    llvm.return
  }
  llvm.func @bar(i32, ...)
}
