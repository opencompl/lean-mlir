module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @slt_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_and_max_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "slt" %arg0, %arg1 : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %3 = llvm.and %2, %1  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @slt_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_and_min(%arg0: i9, %arg1: i9) -> i1 {
    %0 = llvm.mlir.constant(-256 : i9) : i9
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i9
    %2 = llvm.icmp "eq" %arg0, %0 : i9
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_and_min_logical(%arg0: i9, %arg1: i9) -> i1 {
    %0 = llvm.mlir.constant(-256 : i9) : i9
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i9
    %3 = llvm.icmp "eq" %arg0, %0 : i9
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ult" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ult" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_swap_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_swap_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_or_not_min(%arg0: i427, %arg1: i427) -> i1 {
    %0 = llvm.mlir.constant(0 : i427) : i427
    %1 = llvm.icmp "ule" %arg0, %arg1 : i427
    %2 = llvm.icmp "ne" %arg0, %0 : i427
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_or_not_min_logical(%arg0: i427, %arg1: i427) -> i1 {
    %0 = llvm.mlir.constant(0 : i427) : i427
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i427
    %3 = llvm.icmp "ne" %arg0, %0 : i427
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_swap_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_swap_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sge_swap_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sge_swap_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_swap_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_swap_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @uge_swap_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @uge_swap_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_swap_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_swap_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_swap_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_swap_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_swap_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_swap_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_swap_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_swap_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_swap_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_swap_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_swap_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_swap_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_swap_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_swap_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_swap_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_swap_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ult" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ult" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ult_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ult_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_swap_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_swap_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ult" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_or_not_min_commute(%arg0: i823, %arg1: i823) -> i1 {
    %0 = llvm.mlir.constant(0 : i823) : i823
    %1 = llvm.icmp "ult" %arg1, %arg0 : i823
    %2 = llvm.icmp "ne" %arg0, %0 : i823
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_or_not_min_commute_logical(%arg0: i823, %arg1: i823) -> i1 {
    %0 = llvm.mlir.constant(0 : i823) : i823
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i823
    %3 = llvm.icmp "ne" %arg0, %0 : i823
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
}
