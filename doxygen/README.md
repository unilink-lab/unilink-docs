# Doxygen API Reference

The Doxygen configuration in this directory generates API reference
documentation from the `unilink` core repository.

The documentation workflow checks out the core repository under:

```text
external/unilink
```

Then it runs:

```bash
doxygen doxygen/Doxyfile
```

Generated output is written to `build/doxygen/` and should not be committed.
