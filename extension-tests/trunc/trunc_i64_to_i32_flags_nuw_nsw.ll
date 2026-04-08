
define i32 @main(i64 %0) {
  %2 = trunc nuw nsw i64 %0 to i32
  ret i32 %2
}
