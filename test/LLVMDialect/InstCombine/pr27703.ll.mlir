module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @mem() {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.br ^bb1(%0 : !llvm.ptr)
  ^bb1(%1: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %3 = llvm.bitcast %2 : !llvm.ptr to !llvm.ptr
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.bitcast %4 : !llvm.ptr to !llvm.ptr
    llvm.br ^bb1(%5 : !llvm.ptr)
  }
}
