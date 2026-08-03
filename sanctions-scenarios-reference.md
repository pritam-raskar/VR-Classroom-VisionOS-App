# Sanctions Alert Scenario Reference

Companion document for the two mock-alert datasets used in the Sanc.AI demo:

- **`sanctions-scenario-alerts-100.json`** — 100 synthetic alerts across 24 scenario families (the 10 presentation scenarios from slides 25+, six real-world archetypes, and eight complex CDE-permutation families).
- **`real-world-sanctions-scenarios.json`** — 27 alerts, each grounded in a documented enforcement case with citations, built for SME-facing presentation.

Both files share the cais-alert-service alert structure. Each alert carries `customFields.decisionContext` with the scenario reference, the rule that fired, and the Maker/Checker decisions; real-world alerts additionally carry `realWorldBasis` (case, year, agency action, screening challenge, outcome, sources, presenter notes).

## Reading the alerts

**Dispositions.** `TRUE_POSITIVE` (TM) — identity confirmed, alert stands. `FALSE_POSITIVE` (FP) — identity contradicted, release with documented reason. `HUMAN_REVIEW` (HR) — evidence conflicts or is insufficient; automation must not decide.

**Field match types** (in `matchAnalysis.matchedFields`):

| Match type | Meaning |
|---|---|
| `EXACT` | Values identical after normalization |
| `STRONG` | High similarity (~0.88+), variants of the same value |
| `FUZZY` | Meaningful similarity, not conclusive alone |
| `PARTIAL` | Structured partial agreement (year-only DOB, truncated ID, city-level address, near-miss digit) |
| `NONE` | Values present on both sides and they contradict |
| `NO_DATA` | Value missing on one or both sides - neither corroborates nor contradicts |

**Scoring.** `totalScore` = overall match score (63–99 across the files). Per-field scenario scores in `reasonDetails` sum exactly to the total. Priority derives from disposition + score (TM ≥95 → Critical; HR ≥78 → High; FP ≥68 → Medium, else Low), which drives `dueIn`/`deadLine`.

---

# Part 1 — Synthetic scenario library (100 alerts)

## 1.1 Presentation scenarios (slides 25+)

The ten scenarios shown in `sanc_ai_Architecture.html`. The first alert in each family is the exact example pair from the slide; the rest are realistic variants across sanctions programs.

### SCN-01 — Fund sponsor / manager relationship

**Route:** business · **Alerts:** 5 (5× TRUE_MATCH) · **Rule:** Step 1 - Fund sponsor / manager relationship

A fund's legal name often embeds its sponsor or asset manager ("X INVESTMENT MANAGEMENT FUND"). When the sponsor is designated, the fund is exposed through the management relationship even where the fund itself is separately incorporated in a clean jurisdiction (Cayman, Luxembourg, DIFC). Real-world anchor: funds managed by sanctioned Russian asset managers post-2022. The decisive CDE is not the name score - it is the FUND_MANAGER relationship field matching the designated party exactly.

**CDE pattern** (representative alert): `NAME` STRONG (90) · `FUND_MANAGER` EXACT (100) · `COUNTRY_OF_INCORPORATION` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090001_TM001` | JP MORGAN INVESTMENT MANAGEMENT FUND | JP MORGAN | 93 | TRUE_MATCH |
| `SANC_20250802090002_TM002` | VOSTOK CAPITAL GROWTH FUND SPC | VOSTOK CAPITAL PJSC | 92 | TRUE_MATCH |
| `SANC_20250802090003_TM003` | PAMIR EQUITY PARTNERS FUND LP | PAMIR EQUITY PARTNERS OOO | 92 | TRUE_MATCH |
| `SANC_20250802090004_TM004` | CASPIAN ENERGY INFRASTRUCTURE FUND SICAV | CASPIAN ENERGY HOLDINGS AO | 91 | TRUE_MATCH |
| `SANC_20250802090005_TM005` | ARIA GLOBAL SUKUK FUND LTD | ARIA HOLDING GROUP | 90 | TRUE_MATCH |

**Per-alert notes:**

- `SANC_20250802090001_TM001` — *Fund sponsor / manager relationship*. Maker: TM - fund is managed by / affiliated with sanctioned sponsor JP MORGAN. Checker: TM - independent re-check of the same facts agrees.
- `SANC_20250802090002_TM002` — *Fund sponsor / manager relationship*. Maker: TM - fund is managed by / affiliated with sanctioned sponsor VOSTOK CAPITAL PJSC. Checker: TM - independent re-check of the same facts agrees.
- `SANC_20250802090003_TM003` — *Fund sponsor / manager relationship*. Maker: TM - fund is managed by / affiliated with sanctioned sponsor PAMIR EQUITY PARTNERS OOO. Checker: TM - independent re-check of the same facts agrees.
- `SANC_20250802090004_TM004` — *Fund sponsor / manager relationship*. Maker: TM - fund is managed by / affiliated with sanctioned sponsor CASPIAN ENERGY HOLDINGS AO. Checker: TM - independent re-check of the same facts agrees.
- `SANC_20250802090005_TM005` — *Fund sponsor / manager relationship*. Maker: TM - fund is managed by / affiliated with sanctioned sponsor ARIA HOLDING GROUP. Checker: TM - independent re-check of the same facts agrees.

### SCN-02 — Sanctioned-state instrumentality

**Route:** business · **Alerts:** 5 (5× TRUE_MATCH) · **Rule:** Step 1 - Sovereign / state instrumentality

Sovereign and quasi-sovereign customers (ministries, state committees, national corporations) hit watchlist entries for instrumentalities of the same sanctioned state. Name overlap is partial ("STATE OF THE RUSSIAN FEDERATION" vs "STATE RESEARCH CENTER OF THE RUSSIAN FEDERATION") but the ENTITY_TYPE=GOVERNMENT plus identical country makes the state-instrumentality rule fire. These are true matches even though the literal string similarity is mediocre - the sanctioned party is the state apparatus itself.

**CDE pattern** (representative alert): `NAME` PARTIAL (82) · `COUNTRY_OF_INCORPORATION` EXACT (100) · `ENTITY_TYPE` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090006_TM006` | STATE OF THE RUSSIAN FEDERATION | STATE RESEARCH CENTER OF THE RUSSIAN FEDERATION | 91 | TRUE_MATCH |
| `SANC_20250802090007_TM007` | MINISTRY OF DEFENCE OF THE RUSSIAN FEDERATION | CENTRAL RESEARCH INSTITUTE NO. 12 OF THE MINISTRY OF DEFENSE OF THE RUSSIAN FEDERATION | 90 | TRUE_MATCH |
| `SANC_20250802090008_TM008` | GOVERNMENT OF THE DEMOCRATIC PEOPLE'S REPUBLIC OF KOREA | STATE HYDROGRAPHIC ADMINISTRATION OF THE DPRK | 90 | TRUE_MATCH |
| `SANC_20250802090009_TM009` | GOVERNMENT OF THE ISLAMIC REPUBLIC OF IRAN | ATOMIC ENERGY RESEARCH ORGANIZATION OF IRAN | 89 | TRUE_MATCH |
| `SANC_20250802090010_TM010` | GOVERNMENT OF THE SYRIAN ARAB REPUBLIC | SCIENTIFIC STUDIES CENTER OF THE SYRIAN ARAB REPUBLIC | 90 | TRUE_MATCH |

**Per-alert notes:**

- `SANC_20250802090006_TM006` — *Sanctioned-state instrumentality*. Maker: TM - STATE RESEARCH CENTER OF THE RUSSIAN FEDERATION is an instrumentality of the sanctioned state. Checker: TM - independent re-check agrees.
- `SANC_20250802090007_TM007` — *Sanctioned-state instrumentality*. Maker: TM - CENTRAL RESEARCH INSTITUTE NO. 12 OF THE MINISTRY OF DEFENSE OF THE RUSSIAN FEDERATION is an instrumentality of the sanctioned state. Checker: TM - independent re-check agrees.
- `SANC_20250802090008_TM008` — *Sanctioned-state instrumentality*. Maker: TM - STATE HYDROGRAPHIC ADMINISTRATION OF THE DPRK is an instrumentality of the sanctioned state. Checker: TM - independent re-check agrees.
- `SANC_20250802090009_TM009` — *Sanctioned-state instrumentality*. Maker: TM - ATOMIC ENERGY RESEARCH ORGANIZATION OF IRAN is an instrumentality of the sanctioned state. Checker: TM - independent re-check agrees.
- `SANC_20250802090010_TM010` — *Sanctioned-state instrumentality*. Maker: TM - SCIENTIFIC STUDIES CENTER OF THE SYRIAN ARAB REPUBLIC is an instrumentality of the sanctioned state. Checker: TM - independent re-check agrees.

### SCN-03 — Multinational subsidiary / division

**Route:** business · **Alerts:** 5 (5× TRUE_MATCH) · **Rule:** Step 1 - Multinational subsidiary

Multinationals appear on lists through specific subsidiaries or divisions incorporated elsewhere. The core name matches strongly while country of incorporation, registration number and (for banks) BIC differ - differences that are EXPECTED for a group structure and therefore must not be treated as contradictions. The rule: same core name + plausible group geography = true match; the country mismatch is neutral, not exculpatory.

**CDE pattern** (representative alert): `NAME` STRONG (94) · `COUNTRY_OF_INCORPORATION` NONE (35) · `REGISTRATION_NUMBER` NO_DATA (0) · `SWIFT_BIC` PARTIAL (70)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090011_TM011` | BARCLAYS BANK PLC | BARCLAYS BANK | 92 | TRUE_MATCH |
| `SANC_20250802090012_TM012` | VNESHPROMTORG BANK PJSC | VNESHPROMTORG BANK (CYPRUS) LTD | 93 | TRUE_MATCH |
| `SANC_20250802090013_TM013` | PARS OIL TRADING GMBH | PARS OIL TRADING COMPANY | 92 | TRUE_MATCH |
| `SANC_20250802090014_TM014` | DALIAN OCEAN LOGISTICS CO LTD | DALIAN OCEAN LOGISTICS PTE LTD | 92 | TRUE_MATCH |
| `SANC_20250802090015_TM015` | AZOV STEEL INTERNATIONAL LLC | AZOV STEEL WORKS OJSC | 91 | TRUE_MATCH |

**Per-alert notes:**

- `SANC_20250802090011_TM011` — *Multinational subsidiary / division*. Maker: TM - same core entity name; geography difference expected for a multinational. Checker: TM - independent re-check agrees.
- `SANC_20250802090012_TM012` — *Multinational subsidiary / division*. Maker: TM - same core entity name; geography difference expected for a multinational. Checker: TM - independent re-check agrees.
- `SANC_20250802090013_TM013` — *Multinational subsidiary / division*. Maker: TM - same core entity name; geography difference expected for a multinational. Checker: TM - independent re-check agrees.
- `SANC_20250802090014_TM014` — *Multinational subsidiary / division*. Maker: TM - same core entity name; geography difference expected for a multinational. Checker: TM - independent re-check agrees.
- `SANC_20250802090015_TM015` — *Multinational subsidiary / division*. Maker: TM - same core entity name; geography difference expected for a multinational. Checker: TM - independent re-check agrees.

### SCN-04 — Generic-word collision

**Route:** business · **Alerts:** 7 (7× FALSE_POSITIVE) · **Rule:** Step 3 - Low similarity + geographic contradiction

The classic false-positive family: two unrelated companies share one generic token (NORDIC, GLOBAL, ATLAS, STAR, DELTA). Name similarity sits in the 0.42-0.55 band, registration country contradicts, industries are unrelated, and no secondary identifier corroborates. These alerts exist to prove the system can release obvious noise quickly - and to calibrate the fuzzy threshold discussion with the SME.

**CDE pattern** (representative alert): `NAME` FUZZY (45) · `COUNTRY_OF_INCORPORATION` NONE (20) · `INDUSTRY` NONE (15)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090016_FP001` | NORDIC TIMBER EXPORTS AS | NORDIC GENERAL TRADING CO | 66 | FALSE_POSITIVE |
| `SANC_20250802090017_FP002` | GLOBAL HORIZON LOGISTICS LLC | GLOBAL HORIZON SHIPPING LINES | 68 | FALSE_POSITIVE |
| `SANC_20250802090018_FP003` | ATLAS PRECISION ENGINEERING LTD | ATLAS EXCHANGE COMPANY | 65 | FALSE_POSITIVE |
| `SANC_20250802090019_FP004` | STAR DAIRY PRODUCTS PTY LTD | STAR TECHNOLOGY TRADING CO | 64 | FALSE_POSITIVE |
| `SANC_20250802090020_FP005` | ORIENT FLOWER EXPORTS BV | ORIENT PETROCHEMICAL INDUSTRIES | 63 | FALSE_POSITIVE |
| `SANC_20250802090021_FP006` | PACIFIC CREST WINERY LLC | PACIFIC TRADING GENERAL LLC | 66 | FALSE_POSITIVE |
| `SANC_20250802090022_FP007` | DELTA AGRO MACHINERY SRL | DELTA PARTS SUPPLY COMPANY | 65 | FALSE_POSITIVE |

### SCN-05 — Priority signal - exact-ID override

**Route:** individual · **Alerts:** 5 (5× TRUE_MATCH) · **Rule:** Step 0 - Priority match signal (deterministic)

The deterministic override: an exact government-issued identifier (passport, national ID) matches on both sides while the name shows transliteration drift. Priority signals fire at Step 0, before any LLM reasoning, and force True Match. Modeled on the slide-25 anchor (ALEKSANDR PETROV / ALEXANDER PETROV, passport 7712345678).

