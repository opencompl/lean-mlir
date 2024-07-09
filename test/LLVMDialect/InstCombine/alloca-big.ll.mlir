module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_bigalloc(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-4294967296 : i864) : i864
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i864) -> !llvm.ptr
    llvm.store %1, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
}
