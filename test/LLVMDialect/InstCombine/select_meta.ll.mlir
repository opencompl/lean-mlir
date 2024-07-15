module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func local_unnamed_addr @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.mlir.constant(-20 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1 overflow<nsw>  : i32
    %5 = llvm.add %arg0, %2  : i32
    %6 = llvm.select %3, %4, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @shrink_select(%arg0: i1, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.select %arg0, %arg1, %0 : i1, i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.return %2 : i8
  }
  llvm.func @min_max_bitcast(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: !llvm.ptr, %arg3: !llvm.ptr) {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : vector<4xf32>
    %1 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %2 = llvm.bitcast %arg1 : vector<4xf32> to vector<4xi32>
    %3 = llvm.select %0, %1, %2 : vector<4xi1>, vector<4xi32>
    %4 = llvm.select %0, %2, %1 : vector<4xi1>, vector<4xi32>
    llvm.store %3, %arg2 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.store %4, %arg3 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr
    llvm.return
  }
  llvm.func local_unnamed_addr @foo2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.add %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @test43(%arg0: i32) -> i64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @scalar_select_of_vectors_sext(%arg0: vector<2xi1>, %arg1: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : i1, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @t7(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i16) : i16
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i16
    %4 = llvm.select %2, %3, %1 : i1, i16
    llvm.return %4 : i16
  }
  llvm.func @abs_nabs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_nabs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.sub %2, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.select %3, %4, %arg0 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %0 : vector<2xi32>
    %7 = llvm.sub %2, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %5, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @test30(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @test70(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(75 : i32) : i32
    %1 = llvm.mlir.constant(36 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @test72(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(92 : i32) : i32
    %1 = llvm.mlir.constant(11 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @test74(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(36 : i32) : i32
    %1 = llvm.mlir.constant(75 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @smin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @smin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @smax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @smax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @umin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @umin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @umax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @umax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @not_cond(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %arg1, %arg2 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @not_cond_vec(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.select %2, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @not_cond_vec_poison(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<2xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.xor %arg0, %6  : vector<2xi1>
    %8 = llvm.select %7, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @select_add(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.add %arg1, %arg2  : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    llvm.return %1 : i64
  }
  llvm.func @select_or(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.or %arg1, %arg2  : vector<2xi32>
    %1 = llvm.select %arg0, %0, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @select_sub(%arg0: i1, %arg1: i17, %arg2: i17) -> i17 {
    %0 = llvm.sub %arg1, %arg2  : i17
    %1 = llvm.select %arg0, %0, %arg1 : i1, i17
    llvm.return %1 : i17
  }
  llvm.func @select_ashr(%arg0: i1, %arg1: i128, %arg2: i128) -> i128 {
    %0 = llvm.ashr %arg1, %arg2  : i128
    %1 = llvm.select %arg0, %0, %arg1 : i1, i128
    llvm.return %1 : i128
  }
  llvm.func @select_fmul(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fmul %arg1, %arg2  : f64
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f64
    llvm.return %1 : f64
  }
  llvm.func @select_fdiv(%arg0: i1, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fdiv %arg1, %arg2  : vector<2xf32>
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
}
