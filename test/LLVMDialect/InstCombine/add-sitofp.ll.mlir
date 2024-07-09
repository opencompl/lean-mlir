module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @x(%arg0: i32, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.sitofp %3 : i32 to f64
    %5 = llvm.fadd %4, %1  : f64
    llvm.return %5 : f64
  }
  llvm.func @test(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sitofp %2 : i32 to f64
    %4 = llvm.fadd %3, %1  : f64
    llvm.return %4 : f64
  }
  llvm.func @test_neg(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sitofp %2 : i32 to f32
    %4 = llvm.fadd %3, %1  : f32
    llvm.return %4 : f32
  }
  llvm.func @test_2(%arg0: i32, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.sitofp %1 : i32 to f64
    %4 = llvm.sitofp %2 : i32 to f64
    %5 = llvm.fadd %3, %4  : f64
    llvm.return %5 : f64
  }
  llvm.func @test_2_neg(%arg0: i32, %arg1: i32) -> f32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.sitofp %1 : i32 to f32
    %4 = llvm.sitofp %2 : i32 to f32
    %5 = llvm.fadd %3, %4  : f32
    llvm.return %5 : f32
  }
  llvm.func @test_3(%arg0: i32, %arg1: i32) -> f32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.sitofp %3 : i32 to f32
    %5 = llvm.fadd %4, %1  : f32
    llvm.return %5 : f32
  }
  llvm.func @test_4(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<1073741823> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.and %arg0, %0  : vector<4xi32>
    %2 = llvm.and %arg1, %0  : vector<4xi32>
    %3 = llvm.sitofp %1 : vector<4xi32> to vector<4xf64>
    %4 = llvm.sitofp %2 : vector<4xi32> to vector<4xf64>
    %5 = llvm.fadd %3, %4  : vector<4xf64>
    llvm.return %5 : vector<4xf64>
  }
  llvm.func @test_4_neg(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<1073741823> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.and %arg0, %0  : vector<4xi32>
    %2 = llvm.and %arg1, %0  : vector<4xi32>
    %3 = llvm.sitofp %1 : vector<4xi32> to vector<4xf32>
    %4 = llvm.sitofp %2 : vector<4xi32> to vector<4xf32>
    %5 = llvm.fadd %3, %4  : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }
}
