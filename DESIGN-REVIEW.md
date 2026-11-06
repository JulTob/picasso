# Agora / Vox — Picasso SVG and Mermaid XY plotting pilot

**Date:** 2026-11-06. **Status:** review-only recommendation and source prototype; no main-branch merge or Wiki publication. **Execution:** one assistant applied five installed specialist profiles sequentially with shared conversation and source context. This is **not** five independent agent/model executions or blind corroboration.

## Sources inspected

- Actual `JulTob/picasso` default-branch `picasso.ads`, `picasso.adb`, demonstration files and README via GitHub connector.
- `JulTob/Data` plotting PR #5 and the proposed Measurement, Experiment, and Signal chapter.
- `JulTob/Optimization/Wizard/visualization.py` and `Wizard/Graphikon/` for potential reuse boundaries.
- GitHub's Markdown, Mermaid and image-format documentation; inline raw SVG inside Wiki markup remains an unsupported assumption, while embedding a separate SVG is an explicit destination check.
- Installed profiles read in this task: Mermy, Signally, Ada Systems, Pyra and Wiky. Their profile lenses were *applied in this model*, not run as separately delegated workers.

## Council (Caesar routing)

Three task-selected specialists:
1. **Mermy** — which renderer preserves visual semantics, and whether Mermaid XY is appropriate.
2. **Signally** — sample index / continuous time and avoiding interpolated observations.
3. **Ada Systems** — compatible child packages, file ownership and preserving the existing SVG foundation; constructive skeptic.

Random members: from eligible distinct installed profiles Pyra, Wiky, Euly, Sematechy, Kolmy, Professor, Ada Assurance, Ada Types, Librarian; a real Python `secrets.SystemRandom().sample(pool, 2)` draw selected **Pyra** and **Wiky**. The random members kept their own focus, not reassigned fields.

## Initial contributions and response to objections

- **Mermy:** Keep both representations, choose using intended mathematical meaning. An SVG scientific figure can show irregular spacing and actual sample markers, while Mermaid `xychart-beta` presents an editable line that connects observed values. The line must be labelled a visual guide.
- **Signally:** An observed temperature vector has points at recorded times only; none supplies an unmeasured continuous trajectory. Use one immutable `Point_Array` for both formats, and prefer SVG for uneven sample positions.
- **Ada Systems (skeptic):** Existing Picasso is a procedural Ada SVG core; rewriting it in Python loses ownership and architectural continuity. But a child package must not destabilise `Picasso`; avoid silently overwriting output. An initial review found a nonstandard `length` SVG attribute, the plotting draft's erroneous `Float_IO.Put` argument, and a shadowed Ada character type identifier. These were corrected on the review branch. **GNAT is absent** from the execution environment: compiled behavior remains unverified. For those reasons, the prototype is ready for review, *not merge certification*.
- **Pyra:** Avoid duplicate general-purpose plotting backends. Existing Plotographer Python covers numerical histograms and reliable image generation, while native Ada in Picasso can initially implement only the proven sample-series primitive. Do not remove the Python backend before demonstrating Ada feature parity or an explicit bridge.
- **Wiky:** Neither SVG markup nor Mermaid rendering in the target GitHub Wiki should be assumed from a chat or a repository file preview. Keep source and tests alongside code, with one selected figure embedded in explanatory Wiki prose only after Julio approves, and a PNG fallback for display compatibility.

**Exchange:** The initial temptation to use Mermaid XY for all plots was rejected: Mermaid's x-axis labels do not encode arbitrary continuous x-spacing, and its bars are not a data-binned histogram. The alternative of migrating all plotting into Ada immediately was narrowed to a child-package pilot; numerical histograms remain a separate future contract. SVG default is preferred for scientific fidelity, Mermaid for clear editable small series, with a destination test.

## Motion and vote

**Motion P1, version 1 (frozen):** "Preserve Picasso's Ada SVG primitives and extend it with a review-branch child package `Picasso.Plots` for the same sample data exported as SVG markers and Mermaid XY; preserve the Data Python plot prototype until parity is tested; retain both formats, select by scientific fidelity and Wiki rendering; merge only after GNAT compile, source review and actual figure rendering verification."

**Sequential profile ballots, N=5, strict threshold 5 YES:**

- **Mermy — YES:** semantic choice criteria are explicit; Mermaid has a documented irregular-spacing limitation.
- **Signally — YES:** source observations are not promoted to an inferred continuous signal.
- **Ada Systems — YES:** as a *conditional review-branch pilot*, not production approval; no merge until compilation and XML tests.
- **Pyra — YES:** existing Python backend stays intact; no unverified parity claim.
- **Wiky — YES:** figure sources and publication authority are clearly separated; actual Wiki test remains.

**Vox:** 5 YES, 0 NO, 0 NEUTRAL. P1 passes as a scoped working recommendation. Its vote is not evidence that the new Ada code compiles, or permission to merge/publish. No counter-motion was proposed.

## Outputs and verification

- New `picasso-plots.ads`, `picasso-plots.adb`, `thermometer_demo.adb` and `PLOTS.md` in a Picasso review branch.
- The previously existing `picasso.adb` changes only the SVG attribute `length` to `height`.
- **Verified:** the exact source files and branch contents were read back from GitHub; the pilot serialises the same three constant source values in two paths by inspection; placeholder data are explicitly illustrative.
- **Unverified:** Ada compilation (GNAT not installed in the working environment), runtime behavior, SVG document validity/visual output and actual GitHub Wiki XY/SVG display. Do not describe this as a passing build.
- **No change:** existing Picasso base API apart from correcting one rendered attribute, existing Python Plotographer plugin or GitHub Data Wiki.

## Participant Reflection (proposed, not incorporated into agent corpora)

- **Mermy:** add a small renderer-choice example for unequal sample spacing to its concept routes.
- **Signally:** retain the three-sample/no-interpolation counterexample as a reusable visualization check.
- **Ada Systems:** GNAT compile, source-level API conformance and SVG XML validation must be explicit acceptance gates.
- **Pyra:** after compiler verification, compare with the already tested Python exporter and decide which numerical algorithms should stay outside the SVG Ada core.
- **Wiky:** verify SVG embedding in an actual project Wiki and keep a PNG fallback; preserve a single source-backed illustration in the chapter, not multiple redundant charts.
- **Zeus:** the experimental library branch and manuscript publication are separate decisions; do not conflate voting, testing, merge, packaging or Wiki publication.

Julio owns acceptance, merge, and all actual Wiki edits.
