module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @bitcast_of_insert_i8_i16(%arg0: i16) -> !llvm.vec<? x 2 x  i8> {
    %0 = llvm.mlir.undef : !llvm.vec<? x 1 x  i16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 1 x  i16>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 1 x  i16> to !llvm.vec<? x 2 x  i8>
    llvm.return %3 : !llvm.vec<? x 2 x  i8>
  }
}
