module  {
  llvm.func @test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.sdiv %arg0, %1  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sdiv %arg0, %1  : vector<2xi32>
    %3 = llvm.icmp "ne" %2, %0 : vector<2xi32>
    llvm.return %3 : i1
  }
}
