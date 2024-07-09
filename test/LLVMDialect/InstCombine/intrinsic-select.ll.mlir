module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @g1(dense<0> : vector<2xi32>) {addr_space = 0 : i32} : vector<2xi32>
  llvm.mlir.global external @g2() {addr_space = 0 : i32} : i8
  llvm.func @use(i32)
  llvm.func @ctlz_sel_const_true_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @ctlz_sel_const_true(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @ctlz_sel_const_false(%arg0: vector<3xi1>, %arg1: vector<3xi17>) -> vector<3xi17> {
    %0 = llvm.mlir.constant(0 : i17) : i17
    %1 = llvm.mlir.constant(-1 : i17) : i17
    %2 = llvm.mlir.constant(7 : i17) : i17
    %3 = llvm.mlir.constant(dense<[7, -1, 0]> : vector<3xi17>) : vector<3xi17>
    %4 = llvm.select %arg0, %arg1, %3 : vector<3xi1>, vector<3xi17>
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = true}> : (vector<3xi17>) -> vector<3xi17>
    llvm.return %5 : vector<3xi17>
  }
  llvm.func @ctlz_sel_const_true_false_extra_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @cttz_sel_const_true_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @cttz_sel_const_true(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_sel_const_false(%arg0: vector<3xi1>, %arg1: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mlir.constant(-1 : i5) : i5
    %2 = llvm.mlir.constant(7 : i5) : i5
    %3 = llvm.mlir.constant(dense<[7, -1, 0]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.select %arg0, %arg1, %3 : vector<3xi1>, vector<3xi5>
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (vector<3xi5>) -> vector<3xi5>
    llvm.return %5 : vector<3xi5>
  }
  llvm.func @cttz_sel_const_true_false_extra_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @ctpop_sel_const_true_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @ctpop_sel_const_true(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @ctpop_sel_const_false(%arg0: vector<3xi1>, %arg1: vector<3xi7>) -> vector<3xi7> {
    %0 = llvm.mlir.constant(0 : i7) : i7
    %1 = llvm.mlir.constant(-1 : i7) : i7
    %2 = llvm.mlir.constant(7 : i7) : i7
    %3 = llvm.mlir.constant(dense<[7, -1, 0]> : vector<3xi7>) : vector<3xi7>
    %4 = llvm.select %arg0, %arg1, %3 : vector<3xi1>, vector<3xi7>
    %5 = llvm.intr.ctpop(%4)  : (vector<3xi7>) -> vector<3xi7>
    llvm.return %5 : vector<3xi7>
  }
  llvm.func @ctpop_sel_const_true_false_extra_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @usub_sat_rhs_const_select_all_const(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.intr.usub.sat(%3, %2)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @usub_sat_rhs_var_select_all_const(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.intr.usub.sat(%2, %arg1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @usub_sat_rhs_const_select_one_const(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.intr.usub.sat(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @usub_sat_rhs_const_select_no_const(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, i32
    %2 = llvm.intr.usub.sat(%1, %0)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @usub_sat_lhs_const_select_all_const(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.intr.usub.sat(%2, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @non_speculatable(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(true) : i1
    %6 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %7 = llvm.mlir.poison : vector<2xi32>
    %8 = llvm.mlir.constant(64 : i32) : i32
    %9 = llvm.select %arg0, %2, %3 : i1, !llvm.ptr
    %10 = llvm.intr.masked.load %9, %6, %7 {alignment = 64 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xi32>) -> vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @vec_to_scalar_select_scalar(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %3 = "llvm.intr.vector.reduce.add"(%2) : (vector<2xi32>) -> i32
    llvm.return %3 : i32
  }
  llvm.func @vec_to_scalar_select_vector(%arg0: vector<2xi1>) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    %3 = "llvm.intr.vector.reduce.add"(%2) : (vector<2xi32>) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_drop_noundef(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.select %arg0, %0, %arg1 : i1, i8
    %3 = llvm.intr.smin(%2, %1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }
  llvm.func @pr85536(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(48 : i64) : i64
    %3 = llvm.mlir.constant(-1 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(65535 : i64) : i64
    %6 = llvm.icmp "ugt" %arg0, %0 : i32
    %7 = llvm.shl %1, %arg0 overflow<nsw>  : i32
    %8 = llvm.zext %7 : i32 to i64
    %9 = llvm.shl %8, %2  : i64
    %10 = llvm.ashr %9, %2  : i64
    %11 = llvm.select %6, %3, %10 : i1, i64
    %12 = llvm.intr.smin(%11, %4)  : (i64, i64) -> i64
    %13 = llvm.and %12, %5  : i64
    %14 = llvm.icmp "eq" %13, %4 : i64
    llvm.return %14 : i1
  }
  llvm.func @test_fabs_select1(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %2 = llvm.fcmp "uno" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %arg0 : i1, f64
    %4 = llvm.intr.fabs(%3)  : (f64) -> f64
    %5 = llvm.select %2, %4, %arg0 : i1, f64
    llvm.return %5 : f64
  }
  llvm.func @test_fabs_select1_vec(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.fcmp "uno" %arg0, %1 : vector<2xf64>
    %4 = llvm.select %3, %2, %arg0 : vector<2xi1>, vector<2xf64>
    %5 = llvm.intr.fabs(%4)  : (vector<2xf64>) -> vector<2xf64>
    %6 = llvm.select %3, %5, %arg0 : vector<2xi1>, vector<2xf64>
    llvm.return %6 : vector<2xf64>
  }
  llvm.func @test_fabs_select2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %2, %0 : f64
    %4 = llvm.select %3, %1, %2 : i1, f64
    %5 = llvm.intr.fabs(%4)  : (f64) -> f64
    llvm.return %5 : f64
  }
  llvm.func @test_fabs_select_fmf1(%arg0: i1, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : i1, f64
    %2 = llvm.intr.fabs(%1)  : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @test_fabs_select_fmf2(%arg0: i1, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %0, %arg1 : i1, f64
    %2 = llvm.intr.fabs(%1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f64) -> f64
    llvm.return %2 : f64
  }
}
