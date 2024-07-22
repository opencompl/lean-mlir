module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @udiv400(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.udiv %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @udiv400_no(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.udiv %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @sdiv400_yes(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.sdiv %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @udiv_i80(%arg0: i80) -> i80 {
    %0 = llvm.mlir.constant(2 : i80) : i80
    %1 = llvm.mlir.constant(100 : i80) : i80
    %2 = llvm.lshr %arg0, %0  : i80
    %3 = llvm.udiv %2, %1  : i80
    llvm.return %3 : i80
  }
  llvm.func @no_crash_notconst_udiv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    %2 = llvm.udiv %1, %0  : i32
    llvm.return %2 : i32
  }
}
