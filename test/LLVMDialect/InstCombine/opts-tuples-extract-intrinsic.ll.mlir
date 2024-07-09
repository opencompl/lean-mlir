module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_extract_insert_same_idx(%arg0: !llvm.vec<? x 64 x  i8>, %arg1: !llvm.vec<? x 16 x  i8>) -> !llvm.vec<? x 16 x  i8> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[48] : !llvm.vec<? x 16 x  i8> into !llvm.vec<? x 64 x  i8>
    %1 = llvm.intr.vector.extract %0[48] : !llvm.vec<? x 16 x  i8> from !llvm.vec<? x 64 x  i8>
    llvm.return %1 : !llvm.vec<? x 16 x  i8>
  }
  llvm.func @test_extract_insert_dif_idx(%arg0: !llvm.vec<? x 64 x  i8>, %arg1: !llvm.vec<? x 16 x  i8>) -> !llvm.vec<? x 16 x  i8> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[48] : !llvm.vec<? x 16 x  i8> into !llvm.vec<? x 64 x  i8>
    %1 = llvm.intr.vector.extract %0[0] : !llvm.vec<? x 16 x  i8> from !llvm.vec<? x 64 x  i8>
    llvm.return %1 : !llvm.vec<? x 16 x  i8>
  }
  llvm.func @neg_test_extract_insert_same_idx_dif_ret_size(%arg0: !llvm.vec<? x 64 x  i8>, %arg1: !llvm.vec<? x 16 x  i8>) -> !llvm.vec<? x 32 x  i8> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[32] : !llvm.vec<? x 16 x  i8> into !llvm.vec<? x 64 x  i8>
    %1 = llvm.intr.vector.extract %0[32] : !llvm.vec<? x 32 x  i8> from !llvm.vec<? x 64 x  i8>
    llvm.return %1 : !llvm.vec<? x 32 x  i8>
  }
}
