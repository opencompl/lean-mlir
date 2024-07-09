module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test() -> i1 {
    %0 = llvm.mlir.constant(4294967297 : i64) : i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    %4 = llvm.icmp "ule" %1, %3 : !llvm.ptr
    llvm.return %4 : i1
  }
}
