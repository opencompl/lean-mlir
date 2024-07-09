module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<7>, dense<[128, 128, 128, 32]> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.alloca_memory_space", 7 : ui64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_array_alloca_intptr_not_sizet(%arg0: i64, %arg1: !llvm.ptr) {
    %0 = llvm.alloca %arg0 x i8 {alignment = 1 : i64} : (i64) -> !llvm.ptr<7>
    llvm.store %0, %arg1 {alignment = 16 : i64} : !llvm.ptr<7>, !llvm.ptr
    llvm.return
  }
}
