module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f32
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.zext %3 : i8 to i32
    llvm.return %4 : i32
  }
}
