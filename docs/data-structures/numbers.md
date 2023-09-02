# Numbers

<style>
  input[type=number] {
    font-family: var(--md-text-font-family);
    padding: 0.5rem;
  }
</style>

$$
\begin{eqnarray} 
700_D &=& 700 + 30 + 5      \nonumber \\
&=& 7 \cdot 10^2 + 3 \cdot 10^1 + 5 \cdot 10^0 \nonumber
\end{eqnarray}
$$

the idea of this _positional notation_ remains same for other bases as well.

## Unsigned integer

Can represent integers in interval $[0, 2^n-1]$; the value of an unsigned integer is the magnitude of all its _n_ bits.

$$ \\
\displaylines{ 0_D = 0000 \ 0000_2 \hspace{0.5cm} \ 1_D = 0000 \ 0001_2 \hspace{0.5cm} \ \ 2_D = 0000 \ 0010_2 \\ 8_D = 0000 \ 1000_2 \hspace{0.5cm} 16_D = 0001 \ 0000_2 \hspace{0.5cm} 31_D = 0001 \ 1111_2 }
$$

## Signed integer

### a) Naive approach

Use the MSB for sign, and the remaining `n-1` bits for magnitude. Leads to two different representation for 0, e.g. `0000` and `1000` in 4-bit version. Arithmetics needs to account for MSB in a special manner.

### b) 2's complement approach

Can represent integers in interval $[-2^{n-1}, 2^{n-1}-1]$. MSB reserved for sign as before. With the remaining $n-1$ bits as $a$, we get:

$$
absolute \ value= 
\begin{cases}
    a,& \text{if positive}\\
   \overline{a} + 1,              & \text{otherwise}
\end{cases}
$$

i.e. complement the remaining bit and add one (ignore overflow) to get the magnitude of a negative number.

<input id="complement-2-demo-input" type="number" value="0"/> <code id="complement-2-demo-output" style="margin-left: 2rem; user-select: all;"></code>

<script>
  function binaryFormat(number) {
    let out = "";
    for (i = 0; i < 32; i++) {
      if (i > 0 && i % 8 == 0) out = ' ' + out;
      out = (number & 1) + out;
      number = number >>> 1; // zero-filling right shift
    }
    return out;
  }
  function showBinary() {
    const input = document.getElementById('complement-2-demo-input');
    document.getElementById('complement-2-demo-output').innerText = binaryFormat(input.value);
  }
  showBinary();
  document.addEventListener("change", showBinary);
</script>

decimal | 8-bit signed binary | decimal | 8-bit signed binary
-------:|--------------------:|--------:|--------------------:
1       | `0000 0001`         | -1      |  `1111 1111`
2       | `0000 0010`         | -2      |  `1111 1110`
3       | `0000 0011`         | -3      |  `1111 1101`
4       | `0000 0100`         | -4      |  `1111 1100`


advantage of 2's complement representation is that there is no more redundant mapping to 0 and arithmetics works without having to account for sign bit. Take for example the summations below:

```
(+1) 0000 0001     (+1) 0000 0001     (-1) 1111 1111
(-4) 1111 1100     (+4) 0000 0100     (-2) 1111 1110
--------------     --------------     --------------
(-3) 1111 1101     (+5) 0000 0101     (-3) 1111 1101 (last carry of 1 overflown)
```

## Floating point

$$
\text{number} = -1^{\text{sign}} \cdot (1 + \text{mantissa}) \cdot 2^{\text{exponent}}
$$

