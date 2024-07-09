module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g1() {addr_space = 0 : i32} : i16
  llvm.mlir.global external @g2() {addr_space = 0 : i32} : i16
  llvm.func @use(i1)
  llvm.func @gen_i1() -> i1
  llvm.func @gen_v2i1() -> vector<2xi1>
  llvm.func @logical_and(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @logical_or(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @logical_and_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @logical_or_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @logical_and_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg0 : i1, i1
    llvm.return %0 : i1
  }
  llvm.func @logical_or_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.select %arg0, %arg0, %arg1 : i1, i1
    llvm.return %0 : i1
  }
  llvm.func @logical_and_not_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %arg0, %arg1, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @logical_or_not_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %arg0, %1, %arg1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @logical_or_implies(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @logical_or_implies_folds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logical_and_implies(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @logical_and_implies_folds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @logical_or_noundef_a(%arg0: i1 {llvm.noundef}, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @logical_or_noundef_b(%arg0: i1, %arg1: i1 {llvm.noundef}) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @logical_and_noundef_a(%arg0: i1 {llvm.noundef}, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @logical_and_noundef_b(%arg0: i1, %arg1: i1 {llvm.noundef}) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @not_not_true(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @not_not_false(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @not_true_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @not_false_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @not_not_true_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @not_not_false_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @not_true_not_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @not_false_not_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @not_not_true_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @not_not_false_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @not_true_not_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @not_false_not_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @not_not_true_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @not_not_false_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @not_true_not_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @not_false_not_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @demorgan_select_infloop1(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.addressof @g2 : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %4 = llvm.mlir.addressof @g1 : !llvm.ptr
    %5 = llvm.mlir.constant(false) : i1
    %6 = llvm.xor %arg0, %0  : i1
    %7 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %8 = llvm.add %7, %7  : i1
    %9 = llvm.xor %8, %0  : i1
    %10 = llvm.select %6, %9, %5 : i1, i1
    llvm.return %10 : i1
  }
  llvm.func @demorgan_select_infloop2(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %4 = llvm.mlir.addressof @g2 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %6 = llvm.mlir.constant(false) : i1
    %7 = llvm.xor %arg0, %0  : i1
    %8 = llvm.icmp "eq" %3, %2 : !llvm.ptr
    %9 = llvm.icmp "eq" %5, %2 : !llvm.ptr
    %10 = llvm.add %8, %9  : i1
    %11 = llvm.xor %10, %0  : i1
    %12 = llvm.select %7, %11, %6 : i1, i1
    llvm.return %12 : i1
  }
  llvm.func @and_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg2  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @and_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @and_or1_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %arg2, %1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @and_or2_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %arg1, %1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @and_or1_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg2  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @and_or2_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @and_or1_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %arg0, %1  : vector<2xi1>
    %4 = llvm.or %3, %2  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @and_or2_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    %4 = llvm.and %3, %arg1  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @and_or1_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %arg0, %1  : vector<2xi1>
    %4 = llvm.or %2, %3  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @and_or2_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    %4 = llvm.and %arg1, %3  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @and_or1_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg2  : i1
    %3 = llvm.select %2, %arg3, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @and_or2_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    %3 = llvm.select %2, %arg0, %arg3 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @and_or3(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.and %arg1, %0  : i1
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @and_or3_commuted(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.and %0, %arg1  : i1
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @and_or3_not_free_to_invert(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.and %arg1, %arg2  : i1
    %1 = llvm.select %0, %arg0, %arg1 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @and_or3_multiuse(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.and %arg1, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @and_or3_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "eq" %arg2, %arg3 : vector<2xi32>
    %1 = llvm.and %arg1, %0  : vector<2xi1>
    %2 = llvm.select %1, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @and_or3_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "eq" %arg2, %arg3 : vector<2xi32>
    %1 = llvm.and %0, %arg1  : vector<2xi1>
    %2 = llvm.select %1, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @and_or3_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32, %arg4: i1) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.and %arg1, %0  : i1
    %2 = llvm.select %1, %arg0, %arg4 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @or_and1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg2  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @or_and2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.or %1, %arg0  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @or_and1_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %arg2, %1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @or_and2_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.or %arg0, %1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @or_and1_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg2  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @or_and2_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @or_and1_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %arg1, %1  : vector<2xi1>
    %4 = llvm.and %2, %3  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @or_and2_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    %4 = llvm.or %arg0, %3  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @or_and1_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %arg1, %1  : vector<2xi1>
    %4 = llvm.and %3, %2  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @or_and2_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    %4 = llvm.or %3, %arg0  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @or_and1_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %arg2, %1  : i1
    %3 = llvm.select %2, %arg0, %arg3 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @or_and2_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.or %arg0, %1  : i1
    %3 = llvm.select %2, %arg3, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @pr64558(%arg0: i1 {llvm.noundef}, %arg1: i1 {llvm.noundef}) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg0  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @or_and3(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.or %arg0, %0  : i1
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @or_and3_commuted(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.or %0, %arg0  : i1
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @or_and3_not_free_to_invert(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.or %arg0, %arg2  : i1
    %1 = llvm.select %0, %arg0, %arg1 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @or_and3_multiuse(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.or %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @or_and3_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "eq" %arg2, %arg3 : vector<2xi32>
    %1 = llvm.or %arg0, %0  : vector<2xi1>
    %2 = llvm.select %1, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @or_and3_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "eq" %arg2, %arg3 : vector<2xi32>
    %1 = llvm.or %0, %arg0  : vector<2xi1>
    %2 = llvm.select %1, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @or_and3_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32, %arg4: i1) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.or %arg0, %0  : i1
    %2 = llvm.select %1, %arg4, %arg1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @test_or_umax(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_or_umin(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    %3 = llvm.select %2, %arg1, %arg0 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_and_umax(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %1, %0 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_and_umin(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %1, %0 : i1, i1
    %3 = llvm.select %2, %arg1, %arg0 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_or_umax_bitwise1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.or %1, %2  : i1
    %4 = llvm.select %3, %arg0, %arg1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @test_or_umax_bitwise2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.or %2, %1  : i1
    %4 = llvm.select %3, %arg0, %arg1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @test_and_umax_bitwise1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.and %1, %2  : i1
    %4 = llvm.select %3, %arg0, %arg1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @test_and_umax_bitwise2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.and %2, %1  : i1
    %4 = llvm.select %3, %arg0, %arg1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @test_or_smax(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_or_abs(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i8
    %5 = llvm.select %arg1, %2, %3 : i1, i1
    %6 = llvm.select %5, %arg0, %4 : i1, i8
    llvm.return %6 : i8
  }
  llvm.func @test_or_fmaxnum(%arg0: f32, %arg1: f32, %arg2: i1) -> f32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @test_or_umax_invalid_logical(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %1, %0, %arg2 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_and_umax_invalid_logical(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %1, %arg2, %0 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_or_umax_multiuse_cond(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_or_eq_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg1, %arg2 : i8
    %1 = llvm.or %arg0, %0  : i1
    %2 = llvm.select %1, %arg1, %arg2 : i1, i8
    llvm.return %2 : i8
  }
  llvm.func @test_and_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg1, %arg2 : i8
    %1 = llvm.and %arg0, %0  : i1
    %2 = llvm.select %1, %arg1, %arg2 : i1, i8
    llvm.return %2 : i8
  }
  llvm.func @test_or_eq_a_b_commuted(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg1, %arg2 : i8
    %1 = llvm.or %arg0, %0  : i1
    %2 = llvm.select %1, %arg2, %arg1 : i1, i8
    llvm.return %2 : i8
  }
  llvm.func @test_and_ne_a_b_commuted(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg1, %arg2 : i8
    %1 = llvm.and %arg0, %0  : i1
    %2 = llvm.select %1, %arg2, %arg1 : i1, i8
    llvm.return %2 : i8
  }
  llvm.func @test_or_eq_different_operands(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i8
    %1 = llvm.icmp "eq" %arg1, %arg0 : i8
    %2 = llvm.or %0, %1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_or_eq_a_b_multi_use(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg1, %arg2 : i8
    %1 = llvm.or %arg0, %0  : i1
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg1, %arg2 : i1, i8
    llvm.return %2 : i8
  }
  llvm.func @test_or_eq_a_b_vec(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.icmp "eq" %arg1, %arg2 : vector<2xi8>
    %1 = llvm.or %arg0, %0  : vector<2xi1>
    %2 = llvm.select %1, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @test_or_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg1, %arg2 : i8
    %1 = llvm.or %arg0, %0  : i1
    %2 = llvm.select %1, %arg1, %arg2 : i1, i8
    llvm.return %2 : i8
  }
  llvm.func @test_and_ne_different_operands_fail(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg0, %arg2 : i8
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.select %2, %arg1, %arg0 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_logical_or_eq_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_logical_commuted_or_eq_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_logical_and_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @test_logical_commuted_and_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }
}
