# draft prep notes

This document also serves as a useful tool to prime ChatGPT context.

## Remaining TODO

1. draft the paper
2. grep `places where GPT can help` in `GPT Study Participant notification` email
3. polish, send to co-authors for review
   1. co-author question: does it make sense for a technical description of the Plugin Forest to go in the background section or the methodology? maybe both with a little duplication? since we want a bajillion pages?
4. triple check 'no hallucination' claim
5. tailor for JEL following Korinek
   1. target 40-60 pages; may also make a letters form for a shorter paper
   2. buchanan's paper is 43p and korinek is ~60+

## Related Threads and Links

1. https://chat.openai.com/c/28294005-8131-4ae6-a515-6b5fb5af5cf1
2. https://chat.openai.com/c/97192013-702e-47f6-afd2-e430530d4cbd

## EDA Notes

### Document 8 Case Study

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

### Generalizing Document 8 Findings

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
6. who won between hand-written papers, gpt papers, and webservice papers?
   1. Hand-written graduate papers seem to win in terms of perceived education level, but there is no difference in paper quality or even a slight edge for quality and consistency favoring GPT-4.
   2. The difference in identifiability without difference in quality seems to indicate a difference in style. This means that using GPT-4 with a Plugin Forest seems to produce a paper suitable for journal quality publication, but some stylistic changes may be in order. It does not seem advisable to submit a GPT-produced manuscript directly to a publisher at this time, but instead the researcher can use GPT-4 to assemble and draft the paper, then conduct a researcher-on-GPT review, making updates as necessary prior to journal submission.
   3. Notably, the single master's-authored paper was not significantly different in perceived quality compared to Ph.D. authors (as perceived by the general public, Chi-Square p=0.163). The small sample size is a limitation of the paper worth further investigation.
7. Overall, GPT-4 appears calibrated evenly with publication-quality research. In lesser-studied or cutting-edge areas of the field, however, a Plugin Forest with GPT-4 falls significantly short of traditionally-produced research.
   - Our results indicate that GPT-4 with a Plugin Forest can execute many functions with high reliability to assist the researcher. Literature reviews are a particular case of utility because the content of a literature review emphasizes established works.
   - GPT-4 seems generally calibrated above the undergraduate level, even after specifying a field of study. GPT-4 further seems calibrated on-par with doctoral-level writing quality for non-niche topics, admittedly with a slightly distinct style. Our limitted data suggests that human niche domination may hold even at the master's level.
   - Notably, the style difference persists despite the fact that the Plugin Forest was specifically crafted to capture research writing styles. Deeper embedding of research writing style can be imprinted by fine-tuning a model or altering the training set to include more academic work and less informal writing. Another approach would be to use multishot prompting for deeper style reinforcement with a context-based approach. Increasingly generous context sizes for GPT-4 make this an approach worth further investigation.
8. then 10% distinction rule holds for phd holders as well: About 31.11% of the time, Ph.D. holders perceived that Ph.D.-authored papers were written by someone with a Ph.D. level of education, while Around 20% of the time, Ph.D. holders perceived that GPT-authored papers were written by someone with a Ph.D. level of education.
   - While the distinction is significant, for practical purposes this might simply mean that a particular journal paper would need to be shopped around a couple more times. We already know that a given paper has a large degree of journal acceptance variation, and that variation will attenuate the 10% distinction rule.
9. Interestingly, Ph.D.-holding respondents rated GPT-authored economic papers slightly higher in quality on average than those authored by Ph.D. holders, with an average quality rating of 6.65 for GPT vs. 6.49 for Ph.D. authors, and GPT-authored papers also had a lower standard deviation (1.69 vs 1.8)

<!-- note: see make_table_1.py -->

Table 1: Performance spread:

| Author Group    | Best Performing Topic | Best Topic Avg. Quality | Worst Performing Topic | Worst Topic Avg. Quality | Performance Spread |
| --------------- | --------------------- | ----------------------- | ---------------------- | ------------------------ | ------------------ |
| GPT Authors     | Macro Health          | 7.03                    | Austrian Neoclassical  | 6.23                     | 0.80               |
| Non-GPT Authors | Austrian Neoclassical | 7.13                    | Macro Health           | 6.03                     | 1.10               |
| PhD Authors     | Austrian Neoclassical | 7.13                    | LLM Best Practices     | 6.27                     | 0.87               |

