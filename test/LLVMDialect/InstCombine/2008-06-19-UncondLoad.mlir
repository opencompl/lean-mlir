module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @x(!llvm.ptr) -> i32
  llvm.func @b(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.call @x(%arg0) : (!llvm.ptr) -> i32
    %5 = llvm.icmp "ne" %3, %0 : i32
    %6 = llvm.select %5, %arg1, %arg0 : i1, !llvm.ptr
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %7 : i32
  }
}
