module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @key("key\00") {addr_space = 0 : i32, alignment = 1 : i64}
  llvm.mlir.global external constant @abc("abc\00de\00\00") {addr_space = 0 : i32, alignment = 1 : i64}
  llvm.func @use(i32)
  llvm.func @strcmp_memcmp(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp(!llvm.ptr {llvm.nocapture}, !llvm.ptr {llvm.nocapture}) -> i32
  llvm.func @strcmp_memcmp2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp3(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp4(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp5(%arg0: !llvm.ptr {llvm.dereferenceable = 5 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp6(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "sgt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp7(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "slt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp8(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp9(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("abc\00de\00\00") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @abc : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strncmp_memcmp(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp(!llvm.ptr {llvm.nocapture}, !llvm.ptr {llvm.nocapture}, i64) -> i32
  llvm.func @strncmp_memcmp2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(11 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "ne" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp3(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(11 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp4(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp5(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp6(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "ne" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp7(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp8(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp9(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "sgt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp10(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "slt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp11(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp12(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp13(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("abc\00de\00\00") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @abc : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp14(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("abc\00de\00\00") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @abc : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strcmp_memcmp_bad(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "sgt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp_bad2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "slt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp_bad3(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %2 : i32
  }
  llvm.func @strcmp_memcmp_bad4(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp_bad5(%arg0: !llvm.ptr {llvm.dereferenceable = 3 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp_bad6(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strcmp(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }
  llvm.func @strcmp_memcmp_bad7(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp_memcmp_bad8(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %2 : i32
  }
  llvm.func @strncmp_memcmp_bad(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "sgt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp_bad1(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "slt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp_bad2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}, %arg1: i64) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.call @strncmp(%1, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %4 = llvm.icmp "slt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @strncmp_memcmp_bad3(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @strncmp_memcmp_bad4(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %3 : i32
  }
  llvm.func @strcmp_memcmp_msan(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["sanitize_memory"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @memcmp(!llvm.ptr {llvm.nocapture}, !llvm.ptr {llvm.nocapture}, i64) -> i32
}