## Background and Introduction Notes

1.  there seem to be four interesting aspects to this study:

    1. We focus on GPT-4 with a novel Plugin Forest prompting strategy.

       1. There's lots of conversation about AI and productivity, but what about GPT-4 in particular? Often we see discussions of ChatGPT, but under the hood they are using GPT-3.5 which is importantly different and inferior. GPT-4 is not only preferred to other large language models for performance reasons, it is in fact not even a large language model! It's a multimodal model, which represents an architectural step beyond "the era of large parameter count LLMs" as Sam Altman has discussed.
       2. We know that prompt techniques cause significant performance variation for a given model, and tree of thoughts is a leading-edge prompt strategy. ChatGPT Plugins are a GPT-4-specific augmentation that improves GPT-4 performance further for certain tasks, including literature review. Of note, plugins give GPT-4 access to some research that it would otherwise not be able to access. The Plugin Forest utilizes plugins together with tree of thought prompting, so it represents an extremely high bar of expected output quality with a high degree of standardization and reproducibility. As one example of quality difference, contrasting with other prompting approaches, this strategy notably provided zero citation hallucinations.
       <!-- TODO: verify that none of the citations were hallucinated. I think so, but if we are going to claim that directly, let's triple-check -->

    2. We are the first to calibrate GPT-4 on the particular task of economic research writing for publication. We know that models perform differently for different tasks due to training sample variation, differential human feedback in RLHF, and for other reasons. Unlike other papers which provide business-oriented research productivity estimates, our paper is of specific interest to other researchers in the academy. GPT-4 has previously shown broad competency across many skills, but competency tends to devolve with the required depth of expertise. By selecting a particular field of research at the publication level, we probe multimodel capabilities to an extent previously unexplored and with specific practical value to many researchers.

Also in background section: we want to mention Andy Stapleton

Andy Stapleton, an expert in AI use for academic research, judged that AI tools could not substitute for a traditional literature review as of July 2023: https://www.youtube.com/watch?v=zzFuDPn4lDg

Here are four related videos from Andy:

1. https://www.youtube.com/watch?v=zzFuDPn4lDg
2. https://www.youtube.com/watch?v=YLa9NWv1wzs
3. https://www.youtube.com/watch?v=fYZaMXA8Ss0
4. https://www.youtube.com/watch?v=pO96e22aprc

## Results

1. Doc 8 case study
2. generalized eda with descriptive stats and difference in means
3. regression results (linear + Curvilinear Model)
   - technically prefer Curvilinear Model but the model power difference is trivial
   - see `regressions.py` but prefer `regressions_statsmodel.py`
   - in both models, `author_credentials_gpt` was insignificant (p > 0.5) and `author_gpt` was insignificant, but they could be partialling each other and we have data that interaction w topic matters. need a bit more regression analysis. also need to rm `doc_id`
   - doc_id was less significant than gpt effects anyway
   - interestingly, `participant_assessed_gpt_likelihood` is positive! so no anti tech bias demonstrated
   - a curvilinear model with squared attention and gpt likelihood had better (lower) AIC and adjusted r2 compared to the linear model. However the difference was small and this may be fragile for applied practical purposes, because we don't have high confidence in our guess about the reviewer's GPT likelihood assessment
     - we do, however, have high confidence that on a boolean scale, the reviewer will pick "False" for GPT-4 attribution, so we construct a simpler and more robust applied model using a calculated boolean (participant_expects_gpt)
     - interestingly, participant_expects_gpt has a positive coefficient, although the usual response will be False, indicating a penalty. neither variable is significant, however `participant_expects_gpt` and `is_written_by_gpt`
     - for attention, linear and quadratic values are both highly significant.
     - `participant_assessed_writer_edu_level_P` is a significant boost and `participant_assessed_writer_edu_level_U` is a significant penalty, with larger and more reliable effects compared to topic effects, but still small compared to practically uncontrolled and independent variation on the part of a journal reviewer: participant and attention effects were much larger.
       - what's the relation between participant_assessed_writer_edu_level_U and is_written_by_gpt? answer: according to chi square test, and simple and multiple regression, people DONT think of material with `is_written_by_gpt` as undergraduate level.
       - GPT-4 is broadly calibrated at the master's level. A simple regression of `is_written_by_gpt` on `participant_assessed_writer_edu_level` has an r-square near zero, indicating general independence of participant educational assessment on their document quality assessment. Further, the master's degree is the only significant feature in this regression and also the only positive coefficient. having an expected undergraduate or lower education, as well as having an expected doctorate-level education, were both negatively and insignificantly related to material actually written by GPT-4 (p > 0.115).

