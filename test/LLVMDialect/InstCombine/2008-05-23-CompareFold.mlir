module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(3.40282347E+38 : f32) : f32
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %2 = llvm.sitofp %1 : i8 to f32
    %3 = llvm.fcmp "ugt" %2, %0 : f32
    llvm.return %3 : i1
  }
}
