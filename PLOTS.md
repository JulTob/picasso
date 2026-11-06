# Picasso.Plots — dual scientific plot output (draft)

This is a **review branch**, not a replacement for Picasso. The existing Ada SVG primitives, public package and examples are preserved. The new child package `Picasso.Plots` uses the existing canvas, shape and circle operations to produce a figure from discrete scientific samples and can serialize the same values as a Mermaid XY chart.

## First use case

The three illustrative measurements from the Data Wiki's proposed **Measurement, Experiment, and Signal** chapter are:

```text
Time (min):      0     1     2
Temperature:   20.0  20.3  20.6 (°C)
```

The [Ada demonstration](thermometer_demo.adb) emits:

- `thermometer_samples.svg`: standalone SVG with **sample markers only**, axes, units and labels. No unobserved continuous trajectory is asserted.
- `thermometer_samples.mmd`: Mermaid `xychart-beta` **line** from the same exact points, with the explicit limitation that joined positions are for visual guidance, not measured intermediate values.

```bash
gnatmake -gnat2022 thermometer_demo.adb
./thermometer_demo
```

__Build status__: GNAT is not installed in the development environment used for this proposal, so the Ada additions have **not** been compiled or executed here. They require compilation and a sample SVG/XML render before adoption. If the SVG file already exists, the new child package raises a `Use_Error` rather than silently overwriting it. Mermaid output is currently overwritten by the demo.

The existing Picasso `NewCanvas` SVG writer has one minimal correction on this review branch: output the standard `height` attribute instead of nonstandard `length`. No other existing API is changed.

## Renderer selection

| Reader's task | Primary source | Destination rendering |
| --- | --- | --- |
| Simple trend with few evenly spaced samples; easy Wiki editing | Mermaid XY `line` | Mermaid fenced source if confirmed in target Wiki |
| Precise samples, irregular time coordinates, explicit markers and units | Picasso SVG | Prefer SVG asset, but test Wiki image embedding; provide PNG fallback if it fails |
| Quantitative histogram, measured count / density, arbitrary bins | Future `Picasso.Plots.Histograms` layer or existing Plotographer numerical backend | Reproducible SVG with computed bin edges, units and validated totals |
| Categorical bars | Mermaid XY `bar` may suffice | Bars must not be called a histogram unless they encode correctly computed numerical bins |
| Scientific drawing requiring rich layout | SVG | Retain inspectable original data and generation script |

**Publication limitation:** Direct inline XML `<svg>` in GitHub Wiki Markdown is not a supported integration target to rely on; an SVG file referenced as an image may differ from an image displayed by the repository renderer. Verify the actual Wiki rendering before using it without PNG fallback. **Both SVG and Mermaid sources remain available even if only one is embedded.**

## Proposed architecture

```text
Scientific observations / domain-specific series
    ↓ validation (finite values, x increasing, units specified by caller)
Picasso.Plots : Point_Array
    ├── SVG_Samples()       → SVG using original Picasso primitives
    └── Mermaid_Samples()   → xychart-beta source
```

These two renderers currently share a **sample data model**. A future histogram requires a different semantic object (numerical bin edges, counts or densities) and should not reuse `Point_Array` as if raw samples were already bins.

### Design limitations (v0 pilot)

- This is a native Ada sample-series pilot, **not** a validated general-purpose plotting engine.
- The SVG output uses a zero-based pixel canvas internally but should retain the true data coordinates in documentation, units and readable tick labels. No interpolation is drawn in SVG.
- The Mermaid XY format uses category labels for x positions; it does not encode unequal numerical spacing. For irregular sampling, use SVG preferentially; do not treat the XY chart as metrically faithful.
- The current implementation uses a fixed output palette. Expose a typed theme only after the API and initial figure layout have been accepted.
- The existing Python Plotographer exporter in the Data review branch is a **working numerical prototype**, not automatically moved or deleted. Preserve it until Ada parity is demonstrated for the relevant plot types.
- Keep `Graphikon` in `JulTob/Optimization` unchanged: its optimization-specific plots solve a different problem.

## Verification before merge

1. Run `gnatmake -gnat2022 thermometer_demo.adb` with a configured GNAT compiler.
2. Generate both files; parse the SVG as XML and inspect visible markers, title, axis labels and units.
3. Compare exactly the three generated values with the input values; do not infer intermediate observations.
4. Check `xychart-beta` rendering in the *actual* GitHub Wiki, not only the chat preview.
5. Test a single point, constant readings, repeated x positions, nonfinite numbers and a title containing `&` or `<`.
6. Only after reviewing the new interface, choose whether to add a typed `Histogram` domain and a common renderer selection procedure.

## Authority

The Data Wiki's canonical prose is read-only to agents and is published only by Julio. This branch does not change the Wiki or the Data plotting PR #5. Picasso's source stays in Picasso; any consumer later imports it via explicit dependency or generated output. The final data figure, not a live renderer, is what the Wiki includes.