## Conclusions and Future Directions Notes

- takeaways
  - GPT-4 produces results of quality comparable to standard research with lower quality variance using the Plugin Forest technique.
- improvements that could be done:
  - larger sample
  - more master's-level investigation
  - look in sections other than literature review / background
  - consider more respondent factors such as demographic data
  - model with better training set (specifically more academic papers), fine tuning, larger context window
  - "textbooks are all you need" already showed supplementing academic training data is a highly effective approach
  - what if GPT took the questionnaire? what would it say? an orthogonal calibration mode; do it's responses look like master's responses?
    - does prompting it to act in a different role generate meaningful similarity to the role target by level of education?
    - how similar is a GPT-produced sample to a crowd-produced sample?
    - what about getting 5 or 10 samples and asking GPT to "stretch" it to 50 or 100?
    - what about getting 5 or 10 samples and asking GPT to stand in for underrepresented voices in the sample?
    - does this sort of "Bean Chili Research Design" add value compared to just using the original 5 or 10 samples?
- future directions: the tech is getting better
  - token limit continues to grow; it's already larger for researchers using GPT-4 through the API instead of the ChatGPT interface. this is important for at least two reasons:
    1. researcher productivity is enhanced when entire papers can be read or drafted at once, on the basis of reading multiple papers, textbooks, data reports, and so on.
    2. having a larger context window allows for multishot prompting with more template samples, allowing GPT-4 to produce a product that better reflects a desired target state for the paper.
  - the plugin store continues to grow and Open AI has plans to make an extension marketplace that would be expected to perform better than the plugin store, because the plugin store itself currently lacks a reputation mechanism making efficient utilization more difficult.

## March 18, Draft Study Design

### Title

GPT-4 Calibration as a Research Assistant in Economics

### Abstract

GPT-4 is a cutting-edge multimodal model that can be used as a writing assistant, but such models have a number of known problems. This study takes a turing-like practical comparative approach to identify the overall quality of summary literature reviews produced by GPT-4. Participants create summary literature reviews by hand, score their own, then blindly cross-score those written by other researchers and those created by GPT-4. I hypothesize that GPT-4 will perform meaningfully worse than a field-relevant doctoral participant, and therefore GPT-4 is an improper substitute to a by-hand literature review. Additional discussion focuses on the potential value and practice of AI-augmented writing in contrast to AI-driven writing.

### Background

Review known cases of training set bias like the “White Obama” image debacle. Review other known benefits and problems of large language models and multimodal models. Time constraint is a key constraint and failure to execute basic math is another glaring concern. There is evidence that specialty AI can do the job for medical research reviews. Field-specific testing is important because GPT can handle many general cases, but fidelity is lost in relatively niche areas. Through training set bias, mainstream and common views are expected to be well-represented while niche and minority views would be relatively expected to be ignored, misunderstood, or misrepresented. A key part of this paper is assessing GPT-4 for such minority view bias.

On net, there doesn’t seem to be good existing evidence that AI can substitute or drive a literature review, but the hypothesis has yet to be directly tested in the field of economics. It may be the case that the magnitude of concerns is practically dominated by the benefits. In another sense, the use of AI is so low-cost that it should be expected, and researchers will benefit from knowing the expected quality of their activities. In this sense, whether AI should be used is a bit of a foolish question, because it will be used. The interesting question is on how economists and researchers can make the best use of AI and what the expected quality of output will be. That is the point of the current study.

### Methodology

Four research questions are communicated to four participants. All participants hold an economics degree. One is held at the bachelor’s level, one at the master’s level, and two at the doctoral level. Each participant is asked to draft a summary literature review related to the research question. Summary literature reviews are constrained to a single page in length, comparable to the background section of an ordinary scholarly paper, rather than a full-length review paper or survey. Participants were asked to complete their summary reviews within a month, or about one week for each summary review.

