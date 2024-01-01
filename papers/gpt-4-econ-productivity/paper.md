# GPT-4 Productivity Study

TODO: front matter, author, affiliation, abstract, keywords, topic codes...

TODO: next up:

1. exploratory data analysis! woohoo (in progress)
2. draft the paper
3. polish, send to co-authors for review
4. spend more money to get published
5. Review `Initial notes` section of [google doc](https://docs.google.com/document/d/1nfoj-e53_16zHdD476N0d6GUvYJvg11skAGcyEESTbs)
   - and find tweeted paper from patricia

---

EDA notes:

- related thread: https://chat.openai.com/c/28294005-8131-4ae6-a515-6b5fb5af5cf1
- Doc 8 was written by GPT-4, but less than 27% of people rated that as likely, where "likely" is 6 or more out of 10 on "written by gpt-4" subquestion. n=1 that people can't tell when it's written by GPT
- Doc 8 avg quality rating of 6.8, so "unlikely GPT" and "high quality" go together for this paper...anti-technology bias? need a multivariate regression to check across docs
  - IQR from 6 to 8, median of 7, and standard deviation of 1.7, so strong majority think it's high quality
- Doc 8 calibrated at education level between undergraduate and master's level
- Looking only at PhD holders for Doc 8 doesn't move the needle on quality: the document is still assessed at a quality of 7 out of 10 although the standard deviation is smaller.
  - notably, phd holders assign a higher education level: none of them thought it was an undergraduate paper! 3 assigned an education level of master's and 2 assigned a level of phd holder.
  - still, notable that most phd holders did not consider Doc 8 to be of PhD-level quality

so far we know:

1. for doc 8, people can't tell it's GPT-4
2. for doc 8, there may be an anti-tech bias demonstrated
3. for doc 8, there is a phd overvaluation effect
4. for doc 8, phd holders have a smaller std dev of quality estimated, but the quality estimate is still on par with population norm

more EDA questions:

1. do all the doc 8 findings generalize to other gpt papers?
2. do people think phd holders have phds to an extent different than they think gpt has a phd?
3. do people rate phd holder papers higher than gpt?
4. does gpt perform worse on the austrian question?
   - and, does it perform better on the LLM question?
   - and, what is the overall performance spread across questions? (answering the "econ niche" question)
5. who won between hand-written papers, gpt papers, and webservice papers?

---

## Background and Introduction

notes:

1.  there seem to be four interesting aspects to this study:

    1. We focus on GPT-4 with a novel Plugin Forest prompting strategy.

       1. There's lots of conversation about AI and productivity, but what about GPT-4 in particular? Often we see discussions of ChatGPT, but under the hood they are using GPT-3.5 which is importantly different and inferior. GPT-4 is not only preferred to other large language models for performance reasons, it is in fact not even a large language model! It's a multimodal model, which represents an architectural step beyond "the era of large parameter count LLMs" as Sam Altman has discussed.
       2. We know that prompt techniques cause significant performance variation for a given model, and tree of thoughts is a leading-edge prompt strategy. ChatGPT Plugins are a GPT-4-specific augmentation that improves GPT-4 performance further for certain tasks, including literature review. Of note, plugins give GPT-4 access to some research that it would otherwise not be able to access. The Plugin Forest utilizes plugins together with tree of thought prompting, so it represents an extremely high bar of expected output quality with a high degree of standardization and reproducibility. As one example of quality difference, contrasting with other prompting approaches, this strategy notably provided zero citation hallucinations.
       <!-- TODO: verify that none of the citations were hallucinated. I think so, but if we are going to claim that directly, let's triple-check -->

    2. We are the first to calibrate GPT-4 on the particular task of economic research writing for publication. We know that models perform differently for different tasks due to training sample variation, differential human feedback in RLHF, and for other reasons. Unlike other papers which provide business-oriented research productivity estimates, our paper is of specific interest to other researchers in the academy. GPT-4 has previously shown broad competency across many skills, but competency tends to devolve with the required depth of expertise. By selecting a particular field of research at the publication level, we probe multimodel capabilities to an extent previously unexplored and with specific practical value to many researchers.

    3. i forgot 3 and 4...but the two above are great already

## Methodology

TODO

## Results

TODO

## Conclusion

TODO
