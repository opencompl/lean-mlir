module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @d(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.func @f(%arg0: i8 {llvm.zeroext}) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @d : !llvm.ptr
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %5 = llvm.or %4, %2  : i32
    %6 = llvm.add %5, %3 overflow<nsw>  : i32
    %7 = llvm.icmp "ugt" %3, %6 : i32
    llvm.return %7 : i1
  }
}