The principal investigator additionally prompted GPT-4 using the ChatGPT web interface to produce three additional literature reviews for each research question, resulting in a total of twenty-eight summary literature reviews. The prompts used are conveyed in the appendix along with the dates of prompting and their associated ChatGPT subversions. GPT-4 was prompted after all other drafts were completed.

At this stage, a random selection program was applied to select one review authored by GPT-4 for each research question. This paper was then edited by the principal investigator. This AI-driven editing workflow is interesting for analysis in the case where naive AI authorship is of a low quality. If naive AI authorship is not suitable for literature review, the possibility of AI augmentation remains open, and augmentation can take at least two forms. By assessing AI-driven authorship, a best practice can be identified.

The investigator-driven approach does not need to be distinctly assessed because an investigator can and will simply select whichever revision they prefer after having done the literature review by hand. An investigator-driven literature review which is reviewed by AI and then reselected on by the researcher is simply a traditional literature review with more steps, a new search tool, and not a form of work which is expected to substantially reduce quality or save time compared to the traditional approach.

Participants were informed prior that some papers would be generated by GPT-4, although they were blind to particular origins other than their own products, with the exception of the principal investigator.

Finally, participants scored their own papers and blindly scored papers from other sources using two variables on a scale from one to ten. First, they scored perceived quality. Second, they scored perceived likelihood that the paper was generated by GPT-4. These two measures were kept distinct with the intention to mitigate implicit bias in quality from perceived origin.

Results are produced by statistical comparisons of these variables. Analysis is robustly conducted to account for bias in the ratings of the principal investigator as well as bias in ratings of individuals on their own work.

More Methodology Notes:

- This study uses a partially blind questionnaire design
- Authors know their own papers. We calculate an is_own_author flag to extract this effect from multiple regression analysis.
- Further, the Principal investigator is aware of the authorship of each paper
- The estimated completion time for the questionnaire response including reading time is 45 minutes (at 20 items)
- Articles normalized in style to minimize the ability to select GPT on the basis of style and formatting alone. Articles were normalized on font, spacing, indentation, the labeling of references, if any, under a section titled “References,” were a variety of names were originally used including “Citations” and “Works Cited.”
- Prolific.com, a crowdsourcing platform, was used for participant recruitment. Participants were US citizens aged 18 and over, were paid an incentive which averaged at about $15, and were oversampled for graduate degree holders.

### Results

Forthcoming

### Conclusions

Depending on results, naive use of GPT-4 is or isn’t substitutable for literature review by hand.

Compare and contrast naive and augmented GPT-4 use. AI-driven is not substituting the AI for the literature review work, but instead merely substituted the AI for search. This approach should be a strict gain in quality, if not a loss in time, when used alongside traditional search. Quality comes into question when AI is allowed to drive to the neglect of other searching patterns. AI review does not substitute for anything, and we certainly don’t suggest this be seen as a replacement for proper peer review. Since it doesn’t substitute for anything, it also seems like a strict gain to quality, although perhaps at the expense of time and therefore a matter of researcher discretion rather than a best practice.

Disclaim that other AI systems may vary in results compared to GPT-4. In particular, some specialty AI may perform substantially better.

### Misc related notes

How accurate is GPT-4? It is more accurate than GPT-3 and in one case study on cybersecurity analysis, GPT-3 had a false positive statement rate of 4/60 and “many false negatives.” Analysis by OpenAI, the creator of GPT-4 and predecessor GPT models, shows that performance varies by domain. Their analysis estimates the lower bound on GPT-3.5 percentile performance on the AP Macroeconomics exam at about the thirtieth percentile. In contrast, GPT-4 has a lower bound performance percentile estimated at about the eighty-third percentile. Similarly, in the domain of law, GPT-3.5 was in the bottom 10th percentile on the Unifiied Bar Exam and GPT-4 was in the top ten percent.
Bryan Caplan: GPT Retakes My Midterm and Gets an A
This is an undergraduate elective course in labor economics, Economics 321.
Because GPT-4 is not contained in its own training set, it thinks it is GPT-3 and it thinks it is not an ideal code assistance model, but actually it is. GPT-4 outperforms GPT-3 on coding tasks, but GPT-4 doesn’t realize this, so it won’t recommend itself even though it is a more performant tool compared to the tools that it does recommend.

## April 4, Initial Instructions for Participants

