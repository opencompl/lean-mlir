module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @pr21445_data() {addr_space = 0 : i32} : i32
  llvm.func @use.i64(i64)
  llvm.func @pr4917_1(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.mul %1, %2  : i64
    %4 = llvm.icmp "ugt" %3, %0 : i64
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @pr4917_1a(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.mul %1, %2  : i64
    %4 = llvm.icmp "uge" %3, %0 : i64
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @pr4917_2(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(111 : i32) : i32
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.trunc %4 : i64 to i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @pr4917_3(%arg0: i32, %arg1: i32) -> i64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(111 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.select %5, %4, %1 : i1, i64
    llvm.return %6 : i64
  }
  llvm.func @pr4917_4(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.mul %1, %2  : i64
    %4 = llvm.icmp "ule" %3, %0 : i64
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @pr4917_4a(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.mul %1, %2  : i64
    %4 = llvm.icmp "ult" %3, %0 : i64
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @pr4917_5(%arg0: i32, %arg1: i8) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(111 : i32) : i32
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i8 to i64
    %4 = llvm.mul %2, %3  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.trunc %4 : i64 to i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @pr4918_1(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.mul %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @pr4918_2(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.mul %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.icmp "eq" %2, %4 : i64
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @pr4918_3(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.mul %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.icmp "ne" %4, %2 : i64
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @pr20113(%arg0: vector<4xi16>, %arg1: vector<4xi16>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.zext %arg0 : vector<4xi16> to vector<4xi32>
    %3 = llvm.zext %arg1 : vector<4xi16> to vector<4xi32>
    %4 = llvm.mul %3, %2  : vector<4xi32>
    %5 = llvm.icmp "sge" %4, %1 : vector<4xi32>
    %6 = llvm.sext %5 : vector<4xi1> to vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }
  llvm.func @pr21445(%arg0: i8) -> i1 {
    %0 = llvm.mlir.addressof @pr21445_data : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.zext %1 : i8 to i32
    %5 = llvm.mul %3, %4  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.icmp "ne" %5, %6 : i32
    llvm.return %7 : i1
  }
  llvm.func @mul_may_overflow(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i34) : i34
    %1 = llvm.zext %arg0 : i32 to i34
    %2 = llvm.zext %arg1 : i32 to i34
    %3 = llvm.mul %1, %2  : i34
    %4 = llvm.icmp "ule" %3, %0 : i34
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @mul_known_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i34) : i34
    %1 = llvm.zext %arg0 : i32 to i34
    %2 = llvm.zext %arg1 : i32 to i34
    %3 = llvm.mul %1, %2 overflow<nuw>  : i34
    %4 = llvm.icmp "ule" %3, %0 : i34
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @extra_and_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.mul %1, %2  : i64
    %4 = llvm.icmp "ugt" %3, %0 : i64
    %5 = llvm.and %3, %0  : i64
    llvm.call @use.i64(%5) : (i64) -> ()
    %6 = llvm.zext %4 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @extra_and_use_small_mask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(268435455 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.and %4, %1  : i64
    llvm.call @use.i64(%6) : (i64) -> ()
    %7 = llvm.zext %5 : i1 to i32
    llvm.return %7 : i32
  }
  llvm.func @extra_and_use_mask_too_large(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(68719476735 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    %5 = llvm.icmp "ugt" %4, %0 : i64
    %6 = llvm.and %4, %1  : i64
    llvm.call @use.i64(%6) : (i64) -> ()
    %7 = llvm.zext %5 : i1 to i32
    llvm.return %7 : i32
  }
}
