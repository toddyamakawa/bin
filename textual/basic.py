#!/usr/bin/env python3
# vim: ft=python noet ts=4 sw=0 sts

from textual.app import App, ComposeResult
from textual.widgets import Button, Header, Footer, Label

class BasicApp(App):
	"""A Textual app to manage stopwatches."""

	BINDINGS = [
		("d", "toggle_dark", "Toggle dark mode"),
		("q", "app.quit", "Quit")
	]

	def compose(self) -> ComposeResult:
		"""Create child widgets for the app."""
		yield Header()
		yield Footer()

	def action_toggle_dark(self) -> None:
		"""An action to toggle dark mode."""
		self.dark = not self.dark


if __name__ == "__main__":
	app = BasicApp()
	app.run()

