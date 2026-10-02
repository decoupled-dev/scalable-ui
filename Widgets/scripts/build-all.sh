#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT}"
chmod +x ./gradlew
if [[ -z "${JAVA_HOME:-}" || ! -x "${JAVA_HOME}/bin/javac" ]]; then
    javac_bin="$(find "${HOME}/.gradle/jdks" -type f -path '*/bin/javac' 2>/dev/null | head -1 || true)"
    if [[ -n "${javac_bin}" ]]; then
        export JAVA_HOME="$(cd "$(dirname "${javac_bin}")/.." && pwd)"
    fi
fi
./gradlew assembleDebug