**CDE pattern** (representative alert): `PASSPORT` EXACT (100) · `NAME` FUZZY (84) · `NATIONALITY` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090023_TM016` | ALEKSANDR PETROV | ALEXANDER PETROV | 98 | TRUE_MATCH |
| `SANC_20250802090024_TM017` | SERGEI VOLKOV | SERGEY VOLKOV | 97 | TRUE_MATCH |
| `SANC_20250802090025_TM018` | FATEMEH HOSSEINI | FATIMA HOSEINI | 96 | TRUE_MATCH |
| `SANC_20250802090026_TM019` | RI CHOL SU | LI CHOL-SU | 96 | TRUE_MATCH |
| `SANC_20250802090027_TM020` | VIKTAR KAZLOU | VICTOR KOZLOV | 95 | TRUE_MATCH |

**Per-alert notes:**

- `SANC_20250802090023_TM016` — *Priority signal - exact-ID override*. Maker: TM - exact passport match 7712345678 is a priority signal that overrides name variation. Checker: TM - exact ID match 7712345678 confirms true match despite spelling difference.
- `SANC_20250802090024_TM017` — *Priority signal - exact-ID override*. Maker: TM - exact passport match 7519223344 is a priority signal that overrides name variation. Checker: TM - exact ID match 7519223344 confirms true match despite spelling difference.
- `SANC_20250802090025_TM018` — *Priority signal - exact-ID override*. Maker: TM - exact national id match 0012345678 is a priority signal that overrides name variation. Checker: TM - exact ID match 0012345678 confirms true match despite spelling difference.
- `SANC_20250802090026_TM019` — *Priority signal - exact-ID override*. Maker: TM - exact passport match 927345112 is a priority signal that overrides name variation. Checker: TM - exact ID match 927345112 confirms true match despite spelling difference.
- `SANC_20250802090027_TM020` — *Priority signal - exact-ID override*. Maker: TM - exact passport match MP1234567 is a priority signal that overrides name variation. Checker: TM - exact ID match MP1234567 confirms true match despite spelling difference.

### SCN-06 — Strong name + exact DOB

**Route:** individual · **Alerts:** 5 (5× TRUE_MATCH) · **Rule:** Step 1 - Name match corroborated by exact DOB

Strong-but-not-exact name plus an exact date of birth - two independent identifiers agreeing. This is the bread-and-butter true match: middle names abbreviated, name order normalized ("SMITH, John A."), DOB and nationality exact. The pairing demonstrates corroboration logic rather than single-field matching.

**CDE pattern** (representative alert): `NAME` STRONG (92) · `DOB` EXACT (100) · `NATIONALITY` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090028_TM021` | JOHN ABDUL SMITH | SMITH, John A. | 94 | TRUE_MATCH |
| `SANC_20250802090029_TM022` | CARLOS EDUARDO RAMIREZ TORRES | RAMIREZ TORRES, Carlos | 95 | TRUE_MATCH |
| `SANC_20250802090030_TM023` | ANDREI VLADIMIROVICH MOROZOV | MOROZOV, Andrei | 95 | TRUE_MATCH |
| `SANC_20250802090031_TM024` | ABDUL KARIM AL-NASSER | AL NASSER, Abdulkarim | 94 | TRUE_MATCH |
| `SANC_20250802090032_TM025` | KIM YONG HO | KIM, Yong Ho | 96 | TRUE_MATCH |

**Per-alert notes:**

- `SANC_20250802090028_TM021` — *Strong name + exact DOB*. Maker: TM - strong name similarity plus exact DOB corroboration. Checker: TM - independent re-check of name + DOB agrees.
- `SANC_20250802090029_TM022` — *Strong name + exact DOB*. Maker: TM - strong name similarity plus exact DOB corroboration. Checker: TM - independent re-check of name + DOB agrees.
- `SANC_20250802090030_TM023` — *Strong name + exact DOB*. Maker: TM - strong name similarity plus exact DOB corroboration. Checker: TM - independent re-check of name + DOB agrees.
- `SANC_20250802090031_TM024` — *Strong name + exact DOB*. Maker: TM - strong name similarity plus exact DOB corroboration. Checker: TM - independent re-check of name + DOB agrees.
- `SANC_20250802090032_TM025` — *Strong name + exact DOB*. Maker: TM - strong name similarity plus exact DOB corroboration. Checker: TM - independent re-check of name + DOB agrees.

### SCN-07 — Exact unique ID, different spelling

**Route:** individual · **Alerts:** 5 (5× TRUE_MATCH) · **Rule:** Step 1 - Exact unique ID confirms the person

Same person, two romanizations (MOHAMMED AL-RASHID / MUHAMMAD ALRASHID), joined by an exact unique ID. Unlike SCN-05 the name score here is genuinely low-to-mid (0.77-0.84); the case shows the ID must dominate the name distance, not average with it.

**CDE pattern** (representative alert): `PASSPORT` EXACT (100) · `NAME` FUZZY (80) · `NATIONALITY` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090033_TM026` | MOHAMMED AL-RASHID | MUHAMMAD ALRASHID | 95 | TRUE_MATCH |
| `SANC_20250802090034_TM027` | TAREQ AZIZ HADDAD | TARIQ AZIZ HADAD | 95 | TRUE_MATCH |
| `SANC_20250802090035_TM028` | OSAMA EL-SAYED | USAMA ALSAYYID | 94 | TRUE_MATCH |
| `SANC_20250802090036_TM029` | ZAYNAB KARIMI | ZEINAB KARIMEE | 94 | TRUE_MATCH |
| `SANC_20250802090037_TM030` | ABU BAKR RAHMAN | ABUBAKAR REHMAN | 94 | TRUE_MATCH |

**Per-alert notes:**

- `SANC_20250802090033_TM026` — *Exact unique ID, different spelling*. Maker: TM - transliteration variants of the same name; unique ID X9988776 identical. Checker: TM - independent re-check agrees; unique ID is decisive.
- `SANC_20250802090034_TM027` — *Exact unique ID, different spelling*. Maker: TM - transliteration variants of the same name; unique ID A1122334 identical. Checker: TM - independent re-check agrees; unique ID is decisive.
- `SANC_20250802090035_TM028` — *Exact unique ID, different spelling*. Maker: TM - transliteration variants of the same name; unique ID 28504122100335 identical. Checker: TM - independent re-check agrees; unique ID is decisive.
- `SANC_20250802090036_TM029` — *Exact unique ID, different spelling*. Maker: TM - transliteration variants of the same name; unique ID D8877665 identical. Checker: TM - independent re-check agrees; unique ID is decisive.
- `SANC_20250802090037_TM030` — *Exact unique ID, different spelling*. Maker: TM - transliteration variants of the same name; unique ID KJ0918273 identical. Checker: TM - independent re-check agrees; unique ID is decisive.

### SCN-08 — Common name, no corroboration

**Route:** individual · **Alerts:** 6 (6× HUMAN_REVIEW) · **Rule:** Step 2 - Borderline name, no corroborating CDE -> human review

The human-review boundary: common names (JON SMITH / JOHN SMYTHE) at 0.80-0.85 similarity with NO corroborating CDE on either side - no DOB, no document, sometimes even conflicting nationality. Automation must refuse to decide; the alert routes to an analyst with an explicit statement of what data is missing.

**CDE pattern** (representative alert): `NAME` FUZZY (80) · `DOB` NO_DATA (0) · `PASSPORT` NO_DATA (0) · `NATIONALITY` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090038_HR001` | JON SMITH | JOHN SMYTHE | 78 | HUMAN_REVIEW |
| `SANC_20250802090039_HR002` | DAVID MILLER | DAVID MUELLER | 77 | HUMAN_REVIEW |
| `SANC_20250802090040_HR003` | ANA MARTINS | ANA MARTINEZ | 76 | HUMAN_REVIEW |
| `SANC_20250802090041_HR004` | MOHAMED ALI | MOHAMMAD ALI | 79 | HUMAN_REVIEW |
| `SANC_20250802090042_HR005` | WEI CHEN | CHEN WEI | 78 | HUMAN_REVIEW |
| `SANC_20250802090043_HR006` | IVAN PETROV | IVAN PETROV | 80 | HUMAN_REVIEW |

### SCN-09 — Same name, contradicting identity

**Route:** individual · **Alerts:** 7 (7× FALSE_POSITIVE) · **Rule:** Step 3 - Geographic + DOB contradiction

Identity contradiction despite perfect name match: MARIA GARCIA vs MARIA GARCIA, but DOB decades apart and different countries. Proves the inverse of SCN-06 - a 1.00 name score with contradicting secondary identifiers is a false positive, and the contradiction (not the name) is the evidence.

**CDE pattern** (representative alert): `NAME` EXACT (100) · `DOB` NONE (35) · `NATIONALITY` NONE (25)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090044_FP008` | MARIA GARCIA | MARIA GARCIA | 70 | FALSE_POSITIVE |
| `SANC_20250802090045_FP009` | ALEXANDER PETROV | PETROV, Alexander Mikhailovich | 72 | FALSE_POSITIVE |
| `SANC_20250802090046_FP010` | LI WEI | LI WEI | 69 | FALSE_POSITIVE |
| `SANC_20250802090047_FP011` | AHMED HASSAN | AHMED HASSAN | 68 | FALSE_POSITIVE |
| `SANC_20250802090048_FP012` | JUAN CARLOS PEREZ | PEREZ, Juan Carlos | 70 | FALSE_POSITIVE |
| `SANC_20250802090049_FP013` | OLGA IVANOVA | IVANOVA, Olga | 69 | FALSE_POSITIVE |
| `SANC_20250802090050_FP014` | FATIMA ZAHRA | FATIMA ZAHRA | 67 | FALSE_POSITIVE |

### SCN-10 — Transliterated alias

**Route:** individual · **Alerts:** 4 (4× TRUE_MATCH) · **Rule:** Step 1 - Name match + country

Transliteration pairs within the same country (YUSUF/YOUSSEF, PYOTR/PETR) scoring 0.94-0.97. With matching nationality these resolve as true matches even without DOB - the variance is orthographic, not identity.

**CDE pattern** (representative alert): `NAME` STRONG (96) · `NATIONALITY` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090051_TM031` | YUSUF IBRAHIM | YOUSSEF IBRAHIM | 90 | TRUE_MATCH |
| `SANC_20250802090052_TM032` | ALIAKSEI NAVUMAU | ALEXEI NAUMOV | 89 | TRUE_MATCH |
| `SANC_20250802090053_TM033` | MYKOLA SHEVCHENKO | NIKOLAI SHEVCHENKO | 90 | TRUE_MATCH |
| `SANC_20250802090054_TM034` | HOSSEIN JAFARI | HUSSEIN JAAFARI | 90 | TRUE_MATCH |

**Per-alert notes:**

- `SANC_20250802090051_TM031` — *Transliterated alias*. Maker: TM - very high name similarity 0.96; transliteration variants of the same name. Checker: TM - independent re-check agrees; same country corroborates.
- `SANC_20250802090052_TM032` — *Transliterated alias*. Maker: TM - very high name similarity 0.94; transliteration variants of the same name. Checker: TM - independent re-check agrees; same country corroborates.
- `SANC_20250802090053_TM033` — *Transliterated alias*. Maker: TM - very high name similarity 0.95; transliteration variants of the same name. Checker: TM - independent re-check agrees; same country corroborates.
- `SANC_20250802090054_TM034` — *Transliterated alias*. Maker: TM - very high name similarity 0.95; transliteration variants of the same name. Checker: TM - independent re-check agrees; same country corroborates.

## 1.2 Real-world archetype extensions

Patterns that dominate actual sanctions operations but were not on the slides.

### SCN-11 — Sanctioned ownership - OFAC 50% rule

**Route:** business · **Alerts:** 5 (5× TRUE_MATCH) · **Rule:** Step 1 - Blocked ownership: entity owned 50% or more by an SDN

The OFAC 50 percent rule: the customer's name matches nothing, but ownership data shows a designated parent holding 50%+ (directly or through layers). The OWNERSHIP CDE is the whole case; name score is irrelevant. Mirrors Rusal 2018 and Sberbank 2022 mechanics.

