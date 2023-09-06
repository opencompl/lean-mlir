module  {
  llvm.mlir.global external @d(15 : i32) : i32
  llvm.mlir.global external @b() : !llvm.ptr<i32> {
    %0 = llvm.mlir.addressof @d : !llvm.ptr<i32>
    llvm.return %0 : !llvm.ptr<i32>
  }
  llvm.mlir.global common @a(0 : i32) : i32
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr<i32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(2072 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.addressof @a : !llvm.ptr<i32>
    %6 = llvm.mlir.addressof @b : !llvm.ptr<ptr<i32>>
    %7 = llvm.load %6 : !llvm.ptr<ptr<i32>>
    %8 = llvm.load %5 : !llvm.ptr<i32>
    %9 = llvm.icmp "eq" %8, %4 : i32
    %10 = llvm.zext %9 : i1 to i32
    %11 = llvm.lshr %3, %10  : i32
    %12 = llvm.lshr %11, %2  : i32
    %13 = llvm.and %12, %1  : i32
    %14 = llvm.load %7 : !llvm.ptr<i32>
    %15 = llvm.or %13, %14  : i32
    llvm.store %15, %7 : !llvm.ptr<i32>
    %16 = llvm.load %0 : !llvm.ptr<i32>
    %17 = llvm.icmp "eq" %16, %4 : i32
    %18 = llvm.zext %17 : i1 to i32
    %19 = llvm.lshr %3, %18  : i32
    %20 = llvm.lshr %19, %2  : i32
    %21 = llvm.and %20, %1  : i32
    %22 = llvm.or %21, %15  : i32
    llvm.store %22, %7 : !llvm.ptr<i32>
    llvm.return %22 : i32
  }
}
