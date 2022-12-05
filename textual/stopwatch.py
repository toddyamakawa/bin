#!/usr/bin/env python3
# vim: ft=python noet ts=4 sw=0 sts

from time import monotonic

from textual.app import App, ComposeResult
from textual.containers import Container
from textual.reactive import reactive
from textual.widgets import Button, Header, Footer, Label, Static

class TimeDisplay(Static):
	start_time = reactive(monotonic)
	time = reactive(0.0)
	total = reactive(0.0)

	def on_mount(self) -> None:
		self.update_timer = self.set_interval(1/60, self.update_time, pause=True)

	def start(self) -> None:
		self.start_time = monotonic()
		self.update_timer.resume()

	def stop(self) -> None:
		self.update_timer.pause()
		self.total =+ monotonic() - self.start_time
		self.time = self.total

	def reset(self) -> None:
		self.total = 0
		self.time = 0

	def update_time(self) -> None:
		self.time = self.total + (monotonic() - self.start_time)

	def watch_time(self, time: float) -> None:
		minutes, seconds = divmod(time, 60)
		hours, minutes = divmod(minutes, 60)
		self.update(f"{hours:02,.0f}:{minutes:02.0f}:{seconds:05.2f}")

class Stopwatch(Static):
	def compose(self) -> ComposeResult:
		yield Button('Start', id='start', variant='success')
		yield Button('Stop', id='stop', variant='error')
		yield Button('Reset', id='reset')
		yield TimeDisplay('00:00:00.00')

	def on_button_pressed(self, event: Button.Pressed) -> None:
		button_id = event.button.id
		time_display = self.query_one(TimeDisplay)
		if button_id == 'start':
			time_display.start()
			self.add_class('started')
		elif button_id == 'stop':
			time_display.stop()
			self.remove_class('started')
		elif button_id == 'reset':
			time_display.reset()

class StopwatchApp(App):
	"""A Textual app to manage stopwatches."""

	CSS_PATH = 'stopwatch.css'
	BINDINGS = [
		("d", "toggle_dark", "Toggle dark mode"),
		("a", "add_stopwatch", "Add"),
		("r", "remove_stopwatch", "Remove"),
		("q", "app.quit", "Quit")
	]

	def compose(self) -> ComposeResult:
		"""Create child widgets for the app."""
		yield Header()
		yield Footer()
		yield Container(Stopwatch(), Stopwatch(), Stopwatch(), id='timers')

	def action_add_stopwatch(self) -> None:
		self.query_one('#timers').mount(Stopwatch())
		#new_stopwatch.scroll_visible()

	def action_remove_stopwatch(self) -> None:
		timers = self.query('Stopwatch')
		if timers: timers.last().remove()

	def action_toggle_dark(self) -> None:
		"""An action to toggle dark mode."""
		self.dark = not self.dark


if __name__ == "__main__":
	app = StopwatchApp()
	app.run()

