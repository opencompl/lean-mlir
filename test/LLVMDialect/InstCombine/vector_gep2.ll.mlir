module  {
  llvm.func @testa(%arg0: !llvm.vec<2 x ptr<i8>>) -> !llvm.vec<2 x ptr<i8>> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.vec<2 x ptr<i8>>, vector<2xi32>) -> !llvm.vec<2 x ptr<i8>>
    llvm.return %1 : !llvm.vec<2 x ptr<i8>>
  }
  llvm.func @vgep_s_v8i64(%arg0: !llvm.ptr<f64>, %arg1: vector<8xi64>) -> !llvm.vec<8 x ptr<f64>> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<f64>, vector<8xi64>) -> !llvm.vec<8 x ptr<f64>>
    llvm.return %0 : !llvm.vec<8 x ptr<f64>>
  }
  llvm.func @vgep_s_v8i32(%arg0: !llvm.ptr<f64>, %arg1: vector<8xi32>) -> !llvm.vec<8 x ptr<f64>> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<f64>, vector<8xi32>) -> !llvm.vec<8 x ptr<f64>>
    llvm.return %0 : !llvm.vec<8 x ptr<f64>>
  }
  llvm.func @vgep_v8iPtr_i32(%arg0: !llvm.vec<8 x ptr<i8>>, %arg1: i32) -> !llvm.vec<8 x ptr<i8>> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.vec<8 x ptr<i8>>, i32) -> !llvm.vec<8 x ptr<i8>>
    llvm.return %0 : !llvm.vec<8 x ptr<i8>>
  }
}
