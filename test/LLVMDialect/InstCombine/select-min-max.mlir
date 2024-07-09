module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @smin_smin_common_op_00(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.intr.smin(%arg3, %arg1)  : (i5, i5) -> i5
    %1 = llvm.intr.smin(%arg3, %arg2)  : (i5, i5) -> i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @smax_smax_common_op_01(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smax(%arg3, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.intr.smax(%arg2, %arg3)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @umin_umin_common_op_10(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5, %arg4: !llvm.ptr) -> i5 {
    %0 = llvm.intr.umin(%arg1, %arg3)  : (i5, i5) -> i5
    llvm.store %0, %arg4 {alignment = 1 : i64} : i5, !llvm.ptr
    %1 = llvm.intr.umin(%arg3, %arg2)  : (i5, i5) -> i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @umax_umax_common_op_11(%arg0: i1, %arg1: vector<3xi5>, %arg2: vector<3xi5>, %arg3: vector<3xi5>, %arg4: !llvm.ptr) -> vector<3xi5> {
    %0 = llvm.intr.umax(%arg1, %arg3)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    %1 = llvm.intr.umax(%arg2, %arg3)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    llvm.store %1, %arg4 {alignment = 2 : i64} : vector<3xi5>, !llvm.ptr
    %2 = llvm.select %arg0, %0, %1 : i1, vector<3xi5>
    llvm.return %2 : vector<3xi5>
  }
  llvm.func @smin_umin_common_op_11(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.intr.smin(%arg1, %arg3)  : (i5, i5) -> i5
    %1 = llvm.intr.umin(%arg2, %arg3)  : (i5, i5) -> i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @smin_smin_no_common_op(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5, %arg4: i5) -> i5 {
    %0 = llvm.intr.smin(%arg3, %arg1)  : (i5, i5) -> i5
    %1 = llvm.intr.smin(%arg4, %arg2)  : (i5, i5) -> i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @umin_umin_common_op_10_uses(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5, %arg4: !llvm.ptr, %arg5: !llvm.ptr) -> i5 {
    %0 = llvm.intr.umin(%arg1, %arg3)  : (i5, i5) -> i5
    llvm.store %0, %arg4 {alignment = 1 : i64} : i5, !llvm.ptr
    %1 = llvm.intr.umin(%arg3, %arg2)  : (i5, i5) -> i5
    llvm.store %1, %arg5 {alignment = 1 : i64} : i5, !llvm.ptr
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @smin_select_const_const(%arg0: i1) -> i5 {
    %0 = llvm.mlir.constant(-3 : i5) : i5
    %1 = llvm.mlir.constant(8 : i5) : i5
    %2 = llvm.mlir.constant(5 : i5) : i5
    %3 = llvm.select %arg0, %0, %1 : i1, i5
    %4 = llvm.intr.smin(%3, %2)  : (i5, i5) -> i5
    llvm.return %4 : i5
  }
  llvm.func @smax_select_const_const(%arg0: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 43]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[0, 42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi8>
    %4 = llvm.intr.smax(%3, %2)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @umin_select_const_const(%arg0: i1) -> i5 {
    %0 = llvm.mlir.constant(8 : i5) : i5
    %1 = llvm.mlir.constant(3 : i5) : i5
    %2 = llvm.mlir.constant(4 : i5) : i5
    %3 = llvm.select %arg0, %0, %1 : i1, i5
    %4 = llvm.intr.umin(%2, %3)  : (i5, i5) -> i5
    llvm.return %4 : i5
  }
  llvm.func @umax_select_const_const(%arg0: vector<3xi1>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = llvm.mlir.constant(3 : i5) : i5
    %2 = llvm.mlir.constant(2 : i5) : i5
    %3 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.mlir.constant(9 : i5) : i5
    %5 = llvm.mlir.constant(8 : i5) : i5
    %6 = llvm.mlir.constant(7 : i5) : i5
    %7 = llvm.mlir.constant(dense<[7, 8, 9]> : vector<3xi5>) : vector<3xi5>
    %8 = llvm.mlir.constant(-16 : i5) : i5
    %9 = llvm.mlir.constant(5 : i5) : i5
    %10 = llvm.mlir.constant(dense<[5, 8, -16]> : vector<3xi5>) : vector<3xi5>
    %11 = llvm.select %arg0, %3, %7 : vector<3xi1>, vector<3xi5>
    %12 = llvm.intr.umax(%10, %11)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    llvm.return %12 : vector<3xi5>
  }
  llvm.func @smin_select_const(%arg0: i1, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(-3 : i5) : i5
    %1 = llvm.mlir.constant(5 : i5) : i5
    %2 = llvm.select %arg0, %0, %arg1 : i1, i5
    %3 = llvm.intr.smin(%2, %1)  : (i5, i5) -> i5
    llvm.return %3 : i5
  }
  llvm.func @smax_select_const(%arg0: vector<2xi1>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 43]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[0, 42]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.select %arg0, %arg1, %0 : vector<2xi1>, vector<2xi8>
    %3 = llvm.intr.smax(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @umin_select_const(%arg0: i1, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(3 : i5) : i5
    %1 = llvm.mlir.constant(4 : i5) : i5
    %2 = llvm.select %arg0, %arg1, %0 : i1, i5
    %3 = llvm.intr.umin(%1, %2)  : (i5, i5) -> i5
    llvm.return %3 : i5
  }
  llvm.func @umax_select_const(%arg0: vector<3xi1>, %arg1: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = llvm.mlir.constant(3 : i5) : i5
    %2 = llvm.mlir.constant(2 : i5) : i5
    %3 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.mlir.constant(1 : i5) : i5
    %5 = llvm.mlir.constant(8 : i5) : i5
    %6 = llvm.mlir.constant(5 : i5) : i5
    %7 = llvm.mlir.constant(dense<[5, 8, 1]> : vector<3xi5>) : vector<3xi5>
    %8 = llvm.select %arg0, %3, %arg1 : vector<3xi1>, vector<3xi5>
    %9 = llvm.intr.umax(%7, %8)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    llvm.return %9 : vector<3xi5>
  }
  llvm.func @smax_smin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @smin_smax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @umax_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "ult" %arg0, %1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @umin_umax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @not_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %0, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @not_smax_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %2, %0 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @not_smin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %0, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @not_smin_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %2, %0 : i1, i8
    llvm.return %3 : i8
  }
}
