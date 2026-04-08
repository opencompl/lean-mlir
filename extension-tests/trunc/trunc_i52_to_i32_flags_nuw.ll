
define i32 @main(i52 %0) {
  %2 = trunc nuw i52 %0 to i32
  ret i32 %2
}
