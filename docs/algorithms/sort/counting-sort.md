# Counting Sort

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<style>
.md-logo img {
  content: url('/algorithms/sort/sort-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/sort/sort-dark.svg');
}
</style>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
</script>

## Intro

This works just as how it sounds. If our input is in a known range, we can count all distinct instances and recreate the sorted list.

## Example

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 299.6419230076003 275.3079762545075" width="400px">
  <g stroke-linecap="round" transform="translate(43.24609382328708 10.138447734519787) rotate(0 98.51093180677475 22.115234375)"><path d="M11.06 0 C61.87 0, 112.69 0, 185.96 0 M11.06 0 C78.1 0, 145.14 0, 185.96 0 M185.96 0 C193.34 0, 197.02 3.69, 197.02 11.06 M185.96 0 C193.34 0, 197.02 3.69, 197.02 11.06 M197.02 11.06 C197.02 17.44, 197.02 23.82, 197.02 33.17 M197.02 11.06 C197.02 18.58, 197.02 26.11, 197.02 33.17 M197.02 33.17 C197.02 40.54, 193.34 44.23, 185.96 44.23 M197.02 33.17 C197.02 40.54, 193.34 44.23, 185.96 44.23 M185.96 44.23 C130.59 44.23, 75.21 44.23, 11.06 44.23 M185.96 44.23 C130.62 44.23, 75.27 44.23, 11.06 44.23 M11.06 44.23 C3.69 44.23, 0 40.54, 0 33.17 M11.06 44.23 C3.69 44.23, 0 40.54, 0 33.17 M0 33.17 C0 28.05, 0 22.92, 0 11.06 M0 33.17 C0 24.43, 0 15.68, 0 11.06 M0 11.06 C0 3.69, 3.69 0, 11.06 0 M0 11.06 C0 3.69, 3.69 0, 11.06 0" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g><g stroke-linecap="round"><g transform="translate(74.28515632328708 10.493916484519787) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(105.00425198853486 11.002427017870815) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(53.56109395030114 21.795645720346613) rotate(0 6.079994201660156 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g stroke-linecap="round"><g transform="translate(133.93457584361204 10) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(160.47988372004238 10.974415085235762) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(184.50811936397497 10.206087790101265) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(213.45244918536946 10.332141486959188) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(82.84816555280042 21.34477845810673) rotate(0 4.269996643066406 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(113.73332213534229 21.67291824040379) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g transform="translate(140.93290872403531 21.720938696349634) rotate(0 4.269996643066406 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(165.83551683664962 22.449248944862603) rotate(0 6.2899932861328125 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">9</text></g><g transform="translate(193.7514085598698 21.826983869896907) rotate(0 4.269996643066406 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(220.94499259156976 21.708933582363215) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g stroke-linecap="round" transform="translate(10 108.39614692586852) rotate(0 139.82096150380016 22.175072642540783)"><path d="M11.09 0 C105.36 0, 199.64 0, 268.55 0 M11.09 0 C64.71 0, 118.34 0, 268.55 0 M268.55 0 C275.95 0, 279.64 3.7, 279.64 11.09 M268.55 0 C275.95 0, 279.64 3.7, 279.64 11.09 M279.64 11.09 C279.64 18.37, 279.64 25.64, 279.64 33.26 M279.64 11.09 C279.64 17.57, 279.64 24.06, 279.64 33.26 M279.64 33.26 C279.64 40.65, 275.95 44.35, 268.55 44.35 M279.64 33.26 C279.64 40.65, 275.95 44.35, 268.55 44.35 M268.55 44.35 C202.28 44.35, 136.01 44.35, 11.09 44.35 M268.55 44.35 C212.36 44.35, 156.17 44.35, 11.09 44.35 M11.09 44.35 C3.7 44.35, 0 40.65, 0 33.26 M11.09 44.35 C3.7 44.35, 0 40.65, 0 33.26 M0 33.26 C0 28.45, 0 23.65, 0 11.09 M0 33.26 C0 25.21, 0 17.16, 0 11.09 M0 11.09 C0 3.7, 3.7 0, 11.09 0 M0 11.09 C0 3.7, 3.7 0, 11.09 0" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g><g stroke-linecap="round"><g transform="translate(41.12304640424418 108.7525774849909) rotate(0 -0.13767407093706652 21.714441285951267)"><path d="M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43 M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(71.92526022387642 109.26246392007667) rotate(0 -0.13767407093706652 21.714441285951267)"><path d="M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43 M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(20.092803384224112 158.9234309590374) rotate(0 6.756850183010101 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g stroke-linecap="round"><g transform="translate(100.93386226626671 108.25732458656555) rotate(0 -0.13767407093706652 21.714441285951267)"><path d="M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43 M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(127.55099507603165 109.23437619419016) rotate(0 -0.13767407093706652 21.714441285951267)"><path d="M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43 M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(151.64424508827756 108.46396999844515) rotate(0 -0.13767407093706652 21.714441285951267)"><path d="M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43 M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(180.6668909936111 108.46231021574536) rotate(0 -0.13767407093706652 21.714441285951267)"><path d="M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43 M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(50.17342272599967 159.18564804546637) rotate(0 4.281550181102375 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(109.6218833769176 159.71489085596184) rotate(0 6.0951995849609375 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g transform="translate(134.729889697491 159.4207353354993) rotate(0 5.8646240234375 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g transform="translate(160.69445139817833 158.61070730080073) rotate(0 6.195450007915497 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">5</text></g><g transform="translate(187.513423513441 159.65683365553858) rotate(0 6.415992736816406 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">6</text></g><g stroke-linecap="round"><g transform="translate(206.71681365046675 108.64330574496879) rotate(0 -0.13767407093706652 21.714441285951267)"><path d="M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43 M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(216.74621096269925 158.87941415309078) rotate(0 5.5939483642578125 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">7</text></g><g stroke-linecap="round"><g transform="translate(235.84122018165874 109.1635273510494) rotate(0 -0.13767407093706652 21.714441285951267)"><path d="M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43 M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(242.8950441420609 157.96102293312518) rotate(0 6.375892639160156 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">8</text></g><g stroke-linecap="round"><g transform="translate(264.8635832439652 108.69932961023895) rotate(0 -0.13767407093706652 21.714441285951267)"><path d="M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43 M0 0 C-0.05 7.24, -0.23 36.19, -0.28 43.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(269.6648364661221 156.88256352667347) rotate(0 6.305717468261719 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">9</text></g><g stroke-linecap="round"><g transform="translate(117.93938046038102 60.027787593479076) rotate(0 -41.98088318454245 21.858311290876912)"><path d="M0 0 C-13.99 7.29, -69.97 36.43, -83.96 43.72 M0 0 C-13.99 7.29, -69.97 36.43, -83.96 43.72" stroke="#1971c2" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(225.65326485170954 58.66920886067609) rotate(0 -95.79680790741963 22.651649240149936)"><path d="M0 0 C-31.93 7.55, -159.66 37.75, -191.59 45.3 M0 0 C-31.93 7.55, -159.66 37.75, -191.59 45.3" stroke="#1971c2" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(18.804202094058837 119.11847662988075) rotate(0 7.017494201660156 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="#1971c2" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g stroke-linecap="round"><g transform="translate(89.12510604050658 59.167421091114875) rotate(0 -14.304093314886643 22.249477921602974)"><path d="M0 0 C-4.77 7.42, -23.84 37.08, -28.61 44.5 M0 0 C-4.77 7.42, -23.84 37.08, -28.61 44.5" stroke="#2f9e44" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(147.11981085684306 60.27189157787072) rotate(0 -43.24041972695693 21.74653795392871)"><path d="M0 0 C-14.41 7.25, -72.07 36.24, -86.48 43.49 M0 0 C-14.41 7.25, -72.07 36.24, -86.48 43.49" stroke="#2f9e44" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(48.766779160564056 118.39859480812427) rotate(0 6.0951995849609375 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g stroke-linecap="round"><g transform="translate(62.580766926360866 57.52929765023893) rotate(0 23.613444479680027 22.158698859699825)"><path d="M0 0 C7.87 7.39, 39.36 36.93, 47.23 44.32 M0 0 C7.87 7.39, 39.36 36.93, 47.23 44.32" stroke="#e03131" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(108.97159737481331 119.15143549122914) rotate(0 4.280670166015625 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(79.79882039149663 119.26936675361279) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#846358" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g transform="translate(132.89921730408253 119.35149767982907) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#846358" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g transform="translate(158.96505208329927 119.75710165567276) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#846358" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g transform="translate(185.84419638920815 120.2909017067831) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#846358" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g stroke-linecap="round"><g transform="translate(195.46335445275668 58.685163902643126) rotate(0 -67.44089149437815 22.461588170135926)"><path d="M0 0 C-22.48 7.49, -112.4 37.44, -134.88 44.92 M0 0 C-22.48 7.49, -112.4 37.44, -134.88 44.92" stroke="#2f9e44" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(214.0018403833227 119.96102956092685) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#846358" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g transform="translate(243.2596605793898 119.86437279658153) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#846358" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g stroke-linecap="round"><g transform="translate(174.74781056280153 58.71191836546785) rotate(0 48.52899055147668 23.224067274625313)"><path d="M0 0 C16.18 7.74, 80.88 38.71, 97.06 46.45 M0 0 C16.18 7.74, 80.88 38.71, 97.06 46.45" stroke="#f08c00" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(271.2272579454175 119.75030758580195) rotate(0 4.280670166015625 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="#f08c00" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g stroke-linecap="round" transform="translate(49.74958009227112 221.07750750450745) rotate(0 98.51093180677475 22.115234375)"><path d="M11.06 0 C79.9 0, 148.74 0, 185.96 0 M11.06 0 C54.42 0, 97.79 0, 185.96 0 M185.96 0 C193.34 0, 197.02 3.69, 197.02 11.06 M185.96 0 C193.34 0, 197.02 3.69, 197.02 11.06 M197.02 11.06 C197.02 16.53, 197.02 22, 197.02 33.17 M197.02 11.06 C197.02 17.87, 197.02 24.69, 197.02 33.17 M197.02 33.17 C197.02 40.54, 193.34 44.23, 185.96 44.23 M197.02 33.17 C197.02 40.54, 193.34 44.23, 185.96 44.23 M185.96 44.23 C117.95 44.23, 49.94 44.23, 11.06 44.23 M185.96 44.23 C122.15 44.23, 58.34 44.23, 11.06 44.23 M11.06 44.23 C3.69 44.23, 0 40.54, 0 33.17 M11.06 44.23 C3.69 44.23, 0 40.54, 0 33.17 M0 33.17 C0 25.86, 0 18.55, 0 11.06 M0 33.17 C0 25.54, 0 17.91, 0 11.06 M0 11.06 C0 3.69, 3.69 0, 11.06 0 M0 11.06 C0 3.69, 3.69 0, 11.06 0" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g><g stroke-linecap="round"><g transform="translate(80.78864259227112 221.43297625450745) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(111.5077382575189 221.94148678785845) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(60.06458021928506 232.73470549033433) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g stroke-linecap="round"><g transform="translate(140.43806211259607 220.93905976998767) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(166.98336998902641 221.91347485522348) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(191.01160563295912 221.14514756008893) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(219.9559354543535 221.2712012569469) rotate(0 -0.13730256469568758 21.655846007905836)"><path d="M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31 M0 0 C-0.05 7.22, -0.23 36.09, -0.27 43.31" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(89.35165182178457 232.28383822809437) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g transform="translate(120.23680840432621 232.61197801039143) rotate(0 4.269996643066406 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(147.43639499301935 232.65999846633733) rotate(0 4.269996643066406 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(172.33900310563354 233.38830871485024) rotate(0 4.269996643066406 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(200.25489482885382 232.7660436398846) rotate(0 6.079994201660156 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g transform="translate(227.4484788605539 232.64799335235088) rotate(0 6.2899932861328125 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">9</text></g><g stroke-linecap="round"><g transform="translate(64.01548329452794 216.87032577845443) rotate(0 16.219015149287884 -0.1314085312520774)"><path d="M0 0 C5.41 -0.04, 27.03 -0.22, 32.44 -0.26 M0 0 C5.41 -0.04, 27.03 -0.22, 32.44 -0.26" stroke="#1971c2" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(31.05162328988831 156.25359808603096) rotate(0 25.014987424563685 30.123913460278942)"><path d="M0 0 C8.34 10.04, 41.69 50.21, 50.03 60.25 M0 0 C8.34 10.04, 41.69 50.21, 50.03 60.25" stroke="#1971c2" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(120.15192512204908 216.66643893933045) rotate(0 28.577490590530772 -0.012699143776444544)"><path d="M0 0 C9.53 0, 47.63 -0.02, 57.15 -0.03 M0 0 C9.53 0, 47.63 -0.02, 57.15 -0.03" stroke="#2f9e44" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(64.10804667670925 156.21284803018435) rotate(0 42.70810227949596 30.142703752870005)"><path d="M0 0 C14.24 10.05, 71.18 50.24, 85.42 60.29 M0 0 C14.24 10.05, 71.18 50.24, 85.42 60.29" stroke="#2f9e44" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(77.54261343843211 158.5922827669382) rotate(0 7.017494201660156 12.533821859247638)"><text x="0" y="17.667675292795465" font-family="Virgil, Segoe UI Emoji" font-size="20.054114974796214px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g stroke-linecap="round"><g transform="translate(121.34751109923525 156.81489624316484) rotate(0 39.99957190071734 29.988804575698936)"><path d="M0 0 C13.33 10, 66.67 49.98, 80 59.98 M0 0 C13.33 10, 66.67 49.98, 80 59.98" stroke="#e03131" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(273.7740684775757 155.87492805219765) rotate(0 -20.861777096138496 30.665136090079955)"><path d="M0 0 C-6.95 10.22, -34.77 51.11, -41.72 61.33 M0 0 C-6.95 10.22, -34.77 51.11, -41.72 61.33" stroke="#f08c00" stroke-width="1" fill="none"></path></g></g><mask></mask></svg>

## Implementation

Our first helper subroutine iterates over the whole input and finds the range of values. This can be omitted if it's known beforehand.

```kotlin linenums="1"
private fun MutableList<Int>.range(start: Int = 0, end: Int = size): Pair<Int, Int> {
  var min = this[start]
  var max = this[start]

  for (i in start + 1..<end) {
    if (this[i] < min) min = this[i]
    if (max < this[i]) max = this[i]
  }

  return Pair(min, max)
}
```

The next subroutine is the key. Here we create an auxiliary array to count the number of each value in our input.

```kotlin linenums="1"
private fun MutableList<Int>.counts(start: Int = 0, end: Int = size, range: Pair<Int, Int>): IntArray {
  val counts = IntArray(range.second - range.first + 1) // length = max - min + 1

  for (n in this) {
    counts[n - range.first]++ // take care of the offset
  }

  return counts
}
```

And then it all comes together as we interate over these counts and overwrite the input array.

```kotlin linenums="1"
fun MutableList<Int>.countingSort(start: Int = 0, end: Int = size) {
  if (isEmpty()) return

  val r = range(start, end)
  var cursor = 0

  for (e in counts(start, end, r).withIndex()) {
    for (i in 1..e.value) {
      this[cursor++] = r.first + e.index
    }
  }
}
```

This may look \\(O(n^2)\\) from the nested loop, but in fact this run in \\(O(n+k)\\), where \\(k\\) is the range of values in the input.

- \\(O(n)\\) for the first pass when we gauge the range of values.
- \\(O(n)\\) again as we fill in the auxiliary array.
- \\(O(n + k)\\) in the final step. 
    - We'd need \\(O(k)\\) to process the whole range, even if most of it may be empty. 
    - and \\(O(n)\\) write the result back.

## Unit test

```kotlin linenums="1"
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import java.util.concurrent.ThreadLocalRandom
import kotlin.streams.toList

class CountingSortKtTest {

  @Test
  fun emptyList() {
    val list = mutableListOf<Int>()

    list.countingSort()

    assertThat(list).isEqualTo(mutableListOf<Int>())
  }

  @Test
  fun one() {
    val list = mutableListOf(5)

    list.countingSort()

    assertThat(list).isEqualTo(mutableListOf(5))
  }

  @Test
  fun two() {
    var list = mutableListOf(4, 5)
    list.countingSort()
    assertThat(list).isEqualTo(mutableListOf(4, 5))

    list = mutableListOf(9, 2)
    list.countingSort()
    assertThat(list).isEqualTo(mutableListOf(2, 9))
  }


  @Test
  fun three() {
    var list = mutableListOf(4, 5, 6)
    list.countingSort()
    assertThat(list).isEqualTo(mutableListOf(4, 5, 6))

    list = mutableListOf(4, 6, 5)
    list.countingSort()
    assertThat(list).isEqualTo(mutableListOf(4, 5, 6))

    list = mutableListOf(5, 4, 6)
    list.countingSort()
    assertThat(list).isEqualTo(mutableListOf(4, 5, 6))

    list = mutableListOf(5, 6, 4)
    list.countingSort()
    assertThat(list).isEqualTo(mutableListOf(4, 5, 6))

    list = mutableListOf(6, 5, 4)
    list.countingSort()
    assertThat(list).isEqualTo(mutableListOf(4, 5, 6))

    list = mutableListOf(6, 4, 5)
    list.countingSort()
    assertThat(list).isEqualTo(mutableListOf(4, 5, 6))
  }

  @Test
  fun random() {
    val list = ThreadLocalRandom.current().ints(100, 0, 90).toList().toMutableList()
    val copy = list.toMutableList()

    assertThat(list == copy).isTrue()
    assertThat(list === copy).isFalse()

    list.countingSort()
    copy.sort()
    assertThat(list).isEqualTo(copy)
  }
}
```

## Against comparison sorts

<div id="chart"></div>

<script type="text/javascript">
  function chart() {
    var data = google.visualization.arrayToDataTable(
      [
        ["size", "comparison", "counting"],
        [100, 0, 3],
        [1000, 0, 1],
        [10000, 4, 2],
        [50000, 8, 11],
        [100000, 16, 4],
        [200000, 24, 6],
        [500000, 67, 6],
        [1000000, 133, 18],
      ]
    );

    var options = {
      title: 'Comparison sorts vs Counting sort',
      curveType: 'function',
      hAxis: {
        title: 'input size'
      },
      vAxis: {
        title: 'millis',
      },
      legend: 'bottom'
    };

    const chart = new google.visualization.LineChart(document.getElementById('chart'));
    chart.draw(data, options);
  };  
  google.charts.setOnLoadCallback(chart);
</script>


Where counting sorts fail is with sparse inputs with large ranges. These result in excess memory allocation for auxiliary array to track our counts.