**CDE pattern** (representative alert): `OWNERSHIP` EXACT (100) · `NAME` FUZZY (72) · `COUNTRY_OF_INCORPORATION` NONE (30)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090055_TM035` | URALTECH INDUSTRIAL SOLUTIONS FZE | URALTECH HOLDINGS PJSC | 94 | TRUE_MATCH |
| `SANC_20250802090056_TM036` | SIBNEFT TRADING DMCC | SIBNEFT ENERGY GROUP OJSC | 95 | TRUE_MATCH |
| `SANC_20250802090057_TM037` | BASTION MARITIME SDN BHD | BASTION SHIPPING GROUP LLC | 93 | TRUE_MATCH |
| `SANC_20250802090058_TM038` | KORYO GLOBAL TRADE LIMITED | KORYO DEVELOPMENT BANK | 93 | TRUE_MATCH |
| `SANC_20250802090059_TM039` | MINSK AGRO EXPORT GMBH | BELAGRO STATE CONCERN | 92 | TRUE_MATCH |

**Per-alert notes:**

- `SANC_20250802090055_TM035` — *Sanctioned ownership - OFAC 50% rule*. Maker: TM - 75% sanctioned ownership by URALTECH HOLDINGS PJSC triggers the 50 percent rule. Checker: TM - ownership evidence verified; blocked property.
- `SANC_20250802090056_TM036` — *Sanctioned ownership - OFAC 50% rule*. Maker: TM - 100% sanctioned ownership by SIBNEFT ENERGY GROUP OJSC triggers the 50 percent rule. Checker: TM - ownership evidence verified; blocked property.
- `SANC_20250802090057_TM037` — *Sanctioned ownership - OFAC 50% rule*. Maker: TM - 51% sanctioned ownership by BASTION SHIPPING GROUP LLC triggers the 50 percent rule. Checker: TM - ownership evidence verified; blocked property.
- `SANC_20250802090058_TM038` — *Sanctioned ownership - OFAC 50% rule*. Maker: TM - 60% sanctioned ownership by KORYO DEVELOPMENT BANK triggers the 50 percent rule. Checker: TM - ownership evidence verified; blocked property.
- `SANC_20250802090059_TM039` — *Sanctioned ownership - OFAC 50% rule*. Maker: TM - 55% sanctioned ownership by BELAGRO STATE CONCERN triggers the 50 percent rule. Checker: TM - ownership evidence verified; blocked property.

### SCN-12 — Shell-company network - shared address / registered agent

**Route:** business · **Alerts:** 5 (5× HUMAN_REVIEW) · **Rule:** Step 2 - Network risk: shared address and agent with an SDN -> human review

Shell-network indicators: zero name similarity but the customer shares a registered address and formation agent (or director) with a designated front company. Screening cannot conclude - it escalates with the network evidence attached. Mirrors IRGC/DPRK procurement-front typologies in the UAE, HK and Singapore.

**CDE pattern** (representative alert): `ADDRESS` EXACT (100) · `REGISTERED_AGENT` EXACT (100) · `NAME` NONE (20)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090060_HR007` | BLUE OCEAN GENERAL TRADING FZE | GULF STAR EQUIPMENT FZE | 78 | HUMAN_REVIEW |
| `SANC_20250802090061_HR008` | HARBOUR LIGHT INDUSTRIAL LTD | EVER WINNING TECH CO LTD | 77 | HUMAN_REVIEW |
| `SANC_20250802090062_HR009` | SILVERLINE FREIGHT SERVICES LLC | CARAVAN LOGISTICS FZE | 76 | HUMAN_REVIEW |
| `SANC_20250802090063_HR010` | MERIDIAN ELECTRONICS TRADING PTE LTD | APEX COMPONENT SUPPLY PTE LTD | 79 | HUMAN_REVIEW |
| `SANC_20250802090064_HR011` | WHITE PEAK CONSULTING SRO | DANUBE COMMERCE SRO | 75 | HUMAN_REVIEW |

**Per-alert notes:**

- `SANC_20250802090060_HR007` — *Shell-company network - shared address / registered agent*. Maker: HR - no name similarity, but exact shared address and registered agent with an SDN front company. Checker: HR - agrees; commission deep research on ownership and network links.
- `SANC_20250802090061_HR008` — *Shell-company network - shared address / registered agent*. Maker: HR - no name similarity, but exact shared address and registered agent with an SDN front company. Checker: HR - agrees; commission deep research on ownership and network links.
- `SANC_20250802090062_HR009` — *Shell-company network - shared address / registered agent*. Maker: HR - no name similarity, but exact shared address and registered agent with an SDN front company. Checker: HR - agrees; commission deep research on ownership and network links.
- `SANC_20250802090063_HR010` — *Shell-company network - shared address / registered agent*. Maker: HR - no name similarity, but exact shared address and registered agent with an SDN front company. Checker: HR - agrees; commission deep research on ownership and network links.
- `SANC_20250802090064_HR011` — *Shell-company network - shared address / registered agent*. Maker: HR - no name similarity, but exact shared address and registered agent with an SDN front company. Checker: HR - agrees; commission deep research on ownership and network links.

### SCN-13 — Vessel - exact IMO match, flag hopped

**Route:** vessel · **Alerts:** 5 (3× TRUE_MATCH, 2× FALSE_POSITIVE) · **Rule:** Step 0 - IMO number is a unique hull identifier; exact match is deterministic

Vessel screening basics: the IMO number is the hull's immutable identifier. Exact IMO = true match even when name, flag or type diverge (rename/reflag evasion); same name with different IMO = false positive (vessel names are not unique). Includes flag-hopping and rename-with-IMO-retention patterns.

**CDE pattern** (representative alert): `IMO_NUMBER` EXACT (100) · `NAME` EXACT (100) · `FLAG` NONE (20)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090065_TM040` | OCEAN PIONEER | OCEAN PIONEER | 98 | TRUE_MATCH |
| `SANC_20250802090066_TM041` | SEA DELIGHT | CASPIAN GLORY | 97 | TRUE_MATCH |
| `SANC_20250802090067_TM042` | PARS TRIUMPH | PARS TRIUMPH | 99 | TRUE_MATCH |
| `SANC_20250802090068_FP015` | STAR FORTUNE | STAR FORTUNE | 68 | FALSE_POSITIVE |
| `SANC_20250802090069_FP016` | ATLANTIC BREEZE | ATLANTIC BREEZE | 66 | FALSE_POSITIVE |

**Per-alert notes:**

- `SANC_20250802090065_TM040` — *Vessel - exact IMO match, flag hopped*. Maker: TM - IMO is immutable for the hull; exact IMO match is deterministic. Checker: TM - flag hop noted as evasion typology; match confirmed.
- `SANC_20250802090066_TM041` — *Vessel - renamed hull, exact IMO match*. Maker: TM - rename does not change the hull; IMO 9218296 is the designated vessel. Checker: TM - former-name alias corroborates; match confirmed.
- `SANC_20250802090067_TM042` — *Vessel - name + IMO both exact*. Maker: TM - all vessel identifiers exact. Checker: TM - confirmed.
- `SANC_20250802090068_FP015` — *Vessel - same name, different IMO*. Maker: FP - IMO mismatch identifies a different hull despite identical name. Checker: FP - IMO contradiction is definitive.
- `SANC_20250802090069_FP016` — *Vessel - same name, different IMO and type*. Maker: FP - IMO, flag and vessel type all contradict. Checker: FP - different hull confirmed.

### SCN-14 — Approximate / year-only watchlist DOB

**Route:** individual · **Alerts:** 4 (4× HUMAN_REVIEW) · **Rule:** Step 2 - Strong name but DOB only partially corroborates -> human review

Watchlist DOB data quality: many list entries carry only a year or 'circa' range. A consistent year corroborates weakly - it narrows but cannot confirm. With no unique ID these stay in human review and become candidates for deep research / RFI.

**CDE pattern** (representative alert): `NAME` STRONG (93) · `YEAR_OF_BIRTH` PARTIAL (70) · `NATIONALITY` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090070_HR012` | RUSLAN GAZIEV | GAZIYEV, Ruslan | 82 | HUMAN_REVIEW |
| `SANC_20250802090071_HR013` | NADIA SALEH | SALIH, Nadya | 81 | HUMAN_REVIEW |
| `SANC_20250802090072_HR014` | JEAN-PIERRE MULAMBA | MULAMBA, Jean Pierre | 80 | HUMAN_REVIEW |
| `SANC_20250802090073_HR015` | WIN MYINT AUNG | AUNG, Win Myint | 80 | HUMAN_REVIEW |

**Per-alert notes:**

- `SANC_20250802090070_HR012` — *Approximate / year-only watchlist DOB*. Maker: HR - strong name and consistent birth year, but watchlist DOB 'circa 1978-1980' is approximate and no unique ID exists. Checker: HR - agrees; escalate for identity documents / deep research.
- `SANC_20250802090071_HR013` — *Approximate / year-only watchlist DOB*. Maker: HR - strong name and consistent birth year, but watchlist DOB '1984' is approximate and no unique ID exists. Checker: HR - agrees; escalate for identity documents / deep research.
- `SANC_20250802090072_HR014` — *Approximate / year-only watchlist DOB*. Maker: HR - strong name and consistent birth year, but watchlist DOB 'approximately 1964-1966' is approximate and no unique ID exists. Checker: HR - agrees; escalate for identity documents / deep research.
- `SANC_20250802090073_HR015` — *Approximate / year-only watchlist DOB*. Maker: HR - strong name and consistent birth year, but watchlist DOB '1970' is approximate and no unique ID exists. Checker: HR - agrees; escalate for identity documents / deep research.

### SCN-15 — Customer name matches SDN alias (AKA)

**Route:** individual · **Alerts:** 3 (3× TRUE_MATCH) · **Rule:** Step 1 - AKA is an equal-strength identifier to the primary name

AKA hits: the customer's legal name matches a REGISTERED alias of the designee, not the primary name. A listed strong alias carries the same evidentiary weight as the primary; the alert shows alias-set matching plus DOB corroboration where available.

**CDE pattern** (representative alert): `ALIAS` EXACT (100) · `NAME` NONE (25) · `NATIONALITY` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090074_TM043` | ABU YUSUF AL-SHAMI | AL-HALABI, Khalid Abdulrahman | 92 | TRUE_MATCH |
| `SANC_20250802090075_TM044` | VIKTOR BARANOV | SAVELYEV, Viktor | 94 | TRUE_MATCH |
| `SANC_20250802090076_TM045` | HAJI BASHIR | KHAN, Abdul Bashir | 93 | TRUE_MATCH |

**Per-alert notes:**

- `SANC_20250802090074_TM043` — *Customer name matches SDN alias (AKA)*. Maker: TM - exact match against registered AKA 'ABU YUSUF AL-SHAMI' of SDN 37401. Checker: TM - alias verified against the list entry; match confirmed.
- `SANC_20250802090075_TM044` — *Customer name matches SDN alias (AKA)*. Maker: TM - exact match against registered AKA 'VIKTOR BARANOV' of SDN 37402. Checker: TM - alias verified against the list entry; match confirmed.
- `SANC_20250802090076_TM045` — *Customer name matches SDN alias (AKA)*. Maker: TM - exact match against registered AKA 'HAJI BASHIR' of SDN 37403. Checker: TM - alias verified against the list entry; match confirmed.

### SCN-16 — Similar name, ID documents contradict

**Route:** individual · **Alerts:** 3 (3× FALSE_POSITIVE) · **Rule:** Step 3 - Distinct government-issued IDs prove different persons

ID-contradiction false positives: high name similarity but each party holds a distinct government-issued document from a different issuing state. Distinct IDs are treated as near-definitive proof of different persons.

**CDE pattern** (representative alert): `NAME` FUZZY (88) · `PASSPORT` NONE (0) · `NATIONALITY` NONE (25)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090077_FP017` | KAMAL NASSER | NASIR, Kamal | 72 | FALSE_POSITIVE |
| `SANC_20250802090078_FP018` | ELENA POPOVA | POPOVA, Elena | 71 | FALSE_POSITIVE |
| `SANC_20250802090079_FP019` | YOUSSEF AMIN | AMIN, Yusuf | 70 | FALSE_POSITIVE |

**Per-alert notes:**

- `SANC_20250802090077_FP017` — *Similar name, ID documents contradict*. Maker: FP - passport JO4455667 contradicts watchlist passport K8877441. Checker: FP - distinct IDs from different issuing states are definitive.
- `SANC_20250802090078_FP018` — *Similar name, ID documents contradict*. Maker: FP - passport MD2004556 contradicts watchlist passport 7211334455. Checker: FP - distinct IDs from different issuing states are definitive.
- `SANC_20250802090079_FP019` — *Similar name, ID documents contradict*. Maker: FP - passport LR0099887 contradicts watchlist passport E1122334. Checker: FP - distinct IDs from different issuing states are definitive.

## 1.3 Complex CDE permutations

Deliberate permutations of corroborating, contradicting and missing CDEs — same fields, different outcomes depending on what else is present. Built for the 'how does the framework weigh conflicting evidence' conversation.

### SCN-17 — Conflicting priority signals - exact ID vs DOB contradiction

**Route:** individual · **Alerts:** 3 (3× HUMAN_REVIEW) · **Rule:** Step 2 - Priority signal contradicted by another CDE -> human review

Conflicting priority signals - the hardest individual pattern. An exact passport or national ID (normally a Step-0 override) collides with a hard biographic contradiction (DOB decades apart, unrelated name). Possible causes: reissued document numbers, stolen identity, list data error, family document reuse. Neither the TM override nor the FP contradiction may win automatically; these must land in human review.

**CDE pattern** (representative alert): `PASSPORT` EXACT (100) · `NAME` STRONG (90) · `DOB` NONE (15) · `NATIONALITY` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090080_HR016` | IGOR LEBEDEV | LEBEDEV, Igor | 84 | HUMAN_REVIEW |
| `SANC_20250802090081_HR017` | AMIR TAVAKOLI | GHORBANI, Reza | 80 | HUMAN_REVIEW |
| `SANC_20250802090082_HR018` | PAVEL ROMANOV | ROMANOV, Pavel | 85 | HUMAN_REVIEW |

**Per-alert notes:**

- `SANC_20250802090080_HR016` — *Conflicting priority signals - exact ID vs DOB contradiction*. Maker: HR - exact passport match cannot be reconciled with a 1990 vs 1958 DOB; conflicting priority signals. Checker: HR - agrees; verify document authenticity and list data before deciding.
- `SANC_20250802090081_HR017` — *Conflicting priority signals - exact national ID, unrelated name*. Maker: HR - exact melli-code match with zero name similarity; cannot attribute the ID safely. Checker: HR - agrees; request identity documents / deep research.
- `SANC_20250802090082_HR018` — *Conflicting priority signals - passport + name exact, DOB contradicts*. Maker: HR - exact name + passport vs generational DOB gap; conflicting evidence. Checker: HR - agrees; do not auto-block a possible relative.

### SCN-18 — DOB transposition, no other identifiers

**Route:** individual · **Alerts:** 3 (1× HUMAN_REVIEW, 2× TRUE_MATCH) · **Rule:** Step 2 - Exact name + transposed DOB, nothing else -> human review

DOB near-miss taxonomy: day/month transposition (03-12 vs 12-03), single-digit typo, year-off-by-one. Outcome depends entirely on what else corroborates - transposition alone stays HR; a near-miss plus exact POB or full street address resolves TM as a data-entry artifact. Shows graduated DOB tolerance instead of binary equality.

**CDE pattern** (representative alert): `NAME` EXACT (100) · `DOB` PARTIAL (65) · `NATIONALITY` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090083_HR019` | ANTON KRAVTSOV | KRAVTSOV, Anton | 83 | HUMAN_REVIEW |
| `SANC_20250802090084_TM046` | LEILA REZVANI | REZVANI, Leila | 91 | TRUE_MATCH |
| `SANC_20250802090085_TM047` | BORIS ANTONOV | ANTONOV, Boris | 92 | TRUE_MATCH |

