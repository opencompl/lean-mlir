
define i16 @main(i42 %0) {
  %2 = trunc nuw nsw i42 %0 to i16
  ret i16 %2
}
