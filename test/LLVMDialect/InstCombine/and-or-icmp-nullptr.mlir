module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @ugt_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_or_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_or_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_or_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_or_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_or_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_or_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ule_swap_or_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ule_swap_or_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_and_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_and_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_and_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_and_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_and_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_and_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_and_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_and_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @ugt_swap_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @ugt_swap_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sle" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sle_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sle" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sle_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_and_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_and_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @sgt_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @sgt_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @slt_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "slt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @slt_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.icmp "slt" %arg0, %arg1 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
}
