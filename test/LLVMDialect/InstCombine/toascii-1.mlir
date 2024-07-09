module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @toascii(i32) -> i32
  llvm.func @test_simplify1() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify2() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify3() -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify5() -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify6() -> i32 {
    %0 = llvm.mlir.constant(256 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify7(%arg0: i32) -> i32 {
    %0 = llvm.call @toascii(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
}
