export const isbnValid = (isbn) => {
  const regex = /^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$/

  if (regex.test(isbn)) {
    const digits = isbn.replace(/^(?:ISBN(?:-1[03])?:? )?|([^0-9X])/g, "").split("")
    const last_digit = digits.pop()
    let sum = 0
    let check_digit, i

    if (digits.length == 9) {
        // Compute check digit for ISBN-10
        digits.reverse();
        for (i = 0; i < digits.length; i++) {
            sum += (i + 2) * parseInt(digits[i], 10);
        }
        check_digit = 11 - (sum % 11);
        if (check_digit == 10) {
          check_digit = "X";
        } else if (check_digit == 11) {
          check_digit = "0";
        }
    } else {
        // Compute check digit for ISBN-13
        for (i = 0; i < digits.length; i++) {
          sum += (((i % 2) * 2) + 1) * parseInt(digits[i], 10);
        }
        check_digit = 10 - (sum % 10);
        if (check_digit == 10) check_digit = "0";
    }

    return check_digit == last_digit
  } else {
    return false
  }
}
