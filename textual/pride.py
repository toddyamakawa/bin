#!/usr/bin/env python3
# vim: ft=python noet ts=4 sw=0 sts

from textual.app import App, ComposeResult
from textual.widgets import Static


class PrideApp(App):
    """Displays a pride flag."""

    COLORS = ["red", "orange", "yellow", "green", "blue", "purple"]

    def compose(self) -> ComposeResult:
        for color in self.COLORS:
            stripe = Static()
            stripe.styles.height = "1fr"
            stripe.styles.background = color
            yield stripe


if __name__ == "__main__":
    PrideApp().run()


