module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_shift_nonnegative(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.icmp "sge" %4, %2 : i32
    llvm.return %5 : i1
  }
  llvm.func @test_shift_negative(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.shl %3, %4 overflow<nsw>  : i32
    %6 = llvm.icmp "slt" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @test_no_sign_bit_conflict1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(8193 : i32) : i32
    %1 = llvm.mlir.constant(8192 : i32) : i32
    %2 = llvm.mlir.constant(18 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.shl %3, %2 overflow<nsw>  : i32
    llvm.return %4 : i32
  }
  llvm.func @test_no_sign_bit_conflict2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-8193 : i32) : i32
    %1 = llvm.mlir.constant(-8194 : i32) : i32
    %2 = llvm.mlir.constant(18 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.shl %3, %2 overflow<nsw>  : i32
    llvm.return %4 : i32
  }
}
