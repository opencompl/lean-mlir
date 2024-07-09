module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @add_byval_callee(!llvm.ptr)
  llvm.func @add_byval_callee_2(!llvm.ptr {llvm.byval = f64})
  llvm.func @add_byval(%arg0: !llvm.ptr) {
    llvm.call @add_byval_callee(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @add_byval_2(%arg0: !llvm.ptr) {
    llvm.call @add_byval_callee_2(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @vararg_byval(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i8
    llvm.call @vararg_callee(%0, %arg0) vararg(!llvm.func<void (i8, ...)>) : (i8, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @vararg_callee(i8, ...)
}
