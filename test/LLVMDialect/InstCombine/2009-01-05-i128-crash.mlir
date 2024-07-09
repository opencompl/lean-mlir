module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func hidden @"\01_gfortrani_max_value"(%arg0: i32, %arg1: i32) -> i128 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(18446744073709551615 : i128) : i128
    %2 = llvm.mlir.constant(9223372036854775807 : i128) : i128
    %3 = llvm.mlir.constant(0 : i128) : i128
    llvm.switch %arg0 : i32, ^bb3 [
      1: ^bb4,
      4: ^bb2,
      8: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    %4 = llvm.icmp "eq" %arg1, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i128
    llvm.return %5 : i128
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i128
  ^bb3:  // pred: ^bb0
    llvm.return %3 : i128
  ^bb4:  // pred: ^bb0
    llvm.return %3 : i128
  }
}
