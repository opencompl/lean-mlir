module  {
  llvm.mlir.global external @g() : !llvm.struct<"opaque_t", opaque>
  llvm.mlir.global external @h() : !llvm.struct<"op_ts", (struct<"opaque2", opaque>, i32)>
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.addressof @h : !llvm.ptr<struct<"op_ts", (struct<"opaque2", opaque>, i32)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<struct<"op_ts", (struct<"opaque2", opaque>, i32)>> to !llvm.ptr<i32>
    %2 = llvm.mlir.addressof @g : !llvm.ptr<struct<"opaque_t", opaque>>
    %3 = llvm.bitcast %2 : !llvm.ptr<struct<"opaque_t", opaque>> to !llvm.ptr<i8>
    %4 = llvm.load %3 : !llvm.ptr<i8>
    %5 = llvm.load %1 : !llvm.ptr<i32>
    %6 = llvm.zext %4 : i8 to i32
    %7 = llvm.add %5, %6  : i32
    llvm.return %7 : i32
  }
}
