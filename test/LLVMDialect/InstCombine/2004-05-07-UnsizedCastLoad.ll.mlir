module  {
  llvm.func @test(%arg0: !llvm.ptr<struct<"Ty", opaque>>) -> i32 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<struct<"Ty", opaque>> to !llvm.ptr<i32>
    %1 = llvm.load %0 : !llvm.ptr<i32>
    llvm.return %1 : i32
  }
}
