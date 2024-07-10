module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @".str"(dense<0> : tensor<1xi8>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<1 x i8>
  llvm.mlir.global external constant @".str1"("hello, world\00") {addr_space = 0 : i32, alignment = 1 : i64}
  llvm.mlir.global external constant @".str2"("foo\00") {addr_space = 0 : i32, alignment = 1 : i64}
  llvm.mlir.global external constant @".str3"("bar\00") {addr_space = 0 : i32, alignment = 1 : i64}
  llvm.mlir.global external constant @".str4"("123.4\00") {addr_space = 0 : i32, alignment = 1 : i64}
  llvm.mlir.global external constant @".str5"("1234\00") {addr_space = 0 : i32, alignment = 1 : i64}
  llvm.mlir.global external constant @empty(dense<0> : tensor<1xi8>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<1 x i8>
  llvm.func @ceil(f64) -> f64
  llvm.func @copysign(f64, f64) -> f64
  llvm.func @cos(f64) -> f64
  llvm.func @fabs(f64) -> f64
  llvm.func @floor(f64) -> f64
  llvm.func @strcat(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @strncat(!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
  llvm.func @strchr(!llvm.ptr, i32) -> !llvm.ptr
  llvm.func @strrchr(!llvm.ptr, i32) -> !llvm.ptr
  llvm.func @strcmp(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @strncmp(!llvm.ptr, !llvm.ptr, i64) -> i32
  llvm.func @strcpy(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @stpcpy(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @strncpy(!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
  llvm.func @strlen(!llvm.ptr) -> i64
  llvm.func @strpbrk(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @strspn(!llvm.ptr, !llvm.ptr) -> i64
  llvm.func @strtod(!llvm.ptr, !llvm.ptr) -> f64
  llvm.func @strtof(!llvm.ptr, !llvm.ptr) -> f32
  llvm.func @strtold(!llvm.ptr, !llvm.ptr) -> f80
  llvm.func @strtol(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @strtoll(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @strtoul(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @strtoull(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @strcspn(!llvm.ptr, !llvm.ptr) -> i64
  llvm.func @abs(i32) -> i32
  llvm.func @ffs(i32) -> i32
  llvm.func @ffsl(i64) -> i32
  llvm.func @ffsll(i64) -> i32
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @isascii(i32) -> i32
  llvm.func @isdigit(i32) -> i32
  llvm.func @toascii(i32) -> i32
  llvm.func @labs(i64) -> i64
  llvm.func @llabs(i64) -> i64
  llvm.func @printf(!llvm.ptr) -> i32
  llvm.func @sprintf(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @t1(%arg0: f64) -> f64 {
    %0 = llvm.call @ceil(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }
  llvm.func @t2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @copysign(%arg0, %arg1) : (f64, f64) -> f64
    llvm.return %0 : f64
  }
  llvm.func @t3(%arg0: f64) -> f64 {
    %0 = llvm.call @cos(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }
  llvm.func @t4(%arg0: f64) -> f64 {
    %0 = llvm.call @fabs(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }
  llvm.func @t5(%arg0: f64) -> f64 {
    %0 = llvm.call @floor(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }
  llvm.func @t6(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @strcat(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @t7(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.call @strncat(%arg0, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @t8() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.call @strchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @t9() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.call @strrchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @t10() -> i32 {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.mlir.constant("bar\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @".str3" : !llvm.ptr
    %4 = llvm.call @strcmp(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }
  llvm.func @t11() -> i32 {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.mlir.constant("bar\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @".str3" : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.call @strncmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %5 : i32
  }
  llvm.func @t12(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.call @strcpy(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @t13(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.call @stpcpy(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @t14(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @t15() -> i64 {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.call @strlen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }
  llvm.func @t16(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strpbrk(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @t17(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strspn(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %3 : i64
  }
  llvm.func @t18(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant("123.4\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str4" : !llvm.ptr
    %2 = llvm.call @strtod(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> f64
    llvm.return %2 : f64
  }
  llvm.func @t19(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant("123.4\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str4" : !llvm.ptr
    %2 = llvm.call @strtof(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> f32
    llvm.return %2 : f32
  }
  llvm.func @t20(%arg0: !llvm.ptr) -> f80 {
    %0 = llvm.mlir.constant("123.4\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str4" : !llvm.ptr
    %2 = llvm.call @strtold(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> f80
    llvm.return %2 : f80
  }
  llvm.func @t21(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtol(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }
  llvm.func @t22(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtoll(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }
  llvm.func @t23(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtoul(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }
  llvm.func @t24(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtoull(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }
  llvm.func @t25(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @strcspn(%2, %arg0) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %3 : i64
  }
  llvm.func @t26(%arg0: i32) -> i32 {
    %0 = llvm.call @abs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @t27(%arg0: i32) -> i32 {
    %0 = llvm.call @ffs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @t28(%arg0: i64) -> i32 {
    %0 = llvm.call @ffsl(%arg0) : (i64) -> i32
    llvm.return %0 : i32
  }
  llvm.func @t29(%arg0: i64) -> i32 {
    %0 = llvm.call @ffsll(%arg0) : (i64) -> i32
    llvm.return %0 : i32
  }
  llvm.func @t30() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %2 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %3 = llvm.call @fprintf(%0, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @t31(%arg0: i32) -> i32 {
    %0 = llvm.call @isascii(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @t32(%arg0: i32) -> i32 {
    %0 = llvm.call @isdigit(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @t33(%arg0: i32) -> i32 {
    %0 = llvm.call @toascii(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @t34(%arg0: i64) -> i64 {
    %0 = llvm.call @labs(%arg0) : (i64) -> i64
    llvm.return %0 : i64
  }
  llvm.func @t35(%arg0: i64) -> i64 {
    %0 = llvm.call @llabs(%arg0) : (i64) -> i64
    llvm.return %0 : i64
  }
  llvm.func @t36() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @printf(%2) : (!llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @t37(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
}
