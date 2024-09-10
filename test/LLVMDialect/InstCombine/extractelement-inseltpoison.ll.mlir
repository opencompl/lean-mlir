module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @extractelement_out_of_range(%arg0: vector<2xi32>) -> i32 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.extractelement %arg0[%0 : i8] : vector<2xi32>
    llvm.return %1 : i32
  }
  llvm.func @extractelement_type_out_of_range(%arg0: vector<2xi32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.extractelement %arg0[%0 : i128] : vector<2xi32>
    llvm.return %1 : i32
  }
  llvm.func @bitcasted_inselt_equal_num_elts(%arg0: f32) -> i32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.bitcast %2 : vector<4xf32> to vector<4xi32>
    %4 = llvm.extractelement %3[%1 : i32] : vector<4xi32>
    llvm.return %4 : i32
  }
  llvm.func @test2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.poison : vector<8xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7]> : vector<8xi64>) : vector<8xi64>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<8xi64>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi64> 
    %5 = llvm.add %4, %2  : vector<8xi64>
    %6 = llvm.extractelement %5[%1 : i32] : vector<8xi64>
    llvm.return %6 : i64
  }
  llvm.func @bitcasted_inselt_wide_source_zero_elt(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %arg0, %1[%2 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<4xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xi32>
    llvm.return %5 : i32
  }
  llvm.func @bitcasted_inselt_wide_source_modulo_elt(%arg0: i64) -> i16 {
    %0 = llvm.mlir.poison : vector<2xi64>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<8xi16>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi16>
    llvm.return %5 : i16
  }
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt(%arg0: i64) -> i32 {
    %0 = llvm.mlir.poison : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<4xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xi32>
    llvm.return %5 : i32
  }
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt_not_half(%arg0: i32) -> i8 {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.bitcast %3 : vector<2xi32> to vector<8xi8>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi8>
    llvm.return %5 : i8
  }
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types(%arg0: i15) -> i3 {
    %0 = llvm.mlir.poison : vector<3xi15>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<3xi15>
    %4 = llvm.bitcast %3 : vector<3xi15> to vector<15xi3>
    %5 = llvm.extractelement %4[%2 : i32] : vector<15xi3>
    llvm.return %5 : i3
  }
  llvm.func @bitcasted_inselt_wide_source_wrong_insert(%arg0: vector<2xi32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi32>
    %3 = llvm.bitcast %2 : vector<2xi32> to vector<8xi8>
    %4 = llvm.extractelement %3[%1 : i32] : vector<8xi8>
    llvm.return %4 : i8
  }
  llvm.func @use(vector<8xi8>)
  llvm.func @bitcasted_inselt_wide_source_uses(%arg0: i32) -> i8 {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.bitcast %3 : vector<2xi32> to vector<8xi8>
    llvm.call @use(%4) : (vector<8xi8>) -> ()
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi8>
    llvm.return %5 : i8
  }
  llvm.func @bitcasted_inselt_to_FP(%arg0: i64) -> f32 {
    %0 = llvm.mlir.poison : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : f32
  }
  llvm.func @use_v2i128(vector<2xi128>)
  llvm.func @use_v8f32(vector<8xf32>)
  llvm.func @bitcasted_inselt_to_FP_uses(%arg0: i128) -> f32 {
    %0 = llvm.mlir.poison : vector<2xi128>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi128>
    llvm.call @use_v2i128(%3) : (vector<2xi128>) -> ()
    %4 = llvm.bitcast %3 : vector<2xi128> to vector<8xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xf32>
    llvm.return %5 : f32
  }
  llvm.func @bitcasted_inselt_to_FP_uses2(%arg0: i128) -> f32 {
    %0 = llvm.mlir.poison : vector<2xi128>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi128>
    %4 = llvm.bitcast %3 : vector<2xi128> to vector<8xf32>
    llvm.call @use_v8f32(%4) : (vector<8xf32>) -> ()
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xf32>
    llvm.return %5 : f32
  }
  llvm.func @bitcasted_inselt_from_FP(%arg0: f64) -> i32 {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xi32>
    llvm.return %5 : i32
  }
  llvm.func @use_v2f64(vector<2xf64>)
  llvm.func @use_v8i16(vector<8xi16>)
  llvm.func @bitcasted_inselt_from_FP_uses(%arg0: f64) -> i16 {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    llvm.call @use_v2f64(%3) : (vector<2xf64>) -> ()
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<8xi16>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi16>
    llvm.return %5 : i16
  }
  llvm.func @bitcasted_inselt_from_FP_uses2(%arg0: f64) -> i16 {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<8xi16>
    llvm.call @use_v8i16(%4) : (vector<8xi16>) -> ()
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi16>
    llvm.return %5 : i16
  }
  llvm.func @bitcasted_inselt_to_and_from_FP(%arg0: f64) -> f32 {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : f32
  }
  llvm.func @bitcasted_inselt_to_and_from_FP_uses(%arg0: f64) -> f32 {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    llvm.call @use_v2f64(%3) : (vector<2xf64>) -> ()
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : f32
  }
  llvm.func @use_v4f32(vector<4xf32>)
  llvm.func @bitcasted_inselt_to_and_from_FP_uses2(%arg0: f64) -> f32 {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xf32>
    llvm.call @use_v4f32(%4) : (vector<4xf32>) -> ()
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : f32
  }
  llvm.func @invalid_extractelement(%arg0: vector<2xf64>, %arg1: vector<4xf64>, %arg2: !llvm.ptr) -> vector<4xf64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<2xf64>
    %6 = llvm.insertelement %5, %arg1[%1 : i32] : vector<4xf64>
    %7 = llvm.extractelement %6[%2 : i32] : vector<4xf64>
    llvm.store %7, %arg2 {alignment = 8 : i64} : f64, !llvm.ptr
    %8 = llvm.extractelement %arg0[%3 : i32] : vector<2xf64>
    %9 = llvm.insertelement %8, %6[%4 : i64] : vector<4xf64>
    llvm.return %9 : vector<4xf64>
  }
}
