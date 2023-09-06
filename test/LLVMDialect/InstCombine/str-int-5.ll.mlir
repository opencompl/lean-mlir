module  {
  llvm.mlir.global external constant @ws("\09\0D\0A\0B\0C \00")
  llvm.mlir.global external constant @ws_im123("\09\0D\0A\0B\0C -123\00")
  llvm.mlir.global external constant @ws_ip234("\09\0D\0A\0B\0C +234\00")
  llvm.mlir.global external constant @i32min(" -2147483648\00")
  llvm.mlir.global external constant @i32min_m1(" -2147483649\00")
  llvm.mlir.global external constant @o32min(" +020000000000\00")
  llvm.mlir.global external constant @mo32min(" -020000000000\00")
  llvm.mlir.global external constant @x32min(" +0x80000000\00")
  llvm.mlir.global external constant @mx32min(" +0x80000000\00")
  llvm.mlir.global external constant @i32max(" 2147483647\00")
  llvm.mlir.global external constant @i32max_p1(" 2147483648\00")
  llvm.mlir.global external constant @mX01(" -0X1\00")
  llvm.mlir.global external constant @ui32max(" 4294967295\00")
  llvm.mlir.global external constant @ui32max_p1(" 4294967296\00")
  llvm.mlir.global external constant @i64min(" -9223372036854775808\00")
  llvm.mlir.global external constant @i64min_m1(" -9223372036854775809\00")
  llvm.mlir.global external constant @i64max(" 9223372036854775807\00")
  llvm.mlir.global external constant @i64max_p1(" 9223372036854775808\00")
  llvm.mlir.global external constant @ui64max(" 18446744073709551615\00")
  llvm.mlir.global external constant @x64max(" 0xffffffffffffffff\00")
  llvm.mlir.global external constant @ui64max_p1(" 18446744073709551616\00")
  llvm.mlir.global external @endptr() : !llvm.ptr<i8>
  llvm.func @strtoul(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
  llvm.func @strtoull(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
  llvm.func @fold_strtoul(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %2 = llvm.mlir.addressof @ui32max : !llvm.ptr<array<12 x i8>>
    %3 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %4 = llvm.mlir.addressof @i32max_p1 : !llvm.ptr<array<12 x i8>>
    %5 = llvm.mlir.constant(9 : i32) : i32
    %6 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %7 = llvm.mlir.addressof @mX01 : !llvm.ptr<array<6 x i8>>
    %8 = llvm.mlir.constant(8 : i32) : i32
    %9 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %10 = llvm.mlir.addressof @i32max : !llvm.ptr<array<12 x i8>>
    %11 = llvm.mlir.constant(7 : i32) : i32
    %12 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %13 = llvm.mlir.addressof @mx32min : !llvm.ptr<array<13 x i8>>
    %14 = llvm.mlir.constant(6 : i32) : i32
    %15 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %16 = llvm.mlir.addressof @x32min : !llvm.ptr<array<13 x i8>>
    %17 = llvm.mlir.constant(5 : i32) : i32
    %18 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %19 = llvm.mlir.addressof @mo32min : !llvm.ptr<array<15 x i8>>
    %20 = llvm.mlir.constant(4 : i32) : i32
    %21 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %22 = llvm.mlir.addressof @o32min : !llvm.ptr<array<15 x i8>>
    %23 = llvm.mlir.constant(3 : i32) : i32
    %24 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %25 = llvm.mlir.addressof @i32min : !llvm.ptr<array<13 x i8>>
    %26 = llvm.mlir.constant(2 : i32) : i32
    %27 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %28 = llvm.mlir.addressof @i32min_m1 : !llvm.ptr<array<13 x i8>>
    %29 = llvm.mlir.constant(1 : i32) : i32
    %30 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %31 = llvm.mlir.addressof @ws_ip234 : !llvm.ptr<array<11 x i8>>
    %32 = llvm.mlir.constant(10 : i32) : i32
    %33 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %34 = llvm.mlir.constant(0 : i32) : i32
    %35 = llvm.mlir.addressof @ws_im123 : !llvm.ptr<array<11 x i8>>
    %36 = llvm.getelementptr %35[%34, %34] : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %37 = llvm.call @strtoul(%36, %33, %32) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %38 = llvm.getelementptr %arg0[%34] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %37, %38 : !llvm.ptr<i32>
    %39 = llvm.getelementptr %31[%34, %34] : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %40 = llvm.call @strtoul(%39, %30, %32) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %41 = llvm.getelementptr %arg0[%29] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %40, %41 : !llvm.ptr<i32>
    %42 = llvm.getelementptr %28[%34, %34] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %43 = llvm.call @strtoul(%42, %27, %32) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %44 = llvm.getelementptr %arg0[%26] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %43, %44 : !llvm.ptr<i32>
    %45 = llvm.getelementptr %25[%34, %34] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %46 = llvm.call @strtoul(%45, %24, %32) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %47 = llvm.getelementptr %arg0[%23] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %46, %47 : !llvm.ptr<i32>
    %48 = llvm.getelementptr %22[%34, %34] : (!llvm.ptr<array<15 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %49 = llvm.call @strtoul(%48, %21, %34) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %50 = llvm.getelementptr %arg0[%20] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %49, %50 : !llvm.ptr<i32>
    %51 = llvm.getelementptr %19[%34, %34] : (!llvm.ptr<array<15 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %52 = llvm.call @strtoul(%51, %18, %34) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %53 = llvm.getelementptr %arg0[%17] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %52, %53 : !llvm.ptr<i32>
    %54 = llvm.getelementptr %16[%34, %34] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %55 = llvm.call @strtoul(%54, %15, %34) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %56 = llvm.getelementptr %arg0[%14] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %55, %56 : !llvm.ptr<i32>
    %57 = llvm.getelementptr %13[%34, %34] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %58 = llvm.call @strtoul(%57, %12, %34) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %59 = llvm.getelementptr %arg0[%11] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %55, %59 : !llvm.ptr<i32>
    %60 = llvm.getelementptr %10[%34, %34] : (!llvm.ptr<array<12 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %61 = llvm.call @strtoul(%60, %9, %32) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %62 = llvm.getelementptr %arg0[%8] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %61, %62 : !llvm.ptr<i32>
    %63 = llvm.getelementptr %7[%34, %34] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %64 = llvm.call @strtoul(%63, %6, %34) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %65 = llvm.getelementptr %arg0[%5] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %64, %65 : !llvm.ptr<i32>
    %66 = llvm.getelementptr %4[%34, %34] : (!llvm.ptr<array<12 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %67 = llvm.call @strtoul(%66, %3, %32) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %68 = llvm.getelementptr %arg0[%32] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %67, %68 : !llvm.ptr<i32>
    %69 = llvm.getelementptr %2[%34, %34] : (!llvm.ptr<array<12 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %70 = llvm.call @strtoul(%69, %1, %32) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %71 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %70, %71 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @call_strtoul(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.addressof @ws : !llvm.ptr<array<7 x i8>>
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %6 = llvm.mlir.addressof @ws : !llvm.ptr<array<7 x i8>>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %9 = llvm.mlir.addressof @ui32max_p1 : !llvm.ptr<array<12 x i8>>
    %10 = llvm.mlir.constant(10 : i32) : i32
    %11 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.addressof @i64min_m1 : !llvm.ptr<array<22 x i8>>
    %14 = llvm.getelementptr %13[%12, %12] : (!llvm.ptr<array<22 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %15 = llvm.call @strtoul(%14, %11, %10) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %16 = llvm.getelementptr %arg0[%12] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %15, %16 : !llvm.ptr<i32>
    %17 = llvm.getelementptr %9[%12, %12] : (!llvm.ptr<array<12 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %18 = llvm.call @strtoul(%17, %8, %10) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %19 = llvm.getelementptr %arg0[%7] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %18, %19 : !llvm.ptr<i32>
    %20 = llvm.getelementptr %6[%12, %12] : (!llvm.ptr<array<7 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %21 = llvm.call @strtoul(%20, %5, %10) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %22 = llvm.getelementptr %arg0[%4] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %21, %22 : !llvm.ptr<i32>
    %23 = llvm.getelementptr %3[%12, %2] : (!llvm.ptr<array<7 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %24 = llvm.call @strtoul(%23, %1, %10) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    %25 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %24, %25 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @fold_strtoull(%arg0: !llvm.ptr<i64>) {
    %0 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %1 = llvm.mlir.addressof @x64max : !llvm.ptr<array<20 x i8>>
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %4 = llvm.mlir.addressof @ui64max : !llvm.ptr<array<22 x i8>>
    %5 = llvm.mlir.constant(8 : i32) : i32
    %6 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %7 = llvm.mlir.addressof @i64max_p1 : !llvm.ptr<array<21 x i8>>
    %8 = llvm.mlir.constant(7 : i32) : i32
    %9 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %10 = llvm.mlir.addressof @i64max : !llvm.ptr<array<21 x i8>>
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %13 = llvm.mlir.addressof @i64min : !llvm.ptr<array<22 x i8>>
    %14 = llvm.mlir.constant(5 : i32) : i32
    %15 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %16 = llvm.mlir.addressof @x32min : !llvm.ptr<array<13 x i8>>
    %17 = llvm.mlir.constant(4 : i32) : i32
    %18 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %19 = llvm.mlir.addressof @o32min : !llvm.ptr<array<15 x i8>>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %22 = llvm.mlir.addressof @i32min : !llvm.ptr<array<13 x i8>>
    %23 = llvm.mlir.constant(2 : i32) : i32
    %24 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %25 = llvm.mlir.addressof @i64min_m1 : !llvm.ptr<array<22 x i8>>
    %26 = llvm.mlir.constant(1 : i32) : i32
    %27 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %28 = llvm.mlir.addressof @ws_ip234 : !llvm.ptr<array<11 x i8>>
    %29 = llvm.mlir.constant(10 : i32) : i32
    %30 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %31 = llvm.mlir.constant(0 : i32) : i32
    %32 = llvm.mlir.addressof @ws_im123 : !llvm.ptr<array<11 x i8>>
    %33 = llvm.getelementptr %32[%31, %31] : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %34 = llvm.call @strtoull(%33, %30, %29) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %35 = llvm.getelementptr %arg0[%31] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %34, %35 : !llvm.ptr<i64>
    %36 = llvm.getelementptr %28[%31, %31] : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %37 = llvm.call @strtoull(%36, %27, %29) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %38 = llvm.getelementptr %arg0[%26] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %37, %38 : !llvm.ptr<i64>
    %39 = llvm.getelementptr %25[%31, %31] : (!llvm.ptr<array<22 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %40 = llvm.call @strtoull(%39, %24, %29) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %41 = llvm.getelementptr %arg0[%23] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %40, %41 : !llvm.ptr<i64>
    %42 = llvm.getelementptr %22[%31, %31] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %43 = llvm.call @strtoull(%42, %21, %29) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %44 = llvm.getelementptr %arg0[%20] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %43, %44 : !llvm.ptr<i64>
    %45 = llvm.getelementptr %19[%31, %31] : (!llvm.ptr<array<15 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %46 = llvm.call @strtoull(%45, %18, %31) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %47 = llvm.getelementptr %arg0[%17] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %46, %47 : !llvm.ptr<i64>
    %48 = llvm.getelementptr %16[%31, %31] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %49 = llvm.call @strtoull(%48, %15, %31) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %50 = llvm.getelementptr %arg0[%14] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %49, %50 : !llvm.ptr<i64>
    %51 = llvm.getelementptr %13[%31, %31] : (!llvm.ptr<array<22 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %52 = llvm.call @strtoull(%51, %12, %29) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %53 = llvm.getelementptr %arg0[%11] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %52, %53 : !llvm.ptr<i64>
    %54 = llvm.getelementptr %10[%31, %31] : (!llvm.ptr<array<21 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %55 = llvm.call @strtoull(%54, %9, %29) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %56 = llvm.getelementptr %arg0[%8] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %55, %56 : !llvm.ptr<i64>
    %57 = llvm.getelementptr %7[%31, %31] : (!llvm.ptr<array<21 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %58 = llvm.call @strtoull(%57, %6, %29) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %59 = llvm.getelementptr %arg0[%5] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %58, %59 : !llvm.ptr<i64>
    %60 = llvm.getelementptr %4[%31, %31] : (!llvm.ptr<array<22 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %61 = llvm.call @strtoull(%60, %3, %29) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %62 = llvm.getelementptr %arg0[%2] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %61, %62 : !llvm.ptr<i64>
    %63 = llvm.getelementptr %1[%31, %31] : (!llvm.ptr<array<20 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %64 = llvm.call @strtoull(%63, %0, %31) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %65 = llvm.getelementptr %arg0[%29] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %64, %65 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @call_strtoull(%arg0: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.addressof @ws : !llvm.ptr<array<7 x i8>>
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %6 = llvm.mlir.addressof @ws : !llvm.ptr<array<7 x i8>>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.constant(10 : i32) : i32
    %9 = llvm.mlir.addressof @endptr : !llvm.ptr<ptr<i8>>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.addressof @ui64max_p1 : !llvm.ptr<array<22 x i8>>
    %12 = llvm.getelementptr %11[%10, %10] : (!llvm.ptr<array<22 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %13 = llvm.call @strtoull(%12, %9, %8) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %14 = llvm.getelementptr %arg0[%7] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %13, %14 : !llvm.ptr<i64>
    %15 = llvm.getelementptr %6[%10, %10] : (!llvm.ptr<array<7 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %16 = llvm.call @strtoull(%15, %5, %8) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %17 = llvm.getelementptr %arg0[%4] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %16, %17 : !llvm.ptr<i64>
    %18 = llvm.getelementptr %3[%10, %2] : (!llvm.ptr<array<7 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %19 = llvm.call @strtoull(%18, %1, %8) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %20 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %19, %20 : !llvm.ptr<i64>
    llvm.return
  }
}
