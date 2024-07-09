module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @main1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    %8 = llvm.select %7, %2, %0 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main1_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    %9 = llvm.select %8, %2, %0 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    %8 = llvm.select %7, %1, %0 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main2_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    %9 = llvm.select %8, %1, %0 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %1, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main3_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %8, %3 : i1, i1
    %10 = llvm.select %9, %1, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main3b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %1, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main3b_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    %9 = llvm.select %6, %8, %3 : i1, i1
    %10 = llvm.select %9, %1, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main3e_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @main3e_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "eq" %5, %0 : i32
    %7 = llvm.select %4, %6, %1 : i1, i1
    %8 = llvm.select %7, %0, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main3c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %1, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main3c_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %1 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    %10 = llvm.select %9, %1, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main3d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %1, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main3d_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    %10 = llvm.select %9, %1, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main3f_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.or %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @main3f_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "ne" %5, %0 : i32
    %7 = llvm.select %4, %1, %6 : i1, i1
    %8 = llvm.select %7, %0, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(48 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %arg0, %1  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main4_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<48> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %0 : vector<2xi32>
    %7 = llvm.and %arg0, %1  : vector<2xi32>
    %8 = llvm.icmp "eq" %7, %1 : vector<2xi32>
    %9 = llvm.and %6, %8  : vector<2xi1>
    %10 = llvm.select %9, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @main4_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(48 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %0 : i32
    %7 = llvm.and %arg0, %1  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %8, %2 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main4b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %arg0, %1  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main4b_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %0 : i32
    %7 = llvm.and %arg0, %1  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    %9 = llvm.select %6, %8, %3 : i1, i1
    %10 = llvm.select %9, %2, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main4e_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %arg1 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "eq" %4, %arg2 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @main4e_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "eq" %3, %arg1 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "eq" %5, %arg2 : i32
    %7 = llvm.select %4, %6, %0 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main4c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(48 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.and %arg0, %1  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main4c_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(48 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %0 : i32
    %7 = llvm.and %arg0, %1  : i32
    %8 = llvm.icmp "ne" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main4d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.and %arg0, %1  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main4d_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %0 : i32
    %7 = llvm.and %arg0, %1  : i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    %10 = llvm.select %9, %2, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main4f_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "ne" %2, %arg1 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "ne" %4, %arg2 : i32
    %6 = llvm.or %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @main4f_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "ne" %3, %arg1 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "ne" %5, %arg2 : i32
    %7 = llvm.select %4, %0, %6 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main5_like(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.and %arg1, %0  : i32
    %6 = llvm.icmp "eq" %5, %0 : i32
    %7 = llvm.and %4, %6  : i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main5_like_logical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %arg1, %0  : i32
    %7 = llvm.icmp "eq" %6, %0 : i32
    %8 = llvm.select %5, %7, %1 : i1, i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main5e_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "eq" %4, %arg0 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @main5e_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "eq" %3, %arg0 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "eq" %5, %arg0 : i32
    %7 = llvm.select %4, %6, %0 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main5c_like(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.and %arg1, %0  : i32
    %6 = llvm.icmp "ne" %5, %0 : i32
    %7 = llvm.or %4, %6  : i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main5c_like_logical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.and %arg1, %0  : i32
    %7 = llvm.icmp "ne" %6, %0 : i32
    %8 = llvm.select %5, %1, %7 : i1, i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main5f_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "ne" %2, %arg0 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "ne" %4, %arg0 : i32
    %6 = llvm.or %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @main5f_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "ne" %3, %arg0 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "ne" %5, %arg0 : i32
    %7 = llvm.select %4, %0, %6 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %arg0, %2  : i32
    %9 = llvm.icmp "eq" %8, %3 : i32
    %10 = llvm.and %7, %9  : i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }
  llvm.func @main6_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.and %arg0, %0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.and %arg0, %2  : i32
    %10 = llvm.icmp "eq" %9, %3 : i32
    %11 = llvm.select %8, %10, %4 : i1, i1
    %12 = llvm.select %11, %5, %6 : i1, i32
    llvm.return %12 : i32
  }
  llvm.func @main6b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.and %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main6b_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %arg0, %2  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    %10 = llvm.select %7, %9, %4 : i1, i1
    %11 = llvm.select %10, %3, %5 : i1, i32
    llvm.return %11 : i32
  }
  llvm.func @main6c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.and %arg0, %2  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    %10 = llvm.or %7, %9  : i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }
  llvm.func @main6c_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.and %arg0, %0  : i32
    %8 = llvm.icmp "ne" %7, %1 : i32
    %9 = llvm.and %arg0, %2  : i32
    %10 = llvm.icmp "ne" %9, %3 : i32
    %11 = llvm.select %8, %4, %10 : i1, i1
    %12 = llvm.select %11, %5, %6 : i1, i32
    llvm.return %12 : i32
  }
  llvm.func @main6d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.or %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main6d_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.and %arg0, %2  : i32
    %9 = llvm.icmp "eq" %8, %3 : i32
    %10 = llvm.select %7, %4, %9 : i1, i1
    %11 = llvm.select %10, %3, %5 : i1, i32
    llvm.return %11 : i32
  }
  llvm.func @main7a(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %arg1 : i32
    %4 = llvm.and %arg2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %arg2 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @main7a_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %arg1 : i32
    %5 = llvm.and %arg2, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %arg2 : i32
    %7 = llvm.select %4, %6, %0 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main7b(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %arg1, %2 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "eq" %arg2, %4 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @main7b_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "eq" %arg1, %3 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "eq" %arg2, %5 : i32
    %7 = llvm.select %4, %6, %0 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main7c(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.icmp "eq" %arg1, %2 : i32
    %4 = llvm.and %arg2, %arg0  : i32
    %5 = llvm.icmp "eq" %arg2, %4 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @main7c_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.icmp "eq" %arg1, %3 : i32
    %5 = llvm.and %arg2, %arg0  : i32
    %6 = llvm.icmp "eq" %arg2, %5 : i32
    %7 = llvm.select %4, %6, %0 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @main7d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg3  : i32
    %3 = llvm.and %arg2, %arg4  : i32
    %4 = llvm.and %arg0, %2  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.and %arg0, %3  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %0, %1 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main7d_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg3  : i32
    %4 = llvm.and %arg2, %arg4  : i32
    %5 = llvm.and %arg0, %3  : i32
    %6 = llvm.icmp "eq" %5, %3 : i32
    %7 = llvm.and %arg0, %4  : i32
    %8 = llvm.icmp "eq" %7, %4 : i32
    %9 = llvm.select %6, %8, %0 : i1, i1
    %10 = llvm.select %9, %1, %2 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main7e(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg3  : i32
    %3 = llvm.and %arg2, %arg4  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %0, %1 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main7e_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg3  : i32
    %4 = llvm.and %arg2, %arg4  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %3 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %4 : i32
    %9 = llvm.select %6, %8, %0 : i1, i1
    %10 = llvm.select %9, %1, %2 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main7f(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg3  : i32
    %3 = llvm.and %arg2, %arg4  : i32
    %4 = llvm.and %arg0, %2  : i32
    %5 = llvm.icmp "eq" %2, %4 : i32
    %6 = llvm.and %arg0, %3  : i32
    %7 = llvm.icmp "eq" %3, %6 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %0, %1 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main7f_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg3  : i32
    %4 = llvm.and %arg2, %arg4  : i32
    %5 = llvm.and %arg0, %3  : i32
    %6 = llvm.icmp "eq" %3, %5 : i32
    %7 = llvm.and %arg0, %4  : i32
    %8 = llvm.icmp "eq" %4, %7 : i32
    %9 = llvm.select %6, %8, %0 : i1, i1
    %10 = llvm.select %9, %1, %2 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main7g(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg3  : i32
    %3 = llvm.and %arg2, %arg4  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %2, %4 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %3, %6 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %0, %1 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main7g_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg3  : i32
    %4 = llvm.and %arg2, %arg4  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %3, %5 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %4, %7 : i32
    %9 = llvm.select %6, %8, %0 : i1, i1
    %10 = llvm.select %9, %1, %2 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "slt" %7, %2 : i8
    %9 = llvm.or %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main8_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "slt" %8, %2 : i8
    %10 = llvm.select %7, %3, %9 : i1, i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }
  llvm.func @main9(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "slt" %7, %2 : i8
    %9 = llvm.and %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main9_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "slt" %8, %2 : i8
    %10 = llvm.select %7, %9, %3 : i1, i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }
  llvm.func @main10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "sge" %7, %2 : i8
    %9 = llvm.and %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main10_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "sge" %8, %2 : i8
    %10 = llvm.select %7, %9, %3 : i1, i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }
  llvm.func @main11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "sge" %7, %2 : i8
    %9 = llvm.or %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main11_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "sge" %8, %2 : i8
    %10 = llvm.select %7, %3, %9 : i1, i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }
  llvm.func @main12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.trunc %arg0 : i32 to i16
    %5 = llvm.icmp "slt" %4, %0 : i16
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.icmp "slt" %6, %1 : i8
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main12_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.icmp "slt" %5, %0 : i16
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "slt" %7, %1 : i8
    %9 = llvm.select %6, %2, %8 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.trunc %arg0 : i32 to i16
    %5 = llvm.icmp "slt" %4, %0 : i16
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.icmp "slt" %6, %1 : i8
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main13_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.icmp "slt" %5, %0 : i16
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "slt" %7, %1 : i8
    %9 = llvm.select %6, %8, %2 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.trunc %arg0 : i32 to i16
    %5 = llvm.icmp "sge" %4, %0 : i16
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.icmp "sge" %6, %1 : i8
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main14_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.icmp "sge" %5, %0 : i16
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "sge" %7, %1 : i8
    %9 = llvm.select %6, %8, %2 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @main15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.trunc %arg0 : i32 to i16
    %5 = llvm.icmp "sge" %4, %0 : i16
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.icmp "sge" %6, %1 : i8
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @main15_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.icmp "sge" %5, %0 : i16
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "sge" %7, %1 : i8
    %9 = llvm.select %6, %2, %8 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }
}
