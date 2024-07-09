module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(!llvm.ptr)
  llvm.func @foo(%arg0: i64) {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(24 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i64
    %3 = llvm.add %2, %1 overflow<nsw>  : i64
    %4 = llvm.alloca %3 x i8 {alignment = 4 : i64} : (i64) -> !llvm.ptr
    llvm.call @use(%4) : (!llvm.ptr) -> ()
    llvm.return
  }
}
