module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg1, %arg0 overflow<nsw>  : i32
    %1 = llvm.mul %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.mul %arg1, %arg1 overflow<nsw>  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @bar(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg1, %arg0  : i64
    %3 = llvm.xor %2, %0  : i64
    %4 = llvm.and %arg1, %3  : i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    llvm.return %5 : i1
  }
}
