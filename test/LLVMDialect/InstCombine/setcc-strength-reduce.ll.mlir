module  {
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "uge" %arg0, %0 : i32
    llvm.return %1 : i1
  }
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }
  llvm.func @test3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %0 : i8
    llvm.return %1 : i1
  }
  llvm.func @test4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %0 : i8
    llvm.return %1 : i1
  }
  llvm.func @test5(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }
}
