module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use16(i16)
  llvm.func @usev4(vector<4xi4>)
  llvm.func @icmp_shl_ugt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.icmp "ugt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @icmp_shl_ugt_2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.shl %2, %1  : vector<2xi32>
    %4 = llvm.icmp "ugt" %2, %3 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @icmp_shl_uge_1(%arg0: vector<3xi7>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i7) : i7
    %1 = llvm.mlir.constant(dense<1> : vector<3xi7>) : vector<3xi7>
    %2 = llvm.shl %arg0, %1  : vector<3xi7>
    %3 = llvm.icmp "uge" %2, %arg0 : vector<3xi7>
    llvm.return %3 : vector<3xi1>
  }
  llvm.func @icmp_shl_uge_2(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(10 : i5) : i5
    %1 = llvm.mlir.constant(1 : i5) : i5
    %2 = llvm.add %0, %arg0  : i5
    %3 = llvm.shl %2, %1  : i5
    %4 = llvm.icmp "uge" %2, %3 : i5
    llvm.return %4 : i1
  }
  llvm.func @icmp_shl_ult_1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    llvm.call @use16(%1) : (i16) -> ()
    %2 = llvm.icmp "ult" %1, %arg0 : i16
    llvm.return %2 : i1
  }
  llvm.func @icmp_shl_ult_2(%arg0: vector<4xi4>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.mlir.constant(dense<-6> : vector<4xi4>) : vector<4xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<4xi4>) : vector<4xi4>
    %4 = llvm.add %1, %arg0  : vector<4xi4>
    %5 = llvm.shl %4, %3  : vector<4xi4>
    llvm.call @usev4(%5) : (vector<4xi4>) -> ()
    %6 = llvm.icmp "ult" %4, %5 : vector<4xi4>
    llvm.return %6 : vector<4xi1>
  }
  llvm.func @icmp_shl_ule_1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.shl %arg0, %6  : vector<2xi8>
    %8 = llvm.icmp "ule" %7, %arg0 : vector<2xi8>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @icmp_shl_ule_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.icmp "ule" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @icmp_shl_eq_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @icmp_shl_eq_2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sdiv %0, %arg0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    %4 = llvm.icmp "eq" %2, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @icmp_shl_ne_1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "ne" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @icmp_shl_ne_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sdiv %0, %arg0  : i8
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @negative_test_signed_pred(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.icmp "slt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @negative_test_shl_more_than_1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    %2 = llvm.icmp "ult" %1, %arg0 : i16
    llvm.return %2 : i1
  }
  llvm.func @negative_test_compare_with_different_value(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    %2 = llvm.icmp "ult" %1, %arg1 : i16
    llvm.return %2 : i1
  }
}
