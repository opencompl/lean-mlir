module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @passthru(%arg0: i16 {llvm.returned}) -> i16 {
    llvm.return %arg0 : i16
  }
  llvm.func @test(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.call @passthru(%0) : (i16) -> i16
    %2 = llvm.sub %arg0, %1 overflow<nsw, nuw>  : i16
    %3 = llvm.icmp "slt" %2, %0 : i16
    %4 = llvm.select %3, %0, %2 : i1, i16
    llvm.return %4 : i16
  }
}
