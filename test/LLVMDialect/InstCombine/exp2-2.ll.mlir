module  {
  llvm.func @exp2(f64) -> f32
  llvm.func @test_no_simplify1(%arg0: i32) -> f32 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f32
    llvm.return %1 : f32
  }
}
