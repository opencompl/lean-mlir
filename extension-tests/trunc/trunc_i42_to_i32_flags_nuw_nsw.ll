
define i32 @main(i42 %0) {
  %2 = trunc nuw nsw i42 %0 to i32
  ret i32 %2
}
