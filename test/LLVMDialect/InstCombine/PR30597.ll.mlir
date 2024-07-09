module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @dot_ref_s(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64, llvm.noalias, llvm.nocapture, llvm.readonly}) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    %4 = llvm.icmp "eq" %3, %0 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @function(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64, llvm.noalias, llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
}