**Per-alert notes:**

- `SANC_20250802090083_HR019` — *DOB transposition, no other identifiers*. Maker: HR - exact name, transposed DOB; cannot distinguish keying error from different person. Checker: HR - agrees; transposition ambiguity needs documents.
- `SANC_20250802090084_TM046` — *Single-digit DOB error, POB corroborates*. Maker: TM - single-digit DOB variance outweighed by exact POB + strong name. Checker: TM - independent re-check agrees; corroboration is decisive.
- `SANC_20250802090085_TM047` — *Year-off-by-one DOB, address corroborates*. Maker: TM - exact name and exact street address; one-year DOB gap is within list tolerance. Checker: TM - agrees; address match is decisive.

### SCN-19 — Second citizenship matches, primary contradicts

**Route:** individual · **Alerts:** 3 (2× TRUE_MATCH, 1× HUMAN_REVIEW) · **Rule:** Step 1 - Citizenship set overlap + YOB corroboration

Dual nationality: the primary nationality field contradicts while the citizenship SET overlaps (naturalized customers retaining origin citizenship). With DOB corroboration these are true matches; with no biographic anchor they stay HR. Screening must compare citizenship sets, not single values.

**CDE pattern** (representative alert): `NAME` STRONG (92) · `NATIONALITY` NONE (30) · `SECOND_CITIZENSHIP` EXACT (100) · `DOB` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090086_TM048` | MARAT ISMAILOV | ISMAILOV, Marat | 90 | TRUE_MATCH |
| `SANC_20250802090087_HR020` | NASRIN FARAHANI | FARAHANI, Nasrin | 79 | HUMAN_REVIEW |
| `SANC_20250802090088_TM049` | HALIM DARWISH | DARWISH, Halim | 93 | TRUE_MATCH |

**Per-alert notes:**

- `SANC_20250802090086_TM048` — *Second citizenship matches, primary contradicts*. Maker: TM - RU second citizenship + exact DOB override the primary-nationality mismatch. Checker: TM - agrees; citizenship-set comparison, not primary-only.
- `SANC_20250802090087_HR020` — *Second citizenship matches, no DOB either side*. Maker: HR - name + second citizenship suggestive but uncorroborated. Checker: HR - agrees; commission deep research.
- `SANC_20250802090088_TM049` — *Naturalized citizen, origin citizenship + DOB match*. Maker: TM - retained SY citizenship + exact DOB; naturalization is not exculpatory. Checker: TM - agrees.

### SCN-20 — Name-order swap + exact DOB + partial ID

**Route:** individual · **Alerts:** 2 (1× TRUE_MATCH, 1× HUMAN_REVIEW) · **Rule:** Step 1 - Order-insensitive name match corroborated by DOB and partial ID

Name-order permutations: surname-first conventions (Chinese, Hungarian) make token-identical names look different to naive comparators. Order-insensitive matching plus whatever corroboration exists (DOB, partial ID, city) determines the outcome - and order-swap also makes names MORE common, which cuts the other way.

**CDE pattern** (representative alert): `NAME` STRONG (89) · `DOB` EXACT (100) · `NATIONAL_ID` PARTIAL (75) · `NATIONALITY` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090089_TM050` | ZHANG WEI MING | WEI MING ZHANG | 93 | TRUE_MATCH |
| `SANC_20250802090090_HR021` | KOVACS ISTVAN | ISTVAN KOVACS | 78 | HUMAN_REVIEW |

**Per-alert notes:**

- `SANC_20250802090089_TM050` — *Name-order swap + exact DOB + partial ID*. Maker: TM - token-identical name under order swap; DOB exact; partial ID consistent. Checker: TM - agrees; ordering is a rendering artifact, not a difference.
- `SANC_20250802090090_HR021` — *Name-order swap, city-only corroboration*. Maker: HR - very common name under natural order swap; corroboration is city-level only. Checker: HR - agrees; escalate for identifiers.

### SCN-21 — POB + full address corroborate, DOB missing

**Route:** individual · **Alerts:** 2 (1× TRUE_MATCH, 1× HUMAN_REVIEW) · **Rule:** Step 1 - Two independent geographic CDEs + strong name

Geographic corroboration when DOB is absent: exact place of birth AND exact street address are two independent confirmations (TM); a single city-level POB on a common name is not enough (HR). Counts corroborators instead of relying on one field class.

**CDE pattern** (representative alert): `NAME` STRONG (92) · `PLACE_OF_BIRTH` EXACT (100) · `ADDRESS` EXACT (100) · `DOB` NO_DATA (0)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090091_TM051` | TAREK MASRI | AL-MASRI, Tarek | 89 | TRUE_MATCH |
| `SANC_20250802090092_HR022` | FARID AZIMI | AZIMI, Farid | 80 | HUMAN_REVIEW |

**Per-alert notes:**

- `SANC_20250802090091_TM051` — *POB + full address corroborate, DOB missing*. Maker: TM - POB and street address both exact; DOB absence is not a contradiction. Checker: TM - agrees; two independent corroborators.
- `SANC_20250802090092_HR022` — *POB matches, single corroborator only*. Maker: HR - one corroborator is insufficient for a common name. Checker: HR - agrees; escalate.

### SCN-22 — Registry-confirmed entity match

**Route:** business · **Alerts:** 4 (2× TRUE_MATCH, 1× FALSE_POSITIVE, 1× HUMAN_REVIEW) · **Rule:** Step 1 - Exact registration number + strong name + country

Entity registry/BIC permutations: exact registry number with translated suffix (OOO/LLC) = TM; identical generic name anchored to different registries = FP; exact SWIFT BIC with translated name = TM (a BIC identifies one institution); strong name + same niche industry with UNKNOWN ownership = HR pending corporate research.

**CDE pattern** (representative alert): `NAME` STRONG (93) · `REGISTRATION_NUMBER` EXACT (100) · `COUNTRY_OF_INCORPORATION` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090093_TM052` | TAVRIA SHIPPING LLC | TAVRIA SHIPPING OOO | 95 | TRUE_MATCH |
| `SANC_20250802090094_FP020` | MERCURY TRADING LLC | MERCURY TRADING LLC | 72 | FALSE_POSITIVE |
| `SANC_20250802090095_TM053` | KAVKAZ INVEST BANK AO | INVESTMENT BANK OF THE CAUCASUS | 94 | TRUE_MATCH |
| `SANC_20250802090096_HR023` | POLARIS ENERGY TRADING DMCC | POLARIS ENERGY LLC | 82 | HUMAN_REVIEW |

**Per-alert notes:**

- `SANC_20250802090093_TM052` — *Registry-confirmed entity match*. Maker: TM - exact OGRN; suffix difference is translation, not identity. Checker: TM - registry number is decisive.
- `SANC_20250802090094_FP020` — *Identical common name, different registries*. Maker: FP - identical generic name, disjoint registries and jurisdictions. Checker: FP - registry contradiction is definitive.
- `SANC_20250802090095_TM053` — *Payment screening - exact BIC, translated name*. Maker: TM - BIC KVIBRUMM is unique to the designated bank; name gap is translation. Checker: TM - BIC match is decisive.
- `SANC_20250802090096_HR023` — *Strong name + same industry, ownership unknown*. Maker: HR - subsidiary hypothesis plausible but ownership chain unverified. Checker: HR - agrees; commission corporate-registry deep research.

### SCN-23 — Former name matches SDN alias

**Route:** business · **Alerts:** 2 (1× TRUE_MATCH, 1× HUMAN_REVIEW) · **Rule:** Step 1 - Former legal name equals listed alias; rename is not exculpatory

Rename and threshold edge-cases: a post-designation rename where the former legal name equals the listed alias (registry continuity proves same legal person, TM); and 49% ownership - below the 50% rule - combined with a shared director indicating control-in-fact (HR: the rule does not block, but control may).