Different levels of precisions are available for floating point numbers, but we are interested in single precision (32 bits) and double precision (64 bits).

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 698.4286193847656 161.53573608398438" width="698.4286193847656" height="161.53573608398438">
  <g stroke-linecap="round" transform="translate(103.28555297851562 49.21429443359375) rotate(0 292.571533203125 30)"><path d="M15 0 M15 0 C227.64 -1.35, 439.11 -1.55, 570.14 0 M15 0 C228.8 -0.26, 443.24 -0.53, 570.14 0 M570.14 0 C579.72 -0.98, 586.87 4.13, 585.14 15 M570.14 0 C578.41 1.56, 585.01 7.18, 585.14 15 M585.14 15 C583.48 21.35, 587.14 26.87, 585.14 45 M585.14 15 C585 24.79, 584.83 34.91, 585.14 45 M585.14 45 C583.35 55.94, 578.38 61.04, 570.14 60 M585.14 45 C587.24 53.86, 579.12 58.36, 570.14 60 M570.14 60 C358.49 61.74, 145.22 62.9, 15 60 M570.14 60 C414.93 59.42, 259.68 59.56, 15 60 M15 60 C6.71 58.2, 0.14 56.56, 0 45 M15 60 C2.71 60.91, -1.48 53.93, 0 45 M0 45 C0.53 37.19, -1.96 24.56, 0 15 M0 45 C0.42 36.47, 0.45 26.85, 0 15 M0 15 C-1.78 5.24, 5.62 1.43, 15 0 M0 15 C-1.11 5.1, 6.26 0.86, 15 0" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g stroke-linecap="round"><g transform="translate(134.7142333984375 49.78570556640625) rotate(0 0.41589441061950083 29.83358120804654)"><path d="M0.82 -0.18 C1.04 9.73, 0.94 49.49, 1.05 59.45 M-0.21 -1.33 C-0.08 8.8, 0.12 50.61, 0.35 60.99" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(304.1784973144531 49.21430969238281) rotate(0 -0.0888364188373032 29.468555139526714)"><path d="M0.71 -0.15 C0.62 9.68, -0.83 49.22, -1.14 59.14 M-0.38 -1.28 C-0.06 8.66, 0.72 49.96, 0.97 60.22" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(456.74993896484375 65.78573608398438) rotate(0 43.03996276855469 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">mantissa</text></g><g transform="translate(179.60702514648438 66.357177734375) rotate(0 42.01995849609375 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">exponent</text></g><g mask="url(#mask-wGl4oJGmAkWGyliLuZ0uX)" stroke-linecap="round"><g transform="translate(313.3214111328125 23.500015258789062) rotate(0 180.30399046117438 0.26399429254233553)"><path d="M-0.19 -1.09 C59.65 -0.83, 299.93 1.28, 360.16 1.61 M-1.74 0.96 C58.36 0.85, 302 -0.46, 362.35 -0.26" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(313.3214111328125 23.500015258789062) rotate(0 180.30399046117438 0.26399429254233553)"><path d="M26.27 -12.78 C17.74 -7.2, 5.48 -2.62, 1.5 -1.49 M27.18 -10.5 C18.79 -8.62, 9.89 -5.34, 0.17 -0.25" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(313.3214111328125 23.500015258789062) rotate(0 180.30399046117438 0.26399429254233553)"><path d="M26.12 7.74 C17.64 5.24, 5.43 1.75, 1.5 -1.49 M27.02 10.02 C18.77 5.34, 9.92 2.07, 0.17 -0.25" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(313.3214111328125 23.500015258789062) rotate(0 180.30399046117438 0.26399429254233553)"><path d="M332.37 8.4 C346.05 6.05, 356 2.62, 364.04 -0.67 M333.27 10.68 C343 5.7, 352.13 2.48, 362.7 0.57" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(313.3214111328125 23.500015258789062) rotate(0 180.30399046117438 0.26399429254233553)"><path d="M332.33 -12.12 C346.04 -6.39, 356 -1.74, 364.04 -0.67 M333.24 -9.84 C342.89 -8.27, 352.03 -4.93, 362.7 0.57" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask id="mask-wGl4oJGmAkWGyliLuZ0uX"><rect x="0" y="0" fill="#fff" width="774.4643249511719" height="124.64285278320312"></rect><rect x="456.61289978027344" y="11.571434020996094" fill="#000" width="74.5599365234375" height="25" opacity="1"></rect></mask><g transform="translate(456.61289978027344 11.571434020996094) rotate(0 37.01250181371344 12.192575530335304)"><text x="37.27996826171875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">23 bits</text></g><g mask="url(#mask-AUZ1g75hNN_Un3txNTpeZ)" stroke-linecap="round"><g transform="translate(139.73156251734127 23.07146453857422) rotate(0 78.75054824800227 -0.6509063854177413)"><path d="M-0.97 0.23 C25.06 0.08, 129.75 0.22, 156.24 0.03 M0.71 -0.7 C27.12 -1.23, 132.33 -1.68, 158.48 -1.48" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(139.73156251734127 23.07146453857422) rotate(0 78.75054824800227 -0.6509063854177413)"><path d="M27.58 -11.57 C20.71 -5.86, 10.56 -3.16, -2.54 0.23 M26.52 -9.62 C16.32 -6.23, 5.54 -3.33, -1.72 -0.08" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(139.73156251734127 23.07146453857422) rotate(0 78.75054824800227 -0.6509063854177413)"><path d="M27.6 8.96 C20.57 8.45, 10.42 4.94, -2.54 0.23 M26.54 10.9 C16.37 6.66, 5.58 1.93, -1.72 -0.08" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(139.73156251734127 23.07146453857422) rotate(0 78.75054824800227 -0.6509063854177413)"><path d="M130.66 7.26 C140.68 7.21, 147.59 3.7, 156.91 -1.48 M129.59 9.2 C140.4 4.9, 150.58 0.16, 157.73 -1.78" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(139.73156251734127 23.07146453857422) rotate(0 78.75054824800227 -0.6509063854177413)"><path d="M130.67 -13.26 C140.85 -7.1, 147.75 -4.41, 156.91 -1.48 M129.6 -11.32 C140.37 -7.99, 150.55 -5.1, 157.73 -1.78" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask id="mask-AUZ1g75hNN_Un3txNTpeZ"><rect x="0" y="0" fill="#fff" width="396.8743542653881" height="124.21439361572266"></rect><rect x="187.30298890894278" y="10" fill="#000" width="61.99993896484375" height="25" opacity="1"></rect></mask><g transform="translate(187.30298890894278 10) rotate(0 31.17912185640077 12.420558153156477)"><text x="30.999969482421875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">8 bits</text></g><g mask="url(#mask-CEHyzBivgwzJed6rDAmcK)" stroke-linecap="round"><g transform="translate(313.3921982352063 136.89282608032227) rotate(0 180.9628561396152 -0.3534857487119609)"><path d="M-0.37 -0.37 C59.94 -0.39, 301.95 -0.15, 362.29 -0.03 M1.64 -1.6 C61.85 -1.54, 302.02 0.41, 361.95 0.9" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(313.3921982352063 136.89282608032227) rotate(0 180.9628561396152 -0.3534857487119609)"><path d="M27.22 -8.69 C16.38 -6.31, 7.55 -3.85, -1.34 0.5 M27.82 -10.63 C17.18 -6.87, 8.19 -3.9, -0.73 -0.14" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(313.3921982352063 136.89282608032227) rotate(0 180.9628561396152 -0.3534857487119609)"><path d="M27.21 11.83 C16.35 7.29, 7.52 2.83, -1.34 0.5 M27.81 9.89 C16.99 6.42, 8.01 2.18, -0.73 -0.14" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(313.3921982352063 136.89282608032227) rotate(0 180.9628561396152 -0.3534857487119609)"><path d="M333.06 12.85 C341.25 8.56, 351.47 4.18, 360.97 1.77 M333.67 10.9 C342.73 7.85, 353.63 3.69, 361.58 1.12" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(313.3921982352063 136.89282608032227) rotate(0 180.9628561396152 -0.3534857487119609)"><path d="M333.23 -7.67 C341.38 -5.04, 351.54 -2.5, 360.97 1.77 M333.83 -9.62 C343.01 -5.45, 353.85 -2.38, 361.58 1.12" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask id="mask-CEHyzBivgwzJed6rDAmcK"><rect x="0" y="0" fill="#fff" width="774.5351120535656" height="238.03566360473633"></rect><rect x="457.31369176547963" y="124.9642448425293" fill="#000" width="73.2999267578125" height="25" opacity="1"></rect></mask><g transform="translate(457.3136917654797 124.9642448425293) rotate(0 37.04136260934183 11.575095489081008)"><text x="36.64996337890625" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">52 bits</text></g><g mask="url(#mask-mj7j20lK2f_GPdtuwMTeR)" stroke-linecap="round"><g transform="translate(139.80234961973508 136.46427536010742) rotate(0 78.24659614116882 -0.13377972758479473)"><path d="M0.56 -0.76 C26.55 -0.86, 130.92 -1.77, 157.1 -1.73 M-0.61 1.45 C25.12 1.61, 129.84 0.16, 156.13 -0.5" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(139.80234961973508 136.46427536010742) rotate(0 78.24659614116882 -0.13377972758479473)"><path d="M27.41 -11.28 C16.47 -6.08, 7.36 -1.1, -0.58 -0.78 M28.81 -11.56 C19.88 -7.81, 11.33 -5.25, 1.55 -1.74" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(139.80234961973508 136.46427536010742) rotate(0 78.24659614116882 -0.13377972758479473)"><path d="M27.55 9.24 C16.75 6.32, 7.59 3.18, -0.58 -0.78 M28.95 8.96 C20.14 6.62, 11.56 3.08, 1.55 -1.74" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(139.80234961973508 136.46427536010742) rotate(0 78.24659614116882 -0.13377972758479473)"><path d="M126.86 10.21 C138.34 6.75, 151.44 3.32, 154.99 -0.52 M128.26 9.94 C136.18 7.22, 144.3 3.47, 157.12 -1.48" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(139.80234961973508 136.46427536010742) rotate(0 78.24659614116882 -0.13377972758479473)"><path d="M126.49 -10.31 C137.91 -5.65, 151.16 -0.96, 154.99 -0.52 M127.89 -10.58 C135.74 -7.21, 143.98 -4.86, 157.12 -1.48" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask id="mask-mj7j20lK2f_GPdtuwMTeR"><rect x="0" y="0" fill="#fff" width="396.9451413677819" height="237.60720443725586"></rect><rect x="189.6037717388757" y="123.3928108215332" fill="#000" width="57.539947509765625" height="25" opacity="1"></rect></mask><g transform="translate(189.6037717388757 123.3928108215332) rotate(0 28.445174022028198 12.937684810989424)"><text x="28.769973754882812" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">11 bits</text></g><g transform="translate(10 126.53573608398438) rotate(0 35.21996307373047 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">sign bit</text></g><g stroke-linecap="round"><g transform="translate(32.285675048828125 115.67861938476562) rotate(0 34.41544569320976 -19.1382019634638)"><path d="M-0.5 0.1 C2.73 -5.23, 7.52 -26.72, 19.16 -32.78 C30.8 -38.83, 60.79 -35.42, 69.33 -36.22 M1.44 -0.9 C4.51 -5.96, 6.92 -25.1, 18.07 -31.35 C29.23 -37.59, 59.54 -37.44, 68.36 -38.37" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(32.285675048828125 115.67861938476562) rotate(0 34.41544569320976 -19.1382019634638)"><path d="M45.37 -28.81 C51.45 -31.73, 58.9 -32.74, 66.76 -39.23 M45.96 -28.82 C54.45 -33.29, 63.88 -36.79, 67.59 -37.74" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(32.285675048828125 115.67861938476562) rotate(0 34.41544569320976 -19.1382019634638)"><path d="M44.35 -46.03 C50.6 -44.1, 58.33 -40.26, 66.76 -39.23 M44.94 -46.04 C53.88 -43.69, 63.72 -40.36, 67.59 -37.74" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask></svg>

IEEE 754 adds _bias_ to the exponent, 127 for 32 bit and 1023 for 64 bit. This bias helps the hardware to compare floating point numbers against 2's complement integers. An example to illustrate this:

$$
0.15625_{10} = 0.00101_2 = 1.01_2 \times 2^{-3}
$$

So we set:

- sign bit to `0` for positive number.
- set the exponent as $-3 + bias = 124$.
- set fraction as `0.0100...`.

Some special values:

- $\hspace{0.5cm} \infty$ - `0 | 1111 1111 | 0000 0000 0000 0000 0000 000` 
- $\hspace{0.2cm} -\infty$ - `1 | 1111 1111 | 0000 0000 0000 0000 0000 000` 
- $NaN$ - `x | 1111 1111 | ???? ???? ???? ???? ???? ???` sign bit can be anything, and mantissa must not be all `0`  


## Sources
- <a href="https://www3.ntu.edu.sg/home/ehchua/programming/java/DataRepresentation.html" target="_blank">yet another insignificant programming notes... :octicons-tab-external-16:</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number" target="_blank">Number - MDN :octicons-tab-external-16:</a>
- <a href="https://en.wikipedia.org/wiki/IEEE_754-1985" target="_blank">IEEE 754 Wikipedia :octicons-tab-external-16:</a>