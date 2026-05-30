# unilink-docs

Documentation repository for the `unilink` C++20 core library.

Core library:
https://github.com/jwsung91/unilink

This repository contains:

- user guides
- contributor guides
- architecture notes
- API stability policy
- transport feature matrix
- Doxygen API reference configuration

Generated documentation is not committed. Doxygen output is produced under
`build/doxygen/` by local scripts and GitHub Actions.

## Documentation

- [Documentation index](docs/index.md)
- [User guide](docs/user/index.md)
- [Contributor guide](docs/contributor/index.md)
- [Doxygen configuration](doxygen/)

## Local validation

Generate the Doxygen API reference before publishing documentation changes that
touch API pages, snippets, or Doxygen configuration:

```bash
./scripts/generate_docs.sh
```

The script writes HTML output to `build/doxygen/html/`. The GitHub Actions
Doxygen workflow runs `doxygen doxygen/Doxyfile` and uploads the generated HTML
as the `doxygen-html` workflow artifact.
