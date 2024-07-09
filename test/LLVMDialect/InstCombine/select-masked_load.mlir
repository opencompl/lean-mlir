module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @masked_load_and_zero_inactive_1(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %4 = llvm.intr.masked.load %arg0, %arg1, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    %5 = llvm.select %arg1, %4, %3 : vector<4xi1>, vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }
  llvm.func @masked_load_and_zero_inactive_2(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.intr.masked.load %arg0, %arg1, %1 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>
    %4 = llvm.select %arg1, %3, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @masked_load_and_zero_inactive_3(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.intr.masked.load %arg0, %arg1, %arg2 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>
    %4 = llvm.select %arg1, %3, %2 : vector<4xi1>, vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @masked_load_and_zero_inactive_4(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %6 = llvm.xor %arg1, %1  : vector<4xi1>
    %7 = llvm.intr.masked.load %arg0, %6, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>
    %8 = llvm.select %arg1, %5, %7 : vector<4xi1>, vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }
  llvm.func @masked_load_and_zero_inactive_5(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.xor %arg1, %1  : vector<4xi1>
    %6 = llvm.intr.masked.load %arg0, %5, %3 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>
    %7 = llvm.select %arg1, %3, %6 : vector<4xi1>, vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
  llvm.func @masked_load_and_zero_inactive_6(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %5 = llvm.xor %arg1, %1  : vector<4xi1>
    %6 = llvm.intr.masked.load %arg0, %5, %arg2 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>
    %7 = llvm.select %arg1, %4, %6 : vector<4xi1>, vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
  llvm.func @masked_load_and_zero_inactive_7(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.intr.masked.load %arg0, %arg1, %1 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>
    %4 = llvm.select %arg2, %1, %3 : vector<4xi1>, vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @masked_load_and_zero_inactive_8(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %6 = llvm.xor %arg1, %1  : vector<4xi1>
    %7 = llvm.and %6, %arg2  : vector<4xi1>
    %8 = llvm.intr.masked.load %arg0, %7, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    %9 = llvm.select %arg1, %5, %8 : vector<4xi1>, vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }
  llvm.func @masked_load_and_scalar_select_cond(%arg0: !llvm.ptr, %arg1: vector<8xi1>, %arg2: i1) -> vector<8xf32> {
    %0 = llvm.mlir.undef : vector<8xf32>
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %4 = llvm.intr.masked.load %arg0, %arg1, %0 {alignment = 32 : i32} : (!llvm.ptr, vector<8xi1>, vector<8xf32>) -> vector<8xf32>
    %5 = llvm.select %arg2, %3, %4 : i1, vector<8xf32>
    llvm.return %5 : vector<8xf32>
  }
}
