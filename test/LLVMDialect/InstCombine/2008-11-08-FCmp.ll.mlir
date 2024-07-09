module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "ole" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "olt" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "oge" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-4.400000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @test6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-4.400000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "olt" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @test7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3.200000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "oge" %1, %0 : f64
    llvm.return %2 : i1
  }
}
