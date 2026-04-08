
define i16 @main(i64 %0) {
  %2 = trunc nuw nsw i64 %0 to i16
  ret i16 %2
}
