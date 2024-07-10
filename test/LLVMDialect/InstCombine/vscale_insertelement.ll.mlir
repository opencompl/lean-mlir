module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @insertelement_bitcast(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: i32) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg1 : i32 to f32
    %2 = llvm.bitcast %arg0 : !llvm.vec<? x 4 x  i32> to !llvm.vec<? x 4 x  f32>
    %3 = llvm.insertelement %1, %2[%0 : i32] : !llvm.vec<? x 4 x  f32>
    llvm.return %3 : !llvm.vec<? x 4 x  f32>
  }
  llvm.func @insertelement_extractelement(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %3 = llvm.insertelement %2, %arg1[%1 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %3 : !llvm.vec<? x 4 x  i32>
  }
  llvm.func @insertelement_extractelement_fixed_vec_extract_from_scalable(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %3 = llvm.insertelement %2, %arg1[%1 : i32] : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @insertelement_insertelement(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %3 = llvm.insertelement %1, %2[%1 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %3 : !llvm.vec<? x 4 x  i32>
  }
  llvm.func @insertelement_sequene_may_not_be_splat(%arg0: f32) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.undef : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  f32>
    %6 = llvm.insertelement %arg0, %5[%2 : i32] : !llvm.vec<? x 4 x  f32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : !llvm.vec<? x 4 x  f32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : !llvm.vec<? x 4 x  f32>
    llvm.return %8 : !llvm.vec<? x 4 x  f32>
  }
  llvm.func @ossfuzz_27416(%arg0: i32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.constant(-128 : i8) : i8
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %5 = llvm.shufflevector %4, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    %6 = llvm.insertelement %2, %5[%3 : i8] : vector<[4]xi32>
    llvm.store %6, %arg1 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr
    llvm.return
  }
}
