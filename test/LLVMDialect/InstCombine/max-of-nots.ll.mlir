module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @umin_of_nots(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "ult" %1, %2 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @smin_of_nots(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "sle" %1, %2 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @compute_min_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.icmp "sgt" %1, %2 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.sub %0, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @extra_use(i8)
  llvm.func @umin_not_1_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.return %4 : i8
  }
  llvm.func @umin_not_2_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.call @extra_use(%2) : (i8) -> ()
    llvm.return %4 : i8
  }
  llvm.func @umin3_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "ult" %arg1, %arg0 : i8
    %5 = llvm.icmp "ult" %1, %3 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "ult" %2, %3 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    llvm.return %9 : i8
  }
  llvm.func @umin3_not_more_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "ult" %1, %3 : i8
    %5 = llvm.select %4, %1, %3 : i1, i8
    %6 = llvm.icmp "ult" %2, %3 : i8
    %7 = llvm.select %6, %2, %3 : i1, i8
    %8 = llvm.icmp "ult" %arg1, %arg0 : i8
    %9 = llvm.select %8, %5, %7 : i1, i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.call @extra_use(%2) : (i8) -> ()
    llvm.return %9 : i8
  }
  llvm.func @use8(i8)
  llvm.func @umin3_not_all_ops_extra_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "ult" %1, %3 : i8
    %5 = llvm.select %4, %1, %3 : i1, i8
    %6 = llvm.icmp "ult" %5, %2 : i8
    %7 = llvm.select %6, %5, %2 : i1, i8
    llvm.call @use8(%1) : (i8) -> ()
    llvm.call @use8(%2) : (i8) -> ()
    llvm.call @use8(%3) : (i8) -> ()
    llvm.return %7 : i8
  }
  llvm.func @compute_min_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.icmp "sgt" %1, %2 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    %6 = llvm.icmp "sgt" %5, %3 : i32
    %7 = llvm.select %6, %5, %3 : i1, i32
    %8 = llvm.sub %0, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @compute_min_arithmetic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sub %1, %arg1  : i32
    %4 = llvm.icmp "sgt" %2, %3 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @fake_use(i32)
  llvm.func @compute_min_pessimization(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @fake_use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %arg1  : i32
    %4 = llvm.icmp "sgt" %2, %3 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.sub %1, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @max_of_nots(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.select %2, %3, %1 : i1, i32
    %5 = llvm.xor %arg0, %1  : i32
    %6 = llvm.icmp "slt" %4, %5 : i32
    %7 = llvm.select %6, %5, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @abs_of_min_of_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.icmp "sge" %4, %3 : i32
    %6 = llvm.select %5, %3, %4 : i1, i32
    %7 = llvm.icmp "sgt" %6, %0 : i32
    %8 = llvm.sub %2, %6  : i32
    %9 = llvm.select %7, %6, %8 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @max_of_nots_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg1, %1 : vector<2xi32>
    %4 = llvm.xor %arg1, %2  : vector<2xi32>
    %5 = llvm.select %3, %4, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.xor %arg0, %2  : vector<2xi32>
    %7 = llvm.icmp "slt" %5, %6 : vector<2xi32>
    %8 = llvm.select %7, %6, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @max_of_nots_weird_type_vec(%arg0: vector<2xi37>, %arg1: vector<2xi37>) -> vector<2xi37> {
    %0 = llvm.mlir.constant(0 : i37) : i37
    %1 = llvm.mlir.constant(dense<0> : vector<2xi37>) : vector<2xi37>
    %2 = llvm.mlir.constant(-1 : i37) : i37
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi37>) : vector<2xi37>
    %4 = llvm.icmp "sgt" %arg1, %1 : vector<2xi37>
    %5 = llvm.xor %arg1, %3  : vector<2xi37>
    %6 = llvm.select %4, %5, %3 : vector<2xi1>, vector<2xi37>
    %7 = llvm.xor %arg0, %3  : vector<2xi37>
    %8 = llvm.icmp "slt" %6, %7 : vector<2xi37>
    %9 = llvm.select %8, %7, %6 : vector<2xi1>, vector<2xi37>
    llvm.return %9 : vector<2xi37>
  }
  llvm.func @max_of_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @max_of_min_swap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @min_of_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @min_of_max_swap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @max_of_min_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.xor %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "sgt" %arg0, %2 : vector<2xi32>
    %5 = llvm.select %4, %3, %0 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %0 : vector<2xi32>
    %7 = llvm.select %6, %5, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @use(i8, i8, i8, i8)
  llvm.func @cmyk(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "slt" %arg1, %arg0 : i8
    %5 = llvm.icmp "slt" %1, %3 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "slt" %2, %3 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk2(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "slt" %arg1, %arg0 : i8
    %5 = llvm.icmp "slt" %arg2, %arg0 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "slt" %arg2, %arg1 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk3(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "slt" %arg1, %arg0 : i8
    %5 = llvm.icmp "sgt" %arg0, %arg2 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "slt" %arg2, %arg1 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk4(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "slt" %arg1, %arg0 : i8
    %5 = llvm.icmp "sgt" %arg0, %arg2 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "sgt" %arg1, %arg2 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk5(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %5 = llvm.icmp "sgt" %arg0, %arg2 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "sgt" %arg1, %arg2 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
  llvm.func @cmyk6(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "ult" %arg1, %arg0 : i8
    %5 = llvm.icmp "ult" %arg2, %arg0 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "ult" %arg2, %arg1 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }
}
