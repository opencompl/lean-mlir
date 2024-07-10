module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 64 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @sadd_sat32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }
  llvm.func @sadd_sat32_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.return %7 : i32
  }
  llvm.func @ssub_sat32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.sub %2, %3  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }
  llvm.func @ssub_sat32_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.sub %2, %3  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.return %7 : i32
  }
  llvm.func @smul_sat32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.mul %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }
  llvm.func @smul_sat32_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.mul %3, %2  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.return %7 : i32
  }
  llvm.func @sadd_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.sext %arg0 : i16 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i16
    llvm.return %9 : i16
  }
  llvm.func @sadd_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.sext %arg0 : i16 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.intr.smin(%4, %0)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%5, %1)  : (i32, i32) -> i32
    %7 = llvm.trunc %6 : i32 to i16
    llvm.return %7 : i16
  }
  llvm.func @ssub_sat16(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.sext %arg0 : i16 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i16
    llvm.return %9 : i16
  }
  llvm.func @ssub_sat16_mm(%arg0: i16 {llvm.signext}, %arg1: i16 {llvm.signext}) -> (i16 {llvm.signext}) {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.sext %arg0 : i16 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.intr.smin(%4, %0)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%5, %1)  : (i32, i32) -> i32
    %7 = llvm.trunc %6 : i32 to i16
    llvm.return %7 : i16
  }
  llvm.func @sadd_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }
  llvm.func @sadd_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.intr.smin(%4, %0)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%5, %1)  : (i32, i32) -> i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }
  llvm.func @ssub_sat8(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }
  llvm.func @ssub_sat8_mm(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.signext}) {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.intr.smin(%4, %0)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%5, %1)  : (i32, i32) -> i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }
  llvm.func @sadd_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> (i64 {llvm.signext}) {
    %0 = llvm.mlir.constant(9223372036854775807 : i65) : i65
    %1 = llvm.mlir.constant(-9223372036854775808 : i65) : i65
    %2 = llvm.sext %arg0 : i64 to i65
    %3 = llvm.sext %arg1 : i64 to i65
    %4 = llvm.add %3, %2  : i65
    %5 = llvm.icmp "slt" %4, %0 : i65
    %6 = llvm.select %5, %4, %0 : i1, i65
    %7 = llvm.icmp "sgt" %6, %1 : i65
    %8 = llvm.select %7, %6, %1 : i1, i65
    %9 = llvm.trunc %8 : i65 to i64
    llvm.return %9 : i64
  }
  llvm.func @ssub_sat64(%arg0: i64 {llvm.signext}, %arg1: i64 {llvm.signext}) -> (i64 {llvm.signext}) {
    %0 = llvm.mlir.constant(9223372036854775807 : i65) : i65
    %1 = llvm.mlir.constant(-9223372036854775808 : i65) : i65
    %2 = llvm.sext %arg0 : i64 to i65
    %3 = llvm.sext %arg1 : i64 to i65
    %4 = llvm.sub %2, %3  : i65
    %5 = llvm.icmp "slt" %4, %0 : i65
    %6 = llvm.select %5, %4, %0 : i1, i65
    %7 = llvm.icmp "sgt" %6, %1 : i65
    %8 = llvm.select %7, %6, %1 : i1, i65
    %9 = llvm.trunc %8 : i65 to i64
    llvm.return %9 : i64
  }
  llvm.func @sadd_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> (i4 {llvm.signext}) {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.sext %arg0 : i4 to i32
    %3 = llvm.sext %arg1 : i4 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i4
    llvm.return %9 : i4
  }
  llvm.func @ssub_sat4(%arg0: i4 {llvm.signext}, %arg1: i4 {llvm.signext}) -> (i4 {llvm.signext}) {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.sext %arg0 : i4 to i32
    %3 = llvm.sext %arg1 : i4 to i32
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i4
    llvm.return %9 : i4
  }
  llvm.func @sadd_satv4i32(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.sext %arg0 : vector<4xi32> to vector<4xi64>
    %3 = llvm.sext %arg1 : vector<4xi32> to vector<4xi64>
    %4 = llvm.add %3, %2  : vector<4xi64>
    %5 = llvm.icmp "slt" %4, %0 : vector<4xi64>
    %6 = llvm.select %5, %4, %0 : vector<4xi1>, vector<4xi64>
    %7 = llvm.icmp "sgt" %6, %1 : vector<4xi64>
    %8 = llvm.select %7, %6, %1 : vector<4xi1>, vector<4xi64>
    %9 = llvm.trunc %8 : vector<4xi64> to vector<4xi32>
    llvm.return %9 : vector<4xi32>
  }
  llvm.func @sadd_satv4i32_mm(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.sext %arg0 : vector<4xi32> to vector<4xi64>
    %3 = llvm.sext %arg1 : vector<4xi32> to vector<4xi64>
    %4 = llvm.add %3, %2  : vector<4xi64>
    %5 = llvm.intr.smin(%4, %0)  : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %6 = llvm.intr.smax(%5, %1)  : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %7 = llvm.trunc %6 : vector<4xi64> to vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
  llvm.func @ssub_satv4i32(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.sext %arg0 : vector<4xi32> to vector<4xi64>
    %3 = llvm.sext %arg1 : vector<4xi32> to vector<4xi64>
    %4 = llvm.sub %3, %2  : vector<4xi64>
    %5 = llvm.icmp "slt" %4, %0 : vector<4xi64>
    %6 = llvm.select %5, %4, %0 : vector<4xi1>, vector<4xi64>
    %7 = llvm.icmp "sgt" %6, %1 : vector<4xi64>
    %8 = llvm.select %7, %6, %1 : vector<4xi1>, vector<4xi64>
    %9 = llvm.trunc %8 : vector<4xi64> to vector<4xi32>
    llvm.return %9 : vector<4xi32>
  }
  llvm.func @ssub_satv4i32_mm(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.sext %arg0 : vector<4xi32> to vector<4xi64>
    %3 = llvm.sext %arg1 : vector<4xi32> to vector<4xi64>
    %4 = llvm.sub %3, %2  : vector<4xi64>
    %5 = llvm.intr.smin(%4, %0)  : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %6 = llvm.intr.smax(%5, %1)  : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %7 = llvm.trunc %6 : vector<4xi64> to vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
  llvm.func @sadd_satv4i4(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %arg1  : vector<4xi32>
    %3 = llvm.icmp "slt" %2, %0 : vector<4xi32>
    %4 = llvm.select %3, %2, %0 : vector<4xi1>, vector<4xi32>
    %5 = llvm.icmp "sgt" %4, %1 : vector<4xi32>
    %6 = llvm.select %5, %4, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }
  llvm.func @ssub_satv4i4(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %arg0, %arg1  : vector<4xi32>
    %3 = llvm.icmp "slt" %2, %0 : vector<4xi32>
    %4 = llvm.select %3, %2, %0 : vector<4xi1>, vector<4xi32>
    %5 = llvm.icmp "sgt" %4, %1 : vector<4xi32>
    %6 = llvm.select %5, %4, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }
  llvm.func @sadd_sat32_extrause_1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use64(%8) : (i64) -> ()
    llvm.return %9 : i32
  }
  llvm.func @sadd_sat32_extrause_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use64(%6) : (i64) -> ()
    llvm.return %9 : i32
  }
  llvm.func @sadd_sat32_extrause_2_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.call @use64(%5) : (i64) -> ()
    llvm.return %7 : i32
  }
  llvm.func @sadd_sat32_extrause_3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use64(%4) : (i64) -> ()
    llvm.return %9 : i32
  }
  llvm.func @sadd_sat32_extrause_3_mm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.intr.smin(%4, %0)  : (i64, i64) -> i64
    %6 = llvm.intr.smax(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.trunc %6 : i64 to i32
    llvm.call @use64(%4) : (i64) -> ()
    llvm.return %7 : i32
  }
  llvm.func @sadd_sat32_trunc(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i64) : i64
    %1 = llvm.mlir.constant(-32768 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }
  llvm.func @sadd_sat32_ext16(%arg0: i32, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i16 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }
  llvm.func @sadd_sat8_ext8(%arg0: i8, %arg1: i16) -> i8 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    %8 = llvm.select %7, %6, %1 : i1, i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }
  llvm.func @sadd_sat32_zext(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "slt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "sgt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }
  llvm.func @sadd_sat32_maxmin(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i64) : i64
    %1 = llvm.mlir.constant(2147483647 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "sgt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "slt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }
  llvm.func @sadd_sat32_notrunc(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(-2147483648 : i64) : i64
    %1 = llvm.mlir.constant(2147483647 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.icmp "sgt" %4, %0 : i64
    %6 = llvm.select %5, %4, %0 : i1, i64
    %7 = llvm.icmp "slt" %6, %1 : i64
    %8 = llvm.select %7, %6, %1 : i1, i64
    llvm.return %8 : i64
  }
  llvm.func @ashrA(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(2147483647 : i64) : i64
    %2 = llvm.mlir.constant(-2147483648 : i64) : i64
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.sext %arg1 : i32 to i64
    %5 = llvm.add %4, %3  : i64
    %6 = llvm.intr.smin(%5, %1)  : (i64, i64) -> i64
    %7 = llvm.intr.smax(%6, %2)  : (i64, i64) -> i64
    %8 = llvm.trunc %7 : i64 to i32
    llvm.return %8 : i32
  }
  llvm.func @ashrB(%arg0: i32, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.mlir.constant(2147483647 : i64) : i64
    %3 = llvm.sext %arg0 : i32 to i64
    %4 = llvm.ashr %arg1, %0  : i64
    %5 = llvm.add %4, %3  : i64
    %6 = llvm.icmp "sgt" %5, %1 : i64
    %7 = llvm.select %6, %5, %1 : i1, i64
    %8 = llvm.icmp "slt" %7, %2 : i64
    %9 = llvm.select %8, %7, %2 : i1, i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }
  llvm.func @ashrAB(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.mlir.constant(2147483647 : i64) : i64
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.ashr %arg1, %0  : i64
    %5 = llvm.add %4, %3  : i64
    %6 = llvm.icmp "sgt" %5, %1 : i64
    %7 = llvm.select %6, %5, %1 : i1, i64
    %8 = llvm.icmp "slt" %7, %2 : i64
    %9 = llvm.select %8, %7, %2 : i1, i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }
  llvm.func @ashrA31(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.mlir.constant(2147483647 : i64) : i64
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.sext %arg1 : i32 to i64
    %5 = llvm.add %4, %3  : i64
    %6 = llvm.icmp "sgt" %5, %1 : i64
    %7 = llvm.select %6, %5, %1 : i1, i64
    %8 = llvm.icmp "slt" %7, %2 : i64
    %9 = llvm.select %8, %7, %2 : i1, i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }
  llvm.func @ashrA33(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(33 : i64) : i64
    %1 = llvm.mlir.constant(-2147483648 : i64) : i64
    %2 = llvm.mlir.constant(2147483647 : i64) : i64
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.sext %arg1 : i32 to i64
    %5 = llvm.add %4, %3  : i64
    %6 = llvm.icmp "sgt" %5, %1 : i64
    %7 = llvm.select %6, %5, %1 : i1, i64
    %8 = llvm.icmp "slt" %7, %2 : i64
    %9 = llvm.select %8, %7, %2 : i1, i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }
  llvm.func @ashrv2i8(%arg0: vector<2xi16>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 12]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<-128> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<127> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.ashr %arg0, %0  : vector<2xi16>
    %4 = llvm.sext %arg1 : vector<2xi8> to vector<2xi16>
    %5 = llvm.add %4, %3  : vector<2xi16>
    %6 = llvm.icmp "sgt" %5, %1 : vector<2xi16>
    %7 = llvm.select %6, %5, %1 : vector<2xi1>, vector<2xi16>
    %8 = llvm.icmp "slt" %7, %2 : vector<2xi16>
    %9 = llvm.select %8, %7, %2 : vector<2xi1>, vector<2xi16>
    %10 = llvm.trunc %9 : vector<2xi16> to vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @ashrv2i8_s(%arg0: vector<2xi16>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<-128> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<127> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.ashr %arg0, %0  : vector<2xi16>
    %4 = llvm.sext %arg1 : vector<2xi8> to vector<2xi16>
    %5 = llvm.add %4, %3  : vector<2xi16>
    %6 = llvm.icmp "sgt" %5, %1 : vector<2xi16>
    %7 = llvm.select %6, %5, %1 : vector<2xi1>, vector<2xi16>
    %8 = llvm.icmp "slt" %7, %2 : vector<2xi16>
    %9 = llvm.select %8, %7, %2 : vector<2xi1>, vector<2xi16>
    %10 = llvm.trunc %9 : vector<2xi16> to vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @or(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-16 : i16) : i16
    %1 = llvm.mlir.constant(-128 : i16) : i16
    %2 = llvm.mlir.constant(127 : i16) : i16
    %3 = llvm.sext %arg0 : i8 to i16
    %4 = llvm.or %arg1, %0  : i16
    %5 = llvm.sub %3, %4 overflow<nsw>  : i16
    %6 = llvm.icmp "sgt" %5, %1 : i16
    %7 = llvm.select %6, %5, %1 : i1, i16
    %8 = llvm.icmp "slt" %7, %2 : i16
    %9 = llvm.select %8, %7, %2 : i1, i16
    llvm.return %9 : i16
  }
  llvm.func @const(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(10 : i16) : i16
    %1 = llvm.mlir.constant(-128 : i16) : i16
    %2 = llvm.mlir.constant(127 : i16) : i16
    %3 = llvm.sext %arg0 : i8 to i16
    %4 = llvm.add %3, %0  : i16
    %5 = llvm.icmp "sgt" %4, %1 : i16
    %6 = llvm.select %5, %4, %1 : i1, i16
    %7 = llvm.icmp "slt" %6, %2 : i16
    %8 = llvm.select %7, %6, %2 : i1, i16
    llvm.return %8 : i16
  }
  llvm.func @use64(i64)
}
