module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @match_unsigned(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(299 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.urem %arg0, %0  : i64
    %3 = llvm.udiv %arg0, %0  : i64
    %4 = llvm.urem %3, %1  : i64
    %5 = llvm.mul %4, %0  : i64
    %6 = llvm.add %2, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @match_unsigned_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<299> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<64> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.urem %arg0, %0  : vector<2xi64>
    %3 = llvm.udiv %arg0, %0  : vector<2xi64>
    %4 = llvm.urem %3, %1  : vector<2xi64>
    %5 = llvm.mul %4, %0  : vector<2xi64>
    %6 = llvm.add %2, %5  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
  llvm.func @match_andAsRem_lshrAsDiv_shlAsMul(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.urem %4, %2  : i64
    %6 = llvm.shl %5, %1  : i64
    %7 = llvm.add %3, %6  : i64
    llvm.return %7 : i64
  }
  llvm.func @match_signed(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(299 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.mlir.constant(19136 : i64) : i64
    %3 = llvm.mlir.constant(9 : i64) : i64
    %4 = llvm.srem %arg0, %0  : i64
    %5 = llvm.sdiv %arg0, %0  : i64
    %6 = llvm.srem %5, %1  : i64
    %7 = llvm.sdiv %arg0, %2  : i64
    %8 = llvm.srem %7, %3  : i64
    %9 = llvm.mul %6, %0  : i64
    %10 = llvm.add %4, %9  : i64
    %11 = llvm.mul %8, %2  : i64
    %12 = llvm.add %10, %11  : i64
    llvm.return %12 : i64
  }
  llvm.func @match_signed_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<299> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<64> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<19136> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<9> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.srem %arg0, %0  : vector<2xi64>
    %5 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %6 = llvm.srem %5, %1  : vector<2xi64>
    %7 = llvm.sdiv %arg0, %2  : vector<2xi64>
    %8 = llvm.srem %7, %3  : vector<2xi64>
    %9 = llvm.mul %6, %0  : vector<2xi64>
    %10 = llvm.add %4, %9  : vector<2xi64>
    %11 = llvm.mul %8, %2  : vector<2xi64>
    %12 = llvm.add %10, %11  : vector<2xi64>
    llvm.return %12 : vector<2xi64>
  }
  llvm.func @not_match_inconsistent_signs(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(299 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.urem %arg0, %0  : i64
    %3 = llvm.sdiv %arg0, %0  : i64
    %4 = llvm.urem %3, %1  : i64
    %5 = llvm.mul %4, %0  : i64
    %6 = llvm.add %2, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @not_match_inconsistent_values(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(299 : i64) : i64
    %1 = llvm.mlir.constant(29 : i64) : i64
    %2 = llvm.mlir.constant(64 : i64) : i64
    %3 = llvm.urem %arg0, %0  : i64
    %4 = llvm.udiv %arg0, %1  : i64
    %5 = llvm.urem %4, %2  : i64
    %6 = llvm.mul %5, %0  : i64
    %7 = llvm.add %3, %6  : i64
    llvm.return %7 : i64
  }
  llvm.func @not_match_overflow(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(299 : i32) : i32
    %1 = llvm.mlir.constant(147483647 : i32) : i32
    %2 = llvm.urem %arg0, %0  : i32
    %3 = llvm.udiv %arg0, %0  : i32
    %4 = llvm.urem %3, %1  : i32
    %5 = llvm.mul %4, %0  : i32
    %6 = llvm.add %2, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @fold_add_udiv_urem(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @fold_add_sdiv_srem(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.srem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @fold_add_udiv_urem_to_mul(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(21 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.udiv %arg0, %0  : i32
    %4 = llvm.mul %3, %1  : i32
    %5 = llvm.urem %arg0, %0  : i32
    %6 = llvm.mul %5, %2  : i32
    %7 = llvm.add %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @fold_add_udiv_urem_to_mul_multiuse(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(21 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.udiv %arg0, %0  : i32
    %4 = llvm.mul %3, %1  : i32
    %5 = llvm.urem %arg0, %0  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.mul %5, %2  : i32
    %7 = llvm.add %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @fold_add_udiv_urem_commuted(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.add %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @fold_add_udiv_urem_or_disjoint(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @fold_add_udiv_urem_without_noundef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @fold_add_udiv_urem_multiuse_mul(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @fold_add_udiv_srem(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.srem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @fold_add_udiv_urem_non_constant(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.udiv %arg0, %arg1  : i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.urem %arg0, %arg1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
}
