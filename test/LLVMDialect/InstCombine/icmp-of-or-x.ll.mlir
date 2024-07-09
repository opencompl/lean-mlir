module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @barrier()
  llvm.func @use.v2i8(vector<2xi8>)
  llvm.func @use.i8(i8)
  llvm.func @or_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "ugt" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @or_ule(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "ule" %0, %arg0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @or_slt_pos(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg2  : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.or %1, %2  : vector<2xi8>
    %4 = llvm.icmp "slt" %1, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @or_sle_pos(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.or %arg0, %arg1  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @or_sle_fail_maybe_neg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "sle" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @or_eq_noundef(%arg0: i8, %arg1: i8 {llvm.noundef}) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @or_eq_notY_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %arg0, %1  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @or_eq_notY_eq_0_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @or_ne_notY_eq_1s(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %arg0, %1  : i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @or_ne_notY_eq_1s_fail_bad_not(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %arg0, %1  : i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @or_ne_vecC(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[9, 42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @or_eq_fail_maybe_undef(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @or_ne_noundef(%arg0: vector<2xi8>, %arg1: vector<2xi8> {llvm.noundef}) -> vector<2xi1> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "ne" %0, %arg0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @or_ne_noundef_fail_reuse(%arg0: vector<2xi8>, %arg1: vector<2xi8> {llvm.noundef}) -> vector<2xi1> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "ne" %0, %arg0 : vector<2xi8>
    llvm.call @use.v2i8(%0) : (vector<2xi8>) -> ()
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @or_slt_intmin(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "slt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @or_slt_intmin_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg1  : vector<2xi8>
    %2 = llvm.or %1, %0  : vector<2xi8>
    %3 = llvm.icmp "slt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @or_sle_intmin_indirect_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg2  : i8
    %3 = llvm.sub %0, %arg1  : i8
    %4 = llvm.and %arg1, %3  : i8
    %5 = llvm.icmp "slt" %4, %0 : i8
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.or %2, %4  : i8
    %7 = llvm.icmp "sle" %2, %6 : i8
    llvm.return %7 : i1
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %1 : i1
  }
  llvm.func @or_sge_intmin(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "sge" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @or_sgt_intmin_indirect(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.and %arg1, %2  : i8
    %4 = llvm.icmp "sge" %3, %0 : i8
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.or %arg0, %3  : i8
    %6 = llvm.icmp "sgt" %5, %arg0 : i8
    llvm.return %6 : i1
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %1 : i1
  }
  llvm.func @or_sgt_intmin_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg1  : vector<2xi8>
    %2 = llvm.or %1, %0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @or_simplify_ule(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "ule" %4, %3 : i8
    llvm.return %5 : i1
  }
  llvm.func @or_simplify_uge(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "uge" %3, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @or_simplify_ule_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "ule" %4, %3 : i8
    llvm.return %5 : i1
  }
  llvm.func @or_simplify_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "ugt" %4, %3 : i8
    llvm.return %5 : i1
  }
  llvm.func @or_simplify_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(36 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "ult" %3, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @or_simplify_ugt_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "ugt" %4, %3 : i8
    llvm.return %5 : i1
  }
  llvm.func @pr64610(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(74 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i1
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.or %4, %2  : i32
    %6 = llvm.icmp "ugt" %5, %4 : i32
    llvm.return %6 : i1
  }
  llvm.func @icmp_eq_x_invertable_y2_todo(%arg0: i8, %arg1: i1, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.or %arg0, %3  : i8
    %5 = llvm.icmp "eq" %3, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @icmp_eq_x_invertable_y2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %arg0, %1  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @PR38139(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "ne" %1, %arg0 : i8
    llvm.return %2 : i1
  }
}
