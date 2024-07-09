module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g() {addr_space = 0 : i32} : i32
  llvm.func @smin(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %3 = llvm.icmp "slt" %2, %arg0 : i32
    %4 = llvm.select %3, %2, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @smin_int(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %3 = llvm.intr.smin(%2, %arg0)  : (i32, i32) -> i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @smin_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.or %4, %1  : vector<2xi32>
    %6 = llvm.icmp "slt" %5, %arg1 : vector<2xi32>
    %7 = llvm.select %6, %5, %arg1 : vector<2xi1>, vector<2xi32>
    %8 = llvm.icmp "sgt" %7, %3 : vector<2xi32>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @smin_commute(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @smin_commute_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.or %4, %1  : vector<2xi32>
    %6 = llvm.icmp "slt" %arg1, %5 : vector<2xi32>
    %7 = llvm.select %6, %arg1, %5 : vector<2xi1>, vector<2xi32>
    %8 = llvm.icmp "sgt" %7, %3 : vector<2xi32>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @smin_commute_vec_poison_elts(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi32>
    %9 = llvm.and %arg0, %0  : vector<2xi32>
    %10 = llvm.or %9, %1  : vector<2xi32>
    %11 = llvm.icmp "slt" %arg1, %10 : vector<2xi32>
    %12 = llvm.select %11, %arg1, %10 : vector<2xi1>, vector<2xi32>
    %13 = llvm.icmp "sgt" %12, %8 : vector<2xi32>
    llvm.return %13 : vector<2xi1>
  }
  llvm.func @maybe_not_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %3 = llvm.icmp "slt" %2, %arg0 : i32
    %4 = llvm.select %3, %2, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @maybe_not_positive_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %arg1 : vector<2xi32>
    %5 = llvm.select %4, %3, %arg1 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi32>
    llvm.return %6 : vector<2xi1>
  }
}
