# How LLMs work: video outline (about 10 minutes)

Context: students have just built a bigram word predictor (see `llm-bigram-activity.qmd`). The video uses that model as the running example, adds what is missing, and arrives at how an LLM differs. Goal is intuition, not math.

Three things students should leave with:

1. An LLM is the same idea they built: predict the next token from the context, then sample.
2. What changes is how much context it uses and how it represents words, not the basic task.
3. Because it predicts plausible continuations, fluent does not mean true.

## Outline

| Time | Segment | Talking points | On screen |
|---|---|---|---|
| 0:00-1:00 | Hook | Phone autocomplete. "You just built a toy version of what powers ChatGPT." What the video will do: start from your bigram model and ask what it would take to turn it into an LLM. | Autocomplete suggestion strip; screenshot of a student-style output from the activity |
| 1:00-2:30 | What you built | Tokens, counts, probabilities, sample the next word. Say the vocabulary: a *language model* assigns probabilities to the next token; *sampling* (`slice_sample(weight_by = prob)`) is how text gets generated. Always picking the top word gives repetitive text, which is why sampling matters. | Code snippet from step 4 and step 5; a small table of `word1`, `word2`, `prob` |
| 2:30-4:00 | Where it breaks | Look at the generated text. Only one word of context, so sentences wander. Unseen words give nothing (the `"xyzzy"` case). No notion of meaning: "great" and "excellent" are unrelated rows in a table. Mention the trigram tradeoff: more context means more combos that are never seen (with these reviews, about 72% of bigrams appear once, and about 86% of trigrams). | Output of a bad generation; the "seen once" proportions from the optional question |
| 4:00-5:30 | Fix 1: tokens | LLMs do not split on spaces. They use pieces of words (subword tokens), so rare or new words still get handled. Rough numbers: a few thousand to over a hundred thousand tokens in the vocabulary; a typical English word is 1 to 2 tokens. Compare with `unnest_tokens()`. | Example sentence split into subword tokens (precomputed) |
| 5:30-7:30 | Fix 2: meaning as numbers | Instead of a lookup table of counts, each token becomes a list of numbers (an embedding) learned from data so that words used in similar contexts get similar numbers. A neural network turns the context into probabilities for the next token. This lets the model generalize: it can handle contexts it has never seen exactly. | 2D plot of a few embeddings (good/great/excellent near each other; python/java near each other) |
| 7:30-8:30 | Fix 3: attention | Rather than one previous word, the model looks at the whole preceding text and learns which earlier words matter most for the next one. This is the "transformer" idea in one sentence. Mention context window (how much text it can look at at once). | Sentence with arrows from the word being predicted to earlier words, thickness for importance |
| 8:30-9:30 | Training and scale | Same objective as your model (predict the next token), but on a huge amount of text, with a huge number of adjustable numbers. Then a second stage: fine-tuning, including human feedback, to make it follow instructions and be helpful. Temperature: how much to favor top words versus sample widely (what you changed informally in step 5). | Simple two-stage diagram: pretraining, then fine-tuning |
| 9:30-10:00 | Takeaways | Next-token predictor means plausible, not verified: hallucination. Training data shapes outputs: ties to Question 4, and to the sentiment reading. Link to course AI policy. Preview the check questions. | Three bullet takeaways |

## Notes for recording

- Keep the same words in the video that appear in the activity (token, bigram, probability, sample), so the questions make sense.
- Use a screen recording of the actual R code and output for the first two segments; use simple diagrams for the rest.
- Avoid the words "neural network" and "parameters" without a one-sentence plain definition.
- Facts to double check before recording: current typical vocabulary sizes and context window lengths change quickly, so keep numbers approximate or leave them out.

## Possible check questions (due Wed 10/21)

1. In your own words, what task is the bigram model solving, and how is a large language model's task the same?
2. Give two limitations of the bigram model, and for each, one thing LLMs do differently.
3. Why can an LLM produce a confident, fluent sentence that is false?
4. How did changing the training data in Step 6 change the generated text, and what does that suggest about LLM outputs?
