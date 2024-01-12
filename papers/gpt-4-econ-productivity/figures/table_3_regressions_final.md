|                                                     | Model 1 (Linear FE) | Model 2 (Curvilinear) | Model 3 (Expects GPT) |
| --------------------------------------------------- | ------------------- | --------------------- | --------------------- |
| Intercept                                           | 2.1519\*\*\*        | 1.0537\*\*\*          | 1.0718\*\*\*          |
| author_credentials_masters\[T.True\]                | -0.2235             | -0.2369               | -0.2311               |
| author_credentials_phd_student_webservice\[T.True\] | -0.1152             | -0.1395               | -0.1144               |
| author_credentials_unspecified_webservice\[T.True\] | -0.4137\*\*\*       | -0.3951\*\*\*         | -0.4124\*\*\*         |
| is_march_gpt_model\[T.True\]                        | 0.0639              | 0.0633                | 0.0609                |
| is_participant_the_author\[T.True\]                 | 1.2930\*\*          | 1.6037\*\*\*          | 1.2913\*\*            |
| is_written_by_gpt\[T.True\]                         | -0.1021             | -0.1069               | -0.0980               |
| participant_assessed_writer_edu_level\[T.P\]        | 1.1321\*\*\*        | 1.1723\*\*\*          | 1.1198\*\*\*          |
| participant_assessed_writer_edu_level\[T.U\]        | -1.9055\*\*\*       | -1.8657\*\*\*         | -1.8994\*\*\*         |
| participant_education\[T.APhD\]                     | 0.2172              | -0.1006               | -0.0273               |
| participant_education\[T.AnUndergraduateDegree\]    | 0.3585\*\*\*        | 0.4007\*\*\*          | 0.4408\*\*\*          |
| participant_education\[T.HighSchoolorLess\]         | 0.3192\*\*          | 0.5025\*\*\*          | 0.5315\*\*\*          |
| participant_education\[T.SomeCollege\]              | -0.8556\*\*\*       | -0.5250\*             | -0.5592\*             |
| participant_with_econ_degree\[T.Yes\]               | 0.5113\*\*\*        | 0.0402                | 0.0877                |
| topic\[T.llm_best_practices\]                       | 0.0758              | 0.0908                | 0.0777                |
| topic\[T.macro_health\]                             | -0.0887             | -0.1008               | -0.0944               |
| topic\[T.remote_work\]                              | 0.1526              | 0.1641                | 0.1552                |
| participant_assessed_gpt_likelihood                 | 0.0181              | 0.2902\*\*\*          |                       |
| participant_attention                               | 0.5494\*\*\*        | 1.2658\*\*\*          | 1.3731\*\*\*          |
| participant_assessed_gpt_likelihood_squared         |                     | -0.0273\*\*\*         |                       |
| participant_attention_squared                       |                     | -0.0686\*\*\*         | -0.0741\*\*\*         |
| participant_expects_gpt\[T.True\]                   |                     |                       | 0.0219                |
| R-squared                                           | 0.5486              | 0.5553                | 0.5482                |
| R-squared Adj.                                      | 0.5104              | 0.5167                | 0.5101                |
| AIC                                                 | 1908.00             | 1901.96               | 1908.42               |

---

p<.1, ** p<.05, \***p<.01

Participant and author fixed effects excluded for brevity.
