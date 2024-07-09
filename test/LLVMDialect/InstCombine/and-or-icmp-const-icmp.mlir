module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @eq_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ne_basic_equal_5(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    %4 = llvm.icmp "ule" %2, %arg1 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @eq_basic_equal_minus_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.icmp "ugt" %2, %arg1 : i8
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @ne_basic_equal_minus_7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-7 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    %4 = llvm.icmp "ule" %2, %arg1 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @eq_basic_unequal(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.icmp "ugt" %2, %arg1 : i8
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @ne_basic_unequal(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    %4 = llvm.icmp "ule" %2, %arg1 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @eq_multi_c1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %3 : i1
  }
  llvm.func @ne_multi_c2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }
  llvm.func @eq_vector(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi8>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @ne_vector_equal_5(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ule" %2, %arg1 : vector<2xi8>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @eq_vector_equal_minus_1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ugt" %2, %arg1 : vector<2xi8>
    %5 = llvm.or %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @ne_vector_equal_minus_7(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ule" %2, %arg1 : vector<2xi8>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @eq_vector_unequal1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ugt" %2, %arg1 : vector<2xi8>
    %5 = llvm.or %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @ne_vector_unequal2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ule" %2, %arg1 : vector<2xi8>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @eq_vector_poison_icmp(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.add %arg0, %0  : vector<2xi8>
    %9 = llvm.icmp "eq" %arg0, %7 : vector<2xi8>
    %10 = llvm.icmp "ugt" %8, %arg1 : vector<2xi8>
    %11 = llvm.or %9, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @eq_vector_poison_add(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.add %arg0, %6  : vector<2xi8>
    %9 = llvm.icmp "eq" %arg0, %7 : vector<2xi8>
    %10 = llvm.icmp "ugt" %8, %arg1 : vector<2xi8>
    %11 = llvm.or %9, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @eq_commuted(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(43 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.sdiv %0, %arg1  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @ne_commuted_equal_minus_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.sdiv %0, %arg1  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.icmp "ne" %arg0, %2 : i8
    %6 = llvm.icmp "uge" %3, %4 : i8
    %7 = llvm.and %5, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @use(i1)
}
