module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @A() {addr_space = 0 : i32} : i32
  llvm.func @ossfuzz_14169_test1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @A : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i712) : i712
    %3 = llvm.mlir.constant(1 : i712) : i712
    %4 = llvm.mlir.constant(146783911423364576743092537299333564210980159306769991919205685720763064069663027716481187399048043939495936 : i712) : i712
    %5 = llvm.mlir.undef : !llvm.ptr
    %6 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %7 = llvm.icmp "sge" %6, %1 : i64
    %8 = llvm.select %7, %2, %3 : i1, i712
    %9 = llvm.lshr %8, %4  : i712
    %10 = llvm.getelementptr %5[%9] : (!llvm.ptr, i712) -> !llvm.ptr, i64
    llvm.store %10, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @ossfuzz_14169_test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @A : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i712) : i712
    %3 = llvm.mlir.constant(1 : i712) : i712
    %4 = llvm.mlir.constant(146783911423364576743092537299333564210980159306769991919205685720763064069663027716481187399048043939495936 : i712) : i712
    %5 = llvm.mlir.undef : !llvm.ptr
    %6 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %7 = llvm.icmp "sge" %6, %1 : i64
    %8 = llvm.select %7, %2, %3 : i1, i712
    %9 = llvm.shl %8, %4  : i712
    %10 = llvm.getelementptr %5[%9] : (!llvm.ptr, i712) -> !llvm.ptr, i64
    llvm.store %10, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
}
