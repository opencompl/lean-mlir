
define i16 @main(i33 %0) {
  %2 = trunc nuw nsw i33 %0 to i16
  ret i16 %2
}