**CDE pattern** (representative alert): `FORMER_NAME` EXACT (100) · `NAME` NONE (20) · `ADDRESS` PARTIAL (55) · `COUNTRY_OF_INCORPORATION` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090097_TM054` | ATLANTIC GRAIN LOGISTICS SA | CHERNOMORSK GRAIN EXPORT SA | 91 | TRUE_MATCH |
| `SANC_20250802090098_HR024` | RIGA TRANSIT TERMINAL SIA | BALTIC GATEWAY HOLDINGS OOO | 77 | HUMAN_REVIEW |

**Per-alert notes:**

- `SANC_20250802090097_TM054` — *Former name matches SDN alias*. Maker: TM - rename post-designation; former name matches listed alias exactly. Checker: TM - registry continuity confirms the same legal person.
- `SANC_20250802090098_HR024` — *49% SDN ownership + shared director*. Maker: HR - 49% ownership does not trigger the rule, but shared directorship indicates possible control. Checker: HR - agrees; assess control-in-fact and aggregation with other SDN holders.

### SCN-24 — IMO digit error, call sign corroborates

**Route:** vessel · **Alerts:** 2 (1× TRUE_MATCH, 1× HUMAN_REVIEW) · **Rule:** Step 1 - Invalid-checksum list IMO + exact name, call sign and flag

Vessel identifier conflicts: a list IMO that fails the check-digit algorithm against an otherwise exact vessel (call sign, name, flag all match - list typo, TM); and a fuzzy-named vessel with NO customer IMO on file, matching type but contradicting flag (HR until the IMO is obtained).

**CDE pattern** (representative alert): `NAME` EXACT (100) · `IMO_NUMBER` PARTIAL (85) · `CALL_SIGN` EXACT (100) · `FLAG` EXACT (100)

| Alert | Customer | Watchlist entity | Score | Disposition |
|---|---|---|---|---|
| `SANC_20250802090099_TM055` | GOLDEN WAVE | GOLDEN WAVE | 90 | TRUE_MATCH |
| `SANC_20250802090100_HR025` | LUCKY STAR VIII | LUCKY STAR | 76 | HUMAN_REVIEW |

**Per-alert notes:**

- `SANC_20250802090099_TM055` — *IMO digit error, call sign corroborates*. Maker: TM - list IMO fails checksum; call sign + name + flag all exact. Checker: TM - agrees; identifiers converge on one hull.
- `SANC_20250802090100_HR025` — *Name variant, customer IMO missing*. Maker: HR - missing IMO leaves only weak/mixed identifiers. Checker: HR - agrees; obtain IMO / inspect vessel documents.

---

# Part 2 — Real-world scenario file (27 alerts)

Every alert below is grounded in a documented case. Watchlist-side names, programs, IMO numbers and dates come from the public record; customer-side records are fictionalized where the real case had no public customer party (marked *modeled on* in the alert narrative). `realWorldBasis.presenterNotes` carries the SME talking point.

## 2.1 Entity & ownership evasion

### RW-01 — 50% rule - unlisted subsidiary of a designated parent (Rusal)

**Alert:** `SANCRW_20250802100001_TM001` · **Disposition:** TRUE_MATCH · **Score:** 95 · **Route:** business · **List:** OFAC_SDN · **Programs:** UKRAINE-EO13661, UKRAINE-EO13662

**Screened pair:** KRASNOYARSK ALUMINIUM PRODUCTS LLC → UNITED COMPANY RUSAL PLC (entry 41001)

**The real case — Oleg Deripaska - EN+ / RUSAL / GAZ Group designations and delisting (2018-2019).** OFAC designated Deripaska and eight companies he owned or controlled. Via the 50% rule the blocking automatically extended to hundreds of unlisted subsidiaries worldwide - Rusal alone was ~7% of world aluminium supply. Under the delisting agreement the companies cut Deripaska's stake below 50% and rebuilt their boards; the same entity names then went from blocked to non-blocked with zero name change.

**Agency action:** OFAC SDN designations (2018-04-06); En+/Rusal/EuroSibEnergo delisted 2019-01-27 after ownership restructuring (Barker plan)

**Why screening is hard here:** The SDN list named only 8 entities but the 50% rule blocked an unlisted global subsidiary tree - name-matching alone missed most blocked parties. The delisting inverted the problem: screening outcomes depended on cap-table data, not names.

**Outcome:** En+, Rusal, EuroSibEnergo delisted 2019-01-27 under OFAC oversight; Deripaska remains an SDN and was indicted for sanctions evasion (SDNY, 2022).

**How the alert models it:** `OWNERSHIP` EXACT (100) · `NAME` NONE (20) · `COUNTRY_OF_INCORPORATION` NONE (30)

**Rule fired:** Step 1 - Blocked ownership: entity owned 50%+ by a blocked person (never itself listed)  
**Maker:** TM - blocked by ownership: 100% subsidiary of designated Rusal; list lookup on the customer name finds nothing  
**Checker:** TM - ownership evidence verified; 50 percent rule applies

**Presenter notes:** Ask the SME: how does your screening stack resolve ownership when the counterparty name has no list hit? This case is why ownership-graph screening (Orbis/GRID) exists.

**Sources:**
- <https://home.treasury.gov/news/press-releases/sm0338>
- <https://ofac.treasury.gov/system/files/126/20181219_notification_removal.pdf>

### RW-02 — Front network - clean-named intermediary for a designated bank (DHID/KKBC)

**Alert:** `SANCRW_20250802100002_HR001` · **Disposition:** HUMAN_REVIEW · **Score:** 80 · **Route:** business · **List:** OFAC_SDN · **Programs:** NPWMD

**Screened pair:** LIAONING BRIGHT FUTURE TRADING CO LTD → DANDONG HONGXIANG INDUSTRIAL DEVELOPMENT CO LTD (entry 41002)

**The real case — Dandong Hongxiang Industrial Development (DHID) / Ma Xiaohong - front network for DPRK's KKBC (2016).** DHID, a Dandong trading company, ran U.S.-dollar payments for Korea Kwangson Banking Corporation (KKBC, designated 2009) through shells in Hong Kong, BVI, Seychelles and Anguilla, concealing KKBC from the payment chain and moving the money through U.S. correspondent banks.

**Agency action:** OFAC designations under E.O. 13382 (2016-09-26); DOJ indictment (D.N.J.) of DHID and four executives; civil forfeiture against funds in 25 Chinese bank accounts

**Why screening is hard here:** The designated bank never appeared in any payment message - clean-named third-country fronts with no lexical or country link to DPRK defeated list-based screening; detection required beneficial-ownership and trade-pattern analysis.

**Outcome:** Executives indicted but never extradited; forfeiture actions filed; designations stand.

**How the alert models it:** `DIRECTOR` EXACT (100) · `ADDRESS` PARTIAL (70) · `NAME` NONE (15)

**Rule fired:** Step 2 - Network risk: shared officers/address with designated network -> human review  
**Maker:** HR - officer and geography link to the DHID/KKBC network; no direct list match on the entity name  
**Checker:** HR - agrees; commission ownership and trade-pattern research

**Presenter notes:** Great SME discussion: your alert fires not on the name but on network CDEs (director, address). Ask how many of their current rules could catch a DHID.

**Sources:**
- <https://home.treasury.gov/news/press-releases/jl5059>
- <https://www.justice.gov/archives/opa/pr/four-chinese-nationals-and-chinese-company-indicted-conspiracy-defraud-united-states-and>

### RW-03 — Serial fronts - rotating clean-named companies (Karl Lee network)

**Alert:** `SANCRW_20250802100003_HR002` · **Disposition:** HUMAN_REVIEW · **Score:** 82 · **Route:** business · **List:** OFAC_SDN · **Programs:** NPWMD

**Screened pair:** DALIAN NEW METALLURGY IMP AND EXP CO LTD → LIMMT ECONOMIC AND TRADE COMPANY LTD (entry 41003)

**The real case — Li Fangwei ('Karl Lee') / LIMMT - Iran ballistic-missile procurement via serial fronts (2006-2014 (network indicted again 2023)).** After LIMMT's 2006 designation cut it off from the U.S. financial system, Li kept selling controlled missile materials to sanctioned Iranian entities by continuously creating new, innocuous-named front companies that transacted in dollars through U.S. correspondent banks.

**Agency action:** OFAC E.O. 13382 designations (LIMMT 2006; eight more fronts 2014-04); SDNY indictment unsealed 2014-04-29; ~$6.9M seized from correspondent accounts; $5M State Dept reward

**Why screening is hard here:** Whack-a-mole: every new front was clean at screening time; only officer/address/sector continuity connected them to the designated principal.

**Outcome:** Li remains a fugitive with a standing $5M reward; 2023 SDNY indictment of Sinotech Dalian shows the network still operating.

**How the alert models it:** `DIRECTOR` EXACT (100) · `ADDRESS` PARTIAL (65) · `INDUSTRY` STRONG (85) · `NAME` NONE (30)

**Rule fired:** Step 2 - Officer/address continuity with designated network -> human review  
**Maker:** HR - name clean but principal, city and sector all match the LIMMT/Li Fangwei procurement network  
**Checker:** HR - agrees; escalate to network investigation

**Presenter notes:** Use this to argue for perpetual-KYC / event-driven rescreening: a fresh incorporation with a known principal should re-trigger screening even with a clean name.

**Sources:**
- <https://www.justice.gov/archives/opa/pr/karl-lee-charged-manhattan-federal-court-using-web-front-companies-evade-us-sanctions>
- <https://2021-2025.state.gov/transnational-organized-crime-rewards-program-2/li-fangwei/>

### RW-04 — Designated shell with a benign profile (Group Grand Limited)

**Alert:** `SANCRW_20250802100004_TM002` · **Disposition:** TRUE_MATCH · **Score:** 96 · **Route:** business · **List:** OFAC_SDN · **Programs:** VENEZUELA-EO13850

**Screened pair:** GROUP GRAND LIMITED → GROUP GRAND LIMITED (entry 41004)

**The real case — Alex Saab network - Venezuela CLAP food-program corruption through offshore shells (2019-2026).** Saab and Pulido obtained overvalued no-bid CLAP food-import contracts through bribes to the Maduro regime and moved ~$350M through shells registered in Hong Kong, UAE and Turkey - including Group Grand Limited, the HK company at the center of the food contracts.

**Agency action:** OFAC designations under E.O. 13850 (2019-07-25); DOJ S.D.Fla. money-laundering indictment; extradited from Cabo Verde 2021; released in 2023 prisoner exchange; re-arrested 2026

**Why screening is hard here:** The operating entities had clean names, third-country registrations and nominee ownership; counterparty screening saw benign Hong Kong/UAE trading companies, not a sanctioned corruption network.

**Outcome:** Saab extradited (2021), released in a prisoner exchange (2023), re-arrested in Miami (2026); designations remain.

**How the alert models it:** `NAME` EXACT (100) · `COUNTRY_OF_INCORPORATION` EXACT (100) · `REGISTRATION_NUMBER` NO_DATA (0)

**Rule fired:** Step 1 - Exact name + registry match on a designated entity  
**Maker:** TM - exact name and jurisdiction match on designated entity  
**Checker:** TM - confirmed; note benign industry profile is typical of this network

**Presenter notes:** Point for SMEs: even a perfect TM here happens only AFTER designation - the network operated for years pre-listing. Segue into adverse-media/deep-research capability.

**Sources:**
- <https://home.treasury.gov/news/press-releases/sm741>
- <https://www.justice.gov/opa/pr/maduro-regime-ally-alex-saab-arrested-money-laundering-charges-involving-venezuelan-food>

### RW-05 — Layered offshore ownership below the visible list (Gertler)

**Alert:** `SANCRW_20250802100005_TM003` · **Disposition:** TRUE_MATCH · **Score:** 93 · **Route:** business · **List:** OFAC_SDN · **Programs:** GLOMAG

**Screened pair:** LORA ENTERPRISES LIMITED → FLEURETTE PROPERTIES LIMITED (entry 41005)

**The real case — Dan Gertler - Global Magnitsky designation, DRC mining rights via layered offshore holdings (2017-2018).** Treasury cited opaque, corrupt DRC mining/oil deals leveraging Gertler's friendship with President Kabila, with estimates the DRC lost over $1.36B in 2010-2012 from underpriced asset sales to Gertler-linked offshores. Interests were held through dozens of layered holdcos in Gibraltar/BVI - OFAC needed a second tranche six months later.

**Agency action:** OFAC designation in E.O. 13818 annex (2017-12-21) with Fleurette Properties and ~19 companies; 14 more affiliates designated 2018-06-15; 2021 license issued then revoked

**Why screening is hard here:** Ownership fragmented across a deep offshore structure - many holding/operating companies were blocked under the 50% rule without ever being listed; NGO reporting later documented suspected continued activity via new companies and family/associate proxies.

**Outcome:** Designations in force; the January 2021 broad license was revoked in March 2021 after bipartisan objections.

**How the alert models it:** `OWNERSHIP` EXACT (100) · `NAME` NONE (15) · `COUNTRY_OF_INCORPORATION` EXACT (100)

**Rule fired:** Step 1 - Blocked ownership through multi-tier offshore chain  
**Maker:** TM - indirect 65% ownership by designated Fleurette through layered holdcos  
**Checker:** TM - ownership chain verified across both tiers

**Presenter notes:** Demo angle: this is why your ownership traversal must be multi-tier, not single-hop - the match is invisible at one level of depth.

**Sources:**
- <https://home.treasury.gov/news/press-releases/sm0243>
- <https://home.treasury.gov/news/press-releases/sm0417>

### RW-06 — Foreign subsidiary masking a designated principal (Meroe Gold)

**Alert:** `SANCRW_20250802100006_TM004` · **Disposition:** TRUE_MATCH · **Score:** 97 · **Route:** business · **List:** OFAC_SDN · **Programs:** ELECTION-EO13848

**Screened pair:** MEROE GOLD CO LTD → MEROE GOLD CO. LTD. (entry 41006)

**The real case — Yevgeniy Prigozhin - M-Invest / Meroe Gold as Wagner-linked fronts in Sudan (2020).** OFAC designated M Invest and its Sudanese subsidiary Meroe Gold as fronts for the already-sanctioned Prigozhin - cover for Wagner-linked operations that obtained gold concessions in exchange for military and political support to the regime. Trade data later showed equipment shipments continuing post-designation.

**Agency action:** OFAC designations under E.O. 13848 (2020-07-15): M Invest, Meroe Gold, executives Potepkin and Mandel

**Why screening is hard here:** A designated individual operating through foreign companies with no name resemblance - 'Meroe Gold' reads as a local miner; the link ran through Russian corporate ownership and required beneficial-ownership tracing.

**Outcome:** Entities and executives remain designated; fed into the 2023 Wagner global sanctions campaign.

**How the alert models it:** `NAME` STRONG (98) · `COUNTRY_OF_INCORPORATION` EXACT (100) · `OWNERSHIP` EXACT (100)

**Rule fired:** Step 1 - Exact match on designated entity; ownership chain to designated principal  
**Maker:** TM - designated entity; formatting variance (Co Ltd vs Co. Ltd.) is normalization, not identity  
**Checker:** TM - confirmed

**Presenter notes:** Pair this with RW-01: same 50%-rule logic, but here the parent chain crosses two countries and a war economy.

**Sources:**
- <https://home.treasury.gov/news/press-releases/sm1058>

### RW-07 — Post-designation fleet re-registration to HK shells (OMM)

**Alert:** `SANCRW_20250802100007_TM005` · **Disposition:** TRUE_MATCH · **Score:** 92 · **Route:** business · **List:** OFAC_SDN · **Programs:** DPRK

**Screened pair:** TRENDY SUNSHINE HONG KONG LIMITED → OCEAN MARITIME MANAGEMENT COMPANY LIMITED (entry 41007)

**The real case — Ocean Maritime Management (OMM) - post-designation vessel renaming and re-registration (2014-2015).** After OMM (operator behind the 2013 Chong Chon Gang concealed-arms shipment) was listed, the UN Panel of Experts found it renamed 13 of its 14 ships and transferred registered ownership to shells including Trendy Sunshine Hong Kong Ltd, SBC International, Advance Superstar (HK) and Shen Zhong International Shipping - erasing the fleet from screening databases within months.

**Agency action:** UN 1718 Committee listing (2014-07-28); OFAC E.O. 13551 designation (2014-07-30); OFAC designation of OMM front companies and renamed vessels (2015-07-23); UN PoE report S/2015/131

**Why screening is hard here:** Names, registered owners and flags all changed while hulls and controllers stayed identical; only IMO-number tracking and network analysis reconnected the fleet.

**Outcome:** UN and OFAC designated the successor fronts and vessels in 2015; OMM remains listed.

**How the alert models it:** `OWNERSHIP` EXACT (100) · `NAME` NONE (10) · `COUNTRY_OF_INCORPORATION` NONE (20)

**Rule fired:** Step 1 - Registered owner of blocked vessel; corporate continuity despite rename  
**Maker:** TM - shell owns a blocked vessel whose IMO traces to the OMM fleet  
**Checker:** TM - vessel-to-owner continuity verified

**Presenter notes:** The canonical argument for screening vessels by IMO, and owners by network - names churn, hulls don't.

**Sources:**
- <https://home.treasury.gov/news/press-releases/jl0130>
- <https://main.un.org/securitycouncil/en/sanctions/1718/materials/summaries/entity/ocean-maritime-management-company,-limited-(omm)>

### RW-08 — Designation-day subsidiary sweep (Sberbank Europe)

**Alert:** `SANCRW_20250802100008_TM006` · **Disposition:** TRUE_MATCH · **Score:** 96 · **Route:** business · **List:** OFAC_SDN · **Programs:** RUSSIA-EO14024

**Screened pair:** SBERBANK EUROPE AG → PUBLIC JOINT STOCK COMPANY SBERBANK OF RUSSIA (entry 41008)

**The real case — Sberbank and VTB - 50% rule sweep of unlisted subsidiaries after the 2022 invasion (2022).** OFAC fully blocked Russia's two largest banks and listed dozens of subsidiaries, stating that any entity owned 50%+ directly or indirectly by a blocked bank is itself blocked even if unnamed - instantly covering the banks' global networks including Sberbank Europe AG (Vienna) and VTB Bank (Europe) SE (Frankfurt), which failed or wound down under combined US/EU pressure.

**Agency action:** OFAC E.O. 14024 actions: 2022-02-24 (VTB full blocking + 20 subsidiaries; Sberbank CAPTA Directive 2) and 2022-04-06 (Sberbank full blocking + 42 subsidiaries)

**Why screening is hard here:** Hundreds of majority-owned subsidiaries, brokerages and SPVs were blocked without ever appearing on the SDN list - screening required ownership-graph resolution across multi-tier and joint-ownership chains, not name lookup.

**Outcome:** Both banks remain blocked; wind-down licenses expired 2022; European subsidiaries entered resolution.

**How the alert models it:** `OWNERSHIP` EXACT (100) · `NAME` FUZZY (75) · `SWIFT_BIC` PARTIAL (60) · `COUNTRY_OF_INCORPORATION` NONE (30)

**Rule fired:** Step 1 - 50% rule: majority-owned subsidiary blocked from parent's designation moment  
**Maker:** TM - 100% subsidiary of fully blocked parent; BIC family corroborates group membership  
**Checker:** TM - confirmed; EU incorporation does not cure US blocking

**Presenter notes:** Operationally the hardest day in sanctions-screening history for many banks - list deltas of hundreds of entries plus implicit 50%-rule coverage overnight. Ask the SME how their institution handled 2022-02-24.

**Sources:**
- <https://home.treasury.gov/news/press-releases/jy0608>
- <https://home.treasury.gov/news/press-releases/jy0705>

## 2.2 Maritime & vessel evasion

### RW-09 — Mid-voyage rename and reflag (GRACE 1 -> ADRIAN DARYA 1)

**Alert:** `SANCRW_20250802100009_TM007` · **Disposition:** TRUE_MATCH · **Score:** 97 · **Route:** vessel · **List:** OFAC_SDN · **Programs:** SDGT

**Screened pair:** ADRIAN DARYA 1 → GRACE 1 (entry 41009)

**The real case — GRACE 1 -> ADRIAN DARYA 1 - Iranian VLCC renamed mid-detention (2019).** Royal Marines detained the Panama-flagged GRACE 1 carrying 2.1M barrels of Iranian crude bound for Syria. During detention Panama deflagged the ship; it was reflagged to Iran, renamed ADRIAN DARYA 1, released, went AIS-dark off Syria and discharged its cargo near Tartus despite the designation.

**Agency action:** Gibraltar detention (2019-07-04); OFAC identified the renamed vessel as blocked property under E.O. 13224 and designated its master (2019-08-30)

**Why screening is hard here:** Mid-voyage rename plus simultaneous reflag defeats name/flag screening within days; the IMO was the only stable identifier, and the post-release AIS dark period defeated route monitoring.

**Outcome:** Vessel identified as blocked property; captain designated; cargo nonetheless delivered - a documented failure of name-based controls.

**How the alert models it:** `IMO_NUMBER` EXACT (100) · `NAME` NONE (5) · `FLAG` NONE (15)

**Rule fired:** Step 0 - IMO constant through rename/reflag; exact IMO is deterministic  
**Maker:** TM - IMO 9116412 identical; rename and Panama-to-Iran reflag are evasion signals, not contradictions  
**Checker:** TM - confirmed; hull identity is the vessel

**Presenter notes:** The most famous vessel-rename story in sanctions - most SMEs know it. Land the point: your screening keyed on IMO 9116412 catches both identities instantly.

**Sources:**
- <https://home.treasury.gov/news/press-releases/sm765>
- <https://ofac.treasury.gov/recent-actions/20190830_33>

### RW-10 — AIS-dark DPRK bulk carrier behind clean service payments (WISE HONEST)

**Alert:** `SANCRW_20250802100010_TM008` · **Disposition:** TRUE_MATCH · **Score:** 98 · **Route:** vessel · **List:** OFAC_SDN · **Programs:** DPRK

**Screened pair:** WISE HONEST → WISE HONEST (entry 41010)

**The real case — M/V WISE HONEST - first-ever US seizure of a DPRK cargo vessel (2018-2019).** One of North Korea's largest bulk carriers exported DPRK coal with AIS off since ~August 2017, concealing its identity with false documentation, while USD payments for vessel expenses cleared through US correspondent banks - the jurisdictional hook for forfeiture.

**Agency action:** DOJ/SDNY civil forfeiture under IEEPA and NKSPEA (announced 2019-05-09); Indonesian detention April 2018

**Why screening is hard here:** Long AIS silence and falsified documents hid the vessel from counterparties; the payments referenced service providers, not the sanctioned ship - document and payment screening had to connect the vessel to the money.

**Outcome:** Forfeiture judgment October 2019; proceeds directed toward the Otto Warmbier and Kim Dong Shik family claims.

**How the alert models it:** `IMO_NUMBER` EXACT (100) · `NAME` EXACT (100) · `FLAG` EXACT (100)

**Rule fired:** Step 1 - Vessel in underlying voyage documents is DPRK-linked blocked property  
**Maker:** TM - DPRK-flagged blocked vessel; multi-month AIS gap is itself a red flag under the 2020 maritime advisory  
**Checker:** TM - confirmed

**Presenter notes:** Pairs with MID-SHIP: the vessel hides in the documents and the money, not in the payment parties. AIS-gap analytics as a screening CDE.

**Sources:**
- <https://www.justice.gov/usao-sdny/pr/north-korean-cargo-vessel-connected-sanctions-violations-seized-us-government>

### RW-11 — Renamed tanker doing dark STS transfers (COURAGEOUS ex-SEA PRIMA)

**Alert:** `SANCRW_20250802100011_TM009` · **Disposition:** TRUE_MATCH · **Score:** 95 · **Route:** vessel · **List:** OFAC_SDN · **Programs:** DPRK

**Screened pair:** COURAGEOUS → SEA PRIMA (entry 41011)

**The real case — M/T COURAGEOUS - forfeited for DPRK fuel deliveries via dark STS transfers (2019-2021).** Between Aug-Dec 2019 the COURAGEOUS switched off AIS and conducted ship-to-ship petroleum transfers to the DPRK tanker SAEBYOL, with satellite imagery placing it at Nampo - violating UNSCR caps. Cambodia detained it in 2020 under a US warrant.

**Agency action:** DOJ/SDNY seizure via Cambodia (2020) and civil forfeiture (2021-07-30); owner Kwek Kee Seng indicted 2021-04-23

**Why screening is hard here:** Deliberate AIS gaps concealed the transfers; the recently renamed small tanker owned through a private Singaporean's company had no list hit on any screenable identifier at transaction time.

**Outcome:** Vessel judicially forfeited (2021); owner indicted, fugitive.

**How the alert models it:** `IMO_NUMBER` EXACT (100) · `FORMER_NAME` EXACT (100) · `NAME` NONE (10)

**Rule fired:** Step 1 - Former name + IMO continuity; AIS gaps and STS pattern corroborate  
**Maker:** TM - IMO 8617524 continuous through rename; dark-period STS pattern matches DPRK typology  
**Checker:** TM - confirmed

**Presenter notes:** Use for the 'small fry matter too' point - evasion is not just VLCCs; a 2,700 DWT tanker earned a SDNY forfeiture.

**Sources:**
- <https://www.justice.gov/opa/pr/united-states-seizes-oil-tanker-used-violate-sanctions-against-north-korea>

### RW-12 — Shadow-fleet identity churn after designation (Sovcomflot wave)

**Alert:** `SANCRW_20250802100012_TM010` · **Disposition:** TRUE_MATCH · **Score:** 94 · **Route:** vessel · **List:** OFAC_SDN · **Programs:** RUSSIA-EO14024

**Screened pair:** BRATSK STAR → JSC SOVCOMFLOT (entry 41012)

**The real case — Sovcomflot fleet - rename/reflag/manager-rotation wave after the 2024 designation (2023-2024).** After designation the fleet responded with rapid identity churn: stripping SCF/NS name prefixes for neutral names, mass reflagging (Lloyd's List documented 18 Sovcomflot tankers reflagged to Gabon within weeks), and rotating nominal managers through newly formed Dubai shells while hulls and beneficial control stayed constant.

**Agency action:** OFAC designated JSC Sovcomflot and identified 14 crude tankers as blocked property by IMO (2024-02-23); parallel UK/EU actions

**Why screening is hard here:** Industrialized evasion of name-based screening: designated name, flag and manager all changed within weeks; only IMO-level screening plus ownership/management-graph analysis kept pace.

**Outcome:** Sovcomflot and identified tankers remain blocked; successive US/UK/EU shadow-fleet designations followed through 2024-2025.

**How the alert models it:** `OWNERSHIP` EXACT (100) · `FORMER_NAME` STRONG (90) · `FLAG` NONE (20)

**Rule fired:** Step 1 - Beneficial owner designated; name/flag/manager churn are evasion signals  
**Maker:** TM - ownership graph resolves to designated Sovcomflot despite fresh name, flag and manager  
**Checker:** TM - confirmed; identity churn post-designation strengthens, not weakens, the finding

**Presenter notes:** The current-events case every sanctions SME is living daily. Registry-change velocity (new flag + new manager + new name in <60 days) is itself a screenable risk signal.

**Sources:**
- <https://ofac.treasury.gov/recent-actions/20240223>
- <https://www.lloydslist.com/LL1147879/Dark-fleet-safe-haven-Gabon-flags-18-Sovcomflot-tankers-after-US-imposes-sanctions>

### RW-13 — Vessel identity theft - broadcasting a clean twin (YUK TUNG/MAIKA)

**Alert:** `SANCRW_20250802100013_HR003` · **Disposition:** HUMAN_REVIEW · **Score:** 78 · **Route:** vessel · **List:** OFAC_SDN · **Programs:** DPRK

**Screened pair:** MAIKA (claimed identity) → YUK TUNG (entry 41013)

**The real case — YUK TUNG / MAIKA - vessel identity theft documented by the UN Panel of Experts (2018-2020).** The designated tanker YUK TUNG (IMO 9030591) kept operating by transmitting the AIS identity of the legitimate, near-identical tanker MAIKA, with registry documents attributed to Equatorial Guinea and ownership through a Seychelles shell. The UN Panel reconstructed the deception via imagery and registry forensics.

**Agency action:** OFAC designation 2018-02-23 (DPRK shipping action); UN PoE report S/2019/171; typology codified in the 2020-05-14 tri-seal Global Maritime Advisory

**Why screening is hard here:** Worse than a rename: the ship impersonated another vessel's identifiers entirely, so even IMO/MMSI screening returned a false negative on a clean twin. Detection needed physical-attribute corroboration, flag-state verification and AIS-gap analytics.

**Outcome:** YUK TUNG remains designated; the typology became the compliance benchmark in the 2020 Global Maritime Advisory.

**How the alert models it:** `IMO_NUMBER` NONE (30) · `NAME` NONE (20) · `VESSEL_TYPE` EXACT (100) · `FLAG` NONE (25)

**Rule fired:** Step 2 - Claimed identity fails registry verification -> human review  
**Maker:** HR - claimed identity unverifiable; physical attributes match designated YUK TUNG; twin-location conflict  
**Checker:** HR - agrees; require registry confirmation and imagery corroboration before clearing

**Presenter notes:** The ceiling case for vessel screening: when even the IMO lies, screening becomes identity VERIFICATION - registry callbacks, imagery, twin-location conflicts. Strong deep-research demo hook.

**Sources:**
- <https://ofac.treasury.gov/recent-actions/20180223>
- <https://docs.un.org/en/S/2019/171>
- <https://ofac.treasury.gov/recent-actions/20200514>

### RW-14 — Serial rename and flag-hop across years (NITC / SANCHI)

**Alert:** `SANCRW_20250802100014_TM011` · **Disposition:** TRUE_MATCH · **Score:** 96 · **Route:** vessel · **List:** OFAC_SDN · **Programs:** IRAN, IFSR

**Screened pair:** SANCHI → NATIONAL IRANIAN TANKER COMPANY (FLEET VESSEL) (entry 41014)

**The real case — NITC fleet / SANCHI - serial renaming and flag hopping (2012-2018).** After 2012 oil sanctions NITC renamed most of its ~39 tankers to innocuous names and hopped flags (Malta/Cyprus -> Tuvalu -> Tanzania) as registries deregistered them. SANCHI (IMO 9356608) was SAMAN -> SEPID -> GARDENIA -> SEAHORSE -> SANCHI across 2008-2013. The 2018 relisting still enumerated its aliases - ten months after the ship had sunk - because the paper identity trail lagged the physical fleet.

**Agency action:** OFAC identified NITC fleet under E.O. 13599 (2012-07-12); re-imposition listing 2018-11-05 with per-vessel IMOs and aliases

**Why screening is hard here:** The canonical failure mode for name-based vessel screening: aliases proliferate faster than list updates and flag is meaningless as a risk signal; screening must key on IMO plus alias history and registry-change velocity.

**Outcome:** NITC blocked (2012), delisted under JCPOA (2016), relisted with IMOs (2018); SANCHI lost with 32 crew in the January 2018 collision.

**How the alert models it:** `IMO_NUMBER` EXACT (100) · `ALIAS` EXACT (100) · `NAME` FUZZY (40) · `FLAG` NONE (30)

**Rule fired:** Step 0 - IMO + alias history; every former name is an equal identifier  
**Maker:** TM - IMO 9356608 with full alias chain matches the NITC fleet identification  
**Checker:** TM - confirmed; flag state carries no exculpatory weight here

**Presenter notes:** History rhymes: NITC 2012 is Sovcomflot 2024. Also a data-quality lesson - OFAC itself listed a ship that no longer existed.

**Sources:**
- <https://home.treasury.gov/news/press-releases/tg1642>
- <https://ofac.treasury.gov/recent-actions/20181105>

## 2.3 Individuals — aliases, dual nationality, list divergence

### RW-15 — Dual national under two orthographies (Zarrab/Sarraf)

**Alert:** `SANCRW_20250802100015_TM012` · **Disposition:** TRUE_MATCH · **Score:** 95 · **Route:** individual · **List:** OFAC_SDN · **Programs:** IRAN

**Screened pair:** RIZA SARRAF → ZARRAB, Reza (entry 41015)

**The real case — Reza Zarrab (Riza Sarraf) - Iran gold-for-gas scheme via Halkbank (2010-2018).** Zarrab moved billions in Iranian oil proceeds through Turkey's state-owned Halkbank, converting them to gold exports and fake food-trade transactions (fictitious humanitarian shipments with falsified documents) to disguise Iranian access to the US financial system.

**Agency action:** DOJ/SDNY prosecution: arrested March 2016, captioned 'Reza Zarrab a/k/a Riza Sarraf'; guilty plea 2017-10-26; cooperation convicted Halkbank's Hakan Atilla; Halkbank indicted 2019

**Why screening is hard here:** Transliteration divergence across two orthographies of one name, dual Iranian-Turkish citizenship, front companies in Turkey/UAE and falsified trade documents defeating transaction screening.

**Outcome:** Guilty plea and cooperation; Atilla convicted 2018; Halkbank indicted 2019.

**How the alert models it:** `NAME` FUZZY (72) · `ALIAS` EXACT (100) · `SECOND_CITIZENSHIP` EXACT (100) · `DOB` EXACT (100)

**Rule fired:** Step 1 - Cross-orthography name match + citizenship set + exact DOB  
**Maker:** TM - Turkish orthography variant is a registered alias; IR second citizenship and exact DOB corroborate  
**Checker:** TM - confirmed

**Presenter notes:** Note for accuracy when presenting: Zarrab was pursued criminally by DOJ - the alert models him as a watchlist subject to demonstrate the orthography/dual-citizenship pattern documented in the case caption itself.

**Sources:**
- <https://www.justice.gov/archives/opa/pr/turkish-national-arrested-conspiring-evade-us-sanctions-against-iran-money-laundering-and>
- <https://www.justice.gov/usao-sdny/pr/turkish-banker-mehmet-hakan-atilla-sentenced-32-months-conspiring-violate-us-sanctions>

### RW-16 — Multi-DOB list entry with weak aliases (Viktor Bout)

**Alert:** `SANCRW_20250802100016_TM013` · **Disposition:** TRUE_MATCH · **Score:** 94 · **Route:** individual · **List:** OFAC_SDN · **Programs:** LIBERIA

**Screened pair:** VIKTOR BUT → BOUT, Viktor Anatolijevitch (entry 41016)

**The real case — Viktor Bout - arms dealer with a multi-identity SDN entry; OFAC weak-alias guidance (2005-2022).** Bout ran arms through a shifting fleet of front air-cargo companies. His SDN record carries two dates of birth (1967/1970), strong variants (Viktor But, Vitali Sergitov) and quoted weak AKAs ('BOUTOV', 'BONT', 'BUTT', 'BUTTE'). OFAC's 2011 guidance formally distinguished strong aliases from weak ones - printed in quotes and flagged in the machine-readable files - telling institutions weak-AKA screening is a risk-based choice because generic fragments flood systems with false positives.

**Agency action:** OFAC designation 2005-04-26 under E.O. 13348 (Charles Taylor arms network); DEA sting 2008; convicted SDNY 2011, 25-year sentence; released in 2022 prisoner swap; OFAC weak-AKA guidance 2011-01-21 and FAQs 122-123

**Why screening is hard here:** Multiple DOBs in one entry, weak/quoted aliases, and spelling variants - the core tuning trade-off between false-positive volume and missed matches; screening must know which alias fields carry weight.

**Outcome:** Convicted on all four counts; remained designated after the 2022 swap; weak-alias flagging is now a standard field in commercial screening engines.

**How the alert models it:** `NAME` STRONG (90) · `DOB` EXACT (100) · `NATIONALITY` EXACT (100)

**Rule fired:** Step 1 - Match against alternate DOB; weak AKAs weighted per OFAC guidance  
**Maker:** TM - name variant BUT/BOUT with exact match on the entry's alternate DOB  
**Checker:** TM - confirmed; alternate-DOB handling is the decisive mechanic

**Presenter notes:** Ask the SME whether their engine screens weak AKAs and how alternate DOBs are compared - both are silent config decisions with regulatory weight.

**Sources:**
- <https://home.treasury.gov/news/press-releases/js2406>
- <https://ofac.treasury.gov/faqs/topic/1646>
- <https://home.treasury.gov/policy-issues/financial-sanctions/recent-actions/20110121>

### RW-17 — Arabic transliteration multiplicity (Kassim Tajideen)

**Alert:** `SANCRW_20250802100017_TM014` · **Disposition:** TRUE_MATCH · **Score:** 93 · **Route:** individual · **List:** OFAC_SDN · **Programs:** SDGT

**Screened pair:** QASIM TAJEDDINE → TAJIDEEN, Kassim (entry 41024)

**The real case — Kassim Tajideen - Hezbollah financier with African commodity empire (2009-2019).** Designated as an important financial contributor to Hezbollah operating through African commodity businesses with his brothers. Despite designation, his network kept transacting with US companies - over $27M in US-linked transactions - leading to indictment, extradition, a 2018 guilty plea, 60 months and $50M forfeiture.

**Agency action:** OFAC SDGT designation 2009-05-27; DOJ (D.D.C.) prosecution after 2017 Morocco arrest and extradition

**Why screening is hard here:** Multiple Arabic-name transliterations across lists and records; post-designation evasion through family-owned trading companies whose ownership obscured the blocked principal.

**Outcome:** Guilty plea (2018); sentenced 2019; compassionate release 2020; designations stand.

**How the alert models it:** `NAME` FUZZY (80) · `ALIAS` STRONG (95) · `DOB` EXACT (100) · `NATIONALITY` EXACT (100)

**Rule fired:** Step 1 - Cross-transliteration match + network corroboration  
**Maker:** TM - transliteration variants of one Arabic name; exact DOB anchors  
**Checker:** TM - confirmed

**Presenter notes:** Your transliteration demo scenario (SCN-10) made real - and the $27M post-designation flow shows FP-fatigue risk: his hits were probably dismissed as fuzzy noise.

**Sources:**
- <https://home.treasury.gov/news/press-releases/tg149>
- <https://www.justice.gov/usao-dc/pr/lebanese-businessman-tied-hizballah-pleads-guilty-money-laundering-conspiracy-furtherance>

### RW-18 — Cross-list divergence - EU/UK listed, initially not US (Fridman/Aven)

**Alert:** `SANCRW_20250802100018_HR004` · **Disposition:** HUMAN_REVIEW · **Score:** 88 · **Route:** individual · **List:** EU_CONSOLIDATED · **Programs:** EU-RUSSIA-REG-269/2014

**Screened pair:** MIKHAIL FRIDMAN → MIKHAIL FRIDMAN (EU CONSOLIDATED LIST) (entry 41025)

**The real case — Mikhail Fridman and Petr Aven - EU/UK vs US listing divergence (2022-2024).** The Alfa Group co-founders were blocked in the EU and UK for ~17 months while absent from the US SDN list; OFAC designated them in August 2023; in April 2024 the EU General Court annulled the original EU listings for insufficient evidence even as renewals and UK/US designations kept them sanctioned.

**Agency action:** EU listing 2022-02-28; UK 2022-03-15; OFAC designation of all four Alfa Group founders 2023-08-11 (E.O. 14024); EU General Court annulments T-301/22 and T-304/22 on 2024-04-10

**Why screening is hard here:** Cross-list divergence: institutions screening only one list produced opposite dispositions for the same party, and the 'correct' answer changed over time in both directions.

**Outcome:** OFAC-designated (still listed); initial EU listings annulled but subsequent renewal acts maintained EU restrictions.

**How the alert models it:** `NAME` EXACT (100) · `DOB` EXACT (100) · `SECOND_CITIZENSHIP` EXACT (100)

**Rule fired:** Step 2 - Designated on one regime, clean on another -> policy-dependent human review  
**Maker:** HR - perfect identity match on EU list; US list negative; jurisdictional policy decision, not an identity question  
**Checker:** HR - agrees; route to sanctions counsel for regime applicability

**Presenter notes:** The multi-list demo: match quality was never the issue - regime applicability was. Shows why disposition logic needs list-source awareness, not just a score.

**Sources:**
- <https://ofac.treasury.gov/recent-actions/20230811>
- <https://curia.europa.eu/site/upload/docs/application/pdf/2024-04/cp240061en.pdf>

### RW-19 — Family-proxy designation - no shared name token (Tikhonova)

**Alert:** `SANCRW_20250802100019_TM015` · **Disposition:** TRUE_MATCH · **Score:** 95 · **Route:** individual · **List:** OFAC_SDN · **Programs:** RUSSIA-EO14024

**Screened pair:** KATERINA TIKHONOVA → TIKHONOVA, Katerina Vladimirovna (entry 41026)

**The real case — Family-member proxies - designation of Putin's and Lavrov's adult family (2022).** Treasury designated Katerina Tikhonova and Maria Vorontsova - Putin's adult daughters, neither carrying his surname - plus Lavrov's wife and daughter, stating the US believed senior officials hid assets with family members, placing wealth outside searches keyed to the official's own name.

**Agency action:** OFAC designations 2022-04-06 under E.O. 14024 (same action as the Sberbank full blocking)

**Why screening is hard here:** Proxy risk: sanctioned principals continue economic life through relatives whose names share no token with the principal's - requiring relationship screening, not name screening.

**Outcome:** All four designated and remain listed; set the template for later family-network designations.

**How the alert models it:** `NAME` STRONG (96) · `DOB` EXACT (100) · `NATIONALITY` EXACT (100)

**Rule fired:** Step 1 - Designated person; relationship to principal explains the listing  
**Maker:** TM - directly designated; family-proxy rationale documented by Treasury  
**Checker:** TM - confirmed

**Presenter notes:** Segue to your deep-research/relationship-graph capability: the CDE that matters here (kinship) exists in no payment message.

**Sources:**
- <https://home.treasury.gov/news/press-releases/jy0705>

### RW-20 — Mass-alias entry with stale passports (Dawood Ibrahim)

**Alert:** `SANCRW_20250802100020_TM016` · **Disposition:** TRUE_MATCH · **Score:** 96 · **Route:** individual · **List:** OFAC_SDN · **Programs:** SDGT

**Screened pair:** SHEIKH DAWOOD HASSAN → IBRAHIM, Dawood (entry 41027)

**The real case — Dawood Ibrahim - D-Company leader; screening stress-test SDN entry (2003-present).** The fugitive head of D-Company (1993 Bombay bombings; al-Qaida links) has accreted roughly 21 recorded aliases across lists - mixing given-name, patronymic and clan-name orderings - plus multiple Indian passports recorded as revoked or misused, making the listed documents stale identifiers by design.

**Agency action:** OFAC SDGT designation 2003-10-16; UN Al-Qaida Committee listing Nov 2003; network designations 2006-06-01; UK asset freeze

**Why screening is hard here:** Massive alias sets in multiple orderings/transliterations plus revoked passports: document matching yields false confidence while name variants explode the fuzzy-match space.

**Outcome:** Remains designated (OFAC, UN, UK); at large.

**How the alert models it:** `ALIAS` EXACT (100) · `DOB` EXACT (100) · `PASSPORT` PARTIAL (80) · `NATIONALITY` EXACT (100)

**Rule fired:** Step 1 - Alias-set match; document numbers treated as historic, not exculpatory  
**Maker:** TM - exact alias-set hit plus DOB; passport treated as historic corroboration only  
**Checker:** TM - confirmed; alias ordering variants (given/patronymic/clan) all map to the entry

**Presenter notes:** Show how your engine handles an entry with 21 aliases and 7 passports: which fields fire, which are suppressed, and how the analyst sees the full identity cluster.

**Sources:**
- <https://ofac.treasury.gov/recent-actions/20031016>
- <https://ofac.treasury.gov/recent-actions/20060601>

## 2.4 Screening-failure enforcement cases

### RW-21 — Corporate-suffix formatting miss (Apple / SIS d.o.o.)

**Alert:** `SANCRW_20250802100021_TM017` · **Disposition:** TRUE_MATCH · **Score:** 98 · **Route:** business · **List:** OFAC_SDN · **Programs:** SDNTK

**Screened pair:** SIS DOO → SIS d.o.o. (entry 41017)

**The real case — Apple Inc. - OFAC settlement over SIS d.o.o. screening miss (2019).** Apple's screening tool failed to match 'SIS DOO' in its systems against 'SIS d.o.o.' on the SDN list, so Apple kept hosting the designated developer's apps and remitted $1.15M in payments for ~2 years after designation. It also missed the designated individual listed as account administrator because individual account holders were not screened.

**Agency action:** OFAC settlement $466,912 (2019-11-25), 47 apparent violations of the Kingpin sanctions regulations

**Why screening is hard here:** Case/formatting mismatch in matching logic: a lowercase, punctuated corporate suffix defeated the match; secondary party (account admin) not screened at all.

**Outcome:** $466,912 settlement (non-egregious, self-disclosed); Apple reconfigured matching to capture name variants and expanded screening to account personnel.

**How the alert models it:** `NAME` EXACT (100) · `COUNTRY_OF_INCORPORATION` EXACT (100) · `DIRECTOR` EXACT (100)

**Rule fired:** Step 1 - Name match after suffix/case normalization  
**Maker:** TM - identical name after suffix normalization; designated director corroborates  
**Checker:** TM - confirmed; formatting variance is not identity variance

**Presenter notes:** The single best 'why fuzzy matching config matters' story in the industry - a trillion-dollar company undone by 'd.o.o.' vs 'DOO'. Show your normalization layer here.

**Sources:**
- <https://ofac.treasury.gov/recent-actions/20191125>

### RW-22 — Jurisdiction address variant (Amazon / 'Yalta, Krimea')

**Alert:** `SANCRW_20250802100022_TM018` · **Disposition:** TRUE_MATCH · **Score:** 94 · **Route:** individual · **List:** OFAC_SDN · **Programs:** UKRAINE-EO13685

**Screened pair:** DENYS KOVALCHUK → CRIMEA REGION OF UKRAINE (EMBARGOED JURISDICTION) (entry 41018)

**The real case — Amazon.com - OFAC settlement over address-screening gaps (2020).** Amazon's automated screening failed to flag orders addressed to 'Yalta, Krimea' (neither the city nor the variant spelling), shipped orders to sanctioned-country embassies, and in several hundred cases missed correctly spelled SDN names and addresses; it also failed to timely report 362 Crimea transactions under General License 5.

**Agency action:** OFAC settlement $134,523 (2020-07-08), violations across Crimea, Iran, Syria, Cuba, DPRK, Sudan programs

**Why screening is hard here:** Address data not fully analyzed: variant spellings ('Krimea') and city-level geography ('Yalta') defeated region matching; embassy addresses of sanctioned states not interdicted.

**Outcome:** $134,523 settlement (non-egregious, self-disclosed) with major screening remediation.

**How the alert models it:** `ADDRESS` EXACT (100) · `NAME` NO_DATA (0) · `NATIONALITY` EXACT (100)

**Rule fired:** Step 1 - Embargoed-region interdiction on normalized address  
**Maker:** TM - address geo-resolves to the embargoed Crimea region despite variant spelling  
**Checker:** TM - confirmed; city-level resolution required, not just region string

**Presenter notes:** Demo the address-normalization + gazetteer step: Yalta, Sevastopol, Kerch should all resolve to Crimea regardless of spelling.

**Sources:**
- <https://ofac.treasury.gov/recent-actions/20200708>
- <https://ofac.treasury.gov/media/44311/download>

### RW-23 — Blocked vessel inside trade documents (MID-SHIP / M/V HAADI)

**Alert:** `SANCRW_20250802100023_TM019` · **Disposition:** TRUE_MATCH · **Score:** 93 · **Route:** business · **List:** OFAC_SDN · **Programs:** NPWMD

**Screened pair:** CRESCENT FREIGHT CHARTERING DMCC → HAADI (entry 41019)

**The real case — MID-SHIP Group - charter payments for IRISL-blocked vessels (2019).** The New York shipbroker processed five EFTs totaling ~$472,861 for charter payments tied to vessels - including M/V HAADI - blocked as IRISL property. Bills of lading and charter documents in MID-SHIP's own possession named the blocked vessels.

**Agency action:** OFAC settlement $871,837 (2019-05-02), 5 apparent violations of the WMD Proliferators Sanctions Regulations

**Why screening is hard here:** Trade documents were never screened: the blocked party appeared only on the bill of lading, not as a payment party; personnel ignored the red flags in the documents they held.

**Outcome:** $871,837 settlement (no self-disclosure); OFAC used the case to flag maritime obligations to screen vessels, counterparties AND underlying trade documents.

**How the alert models it:** `DOCUMENT_VESSEL` EXACT (100) · `NAME` NO_DATA (0) · `INDUSTRY` PARTIAL (70)

**Rule fired:** Step 1 - Document screening: vessel on bill of lading is blocked property  
**Maker:** TM - bill of lading names blocked IRISL vessel HAADI; payment facilitates blocked property  
**Checker:** TM - confirmed; trade-document screening obligation

**Presenter notes:** Perfect bridge to your trade-finance screening story: the hit is in unstructured document text, not in MT103 fields.

**Sources:**
- <https://ofac.treasury.gov/recent-actions/20190502>
- <https://ofac.treasury.gov/media/35596/download>

### RW-24 — Supply-chain origin false negative (e.l.f. / DPRK materials)

**Alert:** `SANCRW_20250802100024_TM020` · **Disposition:** TRUE_MATCH · **Score:** 91 · **Route:** business · **List:** OFAC_SDN · **Programs:** DPRK

**Screened pair:** XINGHAI LASH MANUFACTURING CO LTD → DEMOCRATIC PEOPLE'S REPUBLIC OF KOREA (ORIGIN EMBARGO) (entry 41020)

**The real case — e.l.f. Cosmetics - DPRK materials in false-eyelash supply chain (2019).** Over ~5 years e.l.f. imported 156 shipments of false-eyelash kits ($4.43M) from two Chinese suppliers that sourced materials from North Korea; an internal review found ~80% of kits contained DPRK materials, and e.l.f. self-disclosed.

**Agency action:** OFAC settlement $996,080 (2019-01-31), 156 apparent violations of the North Korea Sanctions Regulations

**Why screening is hard here:** Supply chain never screened: supplier audits covered quality only, not sanctions/country-of-origin - a false negative persisted for nearly five years.

**Outcome:** $996,080 settlement; remediation included country-of-origin verification, supplier certifications and sanctions training.

**How the alert models it:** `SUPPLY_CHAIN` EXACT (100) · `NAME` NO_DATA (0) · `COUNTRY_OF_INCORPORATION` NONE (20)

**Rule fired:** Step 1 - Country-of-origin interdiction via supplier data  
**Maker:** TM - supplier declaration shows DPRK-origin inputs; origin embargo applies regardless of supplier cleanliness  
**Checker:** TM - confirmed; country-of-origin data is the operative CDE

**Presenter notes:** Use to expand scope beyond payment screening: origin/supply-chain CDEs are screenable data. Resonates with any client importing from China's border provinces.

**Sources:**
- <https://ofac.treasury.gov/recent-actions/20190131>

### RW-25 — Near-variant SDN name + sanctioned-jurisdiction IP (Payoneer pattern)

**Alert:** `SANCRW_20250802100025_TM021` · **Disposition:** TRUE_MATCH · **Score:** 95 · **Route:** individual · **List:** OFAC_SDN · **Programs:** IRAN

**Screened pair:** PARSA TAVAKKOLI → TAVAKOLI, Parsa (entry 41021)

**The real case — Payoneer - weak fuzzy matching, alert backlog auto-release, unused location data (2021).** Payoneer processed 2,241 payments for parties in Crimea, Iran, Sudan and Syria and 19 payments for SDNs. OFAC cited weak algorithms that missed close SDN name variations, an alert backlog that let flagged payments auto-release before analyst review, and failure to use billing/IP location data it already held.

**Agency action:** OFAC settlement $1,385,901 (2021-07-23), 2,260 apparent violations across multiple programs

**Why screening is hard here:** Three mechanical gaps: fuzzy threshold too loose for near variants; alerts auto-released on backlog; geolocation data present but unused.

**Outcome:** $1.39M settlement; remediation included retuned algorithms, no-release-before-disposition controls, and geo/IP screening.

**How the alert models it:** `NAME` FUZZY (88) · `DOB` EXACT (100) · `IP_GEOLOCATION` EXACT (100)

**Rule fired:** Step 1 - Close name variant corroborated by geolocation  
**Maker:** TM - near-variant name within edit distance 1, exact DOB, Iranian login IP  
**Checker:** TM - confirmed; variant must score above threshold

**Presenter notes:** Three lessons in one case for the SME: threshold tuning, queue SLAs (no auto-release), and using every CDE you already hold (IP, billing address).

**Sources:**
- <https://ofac.treasury.gov/recent-actions/20210723>

### RW-26 — Crypto counterparty in embargoed region - IP is the only CDE (BitPay)

**Alert:** `SANCRW_20250802100026_TM022` · **Disposition:** TRUE_MATCH · **Score:** 90 · **Route:** individual · **List:** OFAC_SDN · **Programs:** UKRAINE-EO13685

**Screened pair:** CRYPTO BUYER 0x8f3a...c21e → CRIMEA REGION OF UKRAINE (EMBARGOED JURISDICTION) (entry 41022)

**The real case — BitPay / BitGo - first OFAC actions against digital-currency providers (2020-2021).** BitPay processed 2,102 crypto transactions for buyers in Crimea, Cuba, DPRK, Iran, Sudan and Syria; BitGo processed 183. Both held IP and location data identifying users in sanctioned jurisdictions but did not use it to screen or block.

**Agency action:** OFAC settlements: BitPay $507,375 (2021-02-18); BitGo $98,830 (2020-12-30)

**Why screening is hard here:** Geolocation ignored: screening covered only direct customers/merchants while counterparty location data sat unused.

**Outcome:** Settlements with commitments to IP-blocking/geofencing and location-based screening of all users and counterparties.

**How the alert models it:** `IP_GEOLOCATION` EXACT (100) · `NAME` NO_DATA (0) · `ADDRESS` NO_DATA (0)

**Rule fired:** Step 1 - Jurisdiction interdiction on IP geolocation  
**Maker:** TM - transaction IP geolocates to Simferopol; embargoed-jurisdiction interdiction  
**Checker:** TM - confirmed; absence of KYC identifiers does not excuse the geo signal

**Presenter notes:** If the client touches digital assets: OFAC's first two crypto actions both turned on unused IP data - a CDE most screening programs never ingest.

**Sources:**
- <https://ofac.treasury.gov/recent-actions/20210218>
- <https://ofac.treasury.gov/recent-actions/20201230>

### RW-27 — Namesake false positive with litigation cost (Cortez v. TransUnion)

**Alert:** `SANCRW_20250802100027_FP001` · **Disposition:** FALSE_POSITIVE · **Score:** 66 · **Route:** individual · **List:** OFAC_SDN · **Programs:** SDNTK

**Screened pair:** SANDRA JEAN CORTEZ → CORTES QUINTERO, Sandra (entry 41023)

**The real case — SDN namesake false positives - Cortez v. TransUnion / TransUnion v. Ramirez (2007-2021).** Ordinary US consumers were flagged as SDN matches by name-only screening in credit reports: Sandra Cortez (b. 1944) was matched to narcotrafficker Sandra Cortes Quintero (b. 1971) and detained at a car dealership; Sergio Ramirez was refused a car sale despite mismatched middle initial and DOB.

**Agency action:** FCRA litigation: Cortez $800,000 award upheld (3rd Cir.); Ramirez 8,185-member class reached the U.S. Supreme Court (2021); OFAC FAQ 'Assessing OFAC Name Matches'

**Why screening is hard here:** Name-only fuzzy matching tuned for over-inclusion, ignoring available DOB/address; downstream businesses treated any partial match as a denial - the Third Circuit called the failure to use available DOB 'reprehensible'.

**Outcome:** Cortez: $800K upheld; Ramirez: $60M verdict remanded on standing at SCOTUS; OFAC guidance instructs comparing DOB/address before acting on a hit.

**How the alert models it:** `NAME` FUZZY (84) · `DOB` NONE (10) · `NATIONALITY` NONE (20)

**Rule fired:** Step 3 - Secondary identifiers (DOB, geography) contradict a name-only hit  
**Maker:** FP - secondary identifiers decisively contradict; name-only match must not block  
**Checker:** FP - confirmed; OFAC's own FAQ requires identifier verification before treating a hit as a match

**Presenter notes:** The FP cost story: over-blocking is not 'safe' - it created punitive damages and a Supreme Court case. Your maker-checker + CDE-contradiction logic is the defense.

**Sources:**
- <https://ofac.treasury.gov/faqs/topic/1591>
- <https://www.supremecourt.gov/opinions/20pdf/20-297_4g25.pdf>

---

## Appendix — coverage matrix

| Dimension | Synthetic file | Real-world file |
|---|---|---|
| Alerts | 100 | 27 |
| True match / FP / Human review | 55 / 20 / 25 | 22 / 1 / 4 |
| Party types (individual/entity/vessel) | 55/38/7 | 10/10/7 |
| Distinct CDE fields | 24 | 20 |
| List sources | EU_CONSOLIDATED, OFAC_SDN, UK_HMT_OFSI, UN_CONSOLIDATED | EU_CONSOLIDATED, OFAC_SDN |

**CDE fields exercised (union of both files):** `ADDRESS`, `ALIAS`, `CALL_SIGN`, `COUNTRY_OF_INCORPORATION`, `DIRECTOR`, `DOB`, `DOCUMENT_VESSEL`, `ENTITY_TYPE`, `FLAG`, `FORMER_NAME`, `FUND_MANAGER`, `IMO_NUMBER`, `INDUSTRY`, `IP_GEOLOCATION`, `NAME`, `NATIONALITY`, `NATIONAL_ID`, `OWNERSHIP`, `PASSPORT`, `PLACE_OF_BIRTH`, `REGISTERED_AGENT`, `REGISTRATION_NUMBER`, `SECOND_CITIZENSHIP`, `SUPPLY_CHAIN`, `SWIFT_BIC`, `VESSEL_TYPE`, `YEAR_OF_BIRTH`

