module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @a_true_implies_b_true(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i8
    %4 = llvm.icmp "ugt" %arg0, %1 : i8
    %5 = llvm.select %4, %arg1, %arg2 : i1, i1
    %6 = llvm.select %3, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @a_true_implies_b_true_vec(%arg0: i8, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<[20, 19]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(10 : i8) : i8
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.insertelement %arg0, %0[%1 : i8] : vector<2xi8>
    %7 = llvm.shufflevector %6, %0 [0, 0] : vector<2xi8> 
    %8 = llvm.icmp "ugt" %7, %2 : vector<2xi8>
    %9 = llvm.icmp "ugt" %arg0, %3 : i8
    %10 = llvm.select %9, %arg1, %arg2 : i1, vector<2xi1>
    %11 = llvm.select %8, %10, %5 : vector<2xi1>, vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @a_true_implies_b_true2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @a_true_implies_b_true2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @a_true_implies_b_false(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i8
    %4 = llvm.icmp "ult" %arg0, %1 : i8
    %5 = llvm.select %4, %arg1, %arg2 : i1, i1
    %6 = llvm.select %3, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @a_true_implies_b_false2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @a_true_implies_b_false2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @a_false_implies_b_true(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i8
    %4 = llvm.icmp "ult" %arg0, %1 : i8
    %5 = llvm.select %4, %arg1, %arg2 : i1, i1
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @a_false_implies_b_true2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ult" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @a_false_implies_b_true2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ult" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.or %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @a_false_implies_b_false(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i8
    %4 = llvm.icmp "ugt" %arg0, %1 : i8
    %5 = llvm.select %4, %arg1, %arg2 : i1, i1
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @a_false_implies_b_false2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @a_false_implies_b_false2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.or %4, %2  : i1
    llvm.return %5 : i1
  }
}
