module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @without_range(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i32
    %3 = llvm.sdiv %2, %0  : i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @with_range(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i32
    %3 = llvm.sdiv %2, %0  : i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }
}
