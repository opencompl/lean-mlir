module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @vselect1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.bitcast %arg0 : i32 to vector<2xi16>
    %3 = llvm.bitcast %arg1 : i32 to vector<2xi16>
    %4 = llvm.bitcast %arg2 : i32 to vector<2xi16>
    %5 = llvm.icmp "sge" %4, %1 : vector<2xi16>
    %6 = llvm.select %5, %2, %3 : vector<2xi1>, vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to i32
    llvm.return %7 : i32
  }
}
