module  {
  llvm.mlir.global common @d(0 : i32) : i32
  llvm.func @f(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.addressof @d : !llvm.ptr<i32>
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.load %1 : !llvm.ptr<i32>
    %4 = llvm.or %3, %0  : i32
    %5 = llvm.add %4, %2  : i32
    %6 = llvm.icmp "ugt" %2, %5 : i32
    llvm.return %6 : i1
  }
}
