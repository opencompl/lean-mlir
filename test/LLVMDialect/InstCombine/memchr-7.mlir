module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global private unnamed_addr constant @".str"("abcdefghijklmnopqrstuvwxyz\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.1"("\0D\0A") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.2"("abcdefmno\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.3"("abcijkmno\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.4"("mnabcc\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.func @strchr(!llvm.ptr, i32) -> !llvm.ptr
  llvm.func @memchr(!llvm.ptr, i32, i64) -> !llvm.ptr
  llvm.func @strchr_to_memchr_n_equals_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @memchr_n_equals_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("\0D\0A") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "eq" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @memchr_n_less_than_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(15 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @memchr_n_more_than_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(30 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @memchr_no_zero_cmp(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @memchr_no_zero_cmp2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\0D\0A") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @memchr_n_equals_len_minsize(%arg0: i32) -> (i1 {llvm.zeroext}) attributes {passthrough = ["minsize"]} {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @memchr_n_equals_len2_minsize(%arg0: i32) -> (i1 {llvm.zeroext}) attributes {passthrough = ["minsize"]} {
    %0 = llvm.mlir.constant("\0D\0A") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "eq" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @strchr_to_memchr_2_non_cont_ranges(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("abcdefmno\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @strchr_to_memchr_2_non_cont_ranges_char_dup(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("mnabcc\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @".str.4" : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @strchr_to_memchr_3_non_cont_ranges(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("abcijkmno\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
}
