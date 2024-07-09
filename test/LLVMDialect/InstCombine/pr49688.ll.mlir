module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.ashr %1, %arg0  : i32
    %5 = llvm.icmp "sgt" %arg0, %4 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @f2(%arg0: i32 {llvm.signext}, %arg1: i32 {llvm.zeroext}) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.ashr %1, %arg1  : i32
    %5 = llvm.icmp "sgt" %arg0, %4 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }
}