Thank you for your interest in participating in the study “GPT-4 Calibration as a Research Assistant in Economics.” Participation involves two steps:

1. Write 1-4 single-page summary literature reviews on the research questions provided below.
2. Rate literature reviews on a scale from 1 to 10 for quality and likelihood that the paper was generated by GPT-4.

### Four Important Participation Notes

1. Please review the informed consent paragraph below. Submit a summary literature review if and only if you agree to the statement.
2. Please submit your summary literature review on these topics to John Vandivier by email at john@ladderly.io by June 4, 2023. Use the subject line “Econ RA Lit Review.” The document title should indicate which topic is addressed.
3. I encourage you to timebox your work on each document to 16 hours or less.
4. Please do not discuss your work with other participants, but otherwise conduct the literature review however you see fit.

Informed Consent Statement
I understand that the summary literature review and ratings communicated by me to john@ladderly.io may be used in published academic work and for commercial purposes in an anonymized form. I have had the opportunity to ask questions. I confirm my participation is informed and voluntary. I understand that I can withdraw from the study at any time by providing notice to john@ladderly.io and I acknowledge that any data collected prior to withdrawal may be retained for the purposes of the study.

Research Questions

1. Is modern Austrian economics distinct from neoclassical economics?
2. What key factors indicate the overall health of the macroeconomy? Include both general concepts and also specific public measures.
3. What is the impact of remote work on the gender wage gap and career progression in the post-pandemic labor market?
4. Suggest best practices for literature search with and without a large language model (LLM). Given the benefits and problems of such a process, do you expect the gains to researcher productivity from LLM augmentation to be large, small, or negative?

### Next Steps

Summary literature reviews will be sent for review on June 5, 2023, at latest. An earlier date may be announced if all literature reviews are collected before the cutoff date of June 4. Once summary literature reviews are sent, ratings are requested within two weeks.

## Plugin Picking Methodology

“What ChatGPT Plugins are ideal for academic research?”

1. OpenAI publicly disclosed plugin support for ChatGPT late in March 2023 with twelve plugins initially available: https://openai.com/blog/chatgpt-plugins
2. Currently, ChatGPT can only utilize three plugins concurrently. This presents an emergent problem as the store size scales and multiple plugins are added over the same use cases, such as the use case for literature review assistance. It currently stands as technically impossible for the system to autonomously decide how to go about conducting research. At a minimum, the researcher must select the plugins for use.
3. There are dozens of plugins currently available for academic, research, and scientific use cases. A brute force search is possible, but it would quickly become an out-of-date analysis, it increases exposure to researcher selection bias, and it greatly diminishes the benefits of using AI for automated review in the first place. Presently, we are still able to exploit the plugin store by utilizing finder plugins. This class of plugin is responsible for knowing about the feature sets of other plugins. Currently there are only three. As the store grows, this strategy can be sustainably extended through a grandfathering or cross-validation strategy. In addition, if future tools make things easier, as they likely will, then current results represent a conservative forecast, so the current test remains valuable inasmuch as a preference for an AI-driven strategy today is expected to represent an even stronger preference in the same direction in the future.
4. An ai-driven approach would be to ask ChatGPT about this…so i did. At the moment the three plugin search tools today are:
   1. Chat Tool Finder
   2. PlugFinder
   3. Pluginpedia
5. So that’s a happy coincidence that I exploited basically. In the future a researcher could use the same plugins for consistency or they might somehow do an assessment to pick their prefer “finder plugins”
   ROLE:
   You are a researcher with formal training in economics.

CONTEXT:
You have the following top-level goal: You would like to write a journal-quality academic paper in the field of economics.

TASK:
Identify the three best ChatGPT plugins to assist you achieve your top-level goal.

## Final GPT Prompt notes

This paper describes the Plugin Forest prompt technique, a unified framework for result optimization when using ChatGPT.

High level: Configure N plugin collections, execute tree of thoughts prompting for each collection, then synthesize results.

More tree of thoughts: https://www.reddit.com/r/ChatGPT/comments/13ppc5k/try_the_my_best_guess_is_technique_for_80/
https://github.com/princeton-nlp/tree-of-thought-llm
https://www.promptingguide.ai/techniques/tot

