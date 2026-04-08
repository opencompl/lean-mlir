
define i16 @main(i50 %0) {
  %2 = trunc nuw nsw i50 %0 to i16
  ret i16 %2
}
