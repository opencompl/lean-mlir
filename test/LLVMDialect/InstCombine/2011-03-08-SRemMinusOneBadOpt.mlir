module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: i64) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967294 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.srem %3, %1  : i32
    llvm.return %4 : i32
  }
}