Within-collection, construct your trees: a minimum of two variations; implement one or more critics to decide between the two options, then create
Our trees are different from other ToT papers+self-consistency in a few important ways:
Our trees are binary, dialectical, and dynamic. An evaluator can provide feedback to a navigator-generator agent beyond a pass/fail statement, and the navigator-generator can use this information to create an improved next step, so there is never a need to backtrack.

Because the trees are binary, there is no consistency competition.

1. Given our unique situation, it might be ideal not to use a tree algorithm at all. Instead, we could have the critic simply write their version of the paper and the navigator-generator could compare notes and they could negotiate a synthesis perhaps more richly and readily.
2. A “marginalizing-in” approach in contrast to the “marginalizing-out” approach of self-consistency. Potential marginilizing-in pitfall: That “everyone’s opinion is equally valid” issue.
3. Potential solution? Structured group prompting: give someone in the group veto power (editor, just like they have in the real world) basically, run a prompt simulation of the submission, revision, publishing process. We could do this in multiple steps similar to a “show your work” approach, or we could prompt with a group ROLE: eg you are an expert and highly senior principal investigator, a younger coauthor in the field, a peer reviewer, and an editor; directly write the paper you all agree to (is the multi-round negotiation beneficial or inefficient?)
4. We use a binary tree. Our binary tree is a dialectical learner: The evaluator function provides accumulated context to the tree search navigator.
5. Our tree explores a potentially open-ended space
6. We use DFS, not BFS. Does it matter?
7. Continue splitting the tree and learning until you run out of tokens, then reflect and synthesize the best answer given all knowledge up to that point. Requires a bit of token budgeting and constraining size for each LLM response but nbd.
8. ToT+Dialectic Binary Tree (Base case “best practice”)
   Agentic Peer Review (Accelerated ToT+DBT: “Just tell me what you want insteading of playing the hot/cold game”)
   Structured Group Prompting (editor has veto power)
   Process Simulation (GPT-4 has an observer role, not a group role)
   Incorporate role/task, plan/execute, chaining, and reflection at every stage.
9. The Plugin Forest incorporates more than half a dozen best practices by default with minimal researcher intervention:

   1. Use a high quality model (plugins are currently tightly coupled to GPT-4)
   2. Overcome the knowledge cutoff
   3. ROLE/TASK, supercharged with role diversity
   4. Mixture of Expert simulation by varying roles
   5. PLAN/EXECUTE - planning it out improves outcomes and can be done with or without a chain of thought
   6. Chain of Thought prompting
   7. Tree of Thoughts prompting
   8. Reflection, supercharged with critical reflection to help detect and heal hallucinations automatically

10. I then verified the sources used where real...it’s worth noting that GPT-4 did not hallucinate a single fictional source under this prompting scheme (in contrast to the Buchannan GPT-3.5 ChatGPT work in econ)
11. Search the ChatGPT Plugin Store for plugin search tools, find 3
12. Use all of them and ROLE/TASK prompt GPT to select the best plugins for economic paper writing/
13. Appendix B has threads. Current approach at: https://chat.openai.com/share/fc606c0b-e7c5-4781-9e15-cad65fbf8046
14. Pitfalls: automated duplicate detection occasionally fails and prompting for reflection sometimes induces improper self-critique from the LLM (ie, owning up to mistakes it never made)
    Asking the LLM to detect duplicates led to frequent mistakes. These mistakes became infrequent by asking the LLM to list the plugins then check whether there were duplicates after restating the list of plugins.
    Four Solutions:
    Manual Review: The researcher should already be doing a manual review at some point, catching errors early will save you pain, and an LLM admitting a mistake is a particular indicator for manual intervention.
    Quadruple-Check Prompting: If the LLM admits a mistake, ask it to reflect on whether it really made such a mistake. If it flip-flops (saying you’re right, I didn’t make a mistake), then ask it to reflect on that flip-flop. If it doubles-down, saying it really didn’t make a mistake, for a total of agreement in three out of four trials, you may choose to proceed as if the statement were true rather than digging in with a manual review, at your own risk. This is my least preferred solution to this problem, but in some low-stakes and time-constrained environments it could be useful.
    Programmatic Checking: Programmatic duplicate checks are extremely reliable.
    To maintain a browser-based ChatGPT experience, a researcher could use a browser extension.
    Alternatively, a researcher could exit the browser experience and interact with GPT-4 programmatically through the API.
