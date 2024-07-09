module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f1() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @f2() -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.inttoptr %0 : i16 to !llvm.ptr
    %2 = llvm.mlir.constant(2 : i16) : i16
    %3 = llvm.inttoptr %2 : i16 to !llvm.ptr
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    llvm.return %4 : i1
  }
}
