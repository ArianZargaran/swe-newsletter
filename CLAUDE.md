# Newsletter Bot

## Topic Tracker State

Last sent: 2026-07-15

### Covered topics
- **computer_science**: Binary Numbers, Boolean Logic, Data Structures: Arrays and Linked Lists
- **web_development**: How HTTP Works, REST APIs, HTML and the DOM, CSS Box Model, JavaScript Event Loop
- **software_development**: Version Control with Git
- **ai_engineering**: What is a Neural Network

---

## Scheduled Topics

Rows here take priority over the regular list order. Add a row to lock a specific topic to a specific date. The workflow removes the row after sending.

| Date | Topic | Category |
|------|-------|----------|

---

## Topic Lists

### computer_science (Monday / Friday)
1. ~~Binary Numbers~~ ✓
2. ~~Boolean Logic~~ ✓
3. ~~Data Structures: Arrays and Linked Lists~~ ✓
4. Data Structures: Stacks and Queues
5. Data Structures: Hash Tables
6. Data Structures: Trees
7. Data Structures: Graphs
8. Sorting Algorithms
9. Search Algorithms
10. Recursion
11. Big O Notation
12. Memory Management
13. How CPUs Work
14. Compilers vs Interpreters
15. Operating Systems Basics
16. Concurrency and Parallelism
17. Networking Fundamentals
18. Encryption Basics
19. Databases: SQL vs NoSQL
20. How the Internet Works

### software_development (Tuesday)
1. ~~Version Control with Git~~ ✓
2. Test-Driven Development
3. Code Review Best Practices
4. Continuous Integration and Continuous Delivery
5. Agile and Scrum
6. Design Patterns: Singleton and Factory
7. Design Patterns: Observer and Strategy
8. SOLID Principles
9. Refactoring
10. Technical Debt
11. Documentation Best Practices
12. Semantic Versioning
13. Debugging Techniques
14. Pair Programming
15. The 12-Factor App

### web_development (Wednesday)
1. ~~How HTTP Works~~ ✓
2. ~~REST APIs~~ ✓
3. ~~HTML and the DOM~~ ✓
4. ~~CSS Box Model~~ ✓
5. ~~JavaScript Event Loop~~ ✓
6. How Browsers Render Pages
7. Web Cookies and Sessions
8. HTTPS and TLS
9. WebSockets
10. Content Delivery Networks
11. Progressive Web Apps
12. Web Accessibility
13. Cross-Origin Resource Sharing
14. Frontend vs Backend vs Fullstack
15. GraphQL vs REST

### ai_engineering (Thursday)
1. ~~What is a Neural Network~~ ✓
2. How Large Language Models Work
3. Embeddings and Vector Search
4. Retrieval-Augmented Generation
5. Fine-Tuning vs Prompting
6. Tokens and Context Windows
7. Temperature and Sampling
8. AI Agents and Tool Use
9. Evaluation and Benchmarking
10. Responsible AI and Bias
11. Multimodal Models
12. Reinforcement Learning from Human Feedback
13. Model Quantization
14. Prompt Injection and Security

---

## Daily Newsletter Workflow

**Step 1 — Determine today's category**
Check today's day of the week:
- Monday / Friday → computer_science
- Tuesday → software_development
- Wednesday → web_development
- Thursday → ai_engineering

**Step 2 — Pick the topic**
First, check the "Scheduled Topics" table for a row whose date matches today and whose category matches today's category. If found, use that topic and delete the row from the table before continuing.
Otherwise, from the relevant topic list above, pick the first topic not struck through (✓).
If every topic in the category is covered, remove all strikethroughs in that category and start from the top.

**Step 3 — Write the newsletter**
- Memorable title
- 3–4 paragraphs, plain language (no assumed technical background)
- Spell out every acronym on first use with short form in parentheses
- Bold key terms
- One-sentence takeaway at the end
- 400–600 words, formatted as HTML

Add a tweet box at the bottom:
```html
<div style="margin-top:32px;background:#000;border-radius:16px;padding:20px 24px;font-family:sans-serif;">
  <div style="color:#71767b;font-size:13px;margin-bottom:8px;">𝕏 Share this insight</div>
  <div style="color:#fff;font-size:15px;line-height:1.5;">[TWEET TEXT — max 240 chars, punchy standalone insight]</div>
  <div style="margin-top:12px;color:#1d9bf0;font-size:13px;">[3–4 HASHTAGS]</div>
</div>
```

Hashtag map:
- computer_science → #CS #ComputerScience #TechEducation #LearnCS
- software_development → #SoftwareDev #CleanCode #DevTips #Programming
- web_development → #WebDev #Frontend #BuildForTheWeb #100DaysOfCode
- ai_engineering → #AI #MachineLearning #LLMs #AIEngineering

**Step 4 — Send it**
Load `FROM_EMAIL`, `TO_EMAIL`, and `RESEND_API_KEY` from environment variables.
Using Python with urllib only, POST to https://api.resend.com/emails:
- Authorization: Bearer $RESEND_API_KEY
- from: $FROM_EMAIL
- to: $TO_EMAIL
- subject: the newsletter title
- html: the full HTML newsletter

Include `User-Agent: Mozilla/5.0 (compatible; newsletter-bot/1.0)` in the request headers.
Print the response. If it fails, print the error and exit with code 1.

**Step 5 — Update this file**
After a successful send, update the "Topic Tracker State" section:
- Set "Last sent" to today's date
- Strike through the topic in its list and add ✓

**Step 6 — Commit and push**
```bash
git add CLAUDE.md
git commit -m "sent: <topic> (<date>)"
git push -u origin main
```

If the execution environment is configured to require a feature branch + pull request instead of a direct push to `main` (some sessions are), do this instead:
1. Push the commit to that branch and open a pull request into `main`.
2. Mark the pull request ready for review (not draft).
3. Merge it immediately (this repo has no required CI checks, so there is nothing to wait on — attempting to "enable auto-merge" will just error with "already in clean status"; call the merge endpoint directly instead).

Do not leave a tracker-update PR open (draft or otherwise); that's how the backlog from before got created — a dozen sessions each read stale tracker state from an unmerged `main` and re-picked already-covered topics.

---

## Forward Calendar

When asked "what topics are coming up?" or "show the schedule", simulate the next N newsletter sends (default: 4 weeks ahead) and output a table.

Algorithm:
1. Start from tomorrow's date and walk forward day by day.
2. Skip days with no category (Saturday, Sunday, and weekdays not in the map).
3. For each send day, check "Scheduled Topics" for a pinned entry first.
4. Otherwise simulate picking the next uncovered topic from the relevant list (track a local pointer per category — do not modify the actual lists).
5. Stop after N send days.

Output format:
| Date | Day | Category | Topic |
|------|-----|----------|-------|
| YYYY-MM-DD | Wednesday | web_development | HTML and the DOM |
| … | … | … | … |

Note: this is a read-only preview — it does not update any state.
