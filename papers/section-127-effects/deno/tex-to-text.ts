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
// project generated with `ameerthehacker.deno-vscode` + `deno init`
//
// ref: https://stackoverflow.com/questions/52905844/git-bash-on-windows-vs-wsl
// ref: https://deno.land/
//
// TODO: secure command + Deno 1.0
// OS-normalized EOL once supported: https://github.com/denoland/deno/issues/4631
// TODO: follow up on GitHub issues in this article https://www.afterecon.com/programming/deno-grammarly-and-windows/

import { BufReader, ReadLineResult } from "https://deno.land/std/io/bufio.ts";

const decoder = new TextDecoder();
const encoder = new TextEncoder();

const handleLine = (sLine: string): string => {
    const isComment = sLine.trim()[0] === "%";
    const isOmittedFromTextVersion = sLine.includes('%%%'); // a convention
    const isTechnical = sLine.trim()[0] === "\\" || sLine.trim()[0] === "}";
    const regexMatchIsSectionHeading = sLine.match(/\\[a-z]*section{(?<headingText>[A-z- ]*)}/);

    if (!isComment && !isTechnical && !isOmittedFromTextVersion) {
        return sLine.trim() + '\n';
    } else if(regexMatchIsSectionHeading) {
        const headingText = regexMatchIsSectionHeading.groups && regexMatchIsSectionHeading.groups.headingText;
        if (headingText) return headingText.trim() + '\n';
    }

    return '';
}

export async function read_line(filename: string, lineCallback: (s: string)=>string): Promise<string> {
  const file = await Deno.open(filename);
  const bufReader = new BufReader(file);
  let sAccumulator = '';
  let readlineResult: ReadLineResult | Deno.EOF;

  while ((readlineResult = await bufReader.readLine()) !== Deno.EOF) {
    const sCurrentLine = decoder.decode(readlineResult.line);
    sAccumulator += lineCallback(sCurrentLine);
  }

  file.close();
  return sAccumulator;
}

const sOut = await read_line("../section-127-effects.tex", handleLine);
await Deno.writeFile("../section-127-effects.txt", encoder.encode(sOut));

export {}