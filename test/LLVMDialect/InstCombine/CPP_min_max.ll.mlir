module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @_Z5test1RiS_(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %4, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @_Z5test2RiS_(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %2, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.icmp "slt" %2, %3 : i32
    %5 = llvm.select %4, %arg1, %1 : i1, !llvm.ptr
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %6, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
