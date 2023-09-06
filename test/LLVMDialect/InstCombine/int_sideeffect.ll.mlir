module  {
  llvm.func @llvm.sideeffect()
  llvm.func @s2l(%arg0: !llvm.ptr<f32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    llvm.store %0, %arg0 : !llvm.ptr<f32>
    llvm.call @llvm.sideeffect() : () -> ()
    %1 = llvm.load %arg0 : !llvm.ptr<f32>
    llvm.return %1 : f32
  }
}
