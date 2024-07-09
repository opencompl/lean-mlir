module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @strtol(!llvm.ptr, !llvm.ptr, i32) -> i32
  llvm.func @strtod(!llvm.ptr, !llvm.ptr) -> f64
  llvm.func @strtof(!llvm.ptr, !llvm.ptr) -> f32
  llvm.func @strtoul(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @strtoll(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @strtold(!llvm.ptr, !llvm.ptr) -> f64
  llvm.func @strtoull(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @test_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.call @strtol(%arg0, %0, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @strtod(%arg0, %0) : (!llvm.ptr, !llvm.ptr) -> f64
    llvm.return
  }
  llvm.func @test_simplify3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @strtof(%arg0, %0) : (!llvm.ptr, !llvm.ptr) -> f32
    llvm.return
  }
  llvm.func @test_simplify4(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.call @strtoul(%arg0, %0, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return
  }
  llvm.func @test_simplify5(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.call @strtoll(%arg0, %0, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return
  }
  llvm.func @test_simplify6(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @strtold(%arg0, %0) : (!llvm.ptr, !llvm.ptr) -> f64
    llvm.return
  }
  llvm.func @test_simplify7(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.call @strtoull(%arg0, %0, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return
  }
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.call @strtol(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return
  }
}
