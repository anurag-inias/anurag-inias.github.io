# Number representation

## 2's complement

([source](https://www3.ntu.edu.sg/home/ehchua/programming/java/DataRepresentation.html))

The method of representing signed integers on computers.

1. A positive number \\(v\\) will have MSB as `0` and remaining \\(n-1\\) bits as \\(v\\).
2. a negative number \\(v\\) will have MSB as `1` and remaining \\(n-1\\) bits as \\(\overline{|v|} + 1\\). That is:
    1. First take the binary representation of \\(|v|\\),
    2. then invert all its bits,
    3. and then add \\(1\\) while ignoring any overflow.


Example: 2's complement for 8-bit integer
```
decimal          binary
 0               0000 0000

 1               0000 0001
 2               0000 0010
 3               0000 0011
 4               0000 0100
 5               0000 0101

-1               1111 1111
-2               1111 1110
-3               1111 1101
-4               1111 1100
-5               1111 1011        
```

[more examples](https://chatgpt.com/share/c452f58a-8eb9-42ab-bcbe-7576739b1ca3)

## Convert to binary

`%b` formatter is supported in most languages to get the number in binary format. However, for negative number it will simply print the binary representation of absolute value with `-` prefix. So we need a custom function:

```golang linenums="1"
// Can't declare method on int directly.
type Int int

func (n Int) ToBinary(bits int) string {
  // we know ahead of times how many runes we need
  b := make([]rune, bits)

  for i := 0; i < bits; i++ {
    if n & (1 << i) == 0 {
      // MSB is at index 0, LSB is at index (length - 1)
      b[bits - 1 - i] = '0'
    } else {
      b[bits - 1 - i] = '1'
    }
  }

  return string(b)
}

func main() {
  for _, v := range []Int{0, 1, 2, 3, 4, 5, -1, -2, -3, -4, -5} {
	fmt.Printf("%2d as %s\n", v, v.ToBinary( /* should be strconv.IntSize */ 8))
  }
}
```

## IEEE 754 

([source](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#number_encoding))

a floating point is represented in 3 parts:

\\[
\text{number} = -1^{sign} \cdot (1 + \text{fraction}) \cdot 2^{exponent}    
\\]

1. **sign** bit, as usual takes 1 bit (msb).
2. **exponent** takes 8 bits in single-precision float and 11 bits in double-precision floating point number.
3. **fraction** takes the remaining 23 / 52 bits.

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 332.6583141371569 158.92105900826286" width="332.6583141371569" height="158.92105900826286">
  <g stroke-linecap="round" transform="translate(19.32494011371938 50.87939791338519) rotate(0 151.66668701171875 25.333328247070312)"><path d="M12.67 0 C70.33 0, 127.99 0, 290.67 0 M12.67 0 C92.91 0, 173.15 0, 290.67 0 M290.67 0 C299.11 0, 303.33 4.22, 303.33 12.67 M290.67 0 C299.11 0, 303.33 4.22, 303.33 12.67 M303.33 12.67 C303.33 22.79, 303.33 32.91, 303.33 38 M303.33 12.67 C303.33 18, 303.33 23.34, 303.33 38 M303.33 38 C303.33 46.44, 299.11 50.67, 290.67 50.67 M303.33 38 C303.33 46.44, 299.11 50.67, 290.67 50.67 M290.67 50.67 C210.6 50.67, 130.54 50.67, 12.67 50.67 M290.67 50.67 C204.17 50.67, 117.68 50.67, 12.67 50.67 M12.67 50.67 C4.22 50.67, 0 46.44, 0 38 M12.67 50.67 C4.22 50.67, 0 46.44, 0 38 M0 38 C0 29.59, 0 21.18, 0 12.67 M0 38 C0 32.89, 0 27.78, 0 12.67 M0 12.67 C0 4.22, 4.22 0, 12.67 0 M0 12.67 C0 4.22, 4.22 0, 12.67 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g stroke-linecap="round"><g transform="translate(61.01440851794092 51.74177768873682) rotate(0 0.05170107645471944 24.052989822960626)"><path d="M0 0 C0.02 8.02, 0.09 40.09, 0.1 48.11 M0 0 C0.02 8.02, 0.09 40.09, 0.1 48.11" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(145.78383488061962 52.12781751366114) rotate(0 0.05170107645471944 24.052989822960626)"><path d="M0 0 C0.02 8.02, 0.09 40.09, 0.1 48.11 M0 0 C0.02 8.02, 0.09 40.09, 0.1 48.11" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(23.959708244265357 56.65770521248197) rotate(0 17.517836009360877 20.293275563210074)"><path d="M0 0 C0 0, 0 0, 0 0 M0 0 C0 0, 0 0, 0 0 M0.13 12.04 C3.35 8.34, 6.57 4.64, 10.63 -0.03 M0.13 12.04 C3.34 8.35, 6.55 4.66, 10.63 -0.03 M0.27 24.08 C8.12 15.05, 15.98 6.01, 21.26 -0.07 M0.27 24.08 C8.33 14.8, 16.4 5.53, 21.26 -0.07 M-0.26 36.88 C7.97 27.42, 16.19 17.95, 31.89 -0.1 M-0.26 36.88 C7.17 28.34, 14.59 19.8, 31.89 -0.1 M7.09 40.62 C17.74 28.37, 28.38 16.13, 35.3 8.16 M7.09 40.62 C13.61 33.11, 20.14 25.61, 35.3 8.16 M17.72 40.58 C21.33 36.43, 24.95 32.27, 35.44 20.2 M17.72 40.58 C21.61 36.11, 25.5 31.64, 35.44 20.2 M28.35 40.55 C30.07 38.57, 31.78 36.6, 35.57 32.25 M28.35 40.55 C30.75 37.79, 33.15 35.02, 35.57 32.25" stroke="#a5d8ff" stroke-width="1" fill="none"></path><path d="M0 0 C8.85 0, 17.69 0, 35.04 0 M0 0 C10.85 0, 21.69 0, 35.04 0 M35.04 0 C35.04 9.19, 35.04 18.39, 35.04 40.59 M35.04 0 C35.04 12.94, 35.04 25.88, 35.04 40.59 M35.04 40.59 C21.32 40.59, 7.61 40.59, 0 40.59 M35.04 40.59 C26.26 40.59, 17.49 40.59, 0 40.59 M0 40.59 C0 31.36, 0 22.13, 0 0 M0 40.59 C0 26.8, 0 13.01, 0 0" fill="none"></path></g><g stroke-linecap="round" transform="translate(63.26175707226082 55.904580054179405) rotate(0 39.97841972204347 20.293275563210074)"><path d="M0 0 C0 0, 0 0, 0 0 M0 0 C0 0, 0 0, 0 0 M0.13 12.04 C3.41 8.27, 6.68 4.51, 10.63 -0.03 M0.13 12.04 C4.32 7.23, 8.5 2.41, 10.63 -0.03 M0.27 24.08 C6.45 16.97, 12.63 9.86, 21.26 -0.07 M0.27 24.08 C8.31 14.83, 16.36 5.57, 21.26 -0.07 M-0.26 36.88 C6.23 29.42, 12.72 21.96, 31.89 -0.1 M-0.26 36.88 C9.65 25.48, 19.55 14.09, 31.89 -0.1 M7.09 40.62 C15.08 31.43, 23.07 22.24, 42.52 -0.14 M7.09 40.62 C14.75 31.8, 22.42 22.99, 42.52 -0.14 M17.72 40.58 C31 25.3, 44.29 10.03, 53.15 -0.17 M17.72 40.58 C30.9 25.42, 44.08 10.27, 53.15 -0.17 M28.35 40.55 C41.61 25.3, 54.86 10.06, 63.78 -0.21 M28.35 40.55 C35.92 31.84, 43.49 23.14, 63.78 -0.21 M38.98 40.51 C48.15 29.97, 57.32 19.42, 74.41 -0.24 M38.98 40.51 C46.32 32.07, 53.66 23.63, 74.41 -0.24 M49.61 40.48 C58.03 30.79, 66.45 21.11, 80.45 5.01 M49.61 40.48 C61.92 26.32, 74.23 12.17, 80.45 5.01 M59.59 41.2 C65.18 34.76, 70.78 28.32, 80.58 17.05 M59.59 41.2 C65.25 34.69, 70.91 28.18, 80.58 17.05 M70.22 41.16 C74.32 36.44, 78.43 31.72, 80.71 29.09 M70.22 41.16 C73.22 37.71, 76.22 34.26, 80.71 29.09" stroke="#ffc9c9" stroke-width="1" fill="none"></path><path d="M0 0 C17.42 0, 34.85 0, 79.96 0 M0 0 C21.39 0, 42.78 0, 79.96 0 M79.96 0 C79.96 8.25, 79.96 16.49, 79.96 40.59 M79.96 0 C79.96 15.09, 79.96 30.18, 79.96 40.59 M79.96 40.59 C61.28 40.59, 42.6 40.59, 0 40.59 M79.96 40.59 C51.17 40.59, 22.38 40.59, 0 40.59 M0 40.59 C0 25.8, 0 11.01, 0 0 M0 40.59 C0 25.72, 0 10.86, 0 0" fill="none"></path></g><g stroke-linecap="round" transform="translate(147.9442437749164 56.05635929606541) rotate(0 85.27899356979799 20.293275563210074)"><path d="M0 0 C0 0, 0 0, 0 0 M0 0 C0 0, 0 0, 0 0 M0.13 12.04 C2.84 8.93, 5.54 5.82, 10.63 -0.03 M0.13 12.04 C2.32 9.52, 4.51 7, 10.63 -0.03 M0.27 24.08 C4.65 19.04, 9.03 13.99, 21.26 -0.07 M0.27 24.08 C6.43 17, 12.58 9.91, 21.26 -0.07 M-0.26 36.88 C8.24 27.1, 16.74 17.33, 31.89 -0.1 M-0.26 36.88 C9.85 25.25, 19.96 13.62, 31.89 -0.1 M7.09 40.62 C20.39 25.32, 33.69 10.02, 42.52 -0.14 M7.09 40.62 C20.27 25.45, 33.45 10.29, 42.52 -0.14 M17.72 40.58 C24.87 32.37, 32.01 24.15, 53.15 -0.17 M17.72 40.58 C26.48 30.51, 35.23 20.44, 53.15 -0.17 M28.35 40.55 C39.28 27.98, 50.2 15.41, 63.78 -0.21 M28.35 40.55 C37.35 30.19, 46.36 19.84, 63.78 -0.21 M38.98 40.51 C48.3 29.79, 57.62 19.07, 74.41 -0.24 M38.98 40.51 C52.96 24.44, 66.93 8.36, 74.41 -0.24 M49.61 40.48 C57.84 31.02, 66.06 21.55, 85.04 -0.28 M49.61 40.48 C57.04 31.94, 64.46 23.4, 85.04 -0.28 M59.59 41.2 C69.63 29.65, 79.67 18.09, 95.67 -0.31 M59.59 41.2 C71.63 27.35, 83.66 13.5, 95.67 -0.31 M70.22 41.16 C83.09 26.35, 95.97 11.54, 106.3 -0.34 M70.22 41.16 C82.75 26.75, 95.28 12.33, 106.3 -0.34 M80.85 41.13 C88.39 32.45, 95.94 23.77, 116.27 0.38 M80.85 41.13 C92.56 27.66, 104.27 14.19, 116.27 0.38 M91.48 41.1 C104.89 25.67, 118.3 10.25, 126.91 0.34 M91.48 41.1 C102.66 28.23, 113.84 15.37, 126.91 0.34 M102.11 41.06 C111.62 30.11, 121.14 19.17, 137.54 0.31 M102.11 41.06 C110.62 31.27, 119.14 21.47, 137.54 0.31 M112.74 41.03 C126.17 25.58, 139.6 10.13, 148.17 0.27 M112.74 41.03 C119.87 32.82, 127.01 24.61, 148.17 0.27 M123.37 40.99 C136.93 25.39, 150.48 9.8, 158.8 0.24 M123.37 40.99 C130.71 32.55, 138.05 24.1, 158.8 0.24 M134 40.96 C145.57 27.65, 157.14 14.34, 169.43 0.2 M134 40.96 C142.18 31.54, 150.37 22.12, 169.43 0.2 M144.63 40.92 C153.25 31, 161.88 21.08, 170.87 10.73 M144.63 40.92 C154.19 29.92, 163.75 18.92, 170.87 10.73 M155.26 40.89 C161.16 34.1, 167.06 27.31, 171 22.78 M155.26 40.89 C159.5 36, 163.75 31.12, 171 22.78 M165.89 40.85 C166.88 39.71, 167.87 38.57, 170.48 35.57 M165.89 40.85 C167.42 39.09, 168.96 37.32, 170.48 35.57" stroke="#b2f2bb" stroke-width="1" fill="none"></path><path d="M0 0 C60.69 0, 121.37 0, 170.56 0 M0 0 C45.1 0, 90.2 0, 170.56 0 M170.56 0 C170.56 9.74, 170.56 19.47, 170.56 40.59 M170.56 0 C170.56 11.01, 170.56 22.01, 170.56 40.59 M170.56 40.59 C135.01 40.59, 99.46 40.59, 0 40.59 M170.56 40.59 C125.89 40.59, 81.23 40.59, 0 40.59 M0 40.59 C0 27.46, 0 14.34, 0 0 M0 40.59 C0 31.22, 0 21.85, 0 0" fill="none"></path></g><g transform="translate(17.832506144533454 122.55878808741497) rotate(0 17.29998016357422 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">sign</text></g><g transform="translate(65.37928854777681 123.92105900826286) rotate(0 42.01995849609372 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">exponent</text></g><g transform="translate(196.1383093825894 122.46796659484826) rotate(0 38.89996337890625 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">fraction</text></g><g transform="translate(10 12.615534416235931) rotate(0 19.739974975585938 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1-bit</text></g><g transform="translate(63.90849615737909 11.743676307527949) rotate(0 40.52996063232419 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">8/11-bits</text></g><g transform="translate(185.4224533639993 10) rotate(0 54.68994903564453 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">23/52-bits</text></g></svg>