 
AuroraAI — 4-Minute Town Hall Script
11 slides · POC slide hidden · ~130 words/min

SLIDE 1 — Title (~15 sec)

"Good morning everyone. Today I want to share AuroraAI — an AI system the QSS Aurora Team has built to transform how we handle sanctions screening at BNY. Let's dive in."


SLIDE 2 — The Challenge (~45 sec)

"Here's the problem. Every day, thousands of sanctions alerts come in across AMER, EMEA, and APAC. Each one requires a manual review — 15 to 30 minutes, field by field.
And the painful reality? 73% are false positives. Analysts spending most of their day on cases that were never real threats, with decision quality varying by shift, by analyst, by fatigue.
The opportunity: use AI to eliminate that noise so our people focus only on genuine risk."


SLIDE 3 — What is AuroraAI? (~25 sec)

"AuroraAI is an end-to-end AI platform that takes Bridger sanctions alerts through a 5-agent pipeline, produces a structured recommendation with full rationale, and persists everything to Oracle for regulators. AI recommends — the analyst always decides."


SLIDE 4 — Architecture (~20 sec)

"Five layers: Bridger feeds alerts into our FastAPI backend, through the AI Engine, into Oracle, and up to the analyst's Review Dashboard. Runs on BNY AppEngine, containerised, certificate-authenticated, zero PII leakage."


SLIDE 5 — Multi-Agent AI Pipeline (~45 sec)

"This is the core of AuroraAI — five agents in sequence.
Pre-Processor structures the watchlist data. Analyzer does a field-by-field comparison. Maker renders the decision — true match, false positive, or human review.
Then the Checker — running on a completely different AI model — independently validates that decision. If they disagree, it's escalated to a human. No single point of failure.
Finally, Consolidator rolls everything into one alert-level recommendation.
This Maker-Checker pattern is what gives us consistency and auditability at scale."


SLIDE 6 — User Interaction Flow (~20 sec)

"Simple flow. Alerts in from Bridger, pipeline runs, Oracle stores the result, analyst sees recommendation plus evidence in one dashboard view. They accept or override. The human is always the final decision-maker."


SLIDE 7 — Analyst Benefits (~25 sec)

"For the analyst this is transformative. Review time drops from 30 minutes to 3-5 minutes. Daily throughput goes from 20 alerts to 60-120. No more manual documentation — the audit trail writes itself. And instead of false positives, they're working on real risk."


SLIDE 8 — ROI (~30 sec)

"The numbers speak for themselves. 80% reduction in review time. 4x throughput gain. Just $0.05 per alert. 99.7% pipeline success rate.
False positive handling: analysts were spending time on 73% false positives. With AuroraAI, that falls to 17%. That's the ROI — not just in cost, but in analyst capacity redirected to what matters."


SLIDE 9 — BNY Benefits (~20 sec)

"For BNY: operational efficiency at scale, standardised and auditable compliance decisions, and a model regulators can trust. AI assists — humans control. That's the principle we built on."


SLIDE 10 — Roadmap (~20 sec)

"We're live in EMEA today. Q2-Q3 we expand to AMER and APAC and launch the analyst review portal. By Q4 and beyond — self-learning from analyst feedback, advanced analytics, and new compliance domains. Clear path, fast execution."


SLIDE 11 — Thank You (~15 sec)

"AuroraAI — smarter screening, faster analysts, stronger compliance. The team has built something genuinely impactful here. Thank you, and I'm happy to take questions."
