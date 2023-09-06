module  {
  llvm.mlir.global external @G() : !llvm.array<0 x struct<"opaque_struct", opaque>>
  llvm.func @foo(!llvm.ptr<struct<"opaque_struct", opaque>>)
  llvm.func @bar() {
    %0 = llvm.mlir.addressof @G : !llvm.ptr<array<0 x struct<"opaque_struct", opaque>>>
    %1 = llvm.bitcast %0 : !llvm.ptr<array<0 x struct<"opaque_struct", opaque>>> to !llvm.ptr<struct<"opaque_struct", opaque>>
    llvm.call @foo(%1) : (!llvm.ptr<struct<"opaque_struct", opaque>>) -> ()
    llvm.return
  }
}
