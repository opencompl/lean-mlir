module  {
  llvm.func @test0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1431655765 : i32) : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %4, %0  : i32
    %6 = llvm.add %arg0, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @test0_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<1431655765> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %2  : vector<4xi32>
    %4 = llvm.xor %3, %1  : vector<4xi32>
    %5 = llvm.add %4, %0  : vector<4xi32>
    %6 = llvm.add %arg0, %5  : vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1431655765 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.add %5, %2  : i32
    %7 = llvm.add %arg0, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @test1_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1431655765> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.ashr %arg0, %2  : vector<4xi32>
    %4 = llvm.and %3, %1  : vector<4xi32>
    %5 = llvm.xor %4, %0  : vector<4xi32>
    %6 = llvm.add %5, %2  : vector<4xi32>
    %7 = llvm.add %arg0, %6  : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
}
