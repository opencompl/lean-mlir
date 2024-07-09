module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
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
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.bitcast %2 : vector<4xf32> to vector<4xi32>
    %4 = llvm.extractelement %3[%1 : i32] : vector<4xi32>
    llvm.return %4 : i32
  }
  llvm.func @test2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.undef : vector<8xi64>
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
    %0 = llvm.mlir.undef : vector<2xi64>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<8xi16>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi16>
    llvm.return %5 : i16
  }
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt(%arg0: i64) -> i32 {
    %0 = llvm.mlir.undef : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<4xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xi32>
    llvm.return %5 : i32
  }
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt_not_half(%arg0: i32) -> i8 {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.bitcast %3 : vector<2xi32> to vector<8xi8>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi8>
    llvm.return %5 : i8
  }
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types(%arg0: i15) -> i3 {
    %0 = llvm.mlir.undef : vector<3xi15>
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
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.bitcast %3 : vector<2xi32> to vector<8xi8>
    llvm.call @use(%4) : (vector<8xi8>) -> ()
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi8>
    llvm.return %5 : i8
  }
  llvm.func @bitcasted_inselt_to_FP(%arg0: i64) -> f32 {
    %0 = llvm.mlir.undef : vector<2xi64>
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
    %0 = llvm.mlir.undef : vector<2xi128>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi128>
    llvm.call @use_v2i128(%3) : (vector<2xi128>) -> ()
    %4 = llvm.bitcast %3 : vector<2xi128> to vector<8xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xf32>
    llvm.return %5 : f32
  }
  llvm.func @bitcasted_inselt_to_FP_uses2(%arg0: i128) -> f32 {
    %0 = llvm.mlir.undef : vector<2xi128>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi128>
    %4 = llvm.bitcast %3 : vector<2xi128> to vector<8xf32>
    llvm.call @use_v8f32(%4) : (vector<8xf32>) -> ()
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xf32>
    llvm.return %5 : f32
  }
  llvm.func @bitcasted_inselt_from_FP(%arg0: f64) -> i32 {
    %0 = llvm.mlir.undef : vector<2xf64>
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
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    llvm.call @use_v2f64(%3) : (vector<2xf64>) -> ()
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<8xi16>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi16>
    llvm.return %5 : i16
  }
  llvm.func @bitcasted_inselt_from_FP_uses2(%arg0: f64) -> i16 {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<8xi16>
    llvm.call @use_v8i16(%4) : (vector<8xi16>) -> ()
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi16>
    llvm.return %5 : i16
  }
  llvm.func @bitcasted_inselt_to_and_from_FP(%arg0: f64) -> f32 {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : f32
  }
  llvm.func @bitcasted_inselt_to_and_from_FP_uses(%arg0: f64) -> f32 {
    %0 = llvm.mlir.undef : vector<2xf64>
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
    %0 = llvm.mlir.undef : vector<2xf64>
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
  llvm.func @bitcast_scalar_supported_type_index0(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %2 = llvm.extractelement %1[%0 : i8] : vector<4xi8>
    llvm.return %2 : i8
  }
  llvm.func @bitcast_scalar_supported_type_index2(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %2 = llvm.extractelement %1[%0 : i64] : vector<4xi8>
    llvm.return %2 : i8
  }
  llvm.func @bitcast_scalar_legal_type_index3(%arg0: i64) -> i4 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.bitcast %arg0 : i64 to vector<16xi4>
    %2 = llvm.extractelement %1[%0 : i64] : vector<16xi4>
    llvm.return %2 : i4
  }
  llvm.func @bitcast_scalar_illegal_type_index1(%arg0: i128) -> i8 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.bitcast %arg0 : i128 to vector<16xi8>
    %2 = llvm.extractelement %1[%0 : i64] : vector<16xi8>
    llvm.return %2 : i8
  }
  llvm.func @bitcast_fp_index0(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : f32 to vector<4xi8>
    %2 = llvm.extractelement %1[%0 : i8] : vector<4xi8>
    llvm.return %2 : i8
  }
  llvm.func @bitcast_fp16vec_index0(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<2xf16>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf16>
    llvm.return %2 : f16
  }
  llvm.func @bitcast_fp16vec_index1(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<2xf16>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf16>
    llvm.return %2 : f16
  }
  llvm.func @bitcast_bfp16vec_index0(%arg0: i32) -> bf16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<2xbf16>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xbf16>
    llvm.return %2 : bf16
  }
  llvm.func @bitcast_bfp16vec_index1(%arg0: i32) -> bf16 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<2xbf16>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xbf16>
    llvm.return %2 : bf16
  }
  llvm.func @bitcast_fp32vec_index0(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<2xf32>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf32>
    llvm.return %2 : f32
  }
  llvm.func @bitcast_fp32vec_index1(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<2xf32>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf32>
    llvm.return %2 : f32
  }
  llvm.func @bitcast_fp64vec64_index0(%arg0: i64) -> f64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<1xf64>
    %2 = llvm.extractelement %1[%0 : i8] : vector<1xf64>
    llvm.return %2 : f64
  }
  llvm.func @bitcast_fp64vec_index0(%arg0: i128) -> f64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i128 to vector<2xf64>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf64>
    llvm.return %2 : f64
  }
  llvm.func @bitcast_fp64vec_index1(%arg0: i128) -> f64 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i128 to vector<2xf64>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf64>
    llvm.return %2 : f64
  }
  llvm.func @bitcast_x86fp80vec_index0(%arg0: i160) -> f80 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i160 to vector<2xf80>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf80>
    llvm.return %2 : f80
  }
  llvm.func @bitcast_x86fp80vec_index1(%arg0: i160) -> f80 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i160 to vector<2xf80>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf80>
    llvm.return %2 : f80
  }
  llvm.func @bitcast_fp128vec_index0(%arg0: i256) -> f128 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i256 to vector<2xf128>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf128>
    llvm.return %2 : f128
  }
  llvm.func @bitcast_fp128vec_index1(%arg0: i256) -> f128 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i256 to vector<2xf128>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf128>
    llvm.return %2 : f128
  }
  llvm.func @bitcast_ppcfp128vec_index0(%arg0: i256) -> !llvm.ppc_fp128 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i256 to !llvm.vec<2 x ppc_fp128>
    %2 = llvm.extractelement %1[%0 : i8] : !llvm.vec<2 x ppc_fp128>
    llvm.return %2 : !llvm.ppc_fp128
  }
  llvm.func @bitcast_ppcfp128vec_index1(%arg0: i256) -> !llvm.ppc_fp128 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i256 to !llvm.vec<2 x ppc_fp128>
    %2 = llvm.extractelement %1[%0 : i8] : !llvm.vec<2 x ppc_fp128>
    llvm.return %2 : !llvm.ppc_fp128
  }
  llvm.func @bitcast_scalar_index_variable(%arg0: i32, %arg1: i64) -> i8 {
    %0 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %1 = llvm.extractelement %0[%arg1 : i64] : vector<4xi8>
    llvm.return %1 : i8
  }
  llvm.func @bitcast_scalar_index0_use(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : i64 to vector<8xi8>
    llvm.call @use(%1) : (vector<8xi8>) -> ()
    %2 = llvm.extractelement %1[%0 : i64] : vector<8xi8>
    llvm.return %2 : i8
  }
  llvm.func @bit_extract_cmp(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.bitcast %arg0 : i64 to vector<2xf32>
    %3 = llvm.extractelement %2[%0 : i8] : vector<2xf32>
    %4 = llvm.fcmp "oeq" %3, %1 : f32
    llvm.return %4 : i1
  }
  llvm.func @extelt_select_const_operand_vector(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    %4 = llvm.extractelement %3[%2 : i32] : vector<3xi32>
    llvm.return %4 : i32
  }
  llvm.func @extelt_select_const_operand_vector_float(%arg0: i1) -> f32 {
    %0 = llvm.mlir.constant(dense<[2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, vector<3xf32>
    %4 = llvm.extractelement %3[%2 : i32] : vector<3xf32>
    llvm.return %4 : f32
  }
  llvm.func @extelt_vecselect_const_operand_vector(%arg0: vector<3xi1>) -> i32 {
    %0 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : vector<3xi1>, vector<3xi32>
    %4 = llvm.extractelement %3[%2 : i32] : vector<3xi32>
    llvm.return %4 : i32
  }
  llvm.func @extelt_select_const_operand_extractelt_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<3xi32>
    %6 = llvm.mul %5, %2  : i32
    %7 = llvm.mul %5, %3  : i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @extelt_select_const_operand_select_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<3xi32>
    %6 = llvm.extractelement %4[%3 : i32] : vector<3xi32>
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @extelt_select_const_operand_vector_cond_index(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %4 = llvm.select %arg0, %0, %1 : i1, i32
    %5 = llvm.select %arg0, %2, %3 : i1, vector<3xi32>
    %6 = llvm.extractelement %5[%4 : i32] : vector<3xi32>
    llvm.return %6 : i32
  }
  llvm.func @extelt_select_const_operand_vector_var_index(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    %3 = llvm.extractelement %2[%arg1 : i32] : vector<3xi32>
    llvm.return %3 : i32
  }
  llvm.func @extelt_select_var_const_operand_vector(%arg0: i1, %arg1: vector<3xi32>) -> i32 {
    %0 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.select %arg0, %arg1, %0 : i1, vector<3xi32>
    %3 = llvm.extractelement %2[%1 : i32] : vector<3xi32>
    llvm.return %3 : i32
  }
  llvm.func @extelt_select_const_var_operand_vector(%arg0: i1, %arg1: vector<3xi32>) -> i32 {
    %0 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, vector<3xi32>
    %3 = llvm.extractelement %2[%1 : i32] : vector<3xi32>
    llvm.return %3 : i32
  }
  llvm.func @use_select(vector<3xi32>)
  llvm.func @extelt_select_const_var_operands_vector_extra_use(%arg0: i1, %arg1: vector<3xi32>) -> i32 {
    %0 = llvm.mlir.constant(dense<[42, 5, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.select %arg0, %0, %arg1 : i1, vector<3xi32>
    llvm.call @use_select(%2) : (vector<3xi32>) -> ()
    %3 = llvm.extractelement %2[%1 : i64] : vector<3xi32>
    llvm.return %3 : i32
  }
  llvm.func @extelt_select_const_operands_vector_extra_use_2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[42, 5, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    llvm.call @use_select(%3) : (vector<3xi32>) -> ()
    %4 = llvm.extractelement %3[%2 : i64] : vector<3xi32>
    llvm.return %4 : i32
  }
  llvm.func @crash_4b8320(%arg0: vector<2xf32>, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.fmul %1, %arg0  : vector<2xf32>
    %7 = llvm.fmul %1, %6  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>
    %8 = llvm.extractelement %7[%2 : i64] : vector<2xf32>
    %9 = llvm.extractelement %7[%2 : i64] : vector<2xf32>
    %10 = llvm.insertelement %8, %3[%2 : i64] : vector<4xf32>
    %11 = llvm.insertelement %9, %10[%4 : i64] : vector<4xf32>
    %12 = llvm.insertelement %arg1, %11[%5 : i64] : vector<4xf32>
    %13 = llvm.shufflevector %12, %3 [1, 1, 1, 1] : vector<4xf32> 
    %14 = llvm.fadd %13, %12  : vector<4xf32>
    %15 = llvm.shufflevector %12, %3 [3, 3, 3, 3] : vector<4xf32> 
    %16 = llvm.fadd %14, %15  : vector<4xf32>
    %17 = llvm.extractelement %16[%2 : i64] : vector<4xf32>
    llvm.return %17 : f32
  }
}
