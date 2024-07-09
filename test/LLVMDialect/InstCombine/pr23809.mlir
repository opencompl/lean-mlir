module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @icmp(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "sge" %1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : i32
  }
  llvm.func @fcmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg1  : f32
    %2 = llvm.fcmp "oge" %1, %0 : f32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : f32
  }
}
