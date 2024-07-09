module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @glob() {addr_space = 0 : i32, alignment = 1 : i64} : i8
  llvm.mlir.global external @glob1() {addr_space = 0 : i32, alignment = 8 : i64} : i64
  llvm.func @reduce_or_self(%arg0: vector<8xi1>) -> i1 {
    %0 = "llvm.intr.vector.reduce.or"(%arg0) : (vector<8xi1>) -> i1
    llvm.return %0 : i1
  }
  llvm.func @reduce_or_sext(%arg0: vector<4xi1>) -> i32 {
    %0 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %1 = "llvm.intr.vector.reduce.or"(%0) : (vector<4xi32>) -> i32
    llvm.return %1 : i32
  }
  llvm.func @reduce_or_zext(%arg0: vector<8xi1>) -> i64 {
    %0 = llvm.zext %arg0 : vector<8xi1> to vector<8xi64>
    %1 = "llvm.intr.vector.reduce.or"(%0) : (vector<8xi64>) -> i64
    llvm.return %1 : i64
  }
  llvm.func @reduce_or_sext_same(%arg0: vector<16xi1>) -> i16 {
    %0 = llvm.sext %arg0 : vector<16xi1> to vector<16xi16>
    %1 = "llvm.intr.vector.reduce.or"(%0) : (vector<16xi16>) -> i16
    llvm.return %1 : i16
  }
  llvm.func @reduce_or_zext_long(%arg0: vector<128xi1>) -> i8 {
    %0 = llvm.sext %arg0 : vector<128xi1> to vector<128xi8>
    %1 = "llvm.intr.vector.reduce.or"(%0) : (vector<128xi8>) -> i8
    llvm.return %1 : i8
  }
  llvm.func @reduce_or_zext_long_external_use(%arg0: vector<128xi1>) -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @glob : !llvm.ptr
    %2 = llvm.sext %arg0 : vector<128xi1> to vector<128xi8>
    %3 = "llvm.intr.vector.reduce.or"(%2) : (vector<128xi8>) -> i8
    %4 = llvm.extractelement %2[%0 : i32] : vector<128xi8>
    llvm.store %4, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return %3 : i8
  }
  llvm.func @reduce_or_zext_external_use(%arg0: vector<8xi1>) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @glob1 : !llvm.ptr
    %2 = llvm.zext %arg0 : vector<8xi1> to vector<8xi64>
    %3 = "llvm.intr.vector.reduce.or"(%2) : (vector<8xi64>) -> i64
    %4 = llvm.extractelement %2[%0 : i32] : vector<8xi64>
    llvm.store %4, %1 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %3 : i64
  }
  llvm.func @reduce_or_pointer_cast(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> vector<8xi8>
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<8xi8>
    %3 = llvm.icmp "ne" %1, %2 : vector<8xi8>
    %4 = "llvm.intr.vector.reduce.or"(%3) : (vector<8xi1>) -> i1
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }
  llvm.func @reduce_or_pointer_cast_wide(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>
    %2 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>
    %3 = llvm.icmp "ne" %1, %2 : vector<8xi16>
    %4 = "llvm.intr.vector.reduce.or"(%3) : (vector<8xi1>) -> i1
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }
  llvm.func @reduce_or_pointer_cast_ne(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> vector<8xi8>
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<8xi8>
    %2 = llvm.icmp "ne" %0, %1 : vector<8xi8>
    %3 = "llvm.intr.vector.reduce.or"(%2) : (vector<8xi1>) -> i1
    llvm.return %3 : i1
  }
  llvm.func @reduce_or_pointer_cast_ne_wide(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>
    %1 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>
    %2 = llvm.icmp "ne" %0, %1 : vector<8xi16>
    %3 = "llvm.intr.vector.reduce.or"(%2) : (vector<8xi1>) -> i1
    llvm.return %3 : i1
  }
}
