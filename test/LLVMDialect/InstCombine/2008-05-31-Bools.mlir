module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
  llvm.func @foo2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
  llvm.func @foo3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
  llvm.func @foo4(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
}
