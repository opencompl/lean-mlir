module  {
  llvm.func @test1(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fadd %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }
  llvm.func @test2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fsub %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }
  llvm.func @test3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fmul %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }
  llvm.func @test4(%arg0: f64, %arg1: f16) -> f64 {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f16 to f80
    %2 = llvm.fmul %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }
  llvm.func @test5(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fdiv %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }
}
