module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use1(i1)
  llvm.func @use8(i8)
  llvm.func @f1()
  llvm.func @f2()
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @invert_icmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @invert_fcmp(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f32
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @not_not_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "slt" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @not_not_cmp_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "ugt" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @not_cmp_constant(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @not_cmp_constant_vector(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.xor %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @test7(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.icmp "sle" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @not_ashr_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.ashr %1, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @not_ashr_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_ashr_const_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %0, %arg0  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @not_lshr_const_negative(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_lshr_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_lshr_const_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %0, %arg0  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @not_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @not_sub_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @not_sub_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @not_sub_extra_use_splat(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @not_sub_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 123]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @not_sub_extra_use_vec(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[123, 42]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @not_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @not_add_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @not_add_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 123]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @not_select_cmp_cmp(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @not_select_cmp_cmp_extra_use1(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @not_select_cmp_cmp_extra_use2(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @not_select_cmp_cmp_extra_use3(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @not_select_cmp_cmp_extra_use4(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @not_select_cmpt(%arg0: f64, %arg1: f64, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.select %arg3, %1, %arg2 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }
  llvm.func @not_select_cmpf(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg1, %arg2 : i32
    %2 = llvm.select %arg3, %arg0, %1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }
  llvm.func @not_select_cmpt_extra_use(%arg0: f64, %arg1: f64, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.select %arg3, %1, %arg2 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }
  llvm.func @not_select_cmpf_extra_use(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg1, %arg2 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.select %arg3, %arg0, %1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }
  llvm.func @not_or_neg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @not_or_neg_commute_vec(%arg0: vector<3xi5>, %arg1: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(3 : i5) : i5
    %1 = llvm.mlir.constant(2 : i5) : i5
    %2 = llvm.mlir.constant(1 : i5) : i5
    %3 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.mlir.poison : i5
    %5 = llvm.mlir.constant(0 : i5) : i5
    %6 = llvm.mlir.undef : vector<3xi5>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<3xi5>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %5, %8[%9 : i32] : vector<3xi5>
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.insertelement %4, %10[%11 : i32] : vector<3xi5>
    %13 = llvm.mlir.constant(-1 : i5) : i5
    %14 = llvm.mlir.undef : vector<3xi5>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<3xi5>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %4, %16[%17 : i32] : vector<3xi5>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %13, %18[%19 : i32] : vector<3xi5>
    %21 = llvm.mul %arg1, %3  : vector<3xi5>
    %22 = llvm.sub %12, %arg0  : vector<3xi5>
    %23 = llvm.or %21, %22  : vector<3xi5>
    %24 = llvm.xor %23, %20  : vector<3xi5>
    llvm.return %24 : vector<3xi5>
  }
  llvm.func @not_or_neg_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @not_or_neg_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.or %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @not_select_bool(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @not_select_bool_const1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @not_select_bool_const2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @not_select_bool_const3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @not_select_bool_const4(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @not_logicalAnd_not_op0(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.select %4, %arg1, %3 : vector<2xi1>, vector<2xi1>
    %6 = llvm.xor %5, %1  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @not_logicalAnd_not_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @not_logicalAnd_not_op0_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @not_logicalAnd_not_op0_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @not_logicalOr_not_op0(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.select %2, %1, %arg1 : vector<2xi1>, vector<2xi1>
    %4 = llvm.xor %3, %1  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @not_logicalOr_not_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }
  llvm.func @not_logicalOr_not_op0_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }
  llvm.func @not_logicalOr_not_op0_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }
  llvm.func @bitcast_to_wide_elts_sext_bool(%arg0: vector<4xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<2xi64>
    %3 = llvm.xor %2, %0  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @bitcast_to_narrow_elts_sext_bool(%arg0: vector<4xi1>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<8xi16>
    %3 = llvm.xor %2, %0  : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }
  llvm.func @bitcast_to_vec_sext_bool(%arg0: i1) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.bitcast %1 : i32 to vector<2xi16>
    %3 = llvm.xor %2, %0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @bitcast_to_scalar_sext_bool(%arg0: vector<4xi1>) -> i128 {
    %0 = llvm.mlir.constant(-1 : i128) : i128
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to i128
    %3 = llvm.xor %2, %0  : i128
    llvm.return %3 : i128
  }
  llvm.func @bitcast_to_vec_sext_bool_use1(%arg0: i1) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sext %arg0 : i1 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.bitcast %2 : i8 to vector<2xi4>
    %4 = llvm.xor %3, %1  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @bitcast_to_scalar_sext_bool_use2(%arg0: vector<4xi1>) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi2>
    %2 = llvm.bitcast %1 : vector<4xi2> to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @invert_both_cmp_operands_add(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %arg1, %2  : i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @invert_both_cmp_operands_sub(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.sub %2, %arg1  : i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @invert_both_cmp_operands_complex(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.xor %arg3, %0  : i32
    %4 = llvm.add %arg3, %1  : i32
    %5 = llvm.select %arg0, %4, %2 : i1, i32
    %6 = llvm.icmp "sle" %5, %3 : i32
    llvm.return %6 : i1
  }
  llvm.func @test_sext(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.sext %2 : i1 to i32
    %4 = llvm.add %arg1, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }
  llvm.func @test_sext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi1> to vector<2xi32>
    %5 = llvm.add %arg1, %4  : vector<2xi32>
    %6 = llvm.xor %5, %2  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @test_zext_nneg(%arg0: i32, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i64) : i64
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.add %arg1, %1  : i64
    %5 = llvm.add %3, %arg2  : i64
    %6 = llvm.sub %4, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @test_trunc(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.add %3, %0 overflow<nsw>  : i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.xor %6, %2  : i8
    llvm.return %7 : i8
  }
  llvm.func @test_trunc_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %4 = llvm.add %3, %0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.ashr %4, %1  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi8>
    %7 = llvm.xor %6, %2  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }
  llvm.func @test_zext(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.add %arg1, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }
  llvm.func @test_invert_demorgan_or(%arg0: i32, %arg1: i32, %arg2: i1) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.or %2, %3  : i1
    %5 = llvm.xor %arg2, %1  : i1
    %6 = llvm.or %5, %4  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @f1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @f2() : () -> ()
    llvm.unreachable
  }
  llvm.func @test_invert_demorgan_or2(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant(23 : i64) : i64
    %1 = llvm.mlir.constant(59 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i64
    %4 = llvm.icmp "ugt" %arg1, %1 : i64
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.icmp "ugt" %arg2, %1 : i64
    %7 = llvm.or %5, %6  : i1
    %8 = llvm.xor %7, %2  : i1
    llvm.return %8 : i1
  }
  llvm.func @test_invert_demorgan_or3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(178206 : i32) : i32
    %1 = llvm.mlir.constant(-195102 : i32) : i32
    %2 = llvm.mlir.constant(1506 : i32) : i32
    %3 = llvm.mlir.constant(-201547 : i32) : i32
    %4 = llvm.mlir.constant(716213 : i32) : i32
    %5 = llvm.mlir.constant(-918000 : i32) : i32
    %6 = llvm.mlir.constant(196112 : i32) : i32
    %7 = llvm.mlir.constant(true) : i1
    %8 = llvm.icmp "eq" %arg0, %0 : i32
    %9 = llvm.add %arg1, %1  : i32
    %10 = llvm.icmp "ult" %9, %2 : i32
    %11 = llvm.add %arg1, %3  : i32
    %12 = llvm.icmp "ult" %11, %4 : i32
    %13 = llvm.add %arg1, %5  : i32
    %14 = llvm.icmp "ult" %13, %6 : i32
    %15 = llvm.or %8, %10  : i1
    %16 = llvm.or %15, %12  : i1
    %17 = llvm.or %16, %14  : i1
    %18 = llvm.xor %17, %7  : i1
    llvm.return %18 : i1
  }
  llvm.func @test_invert_demorgan_logical_or(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(27 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i64
    %4 = llvm.icmp "eq" %arg1, %1 : i64
    %5 = llvm.select %3, %2, %4 : i1, i1
    %6 = llvm.icmp "eq" %arg0, %1 : i64
    %7 = llvm.or %6, %5  : i1
    %8 = llvm.xor %7, %2  : i1
    llvm.return %8 : i1
  }
  llvm.func @test_invert_demorgan_and(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.xor %arg2, %1  : i1
    %6 = llvm.and %5, %4  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @f1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @f2() : () -> ()
    llvm.unreachable
  }
  llvm.func @test_invert_demorgan_and2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(9223372036854775807 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.add %arg0, %0  : i64
    %3 = llvm.and %2, %0  : i64
    %4 = llvm.xor %3, %1  : i64
    llvm.return %4 : i64
  }
  llvm.func @test_invert_demorgan_and3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(4095 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.add %arg1, %3  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @test_invert_demorgan_logical_and(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(27 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg0, %0 : i64
    %5 = llvm.icmp "eq" %arg1, %1 : i64
    %6 = llvm.select %4, %5, %2 : i1, i1
    %7 = llvm.icmp "eq" %arg0, %1 : i64
    %8 = llvm.or %7, %6  : i1
    %9 = llvm.xor %8, %3  : i1
    llvm.return %9 : i1
  }
  llvm.func @test_invert_demorgan_and_multiuse(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.xor %arg2, %1  : i1
    %6 = llvm.and %5, %4  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @f1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @f2() : () -> ()
    llvm.unreachable
  }
}
