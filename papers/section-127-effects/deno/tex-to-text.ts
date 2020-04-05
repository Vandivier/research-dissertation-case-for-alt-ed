// @ts-ignore: 1375
//
// run like `deno --allow-read --allow-write tex-to-text.ts`
//      a more restrictive and secure invocation will be possible after Deno 1.0
//      ref: https://github.com/denoland/deno/issues/1639
//
// built using { deno: "0.39.0", v8: "8.2.308", typescript: "3.8.3" }
// Deno installed via curl
// using windows 10
// using WSL2 with Ubuntu 16.04.6 LTS
//
// ref: https://stackoverflow.com/questions/52905844/git-bash-on-windows-vs-wsl
// https://deno.land/

const decoder = new TextDecoder("utf-8");
const encoder = new TextEncoder()
const sIn = await Deno.readFile("tsconfig.json");
const sOut = decoder.decode(sIn).replace(/{/g, '!!!!!!!!!!!!!!!')


await Deno.writeFile("../section-127-effects.txt", encoder.encode(sOut));
