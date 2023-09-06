module  {
  llvm.func @a() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @a : !llvm.ptr<func<i32 ()>>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<func<i32 ()>> to i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }
}
