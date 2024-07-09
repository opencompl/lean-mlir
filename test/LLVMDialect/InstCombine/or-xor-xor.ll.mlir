module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i3(i1)
  llvm.func @use.i5(i5)
  llvm.func @use.i32(i5)
  llvm.func @or_xor_xor_normal_variant1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    %1 = llvm.xor %0, %arg0  : i1
    %2 = llvm.xor %0, %arg1  : i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @or_xor_xor_normal_variant2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.xor %0, %arg1  : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.or %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_xor_xor_normal_variant3(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.and %arg1, %arg0  : i16
    %1 = llvm.xor %arg1, %0  : i16
    %2 = llvm.xor %arg0, %0  : i16
    %3 = llvm.or %1, %2  : i16
    llvm.return %3 : i16
  }
  llvm.func @or_xor_xor_normal_variant4(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0  : i64
    %1 = llvm.xor %0, %arg1  : i64
    %2 = llvm.xor %0, %arg0  : i64
    %3 = llvm.or %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @or_xor_xor_normal_binops(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.xor %arg1, %arg2  : i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.xor %0, %2  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @or_xor_xor_normal_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.and %arg0, %arg1  : vector<3xi1>
    %1 = llvm.xor %0, %arg1  : vector<3xi1>
    %2 = llvm.xor %0, %arg0  : vector<3xi1>
    %3 = llvm.or %1, %2  : vector<3xi1>
    llvm.return %3 : vector<3xi1>
  }
  llvm.func @or_xor_xor_normal_multiple_uses_and(%arg0: i3, %arg1: i3) -> i3 {
    %0 = llvm.mlir.addressof @use.i3 : !llvm.ptr
    %1 = llvm.and %arg0, %arg1  : i3
    llvm.call %0(%1) : !llvm.ptr, (i3) -> ()
    %2 = llvm.xor %arg1, %1  : i3
    %3 = llvm.xor %arg0, %1  : i3
    %4 = llvm.or %2, %3  : i3
    llvm.return %4 : i3
  }
  llvm.func @or_xor_xor_negative_multiple_uses_xor1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.addressof @use.i32 : !llvm.ptr
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %arg1  : i32
    llvm.call %0(%2) : !llvm.ptr, (i32) -> ()
    %3 = llvm.xor %1, %arg0  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_xor_xor_negative_multiple_uses_xor2(%arg0: i5, %arg1: i5) -> i5 {
    %0 = llvm.and %arg0, %arg1  : i5
    %1 = llvm.xor %0, %arg1  : i5
    %2 = llvm.xor %0, %arg0  : i5
    llvm.call @use.i5(%2) : (i5) -> ()
    %3 = llvm.or %1, %2  : i5
    llvm.return %3 : i5
  }
}
