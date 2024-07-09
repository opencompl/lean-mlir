module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @vec_select(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.icmp "slt" %arg1, %1 : vector<4xi32>
    %4 = llvm.sext %3 : vector<4xi1> to vector<4xi32>
    %5 = llvm.sub %1, %arg0 overflow<nsw>  : vector<4xi32>
    %6 = llvm.icmp "slt" %4, %1 : vector<4xi32>
    %7 = llvm.sext %6 : vector<4xi1> to vector<4xi32>
    %8 = llvm.xor %7, %2  : vector<4xi32>
    %9 = llvm.and %arg0, %8  : vector<4xi32>
    %10 = llvm.and %7, %5  : vector<4xi32>
    %11 = llvm.or %9, %10  : vector<4xi32>
    llvm.return %11 : vector<4xi32>
  }
  llvm.func @vec_select_alternate_sign_bit_test(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.icmp "sgt" %arg1, %0 : vector<4xi32>
    %4 = llvm.sext %3 : vector<4xi1> to vector<4xi32>
    %5 = llvm.sub %2, %arg0 overflow<nsw>  : vector<4xi32>
    %6 = llvm.icmp "slt" %4, %2 : vector<4xi32>
    %7 = llvm.sext %6 : vector<4xi1> to vector<4xi32>
    %8 = llvm.xor %7, %0  : vector<4xi32>
    %9 = llvm.and %arg0, %8  : vector<4xi32>
    %10 = llvm.and %7, %5  : vector<4xi32>
    %11 = llvm.or %9, %10  : vector<4xi32>
    llvm.return %11 : vector<4xi32>
  }
  llvm.func @is_negative_poison_elt(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "slt" %arg0, %6 : vector<2xi32>
    %8 = llvm.sext %7 : vector<2xi1> to vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @is_positive_poison_elt(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "sgt" %arg0, %6 : vector<2xi32>
    %8 = llvm.sext %7 : vector<2xi1> to vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
}
