#!/usr/bin/env bash

cat << __EOF__ >> /usr/local/lib/sbom.md
## $1 (expected: $2)

\`\`\`
$3
\`\`\`

__EOF__
