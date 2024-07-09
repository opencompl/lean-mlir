module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fneg_as_int_f32_castback_noimplicitfloat(%arg0: f32) -> f32 attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }
  llvm.func @fneg_as_int_v2f32_noimplicitfloat(%arg0: vector<2xf32>) -> vector<2xi32> attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @fneg_as_int_f32_castback(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }
  llvm.func @not_fneg_as_int_f32_castback_wrongconst(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }
  llvm.func @fneg_as_int_f32_castback_multi_use(%arg0: f32, %arg1: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.xor %1, %0  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }
  llvm.func @fneg_as_int_f64(%arg0: f64) -> i64 {
    %0 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.xor %1, %0  : i64
    llvm.return %2 : i64
  }
  llvm.func @fneg_as_int_v2f64(%arg0: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-9223372036854775808> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.bitcast %arg0 : vector<2xf64> to vector<2xi64>
    %2 = llvm.xor %1, %0  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @fneg_as_int_f64_swap(%arg0: f64) -> i64 {
    %0 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.xor %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @fneg_as_int_f32(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @fneg_as_int_v2f32(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @not_fneg_as_int_v2f32_nonsplat(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-2147483648, -2147483647]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @fneg_as_int_v3f32_poison(%arg0: vector<3xf32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.bitcast %arg0 : vector<3xf32> to vector<3xi32>
    %10 = llvm.xor %9, %8  : vector<3xi32>
    llvm.return %10 : vector<3xi32>
  }
  llvm.func @fneg_as_int_f64_not_bitcast(%arg0: f64) -> i64 {
    %0 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %1 = llvm.fptoui %arg0 : f64 to i64
    %2 = llvm.xor %1, %0  : i64
    llvm.return %2 : i64
  }
  llvm.func @not_fneg_as_int_f32_bitcast_from_v2f16(%arg0: vector<2xf16>) -> f32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : vector<2xf16> to i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }
  llvm.func @not_fneg_as_int_f32_bitcast_from_v2i16(%arg0: vector<2xi16>) -> f32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : vector<2xi16> to i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }
  llvm.func @fneg_as_int_fp128_f64_mask(%arg0: f128) -> i128 {
    %0 = llvm.mlir.constant(-9223372036854775808 : i128) : i128
    %1 = llvm.bitcast %arg0 : f128 to i128
    %2 = llvm.xor %1, %0  : i128
    llvm.return %2 : i128
  }
  llvm.func @fneg_as_int_fp128_f128_mask(%arg0: f128) -> i128 {
    %0 = llvm.mlir.constant(-170141183460469231731687303715884105728 : i128) : i128
    %1 = llvm.bitcast %arg0 : f128 to i128
    %2 = llvm.xor %1, %0  : i128
    llvm.return %2 : i128
  }
  llvm.func @fneg_as_int_f16(%arg0: f16) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i16) : i16
    %1 = llvm.bitcast %arg0 : f16 to i16
    %2 = llvm.xor %1, %0  : i16
    llvm.return %2 : i16
  }
  llvm.func @fneg_as_int_v2f16(%arg0: vector<2xf16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<-32768> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.bitcast %arg0 : vector<2xf16> to vector<2xi16>
    %2 = llvm.xor %1, %0  : vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }
  llvm.func @fneg_as_int_bf16(%arg0: bf16) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i16) : i16
    %1 = llvm.bitcast %arg0 : bf16 to i16
    %2 = llvm.xor %1, %0  : i16
    llvm.return %2 : i16
  }
  llvm.func @fneg_as_int_v2bf16(%arg0: vector<2xbf16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<-32768> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.bitcast %arg0 : vector<2xbf16> to vector<2xi16>
    %2 = llvm.xor %1, %0  : vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }
  llvm.func @fneg_as_int_x86_fp80_f64_mask(%arg0: f80) -> i80 {
    %0 = llvm.mlir.constant(-604462909807314587353088 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.xor %1, %0  : i80
    llvm.return %2 : i80
  }
  llvm.func @fneg_as_int_ppc_fp128_f64_mask(%arg0: !llvm.ppc_fp128) -> i128 {
    %0 = llvm.mlir.constant(-9223372036854775808 : i128) : i128
    %1 = llvm.bitcast %arg0 : !llvm.ppc_fp128 to i128
    %2 = llvm.xor %1, %0  : i128
    llvm.return %2 : i128
  }
  llvm.func @fneg_as_int_ppc_fp128_f128_mask(%arg0: !llvm.ppc_fp128) -> i128 {
    %0 = llvm.mlir.constant(-170141183460469231731687303715884105728 : i128) : i128
    %1 = llvm.bitcast %arg0 : !llvm.ppc_fp128 to i128
    %2 = llvm.xor %1, %0  : i128
    llvm.return %2 : i128
  }
}
