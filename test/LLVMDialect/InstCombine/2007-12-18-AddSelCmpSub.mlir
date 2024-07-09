module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    %6 = llvm.add %5, %arg0  : i32
    %7 = llvm.add %6, %2  : i32
    llvm.return %7 : i32
  }
  llvm.func @bar(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.add %4, %arg0  : i32
    llvm.return %5 : i32
  }
}
