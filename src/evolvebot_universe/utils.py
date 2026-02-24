"""Small helpers for registry service."""

from __future__ import annotations

from pathlib import Path


def get_data_dir() -> Path:
    """Return the data directory used for logs/state."""
    path = Path.home() / ".evolvebot"
    path.mkdir(parents=True, exist_ok=True)
    return path
