module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @ctpop_x_and_negx(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sub %0, %arg0  : i16
    %2 = llvm.and %arg0, %1  : i16
    %3 = llvm.intr.ctpop(%2)  : (i16) -> i16
    llvm.return %3 : i16
  }
  llvm.func @ctpop_x_nz_and_negx(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.intr.ctpop(%4)  : (i8) -> i8
    llvm.return %5 : i8
  }
  llvm.func @ctpop_2_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @ctpop_2_shl_nz(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %0, %arg0  : i32
    %3 = llvm.shl %1, %2  : i32
    %4 = llvm.intr.ctpop(%3)  : (i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @ctpop_imin_plus1_lshr_nz(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.lshr %1, %arg0  : i8
    %4 = llvm.intr.ctpop(%3)  : (i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @ctpop_x_and_negx_nz(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %0, %arg0  : i64
    %2 = llvm.and %arg0, %1  : i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.intr.ctpop(%2)  : (i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @ctpop_shl2_1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0  : vector<2xi32>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @ctpop_lshr_intmin_intmin_plus1_vec_nz(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2147483648, -2147483647]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %1, %2  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ctpop_shl2_1_vec_nz(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.shl %1, %2  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @ctpop_x_and_negx_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %1, %arg0  : vector<2xi64>
    %3 = llvm.and %2, %arg0  : vector<2xi64>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @ctpop_x_and_negx_vec_nz(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.or %arg0, %0  : vector<2xi32>
    %4 = llvm.sub %2, %3  : vector<2xi32>
    %5 = llvm.and %4, %3  : vector<2xi32>
    %6 = llvm.intr.ctpop(%5)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
}
