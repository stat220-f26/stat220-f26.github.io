# Text week rework (Week 5)

Planning notes, written 2026-10-07. Nothing in the course materials has been changed yet.

## The plan

Current schedule (from the schedule sheet): Mon 10/12 strings and regex, Wed 10/14 intro to text analysis, Fri 10/16 text analysis (sentiment). Fri 10/16 is also Lab Quiz 2. Mon 10/19 is midterm break, and Wed 10/21 is Functions.

Proposed:

| Day | Topic | Format |
|---|---|---|
| Mon 10/12 | Strings and regex | In class |
| Wed 10/14 | Intro to text analysis (tokenizing) | In class |
| Fri 10/16 | Intro to LLMs, building on tokens and n-grams | Quiz in class, LLM piece out of class (recorded video plus short R notebook) |

Why it works: regex currently gets split across two decks, and the Wednesday deck is overloaded. The arc from tokens to n-grams to next-word prediction to LLMs is coherent, and the "Trouble with Sentiment Analysis" reading fits as a bridge to why counting words is not enough.

Costs: sentiment analysis loses its slot, and the Friday piece lands right before the break, so it needs a light, low-stakes deadline.

## Day outlines (70 min)

### Monday 10/12: strings and regex

- 0-5: hook with messy strings (phone numbers, names)
- 5-25: `stringr` basics (`str_length`, `str_c`, case, `str_sub`, `str_detect`); babynames "Amanda" plot as the in-class activity
- 25-60: regex through literals, `.`, `[]`, `[^]`, `\\d \\w \\s`, anchors, alternation and repetition, with Your turns on `str_detect` and `str_subset`
- 60-70: practice and wrap-up
- Cut or make optional: `str_pad`, "duplicating groups" (back-references)

### Wednesday 10/14: intro to text analysis

- 0-5: Google Ngram Viewer hook (already in the Prepare column)
- 5-15: text as tidy data, what a token is, `unnest_tokens()`
- 15-35: stopwords, `anti_join`, counts, top-words plot per course
- 35-45: bigrams (new in the activity; sets up Friday)
- 45-65: open-ended work on the Coursera reviews
- 65-70: preview Friday
- tf-idf becomes optional

### Friday 10/16: LLMs (out of class)

About 20 minutes of video plus 30 minutes of hands-on R, with a short check (4 or 5 questions) due Wed 10/21.

1. A language model predicts the next token. Build a bigram model from Wednesday's counts and generate text by sampling.
2. Where counting breaks down: sparsity and context (connects to the sentiment reading).
3. Tokens are not words: subword tokenization compared with `unnest_tokens()`.
4. Embeddings: words as vectors, using precomputed examples.
5. Transformers and training at a conceptual level: attention, pretraining, fine-tuning.
6. Consequences: hallucination as plausible continuation, training-data bias, the course AI policy.

Keep the activity LLM-free, or use precomputed outputs, since the syllabus says not to paste course material into LLMs.

## How current materials fit

| Material | Fit |
|---|---|
| slides13, activity 13 (strings, babynames, courses, regex) | Fits Monday; slides13 needs trimming |
| slides14, regex half | Duplicates slides13's regex section; delete the duplicate and move alternation, repetition (and optionally groups) to Monday |
| slides14, opening (midterm check-in, Portfolio 2) | Doesn't fit; midterm check-in shows last term's feedback with a "[graphs from google]" placeholder |
| slides14, text-analysis half, activity 14 | Fits Wednesday; activity has no bigram chunk |
| slides15, activity 15 (sentiment) | No slot; activity 15 is unfinished (afinn loaded but unused, no most positive/negative step, nothing on weaknesses); `get_sentiments("afinn")` needs a `textdata` download that is untested for students |

## Decisions to make

- [ ] Lab Quiz 2 scope (the quiz page is still a stub). If it includes strings and regex, students get only four days of exposure.
- [ ] Midterm check-in: collect new feedback this week, or drop it?
- [ ] Where sentiment goes: optional "before" half of the Friday piece, Week 7 APIs day (compare against an LLM API), or cut
- [ ] Friday check format and due date (Wed 10/21, after the break)
- [ ] File naming: slides15 and activity 15 currently mean sentiment

## Todo

### Monday
- [ ] slides13: trim `stringr` (drop `str_pad`, possibly the second babynames slide)
- [ ] slides13: move alternation and repetition slides in from slides14; decide on duplicating groups
- [ ] slides13: update the Today slide
- [ ] activity 13: add alternation and repetition practice; fix numbering (the extra practice skips #6)

### Wednesday
- [ ] slides14: remove the midterm check-in, Portfolio 2 and duplicated regex slides; new Today slide
- [ ] slides14: mark tf-idf optional; add a Friday preview at the end
- [ ] activity 14: add a bigram chunk (`unnest_tokens(token = "ngrams", n = 2)`)

### Friday
- [ ] Write the video outline and record (about 20 min)
- [ ] Build the notebook: bigram model and sampling, tokens vs words, embeddings, temperature
- [ ] Precompute tokenizer examples and a small embedding dataset (no LLM access needed)
- [ ] Write the 4 or 5 check questions
- [ ] Add a short note on the AI policy

### Sentiment
- [ ] Decide where it lives (see Decisions)
- [ ] If kept: finish activity 15 and test the `textdata` afinn download on a clean machine

### Logistics
- [ ] Update the schedule sheet (Friday topic, Prepare column reading, due column)
- [ ] Update `lab-quiz/lab-quiz-02.qmd` once scope is settled
- [ ] Re-render and commit `_freeze/` along with the changed slides and activities
