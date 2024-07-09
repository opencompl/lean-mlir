module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use_vscale_2_i32(!llvm.vec<? x 2 x  i32>)
  llvm.func @use_vscale_8_i8(!llvm.vec<? x 8 x  i8>)
  llvm.func @extractelement_in_range(%arg0: !llvm.vec<? x 4 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<? x 4 x  i32>
    llvm.return %1 : i32
  }
  llvm.func @extractelement_maybe_out_of_range(%arg0: !llvm.vec<? x 4 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<? x 4 x  i32>
    llvm.return %1 : i32
  }
  llvm.func @extractelement_bitcast(%arg0: f32) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  f32>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 4 x  f32> to !llvm.vec<? x 4 x  i32>
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %4 : i32
  }
  llvm.func @extractelement_bitcast_to_trunc(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : !llvm.vec<? x 2 x  i32>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 2 x  i32> to !llvm.vec<? x 8 x  i8>
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<? x 8 x  i8>
    llvm.return %4 : i8
  }
  llvm.func @extractelement_bitcast_useless_insert(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : !llvm.vec<? x 2 x  i32>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 2 x  i32> to !llvm.vec<? x 8 x  i8>
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<? x 8 x  i8>
    llvm.return %4 : i8
  }
  llvm.func @extractelement_bitcast_insert_extra_use_insert(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : !llvm.vec<? x 2 x  i32>
    llvm.call @use_vscale_2_i32(%2) : (!llvm.vec<? x 2 x  i32>) -> ()
    %3 = llvm.bitcast %2 : !llvm.vec<? x 2 x  i32> to !llvm.vec<? x 8 x  i8>
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<? x 8 x  i8>
    llvm.return %4 : i8
  }
  llvm.func @extractelement_bitcast_insert_extra_use_bitcast(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : !llvm.vec<? x 2 x  i32>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 2 x  i32> to !llvm.vec<? x 8 x  i8>
    llvm.call @use_vscale_8_i8(%3) : (!llvm.vec<? x 8 x  i8>) -> ()
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<? x 8 x  i8>
    llvm.return %4 : i8
  }
  llvm.func @extractelement_shuffle_maybe_out_of_range(%arg0: i32) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    %5 = llvm.extractelement %4[%2 : i32] : vector<[4]xi32>
    llvm.return %5 : i32
  }
  llvm.func @extractelement_shuffle_invalid_index(%arg0: i32) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    %5 = llvm.extractelement %4[%2 : i32] : vector<[4]xi32>
    llvm.return %5 : i32
  }
  llvm.func @extractelement_insertelement_same_positions(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %5 = llvm.extractelement %arg0[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %6 = llvm.extractelement %arg0[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %7 = llvm.extractelement %arg0[%3 : i32] : !llvm.vec<? x 4 x  i32>
    %8 = llvm.insertelement %4, %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %9 = llvm.insertelement %5, %8[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.insertelement %6, %9[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %11 = llvm.insertelement %7, %10[%3 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %11 : !llvm.vec<? x 4 x  i32>
  }
  llvm.func @extractelement_insertelement_diff_positions(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.constant(3 : i32) : i32
    %8 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %9 = llvm.extractelement %arg0[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.extractelement %arg0[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %11 = llvm.extractelement %arg0[%3 : i32] : !llvm.vec<? x 4 x  i32>
    %12 = llvm.insertelement %8, %arg0[%4 : i32] : !llvm.vec<? x 4 x  i32>
    %13 = llvm.insertelement %9, %12[%5 : i32] : !llvm.vec<? x 4 x  i32>
    %14 = llvm.insertelement %10, %13[%6 : i32] : !llvm.vec<? x 4 x  i32>
    %15 = llvm.insertelement %11, %14[%7 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %15 : !llvm.vec<? x 4 x  i32>
  }
  llvm.func @bitcast_of_extractelement(%arg0: !llvm.vec<? x 2 x  f32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 2 x  f32>
    %2 = llvm.bitcast %1 : f32 to i32
    llvm.return %2 : i32
  }
  llvm.func @extractelement_is_zero(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i1, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 2 x  i32>
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @ossfuzz_25272(%arg0: f32) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2147483647 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.bitcast %3 : !llvm.vec<? x 4 x  f32> to !llvm.vec<? x 4 x  i32>
    %5 = llvm.extractelement %4[%2 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %5 : i32
  }
}
