module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f0(%arg0: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0x41EFFFFFFFE00000 : f64) : f64
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.uitofp %1 : i32 to f64
    %3 = llvm.fcmp "ogt" %2, %0 : f64
    llvm.return %3 : i1
  }
}
