module  {
  llvm.func @exp2(f64) -> f64
  llvm.func @exp2f(f32) -> f32
  llvm.func @test_simplify1(%arg0: i32) -> f64 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify2(%arg0: i16) -> f64 {
    %0 = llvm.sitofp %arg0 : i16 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify3(%arg0: i8) -> f64 {
    %0 = llvm.sitofp %arg0 : i8 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify4(%arg0: i32) -> f32 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.call @exp2f(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_no_simplify1(%arg0: i32) -> f64 {
    %0 = llvm.uitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify6(%arg0: i16) -> f64 {
    %0 = llvm.uitofp %arg0 : i16 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify7(%arg0: i8) -> f64 {
    %0 = llvm.uitofp %arg0 : i8 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify8(%arg0: i8) -> f32 {
    %0 = llvm.uitofp %arg0 : i8 to f32
    %1 = llvm.call @exp2f(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @llvm.exp2.f64(f64) -> f64
  llvm.func @llvm.exp2.f32(f32) -> f32
  llvm.func @test_simplify9(%arg0: i8) -> f64 {
    %0 = llvm.uitofp %arg0 : i8 to f64
    %1 = llvm.call @llvm.exp2.f64(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify10(%arg0: i8) -> f32 {
    %0 = llvm.uitofp %arg0 : i8 to f32
    %1 = llvm.call @llvm.exp2.f32(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
}
