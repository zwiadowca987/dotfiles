from textual.app import ComposeResult
from textual.screen import Screen
from textual.widgets import Header, Footer, Static, Button
from textual.containers import Container, Horizontal, Vertical


class TodoDisplay(Screen):
    def compose(self) -> ComposeResult:
        yield Header()
        yield Footer()
        with Container():
            with Horizontal():
                with Vertical():
                    yield Static('TODO')
                    yield Button('Lista')
                    yield Button('Dodaj')
                with Vertical():
                    yield Static('BOOKMARKS')
                    yield Button('Lista')
                    yield Button('Dodaj')

    def on_mount(self) -> None:
        self.title = 'T&B'
        self.sub_title = 'Tasks'
