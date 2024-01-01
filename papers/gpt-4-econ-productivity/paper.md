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
- Approximately 60% of the respondents who hold a Ph.D. also have a postsecondary degree in Economics.
  - 100% of the human authors have a postsecondary degree in economics

so far we know:

1. for doc 8, people can't tell it's GPT-4
2. for doc 8, there may be an anti-tech bias demonstrated
3. for doc 8, there is a phd overvaluation effect
4. for doc 8, phd holders have a smaller std dev of quality estimated, but the quality estimate is still on par with population norm

more EDA questions:

1. do all the doc 8 findings generalize to other gpt papers?
2. do people think phd holders have phds to an extent different than they think gpt has a phd?
3. do people rate phd holder papers higher than gpt papers on quality?
4. does gpt write with lower quality on the austrian question?
   1. let's assess relative to GPT scores on other papers, and also on non-gpt scores for the austrian question.
   2. and, does it perform better on the LLM question?
   3. and, what is the overall performance spread across questions? (answering the "econ niche" question)
5. How did GPT-4 perform in terms of quality compared to webservice authors for the Austrian question?
6. who won between hand-written papers, gpt papers, and webservice papers?
   - investigate quality and education level
7. what education level does gpt-4 represent overall?
8. do phd holders think phd holders have phds to an extent different than they think gpt has a phd?
9. do phd holders rate phd holder papers higher than gpt papers on quality?

answers:

1. the findings do generalize. in general, people think GPT-4 didn't write papers when it did.
   - notable that people are directionally correct but not significantly accurate; a difference in means test shows that the average likelihood rating that respondents assigned for GPT authorship across all papers, regardless of the actual author, is approximately 4.39, while the average likelihood rating that GPT wrote the papers it actually did write is approximately 4.63 (p-value diff is P-Value: 0.363).
2. people can tell phds are smarter than gpt-4
   - Ph.D. Holder Authors: About 22.22% of the time, respondents perceived the education level of the writer as Ph.D. or higher for documents authored by actual Ph.D. holders.
   - GPT Authorship: For documents written by GPT, approximately 13.33% of the time, respondents perceived the writer's education level as Ph.D. or higher.
3. gpt-4 papers and phd holder papers rounded to the same level of quality on average (6.7) however, before rounding, gpt-4 had a slight advantage (6.71 vs 6.67)
   - this is not just comparing gpt-4 to a random phd holder, but indeed to an econ phd holder!
4. GPT-4 does worse than its own average and also worse than the average econ PhD holder when discussing Austrian econ in particular, and more generally this is a signal of continued weakness in niche topics.
   1. Econ PhDs outperform GPT for austrian (they were the only other authors on the topic).
   2. for LLM best practices, GPT-4 overperformed all other authors and also overperformed itself compared to other topics. so we confirm that research topic is importantly related to performance.
   3. see table 1 for spread info. notable: GPT-4 had lower performance spread compared to PhDs and all other authors. it also had the highest overall average performance and lowest standard deviation (using quality metrics)
5. webservice providers didn't answer the austrian question, but see table 1 where we confirm webservice does much worse in general.

<!-- note: see make_table_1.py -->

Table 1: Performance spread:
| Author Group | Best Performing Topic | Best Topic Avg. Quality | Worst Performing Topic | Worst Topic Avg. Quality | Performance Spread |
|--------------|------------------------|-------------------------|------------------------|--------------------------|--------------------|
| GPT Authors | Macro Health | 7.03 | Austrian Neoclassical | 6.23 | 0.80 |
| Non-GPT Authors | Austrian Neoclassical | 7.13 | Macro Health | 6.03 | 1.10 |
| PhD Authors | Austrian Neoclassical | 7.13 | LLM Best Practices | 6.27 | 0.87 |

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
