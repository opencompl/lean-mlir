module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %2, %4[%3 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }
  llvm.func @bar(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<4xf32>
    %4 = llvm.insertelement %1, %3[%2 : i32] : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @baz(%arg0: vector<4xf32>, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %4 = llvm.insertelement %2, %3[%arg1 : i32] : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @bazz(%arg0: vector<4xf32>, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %7 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %8 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %9 = llvm.insertelement %2, %8[%arg1 : i32] : vector<4xf32>
    %10 = llvm.insertelement %3, %9[%4 : i32] : vector<4xf32>
    %11 = llvm.insertelement %0, %10[%5 : i32] : vector<4xf32>
    %12 = llvm.insertelement %6, %11[%4 : i32] : vector<4xf32>
    %13 = llvm.insertelement %7, %12[%arg1 : i32] : vector<4xf32>
    llvm.return %13 : vector<4xf32>
  }
  llvm.func @bazzz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %2, %4[%3 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }
  llvm.func @bazzzz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %2, %4[%3 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }
  llvm.func @bazzzzz() -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.insertelement %1, %0[%2 : i32] : vector<4xf32>
    %6 = llvm.insertelement %3, %5[%4 : i32] : vector<4xf32>
    llvm.return %6 : vector<4xf32>
  }
  llvm.func @bazzzzzz(%arg0: vector<4xf32>, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.undef : f32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.mlir.poison : f32
    %4 = llvm.mlir.undef : vector<4xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf32>
    %13 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %13, %12[%14 : i32] : vector<4xf32>
    llvm.return %15 : vector<4xf32>
  }
}
