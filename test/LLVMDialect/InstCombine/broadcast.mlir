module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @good1(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    llvm.return %8 : vector<4xf32>
  }
  llvm.func @good2(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    llvm.return %8 : vector<4xf32>
  }
  llvm.func @good3(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.insertelement %arg0, %1[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg0, %8[%5 : i32] : vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }
  llvm.func @good4(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.insertelement %arg0, %1[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg0, %8[%5 : i32] : vector<4xf32>
    %10 = llvm.fadd %9, %9  : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }
  llvm.func @good5(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.fadd %5, %5  : vector<4xf32>
    %7 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg0, %8[%4 : i32] : vector<4xf32>
    %10 = llvm.fadd %6, %9  : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }
  llvm.func @splat_undef1(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg0, %4[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    llvm.return %7 : vector<4xf32>
  }
  llvm.func @splat_undef2(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%3 : i32] : vector<4xf32>
    llvm.return %6 : vector<4xf32>
  }
  llvm.func @bad3(%arg0: f32, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    llvm.return %8 : vector<4xf32>
  }
  llvm.func @bad4(%arg0: f32) -> vector<1xf32> {
    %0 = llvm.mlir.undef : vector<1xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<1xf32>
    llvm.return %2 : vector<1xf32>
  }
  llvm.func @splat_undef3(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    %9 = llvm.fadd %8, %6  : vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }
  llvm.func @bad6(%arg0: f32, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%arg1 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    llvm.return %7 : vector<4xf32>
  }
  llvm.func @bad7(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.fadd %5, %5  : vector<4xf32>
    %7 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg0, %8[%4 : i32] : vector<4xf32>
    %10 = llvm.fadd %6, %9  : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }
}
