module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @and_consts(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %0, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %2, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @and_consts_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %0, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %2, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @and_consts_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %0, %arg0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.and %3, %arg0  : vector<2xi32>
    %7 = llvm.icmp "eq" %6, %2 : vector<2xi32>
    %8 = llvm.or %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @foo1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.shl %0, %arg1  : vector<2xi32>
    %4 = llvm.shl %0, %arg2  : vector<2xi32>
    %5 = llvm.and %3, %arg0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi32>
    %7 = llvm.and %4, %arg0  : vector<2xi32>
    %8 = llvm.icmp "eq" %7, %2 : vector<2xi32>
    %9 = llvm.or %6, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @foo1_and_commuted(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg0, %arg0  : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %2  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.or %6, %8  : i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_commuted_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mul %arg0, %arg0  : i32
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.shl %0, %arg2  : i32
    %6 = llvm.and %3, %4  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %5, %3  : i32
    %9 = llvm.icmp "eq" %8, %1 : i32
    %10 = llvm.select %7, %2, %9 : i1, i1
    llvm.return %10 : i1
  }
  llvm.func @foo1_and_commuted_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %4 = llvm.shl %0, %arg1  : vector<2xi32>
    %5 = llvm.shl %0, %arg2  : vector<2xi32>
    %6 = llvm.and %3, %4  : vector<2xi32>
    %7 = llvm.icmp "eq" %6, %2 : vector<2xi32>
    %8 = llvm.and %5, %3  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %2 : vector<2xi32>
    %10 = llvm.or %7, %9  : vector<2xi1>
    llvm.return %10 : vector<2xi1>
  }
  llvm.func @or_consts(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %0, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_consts_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %0, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %2, %arg0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @or_consts_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %0, %arg0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    %6 = llvm.and %3, %arg0  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %2 : vector<2xi32>
    %8 = llvm.and %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @foo1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_or_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "ne" %7, %1 : i32
    %9 = llvm.select %6, %8, %2 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_or_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.shl %0, %arg1  : vector<2xi32>
    %4 = llvm.shl %0, %arg2  : vector<2xi32>
    %5 = llvm.and %3, %arg0  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi32>
    %7 = llvm.and %4, %arg0  : vector<2xi32>
    %8 = llvm.icmp "ne" %7, %2 : vector<2xi32>
    %9 = llvm.and %6, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @foo1_or_commuted(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg0, %arg0  : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %2  : i32
    %8 = llvm.icmp "ne" %7, %1 : i32
    %9 = llvm.and %6, %8  : i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_or_commuted_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mul %arg0, %arg0  : i32
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.shl %0, %arg2  : i32
    %6 = llvm.and %3, %4  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.and %5, %3  : i32
    %9 = llvm.icmp "ne" %8, %1 : i32
    %10 = llvm.select %7, %9, %2 : i1, i1
    llvm.return %10 : i1
  }
  llvm.func @foo1_or_commuted_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %4 = llvm.shl %0, %arg1  : vector<2xi32>
    %5 = llvm.shl %0, %arg2  : vector<2xi32>
    %6 = llvm.and %3, %4  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %2 : vector<2xi32>
    %8 = llvm.and %5, %3  : vector<2xi32>
    %9 = llvm.icmp "ne" %8, %2 : vector<2xi32>
    %10 = llvm.and %7, %9  : vector<2xi1>
    llvm.return %10 : vector<2xi1>
  }
  llvm.func @foo1_and_signbit_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.lshr %1, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    %9 = llvm.or %6, %8  : i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_signbit_lshr_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.lshr %1, %arg2  : i32
    %6 = llvm.and %4, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.and %5, %arg0  : i32
    %9 = llvm.icmp "eq" %8, %2 : i32
    %10 = llvm.select %7, %3, %9 : i1, i1
    llvm.return %10 : i1
  }
  llvm.func @foo1_and_signbit_lshr_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg1  : vector<2xi32>
    %5 = llvm.lshr %1, %arg2  : vector<2xi32>
    %6 = llvm.and %4, %arg0  : vector<2xi32>
    %7 = llvm.icmp "eq" %6, %3 : vector<2xi32>
    %8 = llvm.and %5, %arg0  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %3 : vector<2xi32>
    %10 = llvm.or %7, %9  : vector<2xi1>
    llvm.return %10 : vector<2xi1>
  }
  llvm.func @foo1_or_signbit_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.lshr %1, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    %9 = llvm.and %6, %8  : i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_or_signbit_lshr_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.lshr %1, %arg2  : i32
    %6 = llvm.and %4, %arg0  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %arg0  : i32
    %9 = llvm.icmp "ne" %8, %2 : i32
    %10 = llvm.select %7, %9, %3 : i1, i1
    llvm.return %10 : i1
  }
  llvm.func @foo1_or_signbit_lshr_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg1  : vector<2xi32>
    %5 = llvm.lshr %1, %arg2  : vector<2xi32>
    %6 = llvm.and %4, %arg0  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %3 : vector<2xi32>
    %8 = llvm.and %5, %arg0  : vector<2xi32>
    %9 = llvm.icmp "ne" %8, %3 : vector<2xi32>
    %10 = llvm.and %7, %9  : vector<2xi1>
    llvm.return %10 : vector<2xi1>
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.shl %arg0, %arg2  : i32
    %6 = llvm.icmp "slt" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "slt" %6, %1 : i32
    %8 = llvm.select %5, %7, %2 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_both_sides(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.shl %arg0, %arg2  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_both_sides_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.shl %arg0, %arg2  : i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.select %3, %1, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_both_sides(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.shl %arg0, %arg2  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    %4 = llvm.shl %arg0, %arg2  : vector<2xi32>
    %5 = llvm.icmp "slt" %4, %1 : vector<2xi32>
    %6 = llvm.and %3, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_both_sides_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.shl %arg0, %arg2  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %3, %5, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @foo1_and_extra_use_shl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    llvm.store %2, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_extra_use_shl_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_extra_use_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_extra_use_and_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    llvm.store %5, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_extra_use_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.store %5, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_extra_use_cmp_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.store %6, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_extra_use_shl2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_extra_use_shl2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_extra_use_and2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    llvm.store %6, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_extra_use_and2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    llvm.store %7, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_extra_use_cmp2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.store %7, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_extra_use_cmp2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    llvm.store %8, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    llvm.store %5, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.store %5, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.store %6, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    llvm.store %6, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    llvm.store %7, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    llvm.store %7, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.store %8, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }
}
