# Doxygen API Reference

The Doxygen configuration in this directory generates API reference
documentation from the `unilink` core repository.

The documentation workflow checks out the core repository under:

```text
external/unilink
```

Then it runs:

```bash
./scripts/generate_docs.sh
```

The generation script reads the project version from
`external/unilink/CMakeLists.txt` and passes it to Doxygen as
`PROJECT_NUMBER`.

Generated output is written to `build/doxygen/` and should not be committed.
