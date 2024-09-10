module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t1(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @t2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sext %arg0 : i32 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @t3(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.zext %arg0 : i32 to i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @t4(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.select %2, %3, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @t5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.zext %arg0 : i32 to i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @t6(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    %3 = llvm.sitofp %2 : i32 to f32
    llvm.return %3 : f32
  }
  llvm.func @t7(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i16) : i16
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i16
    %4 = llvm.select %2, %3, %1 : i1, i16
    llvm.return %4 : i16
  }
  llvm.func @t8(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-32767 : i64) : i64
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.select %2, %arg0, %0 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.icmp "slt" %arg1, %1 : i32
    %6 = llvm.select %5, %1, %4 : i1, i32
    %7 = llvm.icmp "ne" %6, %arg1 : i32
    %8 = llvm.zext %7 : i1 to i32
    llvm.return %8 : i32
  }
  llvm.func @t9(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sext %arg0 : i32 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @t10(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.sitofp %arg0 : i32 to f32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, f32
    llvm.return %4 : f32
  }
  llvm.func @t11(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.sitofp %arg0 : i64 to f32
    %3 = llvm.icmp "sgt" %arg0, %0 : i64
    %4 = llvm.select %3, %2, %1 : i1, f32
    llvm.return %4 : f32
  }
  llvm.func @bitcasts_fcmp_1(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<4xi32> {
    %0 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xf32>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xf32>
    %2 = llvm.fcmp "olt" %1, %0 : vector<4xf32>
    %3 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xi32>
    %4 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xi32>
    %5 = llvm.select %2, %3, %4 : vector<4xi1>, vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @bitcasts_fcmp_2(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<4xi32> {
    %0 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xf32>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xf32>
    %2 = llvm.fcmp "olt" %0, %1 : vector<4xf32>
    %3 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xi32>
    %4 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xi32>
    %5 = llvm.select %2, %3, %4 : vector<4xi1>, vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @bitcasts_icmp(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xi32>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xi32>
    %2 = llvm.icmp "slt" %1, %0 : vector<4xi32>
    %3 = llvm.bitcast %arg0 : vector<2xi64> to vector<4xf32>
    %4 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xf32>
    %5 = llvm.select %2, %3, %4 : vector<4xi1>, vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }
  llvm.func @test68(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(92 : i32) : i32
    %2 = llvm.icmp "slt" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @test68vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<92> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %0, %arg0 : vector<2xi32>
    %3 = llvm.select %2, %0, %arg0 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "slt" %1, %3 : vector<2xi32>
    %5 = llvm.select %4, %1, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test69(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(83 : i32) : i32
    %2 = llvm.icmp "ult" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "ult" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
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
  llvm.func @test71(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(68 : i32) : i32
    %1 = llvm.mlir.constant(47 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "ult" %3, %1 : i32
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
  llvm.func @test72vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<92> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %0, %arg0 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %1 : vector<2xi32>
    %5 = llvm.select %4, %1, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test73(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(83 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
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
  llvm.func @test75(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.mlir.constant(68 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @clamp_signed1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @clamp_signed2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @clamp_signed3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @clamp_signed4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @clamp_unsigned1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @clamp_unsigned2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @clamp_unsigned3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @clamp_unsigned4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @clamp_check_for_no_infinite_loop1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @clamp_check_for_no_infinite_loop2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @clamp_check_for_no_infinite_loop3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg0, %0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.icmp "slt" %4, %2 : i32
    %7 = llvm.select %6, %4, %2 : i1, i32
    %8 = llvm.shl %7, %2 overflow<nsw, nuw>  : i32
    llvm.return %8 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }
  llvm.func @PR31751_umin1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    %4 = llvm.sitofp %3 : i32 to f64
    llvm.return %4 : f64
  }
  llvm.func @PR31751_umin2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    %3 = llvm.sitofp %2 : i32 to f64
    llvm.return %3 : f64
  }
  llvm.func @PR31751_umin3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    %2 = llvm.select %1, %0, %arg0 : i1, i32
    %3 = llvm.sitofp %2 : i32 to f64
    llvm.return %3 : f64
  }
  llvm.func @PR31751_umax1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    %4 = llvm.sitofp %3 : i32 to f64
    llvm.return %4 : f64
  }
  llvm.func @PR31751_umax2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    %3 = llvm.sitofp %2 : i32 to f64
    llvm.return %3 : f64
  }
  llvm.func @PR31751_umax3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.select %1, %0, %arg0 : i1, i32
    %3 = llvm.sitofp %2 : i32 to f64
    llvm.return %3 : f64
  }
  llvm.func @bitcast_scalar_smax(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.bitcast %arg0 : f32 to i32
    %1 = llvm.bitcast %arg1 : f32 to i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    %4 = llvm.bitcast %3 : i32 to f32
    llvm.return %4 : f32
  }
  llvm.func @bitcast_scalar_umax(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.bitcast %arg0 : f32 to i32
    %1 = llvm.bitcast %arg1 : f32 to i32
    %2 = llvm.icmp "ugt" %0, %1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @bitcast_vector_smin(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xf32> {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.bitcast %arg1 : vector<8xf32> to vector<8xi32>
    %2 = llvm.icmp "slt" %0, %1 : vector<8xi32>
    %3 = llvm.select %2, %0, %1 : vector<8xi1>, vector<8xi32>
    %4 = llvm.bitcast %3 : vector<8xi32> to vector<8xf32>
    llvm.return %4 : vector<8xf32>
  }
  llvm.func @bitcast_vector_umin(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xf32> {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.bitcast %arg1 : vector<8xf32> to vector<8xi32>
    %2 = llvm.icmp "slt" %0, %1 : vector<8xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<8xi1>, vector<8xf32>
    llvm.return %3 : vector<8xf32>
  }
  llvm.func @look_through_cast1(%arg0: i32) -> (i8 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(511 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @look_through_cast2(%arg0: i32) -> (i8 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(510 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @min_through_cast_vec1(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[510, 511]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2, -1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %4 = llvm.select %2, %3, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @min_through_cast_vec2(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<511> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %4 = llvm.select %2, %3, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @common_factor_smin(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "slt" %arg1, %arg2 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @common_factor_smax(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "sgt" %arg2, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg2, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "sgt" %1, %3 : vector<2xi32>
    %5 = llvm.select %4, %1, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @common_factor_umin(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "ult" %arg1, %arg2 : vector<2xi32>
    %1 = llvm.select %0, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "ult" %1, %3 : vector<2xi32>
    %5 = llvm.select %4, %1, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @common_factor_umax(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i32
    %1 = llvm.select %0, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @extra_use(i32)
  llvm.func @common_factor_umax_extra_use_lhs(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i32
    %1 = llvm.select %0, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.call @extra_use(%1) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @common_factor_umax_extra_use_rhs(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i32
    %1 = llvm.select %0, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.call @extra_use(%3) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @common_factor_umax_extra_use_both(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg1, %arg2 : i32
    %1 = llvm.select %0, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.call @extra_use(%1) : (i32) -> ()
    llvm.call @extra_use(%3) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @not_min_of_min(%arg0: i8, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.fcmp "ult" %arg1, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.select %3, %arg1, %0 : i1, f32
    %5 = llvm.fcmp "ult" %arg1, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %6 = llvm.select %5, %arg1, %1 : i1, f32
    %7 = llvm.icmp "ult" %arg0, %2 : i8
    %8 = llvm.select %7, %4, %6 : i1, f32
    llvm.return %8 : f32
  }
  llvm.func @add_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_umin_constant_limit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(41 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_umin_simplify(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @add_umin_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(43 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_umin_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_umin_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_umin_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_umin_vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<240> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi16>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi16>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }
  llvm.func @add_umax(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(5 : i37) : i37
    %1 = llvm.mlir.constant(42 : i37) : i37
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i37
    %3 = llvm.icmp "ugt" %2, %1 : i37
    %4 = llvm.select %3, %2, %1 : i1, i37
    llvm.return %4 : i37
  }
  llvm.func @add_umax_constant_limit(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(81 : i37) : i37
    %1 = llvm.mlir.constant(82 : i37) : i37
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i37
    %3 = llvm.icmp "ugt" %2, %1 : i37
    %4 = llvm.select %3, %2, %1 : i1, i37
    llvm.return %4 : i37
  }
  llvm.func @add_umax_simplify(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i37
    %2 = llvm.icmp "ugt" %1, %0 : i37
    %3 = llvm.select %2, %1, %0 : i1, i37
    llvm.return %3 : i37
  }
  llvm.func @add_umax_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(57 : i32) : i32
    %1 = llvm.mlir.constant(56 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_umax_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_umax_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_umax_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_umax_vec(%arg0: vector<2xi33>) -> vector<2xi33> {
    %0 = llvm.mlir.constant(5 : i33) : i33
    %1 = llvm.mlir.constant(dense<5> : vector<2xi33>) : vector<2xi33>
    %2 = llvm.mlir.constant(240 : i33) : i33
    %3 = llvm.mlir.constant(dense<240> : vector<2xi33>) : vector<2xi33>
    %4 = llvm.add %arg0, %1 overflow<nuw>  : vector<2xi33>
    %5 = llvm.icmp "ugt" %4, %3 : vector<2xi33>
    %6 = llvm.select %5, %4, %3 : vector<2xi1>, vector<2xi33>
    llvm.return %6 : vector<2xi33>
  }
  llvm.func @PR14613_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.add %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.trunc %5 : i32 to i8
    llvm.return %6 : i8
  }
  llvm.func @PR14613_umax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.add %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.trunc %5 : i32 to i8
    llvm.return %6 : i8
  }
  llvm.func @add_smin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_smin_constant_limit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(2147483643 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_smin_simplify(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(2147483644 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_smin_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(2147483645 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_smin_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_smin_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_smin_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_smin_vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<240> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi16>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi16>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }
  llvm.func @add_smax(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(5 : i37) : i37
    %1 = llvm.mlir.constant(42 : i37) : i37
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i37
    %3 = llvm.icmp "sgt" %2, %1 : i37
    %4 = llvm.select %3, %2, %1 : i1, i37
    llvm.return %4 : i37
  }
  llvm.func @add_smax_constant_limit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(125 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @add_smax_simplify(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @add_smax_simplify2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @add_smax_wrong_pred(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_smax_wrong_wrap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_smax_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @add_smax_vec(%arg0: vector<2xi33>) -> vector<2xi33> {
    %0 = llvm.mlir.constant(5 : i33) : i33
    %1 = llvm.mlir.constant(dense<5> : vector<2xi33>) : vector<2xi33>
    %2 = llvm.mlir.constant(240 : i33) : i33
    %3 = llvm.mlir.constant(dense<240> : vector<2xi33>) : vector<2xi33>
    %4 = llvm.add %arg0, %1 overflow<nsw>  : vector<2xi33>
    %5 = llvm.icmp "sgt" %4, %3 : vector<2xi33>
    %6 = llvm.select %5, %4, %3 : vector<2xi1>, vector<2xi33>
    llvm.return %6 : vector<2xi33>
  }
  llvm.func @PR14613_smin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(55 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.add %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.trunc %5 : i32 to i8
    llvm.return %6 : i8
  }
  llvm.func @PR14613_smax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(55 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.add %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.trunc %5 : i32 to i8
    llvm.return %6 : i8
  }
  llvm.func @PR46271(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    %10 = llvm.select %9, %arg0, %7 : vector<2xi1>, vector<2xi8>
    %11 = llvm.xor %10, %7  : vector<2xi8>
    %12 = llvm.extractelement %11[%8 : i32] : vector<2xi8>
    llvm.return %12 : i8
  }
  llvm.func @twoway_clamp_lt(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(13768 : i32) : i32
    %1 = llvm.mlir.constant(13767 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @twoway_clamp_gt(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(13767 : i32) : i32
    %1 = llvm.mlir.constant(13768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @twoway_clamp_gt_nonconst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg1, %0  : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @test_umax_smax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_umax_smax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_umax_smax_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[0, 20]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smax(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.intr.umax(%2, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test_smin_umin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_smin_umin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_smin_umin_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[20, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.umin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.intr.smin(%2, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test_umax_smax3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_umax_smax4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_smin_umin3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(-20 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_smin_umin4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_umax_nonminmax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.intr.umax(%1, %0)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_umax_smax_vec_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[0, -20]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smax(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.intr.umax(%2, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
}
