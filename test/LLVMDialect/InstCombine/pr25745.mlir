module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i1(i1)
  llvm.func @use.i64(i64)
  llvm.func @f(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.icmp "slt" %arg0, %0 : i32
    %5 = llvm.select %4, %1, %3 : i1, i64
    llvm.call @use.i1(%4) : (i1) -> ()
    llvm.call @use.i64(%1) : (i64) -> ()
    llvm.return %5 : i64
  }
}
